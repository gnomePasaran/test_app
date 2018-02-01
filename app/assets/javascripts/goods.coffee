$ ->
  $(document).on 'click', '.refresh-link', (e) ->
    e.preventDefault()
    $.ajax '/sales?from=' + $('#from').val() + '&to=' + $('#to').val(),
      type: 'GET'
      dataType: 'json'
      success: (data, status, xhr) ->
        $('.table tbody').replaceWith('<tbody></tbody')
        response = $.parseJSON(xhr.responseText)
        response.goods.forEach (g) =>
          $('.table tbody').append('<tr><td>' + g.title + '</td><td>' + g.revenue + '</td></tr>')
        $('.table tbody').append('<tr><td>Total</td><td>' + response.total_revenue + '</td></tr>')
