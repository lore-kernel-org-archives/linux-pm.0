From: YH Huang <yh.huang@mediatek.com>
Subject: Re: [PATCH] sbs-battery: fix power status when battery is dry
Date: Thu, 24 Mar 2016 14:43:52 +0800
Message-ID: <1458801832.16645.7.camel@mtksdaap41>
References: <1458726794-48298-1-git-send-email-yh.huang@mediatek.com>
	 <CAGS+omDTmJDkJYsf=gDJMrmAos+30enoAa2xfTPyirXUd37=9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:32971 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753224AbcCXGoE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 02:44:04 -0400
In-Reply-To: <CAGS+omDTmJDkJYsf=gDJMrmAos+30enoAa2xfTPyirXUd37=9g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>

Hi Daniel,

On Thu, 2016-03-24 at 12:01 +0800, Daniel Kurtz wrote:
> Hi YH,
> 
> On Wed, Mar 23, 2016 at 5:53 PM, YH Huang <yh.huang@mediatek.com> wrote:
> > When the battery is dry and BATTERY_FULL_DISCHARGED is set,
> > we should check BATTERY_DISCHARGING to decide the power status.
> > If BATTERY_DISCHARGING is set, the power status is not charging.
> > Or the power status should be charging.
> >
> > Signed-off-by: YH Huang <yh.huang@mediatek.com>
> > ---
> >  drivers/power/sbs-battery.c |   22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
> > index d6226d6..d86db0e 100644
> > --- a/drivers/power/sbs-battery.c
> > +++ b/drivers/power/sbs-battery.c
> > @@ -382,11 +382,12 @@ static int sbs_get_battery_property(struct i2c_client *client,
> >
> >                 if (ret & BATTERY_FULL_CHARGED)
> >                         val->intval = POWER_SUPPLY_STATUS_FULL;
> > -               else if (ret & BATTERY_FULL_DISCHARGED)
> > -                       val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> > -               else if (ret & BATTERY_DISCHARGING)
> > -                       val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> > -               else
> > +               else if (ret & BATTERY_DISCHARGING) {
> > +                       if (ret & BATTERY_FULL_DISCHARGED)
> > +                               val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> > +                       else
> > +                               val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> > +               } else
> 
> 
> I think (BATTERY_DISCHARGING && BATTERY_FULL_DISCHARGED) is still
> POWER_SUPPLY_STATUS_DISCHARGING.
> So, let's just report what the battery says and do:
> 
>                else if (ret & BATTERY_DISCHARGING)
>                                val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> 
So we just ignore the special situation (BATTERY_DISCHARGING &&
BATTERY_FULL_DISCHARGED).
Isn't POWER_SUPPLY_STATUS_NOT_CHARGING a useful information?

Regards,
YH Huang

