From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 01/18] thermal: exynos: fix setting rising_threshold for
 Exynos5433
Date: Mon, 30 Apr 2018 17:21:40 +0200
Message-ID: <1562606.5jxUSbM0dm@amdc3058>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
        <1524743493-28113-2-git-send-email-b.zolnierkie@samsung.com>
        <20180430143656.GH11457@mai>
        <CGME20180430152141eucas1p2f39d7e8ee83a1fa66ccd19f74442357f@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180430143656.GH11457@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, April 30, 2018 04:36:56 PM Daniel Lezcano wrote:
> On Thu, Apr 26, 2018 at 01:51:16PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > Add missing clearing of the previous value when setting rising
> > temperature threshold.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index cda716c..523d26e 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -577,6 +577,7 @@ static int exynos5433_tmu_initialize(struct platform_device *pdev)
> >  		threshold_code = temp_to_code(data, temp);
> >  
> >  		rising_threshold = readl(data->base + rising_reg_offset);
> > +		rising_threshold &= ~(0xff << j * 8);
> >  		rising_threshold |= (threshold_code << j * 8);
> 
> Bartlomiej,
> 
> I see this code is duplicated all around the driver, so I can't blame you to
> fix it in the same way it is written today but this is not how to deal with

This patch is a bugfix (which may be backported later) and it shouldn't be
mixed with cleanups.

> fields in a register mapping. Can you fix it by adding correct macros with
> masks?

After my patch series we still have following occurrences of "RMW" code:

        th = readl(data->base + EXYNOS_THD_TEMP_RISE);
        th &= ~(0xff << 8 * trip);
        th |= temp_to_code(data, temp) << 8 * trip;
        writel(th, data->base + EXYNOS_THD_TEMP_RISE);

        th = readl(data->base + EXYNOS_THD_TEMP_FALL);
        th &= ~(0xff << 8 * trip);
        if (hyst)
                th |= temp_to_code(data, temp - hyst) << 8 * trip;
        writel(th, data->base + EXYNOS_THD_TEMP_FALL);

        th = readl(data->base + reg_off);
        th &= ~(0xff << j * 8);
        th |= (temp_to_code(data, temp) << j * 8);
        writel(th, data->base + reg_off);

        th = readl(data->base + reg_off);
        th &= ~(0xff << j * 8);
        th |= (temp_to_code(data, temp - hyst) << j * 8);
        writel(th, data->base + reg_off);

        th = readl(data->base + EXYNOS7_THD_TEMP_RISE7_6 + reg_off);
        th &= ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
        th |= temp_to_code(data, temp) << (16 * bit_off);
        writel(th, data->base + EXYNOS7_THD_TEMP_RISE7_6 + reg_off);

        th = readl(data->base + EXYNOS7_THD_TEMP_FALL7_6 + reg_off);
        th &= ~(EXYNOS7_TMU_TEMP_MASK << (16 * bit_off));
        th |= temp_to_code(data, temp - hyst) << (16 * bit_off);
        writel(th, data->base + EXYNOS7_THD_TEMP_FALL7_6 + reg_off);

My personal opinion is that adding new macro for the code above will
only obfuscate it and make it harder to understand,

Anyway how would you like this new macro to look like (how generic or
specific it should be etc.)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
