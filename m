From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 4/6] thermal: exynos: Replace SOC_ARCH_EXYNOS with
 SOC_ARCH_EXYNOS5250
Date: Fri, 04 Oct 2013 12:13:57 +0200
Message-ID: <4865794.YPLcc7kNlS@amdc1032>
References: <1380010102-25817-1-git-send-email-l.majewski@samsung.com>
 <1380010102-25817-5-git-send-email-l.majewski@samsung.com>
 <524DEAED.4030905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <524DEAED.4030905@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Thursday, October 03, 2013 06:08:45 PM Eduardo Valentin wrote:
> On 24-09-2013 04:08, Lukasz Majewski wrote:
> > The TMU data definition is now separated to Exynos4412 and Exynos5250.
> > 
> > Now SOC_ARCH_EXYNOS only refers to Exynos5250. Hence the name
> > SOC_ARCH_EXYNOS has been changed to SOC_ARCH_EXYNOS5250.
> > 
> 
> How about merging this one with patch 02?

I would prefer that this is not done since patch #2 is a separate logical
change and it should be kept as a minimal preparatory patch for patch #3
(which is an important bugfix) to make potential backporting of fixes into
-stable etc. easier.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c      |    4 ++--
> >  drivers/thermal/samsung/exynos_tmu.h      |    2 +-
> >  drivers/thermal/samsung/exynos_tmu_data.c |    2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index 21b89e4..037cd46 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -632,9 +632,9 @@ static int exynos_tmu_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >  
> > -	if (pdata->type == SOC_ARCH_EXYNOS ||
> > -	    pdata->type == SOC_ARCH_EXYNOS4210 ||
> > +	if (pdata->type == SOC_ARCH_EXYNOS4210 ||
> >  	    pdata->type == SOC_ARCH_EXYNOS4412 ||
> > +	    pdata->type == SOC_ARCH_EXYNOS5250 ||
> >  	    pdata->type == SOC_ARCH_EXYNOS5440)
> >  		data->soc = pdata->type;
> >  	else {
> > diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
> > index db37df0..b42ece4 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.h
> > +++ b/drivers/thermal/samsung/exynos_tmu.h
> > @@ -42,7 +42,7 @@ enum calibration_mode {
> >  enum soc_type {
> >  	SOC_ARCH_EXYNOS4210 = 1,
> >  	SOC_ARCH_EXYNOS4412,
> > -	SOC_ARCH_EXYNOS,
> > +	SOC_ARCH_EXYNOS5250,
> >  	SOC_ARCH_EXYNOS5440,
> >  };
> >  
> > diff --git a/drivers/thermal/samsung/exynos_tmu_data.c b/drivers/thermal/samsung/exynos_tmu_data.c
> > index bd08093..188223f 100644
> > --- a/drivers/thermal/samsung/exynos_tmu_data.c
> > +++ b/drivers/thermal/samsung/exynos_tmu_data.c
> > @@ -183,7 +183,7 @@ struct exynos_tmu_init_data const exynos4412_default_tmu_data = {
> >  struct exynos_tmu_init_data const exynos5250_default_tmu_data = {
> >  	.tmu_data = {
> >  		{ EXYNOS4412_TMU_DATA,
> > -		.type = SOC_ARCH_EXYNOS,
> > +		.type = SOC_ARCH_EXYNOS5250,
> >  		},
> >  	},
> >  	.tmu_count = 1,
