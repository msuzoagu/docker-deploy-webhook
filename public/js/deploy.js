/* global $ */
$(document).ready(function () {
  const $services = $($('#services'))
  const token = $services.data('token')

  getServices()

  function getServices() {
    return $.ajax({
      type: 'GET',
      url: `/services/${token}`,
      async: true,
    })
      .done(function (data, status, xhr) {
        showServices(data.services)
      })
      .fail(function (xhr, ajaxOptions, thrownError) {
        console.error('error')
      })
  }

  function showServices(myServices) {
    const servicesContainer = $('#services')
    myServices.forEach((serviceName) => {
      if (serviceName === 'defaultNotificationOptions') return
      const html = `<tr><td>${serviceName}</td><td><a class="deploy" data-servicename="${serviceName}" href="#">Deploy</a></td></div>`
      servicesContainer.append(html)
    })
    initEventHandlers()
  }

  function initEventHandlers() {
    $('.deploy').on('click', function () {
      const $this = $(this)
      const name = $this.data('servicename')
      deploy(name)
    })
  }

  function deploy(imageName) {
    return $.ajax({
      type: 'POST',
      url: `/deploy/${token}`,
      data: { imageName },
      dataType: 'json',
      async: true,
    })
      .done((data) => {
        if (data.error) {
          console.error(`error: ${data.error}`)
          return
        }
        console.log('ok')
      })
      .fail(function () {
        console.error('error')
      })
  }
})
