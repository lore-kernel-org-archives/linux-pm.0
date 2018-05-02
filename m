From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 14/18] thermal: exynos: move trips setting to
 exynos_tmu_initialize()
Date: Wed, 02 May 2018 11:39:20 +0200
Message-ID: <1585317.VnK93dIYnt@amdc3058>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <1524743493-28113-15-git-send-email-b.zolnierkie@samsung.com>
        <20180501103126.GK27619@mai>
        <CGME20180502093921eucas1p1c1da14cc87d3e2c7f5550b961004521d@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180501103126.GK27619@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 01, 2018 12:31:26 PM Daniel Lezcano wrote:
> On Thu, Apr 26, 2018 at 01:51:29PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > * Add dummy exynos4210_tmu_set_trip_hyst() helper.
> > 
> > * Add ->tmu_set_trip_temp and ->tmu_set_trip_hyst methods to struct
> >   exynos_tmu_data and set them in exynos_map_dt_data().
> > 
> > * Move trips setting to exynos_tmu_initialize().
> > 
> > There should be no functional changes caused by this patch.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> 
> [ ... ]
> 
> > +/* failing thresholds are not supported on Exynos4210 */
> > +static void exynos4210_tmu_set_trip_hyst(struct exynos_tmu_data *data,
> > +					 int trip, u8 temp, u8 hyst)
> > +{
> > +}
> > +
> 
> May be you can get rid of this empty function and check against a NULL pointer
> in exynos_tmu_initialize ?

This is more a question of taste and I prefer adding this one dummy function
instead of adding NULL pointer check for all SoCs.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
