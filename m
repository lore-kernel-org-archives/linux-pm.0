From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH] thermal/drivers/hisi: Remove confusing error message
Date: Tue, 8 Aug 2017 21:29:55 +0800
Message-ID: <20170808132955.GB32732@leoy-ThinkPad-T440>
References: <1499439833-32531-1-git-send-email-daniel.lezcano@linaro.org>
 <1502178956.4296.7.camel@intel.com>
 <46604862-fbb8-8ed1-8b0d-7a51543b3398@linaro.org>
 <1502196531.4296.41.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502196531.4296.41.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, edubezval@gmail.com, "open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, kong.kongxinwei@hisilicon.com
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 08, 2017 at 08:48:51PM +0800, Zhang Rui wrote:

[...]

> > > > @@ -352,10 +353,9 @@ static int hisi_thermal_probe(struct
> > > > platform_device *pdev)
> > > >  		ret = hisi_thermal_register_sensor(pdev, data,
> > > >  						   &data-
> > > > > 
> > > > > sensors[i], i);
> > > >  		if (ret)
> > > > -			dev_err(&pdev->dev,
> > > > -				"failed to register thermal
> > > > sensor:
> > > > %d\n", ret);
> > > > -		else
> > > > -			hisi_thermal_toggle_sensor(&data-
> > > > > 
> > > > > sensors[i], true);
> > > > +			continue;
> > > > +
> > > > +		hisi_thermal_toggle_sensor(&data->sensors[i],
> > > > true);
> > > >  	}
> > > >  
> > > >  	return 0;
> > > With these removed, is there any other information in dmesg that
> > > suggests this failure?
> > The problem is there are always failures showed in dmesg. The init
> > function is based on the assumption there is HISI_MAX_SENSORS sensors
> > which is not true for the hi6220 and that raises at boot time errors.
> > 
> > Why HISI_MAX_SENSORS(=4) while there is only one on hi6220 AFAIK? and
> > this driver is only used for hi6220 (now).
> > 
> right, I think we should remove one error log, and then change the
> HISI_MAX_SENSORS to reflect the reality instead.
> 
> XinWei and Leo,
> can you please help check this?

Sure.

Here I am a bit confusion and I think this is a common question for
SoC thermal driver.

Hi6220 does has 4 thermal sensors, but we now only use one sensor of
them (thermal sensor id 2) to bind with thermal zone and other three
sensors are not bound to any thermal zone. So this is the reason the
booting reports the failure.

I think changing HISI_MAX_SENSORS value cannot resolve this issue, due
we are using thermal id 2. How about below change? We change to use
warning for sensors without binding, and remove redundant log.

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 9c3ce34..6d34980 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -260,8 +260,6 @@ static int hisi_thermal_register_sensor(struct platform_device *pdev,
        if (IS_ERR(sensor->tzd)) {
                ret = PTR_ERR(sensor->tzd);
                sensor->tzd = NULL;
-               dev_err(&pdev->dev, "failed to register sensor id %d: %d\n",
-                       sensor->id, ret);
                return ret;
        }
 
@@ -351,7 +349,10 @@ static int hisi_thermal_probe(struct platform_device *pdev)
        for (i = 0; i < HISI_MAX_SENSORS; ++i) {
                ret = hisi_thermal_register_sensor(pdev, data,
                                                   &data->sensors[i], i);
-               if (ret)
+               if (ret == -ENODEV)
+                       dev_warn(&pdev->dev,
+                                "thermal sensor %d has not bound\n", i);
+               else if (ret)
                        dev_err(&pdev->dev,
                                "failed to register thermal sensor: %d\n", ret);
                else

Thanks,
Leo Yan
