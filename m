From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCHv5 2/5] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal
 driver
Date: Tue, 13 Dec 2016 10:43:40 +0100
Message-ID: <20161213094339.GB24175@bigcity.dyn.berto.se>
References: <20161212141805.14946-1-niklas.soderlund@ragnatech.se>
 <20161212141805.14946-3-niklas.soderlund@ragnatech.se>
 <20161213035052.GA22105@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161213035052.GA22105@localhost.localdomain>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

Thanks for your feedback. I will skip commenting where Wolfram already 
have.

On 2016-12-12 19:50:54 -0800, Eduardo Valentin wrote:

<snip>

> > +/* Structure for thermal temperature calculation */
> > +struct equation_coefs {
> > +	int a1;
> > +	int b1;
> > +	int a2;
> > +	int b2;
> 
> a little description of each coeff would be welcome.

Yes, I too would like to have better documentation of the formulas and 
the meaning of the coefficients.

<snip, Wolfram already covert this>

> 
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	pm_runtime_enable(dev);
> > +	pm_runtime_get_sync(dev);
> > +
> > +	for (i = 0; i < TSC_MAX_NUM; i++) {
> > +		struct rcar_gen3_thermal_tsc *tsc;
> > +
> > +		tsc = devm_kzalloc(dev, sizeof(*tsc), GFP_KERNEL);
> > +		if (!tsc) {
> > +			ret = -ENOMEM;
> > +			goto error_unregister;
> > +		}
> > +
> > +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> > +		if (!res)
> > +			break;
> > +
> > +		tsc->base = devm_ioremap_resource(dev, res);
> > +		if (IS_ERR(tsc->base)) {
> > +			ret = PTR_ERR(tsc->base);
> > +			goto error_unregister;
> > +		}
> > +
> > +		priv->tscs[i] = tsc;
> > +		mutex_init(&tsc->lock);
> > +
> > +		match_data->thermal_init(tsc);
> > +		rcar_gen3_thermal_calc_coefs(&tsc->coef, ptat, thcode[i]);
> 
> oh, the thcode's are currently not read then?

No as Wolfram commented, reading THCODE and PTAT from hardware is not 
possible on the boards we have to test on so I think this needs to be 
added once we can test it. Do you agree this is the best option?

> 
> > +
> > +		zone = devm_thermal_zone_of_sensor_register(dev, i, tsc,
> > +							    &rcar_gen3_tz_of_ops);
> 
> and you are already doing it, therefore those coeff could really come
> from the DT, no?
> 
> > +		if (IS_ERR(zone)) {
> > +			dev_err(dev, "Can't register thermal zone\n");
> > +			ret = PTR_ERR(zone);
> > +			goto error_unregister;
> > +		}
> > +		tsc->zone = zone;
> > +	}
> > +
> > +	return 0;
> > +
> > +error_unregister:
> > +	rcar_gen3_thermal_remove(pdev);
> > +
> > +	return ret;
> > +}
> > +
> > +static struct platform_driver rcar_gen3_thermal_driver = {
> > +	.driver	= {
> > +		.name	= "rcar_gen3_thermal",
> > +		.of_match_table = rcar_gen3_thermal_dt_ids,
> > +	},
> > +	.probe		= rcar_gen3_thermal_probe,
> > +	.remove		= rcar_gen3_thermal_remove,
> > +};
> > +module_platform_driver(rcar_gen3_thermal_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("R-Car Gen3 THS thermal sensor driver");
> > +MODULE_AUTHOR("Wolfram Sang <wsa+renesas@sang-engineering.com>");
> > -- 
> > 2.10.2
> > 

-- 
Regards,
Niklas Söderlund
