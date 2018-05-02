From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 13/18] thermal: exynos: set trips in ascending order in
 exynos7_tmu_initialize()
Date: Wed, 02 May 2018 11:37:08 +0200
Message-ID: <3681690.4QzPMdFsyU@amdc3058>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <1524743493-28113-14-git-send-email-b.zolnierkie@samsung.com>
        <20180501100242.GJ27619@mai>
        <CGME20180502093709eucas1p177dd30efffed16e763fcad10686af159@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180501100242.GJ27619@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 01, 2018 12:02:42 PM Daniel Lezcano wrote:
> On Thu, Apr 26, 2018 at 01:51:28PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Set trips in ascending order in exynos7_tmu_initialize() (it should
> > make no difference in driver operation). This prepares the driver
> > code to moving trips setting from ->tmu_initialize method to
> > exynos_tmu_initialize().
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index 12b60e2..571511f 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -618,7 +618,7 @@ static void exynos7_tmu_initialize(struct platform_device *pdev)
> >  	sanitize_temp_error(data, trim_info);
> >  
> >  	/* Write temperature code for rising and falling threshold */
> > -	for (i = (of_thermal_get_ntrips(tz) - 1); i >= 0; i--) {
> > +	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
> 
> Capped with data->ntrip ?

No need to, the code in question is removed in patch #14 (also Exynos7
DTS doesn't define more trip points than data->ntrip).

> >  		tz->ops->get_trip_temp(tz, i, &temp);
> >  		temp /= MCELSIUS;
> >  		exynos7_tmu_set_trip_temp(data, i, temp);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
