From: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Subject: Re: [PATCH] thermal: imx: interpret fsl,tempmon-data through nvmem
Date: Wed, 5 Jul 2017 15:33:05 +0300
Message-ID: <1499257985.23291.7.camel@nxp.com>
References: <d1a8ec1ef73aefe6018f6a4923bd04b3ac34a5d4.1497879110.git.leonard.crestez@nxp.com>
         <20170704185400.GB18084@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170704185400.GB18084-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Bai Ping <ping.bai-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2017-07-04 at 11:54 -0700, Eduardo Valentin wrote:
> On Mon, Jun 19, 2017 at 04:40:43PM +0300, Leonard Crestez wrote:
> > 
> > On imx6sx accessing the ocotp memory area directly is wrong because the
> > ocotp clock needs to be enabled first. Fix this by reinterpreting the
> > fsl,tempmon-data phandle as a reference to a nvmem_device and doing all
> > the read through that.
> > 
> > @@ -347,29 +348,39 @@ static struct thermal_zone_device_ops imx_tz_ops = {
> >  static int imx_get_sensor_data(struct platform_device *pdev)
> >  {
> >  	struct imx_thermal_data *data = platform_get_drvdata(pdev);
> > -	struct regmap *map;
> > +	struct device_node *ocotp_np;
> > +	struct nvmem_device *ocotp;
> >  	int t1, n1;
> >  	int ret;
> >  	u32 val;
> >  	u64 temp64;
> >  
> > -	map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> > -					      "fsl,tempmon-data");
> > -	if (IS_ERR(map)) {
> > -		ret = PTR_ERR(map);
> > -		dev_err(&pdev->dev, "failed to get sensor regmap: %d\n", ret);
> > +	ocotp_np = of_parse_phandle(pdev->dev.of_node, "fsl,tempmon-data", 0);
> > +	if (IS_ERR(ocotp_np)) {
> > +		ret = PTR_ERR(ocotp_np);
> > +		dev_err(&pdev->dev, "failed to parse fsl,tempmon-data phandle: %d\n", ret);
> > +		return ret;
> > +	}
> > +	ocotp = of_nvmem_device_phandle_get(ocotp_np);
> > +	of_node_put(ocotp_np);
> > +	if (IS_ERR(ocotp)) {
> > +		ret = PTR_ERR(ocotp);
> > +		if (ret != -EPROBE_DEFER)
> > +			dev_err(&pdev->dev, "failed to get fsl,tempmon-data nvmem device: %d\n", ret);
> >  		return ret;
> >  	}
> >  
> > @@ -404,10 +415,11 @@ static int imx_get_sensor_data(struct platform_device *pdev)
> >  	data->c2 = n1 * data->c1 + 1000 * t1;
> >  
> >  	/* use OTP for thermal grade */
> > -	ret = regmap_read(map, OCOTP_MEM0, &val);
> > -	if (ret) {
> > -		dev_err(&pdev->dev, "failed to read temp grade: %d\n", ret);
> > -		return ret;

> I see a few other occurences of regmap_read() in this driver, for
> example, inside imx_get_temp(). Do they also get affect by the reported
> bug? Should they be replaced with nvmem_device_read() too?

No, most of the code uses regmap to read from the tempmon device
itself.

It is only imx_get_sensor_data which uses syscon_regmap_lookup to fetch
the regmap for another device (ocotp) in order to read calibration data
and thermal grading at probe time. Perhaps this function should be
renamed to something like imx_tempmon_init_calib.

The problem is that on newer imx SOCs reading directly from OCOTP like
that doesn't work if the ocotp clock is not enabled.

--
Regards,
Leonard
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
