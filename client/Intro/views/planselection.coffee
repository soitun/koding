class IntroPricingPlanSelection extends KDCustomHTMLView
  constructor : (options = {}, data = {}) ->
    options.cssClass      = KD.utils.curry "plan-selection-box", options.cssClass
    options.title       or= ""
    options.description or= ""
    options.unitPrice    ?= 1
    options.period      or= "Month"
    options.unit        or= 'x'
    super options, data

    @title    = new KDCustomHTMLView
      tagName : "h4"
      partial : "#{options.title}"

    @title.addSubView @count = new KDCustomHTMLView tagName : "cite"

    options.slider       or= {}
    options.slider.drawBar = no

    {unitPrice, unit} = options

    @slider = new KDSliderBarView options.slider
    @slider.on "ValueChanged", (handle) =>
      value = Math.floor handle.value
      price = value * unitPrice
      @count.updatePartial "#{value}#{unit}"
      @emit "ValueChanged", value

    @description = new KDCustomHTMLView
      tagName    : "p"
      cssClass   : "description"
      partial    : options.description

  viewAppended: JView::viewAppended

  pistachio: ->
    """
    {{> @title}}
    {{> @slider}}
    {{> @description}}
    """

    # """
    #   <span class="icon"></span>
    #   <div class="plan-values">
    #     <span class="unit-display">{{> @count }}</span>
    #     <span class="calculated-price">{{> @price}}</span>
    #   </div>
    #   <div class="sliderbar-outer-container">{{> @slider}}</div>
    # """
