From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 1/3] exynos: config: Remove CONFIG_EXYNOS_THERMAL_CORE
 define (exynos_defconfig)
Date: Wed, 04 Feb 2015 14:49:43 +0100
Message-ID: <20150204144943.58003ac6@amdc2363>
References: <1422458920-14555-1-git-send-email-l.majewski@samsung.com>
 <20150129225908.GH29837@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20150129225908.GH29837@developer.amazonguestwifi.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Kukjin,

> On Wed, Jan 28, 2015 at 04:28:38PM +0100, Lukasz Majewski wrote:
> > After Exynos TMU rework to use device tree for configuration this
> > flag can be removed. It is not used anymore.
> > 
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> 
> I dont see problems with this patch:
> 
> Acked-by: Eduardo Valentin <edubezval@gmail.com>
> 
> This should go, obviously, via the correct platform tree.

Could you apply this patch to -samsung tree?

> 
> > ---
> >  arch/arm/configs/exynos_defconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/arm/configs/exynos_defconfig
> > b/arch/arm/configs/exynos_defconfig index 3d0c5d6..3691a68 100644
> > --- a/arch/arm/configs/exynos_defconfig
> > +++ b/arch/arm/configs/exynos_defconfig
> > @@ -88,7 +88,6 @@ CONFIG_HWMON=y
> >  CONFIG_SENSORS_LM90=y
> >  CONFIG_THERMAL=y
> >  CONFIG_EXYNOS_THERMAL=y
> > -CONFIG_EXYNOS_THERMAL_CORE=y
> >  CONFIG_WATCHDOG=y
> >  CONFIG_S3C2410_WATCHDOG=y
> >  CONFIG_MFD_CROS_EC=y
> > -- 
> > 2.0.0.rc2
> > 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
