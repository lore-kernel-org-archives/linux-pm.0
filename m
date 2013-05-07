From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 5/6] thermal: rcar: remove unnecessary
 platform_set_drvdata()
Date: Tue, 07 May 2013 10:36:37 +0900
Message-ID: <000801ce4ac3$50c048a0$f240d9e0$@samsung.com>
References: <004201ce4a12$816b9060$8442b120$@samsung.com>
 <uehdjeib4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:28106 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758214Ab3EGBgj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2013 21:36:39 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MME00M9AN510HJ0@mailout2.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 07 May 2013 10:36:37 +0900 (KST)
In-reply-to: <uehdjeib4.wl%kuninori.morimoto.gx@renesas.com>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Kuninori Morimoto' <kuninori.morimoto.gx@renesas.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>
Cc: 'Zhang Rui' <rui.zhang@intel.com>, 'Eduardo Valentin' <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

On Tuesday, May 07, 2013 9:38 AM, Kuninori Morimoto wrote:
> 
> Dear Jingoo, Sachin
> 
> > The driver core clears the driver data to NULL after device_release
> > or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> > (device-core: Ensure drvdata = NULL when no driver is bound).
> > Thus, it is not needed to manually clear the device driver data to NULL.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/thermal/rcar_thermal.c |    2 --
> >  1 files changed, 0 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> > index 8d7edd4..63c7c13 100644
> > --- a/drivers/thermal/rcar_thermal.c
> > +++ b/drivers/thermal/rcar_thermal.c
> > @@ -487,8 +487,6 @@ static int rcar_thermal_remove(struct platform_device *pdev)
> >  			rcar_thermal_irq_disable(priv);
> >  	}
> >
> > -	platform_set_drvdata(pdev, NULL);
> > -
> >  	pm_runtime_put_sync(dev);
> >  	pm_runtime_disable(dev);
> 
> I got very similar patch for rcar_thermal.c
> from Jingoo and Sachin
> 
> Subject: [PATCH 5/6] thermal: rcar: remove unnecessary platform_set_drvdata()
> From: Jingoo Han <jg1.han@samsung.com>
> 
> Subject: [PATCH 5/6] Thermal: rcar: Remove redundant platform_set_drvdata()
> From: Sachin Kamat <sachin.kamat@linaro.org>
> 
> I'm not sure which one will be applied, but, for both patch,
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Kuninori Morimoto,

In this case, Sachin submitted the patchset before I did;
thus, Sachin's patch will be merged.

Sachin, thank you for your job.
Without you, cleaning cannot be done. :)


Best regards,
Jingoo Han

> 
> Best regards
> --
> Kuninori Morimoto
> 

