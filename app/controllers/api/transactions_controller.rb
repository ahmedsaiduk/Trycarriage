# CRUD API for transactions and metasearch
# with meta-search (core file)
module Api
  # CRUD API class for transactions
  class TransactionsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_transaction, only: %i[show update destroy]
    def all_record
      transactions = Transaction.all
      if transactions.present?
        render json: { transactions: transactions }, status: :ok
      else
        render json: { status: 'NOT SUCCESS', message: 'Error' },
               status: :unprocessable_entity
      end
    end

    def show
      transaction = @transaction
      if transaction.present?
        render json: { transaction: transaction }, status: :ok
      else
        render json: { status: 'NOT SUCCESS', message: 'Wrong ID' },
               status: :unprocessable_entity
      end
    end

    def page
      transactions = Transaction.page(params[:page]).per(3)
      if transactions.present?
        render json: { transactions: transactions }, status: :ok
      else
        render json: { status: 'NOT SUCCESS', message: 'No page Found' },
               status: :unprocessable_entity
      end
    end

    def create
      transaction = Transaction.new(transaction_params)
      if transaction.save
        render json: { transaction: transaction, message: 'Transacion Saved' },
               status: :ok
      else
        render json: { status: 'NOT SAVED', message: transaction.errors },
               status: :unprocessable_entity
      end
    end

    def update
      transaction = @transaction.update(transaction_params)
      if transaction
        render json: { transaction: transaction,
                       message: 'Transacion Update Successfully' },
               status: :ok
      else
        render json: { status: 'NOT SAVED', message: transaction.errors },
               status: :unprocessable_entity
      end
    end

    def price_range
      price = Transaction.ransack(price_gteq: params[:min],
                                  price_lteq: params[:max]).result
      render json: { transactions: price,
                     message: 'Transacions Filtered By Price' },
             status: :ok
    end

    def sq_ft_range
      sq_ft = Transaction.ransack(sq_ft_gteq: params[:min],
                                  sq_ft_lteq: params[:max]).result
      render json: { transactions: sq_ft,
                     message: 'Transacions Filtered By SQ FT' },
             status: :ok
    end

    def type_filter
      type = Transaction.ransack(type_cont: params[:type]).result
      render json: { transactions: type,
                     message: 'Transacions Filtered By Type' },
             status: :ok
    end

    def destroy
      transaction = @transaction.destroy
      if transaction
        render json: { transaction: transaction,
                       message: 'Transacion Deleted Successfully' },
               status: :ok
      else
        render json: { status: 'NOT DELETED', message: transaction.errors },
               status: :unprocessable_entity
      end
    end

    private

    def set_transaction
      @transaction = Transaction.where(id: params[:id])
    end

    def transaction_params
      params.require(:transaction).permit(
        :street, :city, :zip, :state, :beds,
        :baths,
        :sq_ft,
        :types,
        :sale_date,
        :price,
        :latitude, :longitude
      )
    end
  end
end
