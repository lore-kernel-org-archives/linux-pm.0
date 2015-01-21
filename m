From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v5 18/18] thermal: exynos: Remove not needed
 exynos_tmu_init_data declarations from exynos_tmu.h
Date: Wed, 21 Jan 2015 10:00:46 +0100
Message-ID: <20150121100046.371aca71@amdc2363>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
 <1421666462-7606-19-git-send-email-l.majewski@samsung.com>
 <20150121033034.GC22176@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20150121033034.GC22176@developer.hsd1.ca.comcast.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

> On Mon, Jan 19, 2015 at 12:21:02PM +0100, Lukasz Majewski wrote:
> > After switching to device tree based configuration those
> > declarations are not needed anymore.
> > 
> > Reported-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > ---
> > Changes for v5:
> > - New patch
> > ---
> >   | 8 --------
> >  1 file changed, 8 deletions(-)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.h
> > b/drivers/thermal/samsung/exynos_tmu.h index d876d4c..9f9b1b8 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.h
> > +++ b/drivers/thermal/samsung/exynos_tmu.h
> > @@ -71,12 +71,4 @@ struct exynos_tmu_platform_data {
> >  	u32 cal_mode;
> >  };
> >  
> > -extern struct exynos_tmu_init_data const
> > exynos3250_default_tmu_data; -extern struct exynos_tmu_init_data
> > const exynos4210_default_tmu_data; -extern struct
> > exynos_tmu_init_data const exynos4412_default_tmu_data; -extern
> > struct exynos_tmu_init_data const exynos5250_default_tmu_data;
> > -extern struct exynos_tmu_init_data const
> > exynos5260_default_tmu_data; -extern struct exynos_tmu_init_data
> > const exynos5420_default_tmu_data; -extern struct
> > exynos_tmu_init_data const exynos5440_default_tmu_data;
> 
> Please merge this patch to the one that removes these symbols from
> kernel.

Will be done for v6 version.

> 
> > -
> >  #endif /* _EXYNOS_TMU_H */
> > -- 
> > 2.0.0.rc2
> > 



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
