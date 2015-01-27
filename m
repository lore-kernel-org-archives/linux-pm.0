From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH] thermal: Kconfig: Remove config for not used
 EXYNOS_THERMAL_CORE
Date: Tue, 27 Jan 2015 16:00:48 +0100
Message-ID: <20150127160048.2f7d4bbe@amdc2363>
References: <1422357239-20316-1-git-send-email-l.majewski@samsung.com>
 <20150127145458.GB29600@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20150127145458.GB29600@developer.hsd1.ca.comcast.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Paul Bolle <pebolle@tiscali.nl>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

> On Tue, Jan 27, 2015 at 12:13:59PM +0100, Lukasz Majewski wrote:
> > After removing exynos_thermal_common.[c|h] files the
> > CONFIG_EXYNOS_THERMA_CORE is not needed anymore.
> > This patch removes this entry from Kconfig.
> > 
> > Reported-by: Paul Bolle <pebolle@tiscali.nl>
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> 
> This patch looks fine to me and I am about to queue it in my fixes
> tree. However, you must carry along another patch to remove this
> entry: arch/arm/configs/exynos_defconfig:CONFIG_EXYNOS_THERMAL_CORE=y

OK.

> 
> Can you please post it and ask Kim to queue the above suggested
> removal too?

OK.

> 
> > ---
> >  drivers/thermal/samsung/Kconfig | 9 ---------
> >  1 file changed, 9 deletions(-)
> > 
> > diff --git a/drivers/thermal/samsung/Kconfig
> > b/drivers/thermal/samsung/Kconfig index c43306e..c8e35c1 100644
> > --- a/drivers/thermal/samsung/Kconfig
> > +++ b/drivers/thermal/samsung/Kconfig
> > @@ -7,12 +7,3 @@ config EXYNOS_THERMAL
> >  	  the TMU, reports temperature and handles cooling action
> > if defined. This driver uses the Exynos core thermal APIs and TMU
> > configuration data from the supported SoCs.
> > -
> > -config EXYNOS_THERMAL_CORE
> > -	bool "Core thermal framework support for EXYNOS SOCs"
> > -	depends on EXYNOS_THERMAL
> > -	help
> > -	  If you say yes here you get support for EXYNOS TMU
> > -	  (Thermal Management Unit) common
> > registration/unregistration
> > -	  functions to the core thermal layer and also to use the
> > generic
> > -	  CPU cooling APIs.
> > -- 
> > 2.0.0.rc2
> > 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
