# frozen_string_literal: true

json.array! @agreements, partial: "admin/agreements/agreement", as: :agreement
