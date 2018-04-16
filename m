From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 12/14] thermal: exynos: remove separate exynos_tmu.h
 header file
Date: Mon, 16 Apr 2018 16:24:50 +0200
Message-ID: <4780353.WGAykbfPTG@amdc3058>
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <1523873525-23718-13-git-send-email-b.zolnierkie@samsung.com>
        <fa04dbd9-fdb4-26e4-ac1d-2aa3a5840465@linaro.org>
        <CGME20180416142452eucas1p2feb091d3ba51e78f42e93e184eb01291@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fa04dbd9-fdb4-26e4-ac1d-2aa3a5840465@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, April 16, 2018 03:24:57 PM Daniel Lezcano wrote:
> On 16/04/2018 12:12, Bartlomiej Zolnierkiewicz wrote:
> > exynos_tmu.h is used only by exynos_tmu.c so there is no need
> > for a separate include file.
> > 
> > There should be no functional changes caused by this patch.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 18 +++++++++++++++-
> >  drivers/thermal/samsung/exynos_tmu.h | 41 ------------------------------------
> >  2 files changed, 17 insertions(+), 42 deletions(-)
> >  delete mode 100644 drivers/thermal/samsung/exynos_tmu.h
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index 7975f33..197f267 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -34,8 +34,10 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/cpu_cooling.h>
> > +
> 
> This one should go away, no ?

Yes, thanks for noticing (I've just sent v2 of this patch).
.
> Apart this.
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
