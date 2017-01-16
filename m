From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 05/12] pinctrl: samsung: Remove messages for failed
 memory allocation
Date: Mon, 16 Jan 2017 21:04:25 +0200
Message-ID: <20170116190425.365vtjijrxggvwct@kozik-lap>
References: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170116064525eucas1p1556f795af7e2323726ca9a89943c7309@eucas1p1.samsung.com>
 <1484549107-5957-6-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1484549107-5957-6-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 16, 2017 at 07:45:00AM +0100, Marek Szyprowski wrote:
> Memory subsystem already prints message about failed memory
> allocation, there is no need to do it in the drivers.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos.c  |  8 ++------
>  drivers/pinctrl/samsung/pinctrl-s3c64xx.c | 12 +++---------
>  drivers/pinctrl/samsung/pinctrl-samsung.c | 24 ++++++------------------
>  3 files changed, 11 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
> index 24814db251a7..bf753a596209 100644
> --- a/drivers/pinctrl/samsung/pinctrl-exynos.c
> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
> @@ -528,10 +528,8 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
>  
>  		weint_data = devm_kzalloc(dev, bank->nr_pins
>  					* sizeof(*weint_data), GFP_KERNEL);
> -		if (!weint_data) {
> -			dev_err(dev, "could not allocate memory for weint_data\n");
> +		if (!weint_data)
>  			return -ENOMEM;
> -		}
>  
>  		for (idx = 0; idx < bank->nr_pins; ++idx) {
>  			irq = irq_of_parse_and_map(bank->of_node, idx);
> @@ -559,10 +557,8 @@ static int exynos_eint_wkup_init(struct samsung_pinctrl_drv_data *d)
>  
>  	muxed_data = devm_kzalloc(dev, sizeof(*muxed_data)
>  		+ muxed_banks*sizeof(struct samsung_pin_bank *), GFP_KERNEL);
> -	if (!muxed_data) {
> -		dev_err(dev, "could not allocate memory for muxed_data\n");
> +	if (!muxed_data)
>  		return -ENOMEM;
> -	}
>  
>  	irq_set_chained_handler_and_data(irq, exynos_irq_demux_eint16_31,
>  					 muxed_data);
> diff --git a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
> index 4c632812ccff..f17890aa6e25 100644
> --- a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
> +++ b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
> @@ -489,10 +489,8 @@ static int s3c64xx_eint_gpio_init(struct samsung_pinctrl_drv_data *d)
>  
>  	data = devm_kzalloc(dev, sizeof(*data)
>  			+ nr_domains * sizeof(*data->domains), GFP_KERNEL);
> -	if (!data) {
> -		dev_err(dev, "failed to allocate handler data\n");
> +	if (!data)
>  		return -ENOMEM;
> -	}
>  	data->drvdata = d;
>  
>  	bank = d->pin_banks;
> @@ -715,10 +713,8 @@ static int s3c64xx_eint_eint0_init(struct samsung_pinctrl_drv_data *d)
>  		return -ENODEV;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> -	if (!data) {
> -		dev_err(dev, "could not allocate memory for wkup eint data\n");
> +	if (!data)
>  		return -ENOMEM;
> -	}
>  	data->drvdata = d;
>  
>  	for (i = 0; i < NUM_EINT0_IRQ; ++i) {
> @@ -751,10 +747,8 @@ static int s3c64xx_eint_eint0_init(struct samsung_pinctrl_drv_data *d)
>  
>  		ddata = devm_kzalloc(dev,
>  				sizeof(*ddata) + nr_eints, GFP_KERNEL);
> -		if (!ddata) {
> -			dev_err(dev, "failed to allocate domain data\n");
> +		if (!ddata)
>  			return -ENOMEM;
> -		}
>  		ddata->bank = bank;
>  
>  		bank->irq_domain = irq_domain_add_linear(bank->of_node,
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> index 3bc925f61b71..b11e67e85460 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -93,10 +93,8 @@ static int reserve_map(struct device *dev, struct pinctrl_map **map,
>  		return 0;
>  
>  	new_map = krealloc(*map, sizeof(*new_map) * new_num, GFP_KERNEL);
> -	if (!new_map) {
> -		dev_err(dev, "krealloc(map) failed\n");
> +	if (!new_map)
>  		return -ENOMEM;
> -	}
>  
>  	memset(new_map + old_num, 0, (new_num - old_num) * sizeof(*new_map));
>  
> @@ -133,10 +131,8 @@ static int add_map_configs(struct device *dev, struct pinctrl_map **map,
>  
>  	dup_configs = kmemdup(configs, num_configs * sizeof(*dup_configs),
>  			      GFP_KERNEL);
> -	if (!dup_configs) {
> -		dev_err(dev, "kmemdup(configs) failed\n");
> +	if (!dup_configs)
>  		return -ENOMEM;
> -	}
>  
>  	(*map)[*num_maps].type = PIN_MAP_TYPE_CONFIGS_GROUP;
>  	(*map)[*num_maps].data.configs.group_or_pin = group;
> @@ -156,10 +152,8 @@ static int add_config(struct device *dev, unsigned long **configs,
>  
>  	new_configs = krealloc(*configs, sizeof(*new_configs) * new_num,
>  			       GFP_KERNEL);
> -	if (!new_configs) {
> -		dev_err(dev, "krealloc(configs) failed\n");
> +	if (!new_configs)
>  		return -ENOMEM;
> -	}
>  
>  	new_configs[old_num] = config;
>  
> @@ -756,10 +750,8 @@ static struct samsung_pmx_func *samsung_pinctrl_create_functions(
>  
>  	functions = devm_kzalloc(dev, func_cnt * sizeof(*functions),
>  					GFP_KERNEL);
> -	if (!functions) {
> -		dev_err(dev, "failed to allocate memory for function list\n");
> +	if (!functions)
>  		return ERR_PTR(-EINVAL);

Out of scope of this patch - why are we returning EINVAL instead of
ENOMEM?

Regardless:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
