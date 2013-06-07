From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PM / devfreq: Fix incorrect usage of IS_ERR_OR_NULL in exynos5_bus.c
Date: Fri, 07 Jun 2013 12:56:54 +0200
Message-ID: <2776710.Oxrckb5dd8@vostro.rjw.lan>
References: <CAJ0PZbRM0tUs=FrhdVWVf9-_z=O_gkDSYjEGFgJP1xHsEVGNZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59425 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527Ab3FGKrt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 7 Jun 2013 06:47:49 -0400
In-Reply-To: <CAJ0PZbRM0tUs=FrhdVWVf9-_z=O_gkDSYjEGFgJP1xHsEVGNZw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@gmail.com
Cc: Sachin Kamat <sachin.kamat@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, "patches@linaro.org" <patches@linaro.org>

On Friday, June 07, 2013 07:21:58 PM MyungJoo Ham wrote:
> On Wed, Jun 5, 2013 at 3:12 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> >
> > platform_device_register_simple does not return NULL.
> > Hence NULL check is not required.
> >
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> 
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> 
> 
> Will be applied soon.

Are you going to handle all of the new devfreq patches from Sachin?

Rafael


> 
> > ---
> >  drivers/devfreq/exynos/exynos5_bus.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/devfreq/exynos/exynos5_bus.c b/drivers/devfreq/exynos/exynos5_bus.c
> > index 574b16b..cd1e630 100644
> > --- a/drivers/devfreq/exynos/exynos5_bus.c
> > +++ b/drivers/devfreq/exynos/exynos5_bus.c
> > @@ -479,7 +479,7 @@ static int __init exynos5_busfreq_int_init(void)
> >
> >         exynos5_devfreq_pdev =
> >                 platform_device_register_simple("exynos5-bus-int", -1, NULL, 0);
> > -       if (IS_ERR_OR_NULL(exynos5_devfreq_pdev)) {
> > +       if (IS_ERR(exynos5_devfreq_pdev)) {
> >                 ret = PTR_ERR(exynos5_devfreq_pdev);
> >                 goto out1;
> >         }
> > --
> > 1.7.9.5
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> 
> --
> MyungJoo Ham, Ph.D.
> Mobile Software Platform Lab, DMC Business, Samsung Electronics
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
