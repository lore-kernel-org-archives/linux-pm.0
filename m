From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 3/3] exynos: config: Enable support for cpufreq on Exynos
 SoCs (exynos_defconfig)
Date: Wed, 04 Feb 2015 14:52:03 +0100
Message-ID: <20150204145203.004d6b8c@amdc2363>
References: <1422458920-14555-1-git-send-email-l.majewski@samsung.com>
 <1422458920-14555-3-git-send-email-l.majewski@samsung.com>
 <20150129230109.GI29837@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:15008 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbbBDNwN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 08:52:13 -0500
In-reply-to: <20150129230109.GI29837@developer.amazonguestwifi.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Kukjin,

> On Wed, Jan 28, 2015 at 04:28:40PM +0100, Lukasz Majewski wrote:
> > This commit enables the cpufreq subsystem. Moreover, support for
> > using CPU as a cooling device is provided.
> > 
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> 
> I dont see problems with this patch:
> 
> Acked-by: Eduardo Valentin <edubezval@gmail.com>
> 
> 
> Again, it must go via the correct tree.

Could you apply this patch to -samsung tree?

> 
> > ---
> >  arch/arm/configs/exynos_defconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/configs/exynos_defconfig
> > b/arch/arm/configs/exynos_defconfig index 376dbf4..d6be7e8 100644
> > --- a/arch/arm/configs/exynos_defconfig
> > +++ b/arch/arm/configs/exynos_defconfig
> > @@ -86,6 +86,8 @@ CONFIG_BATTERY_SBS=y
> >  CONFIG_CHARGER_TPS65090=y
> >  CONFIG_HWMON=y
> >  CONFIG_SENSORS_LM90=y
> > +CONFIG_CPU_FREQ=y
> > +CONFIG_CPU_THERMAL=y
> >  CONFIG_THERMAL=y
> >  CONFIG_EXYNOS_THERMAL=y
> >  CONFIG_THERMAL_EMULATION=y
> > -- 
> > 2.0.0.rc2
> > 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
