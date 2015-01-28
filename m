From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFT PATCH 1/4] power_supply: twl4030_madc: Check return value of
 power_supply_register
Date: Wed, 28 Jan 2015 08:58:41 +0100
Message-ID: <1422431921.8854.4.camel@AMDC1943>
References: <1422358221-13199-1-git-send-email-k.kozlowski@samsung.com>
 <1422358221-13199-2-git-send-email-k.kozlowski@samsung.com>
 <CAAfyv34YoUG8dyq10mFZRQ-uf6-oT_KAbwZ1UQQ0FvFrs10BrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45679 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155AbbA2CJK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jan 2015 21:09:10 -0500
In-reply-to: <CAAfyv34YoUG8dyq10mFZRQ-uf6-oT_KAbwZ1UQQ0FvFrs10BrQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: Dmitry Artamonow <mad_soft@inbox.ru>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, stable@vger.kernel.org

On wto, 2015-01-27 at 22:06 +0100, Belisko Marek wrote:
> Hi Krzystof,
> 
> On Tue, Jan 27, 2015 at 12:30 PM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
> > The return value of power_supply_register() call was not checked and
> > even on error probe() function returned 0. If registering failed then
> > during unbind the driver tried to unregister power supply which was not
> > actually registered.
> >
> > This could lead to memory corruption because power_supply_unregister()
> > unconditionally cleans up given power supply.
> >
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Fixes: da0a00ebc239 ("power: Add twl4030_madc battery driver.")
> > Cc: <stable@vger.kernel.org>
> > ---
> >  drivers/power/twl4030_madc_battery.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/power/twl4030_madc_battery.c b/drivers/power/twl4030_madc_battery.c
> > index 7ef445a6cfa6..cf907609ec49 100644
> > --- a/drivers/power/twl4030_madc_battery.c
> > +++ b/drivers/power/twl4030_madc_battery.c
> > @@ -192,6 +192,7 @@ static int twl4030_madc_battery_probe(struct platform_device *pdev)
> >  {
> >         struct twl4030_madc_battery *twl4030_madc_bat;
> >         struct twl4030_madc_bat_platform_data *pdata = pdev->dev.platform_data;
> > +       int ret = 0;
> >
> >         twl4030_madc_bat = kzalloc(sizeof(*twl4030_madc_bat), GFP_KERNEL);
> >         if (!twl4030_madc_bat)
> > @@ -216,9 +217,11 @@ static int twl4030_madc_battery_probe(struct platform_device *pdev)
> >
> >         twl4030_madc_bat->pdata = pdata;
> >         platform_set_drvdata(pdev, twl4030_madc_bat);
> > -       power_supply_register(&pdev->dev, &twl4030_madc_bat->psy);
> > +       ret = power_supply_register(&pdev->dev, &twl4030_madc_bat->psy);
> > +       if (ret < 0)
> > +               kfree(twl4030_madc_bat);
> I post update twl4030_madc to iio some time ago [1] where this change
> was incorporated.
> I plan to respin in next week so we can drop this one (or take and
> I'll rebase on top).

Hi,

I am fine with both solutions (especially that I am not able to test my
change). However there is one benefit of my fix: after applying it could
be backported to stable kernels (3.11+?).

Best regards,
Krzysztof

> >
> > -       return 0;
> > +       return ret;
> >  }
> >
> >  static int twl4030_madc_battery_remove(struct platform_device *pdev)
> > --
> > 1.9.1
> >
> 
> [1] - https://lkml.org/lkml/2014/3/5/284
> 
> BR,
> 
> marek
> 

