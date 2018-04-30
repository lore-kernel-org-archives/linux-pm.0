From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 06/18] thermal: exynos: fix trips limit checking in
 get_th_reg()
Date: Mon, 30 Apr 2018 17:48:29 +0200
Message-ID: <26762578.lZtk787caq@amdc3058>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <1524743493-28113-7-git-send-email-b.zolnierkie@samsung.com>
        <20180430153431.GB27619@mai>
        <CGME20180430154830eucas1p20a5d8e1d4d50c60f8072ce022b6afb1d@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180430153431.GB27619@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, April 30, 2018 05:34:31 PM Daniel Lezcano wrote:
> On Thu, Apr 26, 2018 at 01:51:21PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > of_thermal_get_ntrips() may return value bigger than supported
> > by a given SoC (i.e. on Exynos5422/5800) 
> 
> Can you elaborate a bit ?

Odroid-XU3 DTS file [1] define 6 thermal trip points (2 passive ones)
while data->ntrip is 4, the current code works fine by accident as
the threshold values for trip points 5 & 6 don't fit into 32-bits
threshold value (however since they are passive ones this is okay).

Of course the code for handling passive trip points still needs to
be fixed to properly handle all odd cases (which are not present in
current DTS files).

[1] arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi

> > so fix the code to not
> > iterate the loop for i values >= data->ntrip.
> > 
> > There should be no functional changes caused by this patch.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index 5a64879..58cd68e 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -311,9 +311,9 @@ static u32 get_th_reg(struct exynos_tmu_data *data, u32 threshold, bool falling)
> >  	const struct thermal_trip * const trips =
> >  		of_thermal_get_trip_points(tz);
> >  	unsigned long temp;
> > -	int i;
> > +	int i, ntrips = min_t(int, of_thermal_get_ntrips(tz), data->ntrip);
> >  
> > -	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
> > +	for (i = 0; i < ntrips; i++) {
> >  		if (trips[i].type == THERMAL_TRIP_CRITICAL)
> >  			continue;

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
