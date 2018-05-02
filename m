From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 15/18] thermal: exynos: check return values of
 ->get_trip_[temp,hyst] methods
Date: Wed, 02 May 2018 11:41:42 +0200
Message-ID: <2073119.W2NaKLyeRo@amdc3058>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <1524743493-28113-16-git-send-email-b.zolnierkie@samsung.com>
        <20180501104304.GL27619@mai>
        <CGME20180502094143eucas1p282ea9e6519120d8eff473a7b3e1830ac@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180501104304.GL27619@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 01, 2018 12:43:04 PM Daniel Lezcano wrote:
> On Thu, Apr 26, 2018 at 01:51:30PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Check return values of ->get_trip_[temp,hyst] methods in
> > exynos_tmu_initialize().
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index 244aaf6..abe0737 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -357,19 +357,23 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
> >  		/* Write temperature code for rising and falling threshold */
> >  		for (i = 0; i < ntrips; i++) {
> >  			/* Write temperature code for rising threshold */
> > -			tzd->ops->get_trip_temp(tzd, i, &temp);
> > +			ret = tzd->ops->get_trip_temp(tzd, i, &temp);
> > +			if (ret)
> > +				goto err;
> >  			temp /= MCELSIUS;
> >  			data->tmu_set_trip_temp(data, i, temp);
> >  
> >  			/* Write temperature code for falling threshold */
> > -			tzd->ops->get_trip_hyst(tzd, i, &hyst);
> > +			ret = tzd->ops->get_trip_hyst(tzd, i, &hyst);
> > +			if (ret)
> > +				goto err;
> 
> Could this fail for 4210 ?

It can't, please see the method implementation in of-thermal.c:

static int of_thermal_get_trip_hyst(struct thermal_zone_device *tz, int trip,
				    int *hyst)
{
	struct __thermal_zone *data = tz->devdata;

	if (trip >= data->ntrips || trip < 0)
		return -EDOM;

	*hyst = data->trips[trip].hysteresis;

	return 0;
}

> >  			hyst /= MCELSIUS;
> >  			data->tmu_set_trip_hyst(data, i, temp, hyst);
> >  		}
> >  
> >  		data->tmu_clear_irqs(data);
> >  	}
> > -
> > +err:
> >  	clk_disable(data->clk);
> >  	mutex_unlock(&data->lock);
> >  	if (!IS_ERR(data->clk_sec))

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
