From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: imx: Fix race condition in imx_thermal_probe()
Date: Wed, 28 Feb 2018 12:42:43 +0800
Message-ID: <1519792963.2797.20.camel@intel.com>
References: <1517595466-23465-1-git-send-email-festevam@gmail.com>
         <CAOMZO5D5rRask0pGQBFf+47sG0XURj17=pO4hMiAh4MZa4nkJQ@mail.gmail.com>
         <CAOMZO5A7vqGffkj0qHUQo7MXVQMfy5Om7yw1YCs6ZR_0aOE37A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5A7vqGffkj0qHUQo7MXVQMfy5Om7yw1YCs6ZR_0aOE37A@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Mikhail Lappo <mikhail.lappo@esrlabs.com>, linux-pm@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, stable <stable@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-02-26 at 15:56 -0300, Fabio Estevam wrote:
> Rui,
> 
> Any comments, please?
> 
interesting, this problem should be covered by this patch https://patch
work.kernel.org/patch/10242483/, together with some driver code change.

anyway, as that is not a complete solution yet, I will apply this patch
as a quick solution.

thanks,
rui
> On Wed, Feb 14, 2018 at 1:23 AM, Fabio Estevam <festevam@gmail.com>
> wrote:
> > 
> > Hi Eduardo and Rui,
> > 
> > On Fri, Feb 2, 2018 at 4:17 PM, Fabio Estevam <festevam@gmail.com>
> > wrote:
> > > 
> > > From: Mikhail Lappo <mikhail.lappo@esrlabs.com>
> > > 
> > > When device boots with T > T_trip_1 and requests interrupt,
> > > the race condition takes place. The interrupt comes before
> > > THERMAL_DEVICE_ENABLED is set. This leads to an attempt to
> > > reading sensor value from irq and disabling the sensor, based on
> > > the data->mode field, which expected to be
> > > THERMAL_DEVICE_ENABLED,
> > > but still stays as THERMAL_DEVICE_DISABLED. Afher this issue
> > > sensor is never re-enabled, as the driver state is wrong.
> > > 
> > > Fix this problem by setting the 'data' members prior to
> > > requesting the interrupts.
> > > 
> > > Fixes: 37713a1e8e4c ("thermal: imx: implement thermal alarm
> > > interrupt handling")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Mikhail Lappo <mikhail.lappo@esrlabs.com>
> > > Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> > A gentle ping on this patch.
> > 
> > > 
> > > ---
> > >  drivers/thermal/imx_thermal.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/thermal/imx_thermal.c
> > > b/drivers/thermal/imx_thermal.c
> > > index a67781b..ee3a215 100644
> > > --- a/drivers/thermal/imx_thermal.c
> > > +++ b/drivers/thermal/imx_thermal.c
> > > @@ -637,6 +637,9 @@ static int imx_thermal_probe(struct
> > > platform_device *pdev)
> > >         regmap_write(map, TEMPSENSE0 + REG_CLR,
> > > TEMPSENSE0_POWER_DOWN);
> > >         regmap_write(map, TEMPSENSE0 + REG_SET,
> > > TEMPSENSE0_MEASURE_TEMP);
> > > 
> > > +       data->irq_enabled = true;
> > > +       data->mode = THERMAL_DEVICE_ENABLED;
> > > +
> > >         ret = devm_request_threaded_irq(&pdev->dev, data->irq,
> > >                         imx_thermal_alarm_irq,
> > > imx_thermal_alarm_irq_thread,
> > >                         0, "imx_thermal", data);
> > > @@ -649,9 +652,6 @@ static int imx_thermal_probe(struct
> > > platform_device *pdev)
> > >                 return ret;
> > >         }
> > > 
> > > -       data->irq_enabled = true;
> > > -       data->mode = THERMAL_DEVICE_ENABLED;
> > > -
> > >         return 0;
> > >  }
> > > 
> > > --
> > > 2.7.4
> > > 
