From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 1/3] exynos: config: Remove CONFIG_EXYNOS_THERMAL_CORE
 define (exynos_defconfig)
Date: Mon, 16 Feb 2015 10:55:30 +0100
Message-ID: <20150216105530.427c3e10@amdc2363>
References: <1422458920-14555-1-git-send-email-l.majewski@samsung.com>
 <20150128052640.GE29600@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:62943 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbbBPJzi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Feb 2015 04:55:38 -0500
In-reply-to: <20150128052640.GE29600@developer.hsd1.ca.comcast.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Kukjin,

> On Wed, Jan 28, 2015 at 04:28:38PM +0100, Lukasz Majewski wrote:
> > After Exynos TMU rework to use device tree for configuration this
> > flag can be removed. It is not used anymore.
> > 
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> 
> Acked-by: Eduardo Valentin <edubezval@gmail.com>

Could you add this change to -samsung tree?

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
