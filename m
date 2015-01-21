From: Todd E Brandt <todd.e.brandt-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 3/3] power/axp288_fuel_gauge: axp288 fuel gauge driver
Date: Wed, 21 Jan 2015 12:52:53 -0800
Message-ID: <20150121205253.GB15525@linux.intel.com>
References: <20150107212655.GD3440@linux.intel.com>
 <20150118104923.GA11147@earth.universe>
Reply-To: todd.e.brandt-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150118104923.GA11147-SfvFxonMDyemK9LvCR3Hrw@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, todd.e.brandt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Sun, Jan 18, 2015 at 11:49:27AM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Jan 07, 2015 at 01:26:55PM -0800, Todd E Brandt wrote:
> > X-Power AXP288 PMIC Fuel Gauge Driver
> > 
> >  new power_supply driver at driver/power
> >  interfaces with the axp20x mfd driver as a cell
> >  provides battery info and monitors for changes
> >  generates alerts on temperature and capacity issues
> > 
> > [...]
> >
> > +static int fuel_gauge_battery_health(struct axp288_fg_info *info)
> > +{
> > +	int temp, vocv;
> > +	int ret, health = POWER_SUPPLY_HEALTH_UNKNOWN;
> > +
> > +	ret = fuel_gauge_get_btemp(info, &temp);
> > +	if (ret < 0)
> > +		goto health_read_fail;
> > +
> > +	ret = fuel_gauge_get_vocv(info, &vocv);
> > +	if (ret < 0)
> > +		goto health_read_fail;
> > +
> > +	if (vocv > info->pdata->max_volt)
> > +		health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> > +	else if (temp > info->pdata->max_temp ||
> > +			temp < info->pdata->min_temp)
> > +		health = POWER_SUPPLY_HEALTH_OVERHEAT;
> 
> if (temp < info->pdata->min_temp)
>     health = POWER_SUPPLY_HEALTH_COLD;

Will add in v2, thanks.

> 
> > +	else if (vocv < info->pdata->min_volt)
> > +		health = POWER_SUPPLY_HEALTH_DEAD;
> > +	else
> > +		health = POWER_SUPPLY_HEALTH_GOOD;
> > +
> > +health_read_fail:
> > +	return health;
> > +}
> >
> > [...]
> >
> > +static int axp288_fuel_gauge_remove(struct platform_device *pdev)
> > +{
> > +	return 0;
> > +}
> 
> You can drop this function if nothing needs to be cleaned, but
> that's not the case, so where is the cleanup code?

You're right, I believe it needs:

cancel_delayed_work_sync(&info->status_monitor);
power_supply_unregister(&info->bat);

will add in v2, thanks

> 
> > [...]
> 
> -- Sebastian
