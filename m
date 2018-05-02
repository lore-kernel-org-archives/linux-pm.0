From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 11/18] thermal: exynos: add
 exynos*_tmu_set_[trip,hyst]() helpers
Date: Wed, 02 May 2018 11:33:15 +0200
Message-ID: <2658994.PYbssquHNy@amdc3058>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <1524743493-28113-12-git-send-email-b.zolnierkie@samsung.com>
        <20180501095540.GH27619@mai>
        <CGME20180502093316eucas1p1e7e7b2f27eae677dde9882a4aedd2ed7@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180501095540.GH27619@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 01, 2018 11:55:40 AM Daniel Lezcano wrote:
> On Thu, Apr 26, 2018 at 01:51:26PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Add exynos*_tmu_set_[trip,hyst]() helpers and convert
> > all ->tmu_initialize implementations accordingly.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 282 +++++++++++++++++------------------
> >  1 file changed, 140 insertions(+), 142 deletions(-)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index 82484c5..80265d2 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -305,30 +305,6 @@ static void sanitize_temp_error(struct exynos_tmu_data *data, u32 trim_info)
> >  			EXYNOS_TMU_TEMP_MASK;
> >  }
> 
> [ ... ]
> 
> > +static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
> > +					 int trip, u8 temp)
> > +{
> > +	const struct thermal_trip * const trips =
> > +		of_thermal_get_trip_points(data->tzd);
> > +	u8 ref, th_code;
> 
> I would not do this kind of change (unsigned long => u8) with this patch.
> Just code reorg and another patch to tweak the variable types if needed.

This is so minor change and it is has been already tested so I prefer to
not split it from this patch now.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
