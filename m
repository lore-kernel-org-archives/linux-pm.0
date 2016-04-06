From: YH Huang <yh.huang@mediatek.com>
Subject: Re: [PATCH] sbs-battery: fix power status when battery is dry
Date: Wed, 6 Apr 2016 10:35:37 +0800
Message-ID: <1459910137.7609.0.camel@mtksdaap41>
References: <1458801832.16645.7.camel@mtksdaap41>
	 <CAGS+omDhFP+_shCqEWasLDsHf-ab0-OWJJ-gZZkgihAgrZwBHA@mail.gmail.com>
	 <1459132330.16645.14.camel@mtksdaap41>
	 <CAGS+omBVStB3mfXtDHdbsOK+y2UesGYtZBtYm=ctcpBfm88VEg@mail.gmail.com>
	 <56F95451.5040607@nvidia.com> <1459216353.16645.20.camel@mtksdaap41>
	 <56FA99D0.1010004@nvidia.com> <1459328310.29450.24.camel@mtksdaap41>
	 <20160330150919.GA21068@earth> <1459392151.29450.44.camel@mtksdaap41>
	 <20160402034649.GA11414@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:14051 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754356AbcDFCfo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2016 22:35:44 -0400
In-Reply-To: <20160402034649.GA11414@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Rhyland Klein <rklein@nvidia.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Matthias Brugger <matthias.bgg@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, 2016-04-02 at 05:46 +0200, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Mar 31, 2016 at 10:42:31AM +0800, YH Huang wrote:
> > On Wed, 2016-03-30 at 17:09 +0200, Sebastian Reichel wrote:
> > > Hi,
> > > 
> > > On Wed, Mar 30, 2016 at 04:58:30PM +0800, YH Huang wrote:
> > > > If I revise the description in this way(using your clear explanation):
> > > > ------------------------------------------------------------------------
> > > > The battery capacity changing course is like this:
> > > > 
> > > > full: BATTERY_FULLY_CHARGED => POWER_SUPPLY_STATUS_FULL
> > > > <unplug AC>
> > > > high->low: BATTERY_DISCHARGING => POWER_SUPPLY_STATUS_DISCHARGING
> > > > ~0%: DISCHARGING & FULLY_DISCHARGED => POWER_SUPPLY_STATUS_NOT_CHARGING
> > > > <plug in AC>
> > > > 0%~20%: FULLY_DISCHARGED => POWER_SUPPLY_STATUS_CHARGING
> > > > 20%~: No flag => POWER_SUPPLY_STATUS_CHARGING
> > > > 
> > > > For now, it is not exactly right to show the status as
> > > > POWER_SUPPLY_STATUS_NOT_CHARGING when the battery is dry
> > > > (FULLY_DISCHARGED) and AC is plugged in.
> > > > Although the battery is in a low level, system works fine with the AC
> > > > charging.
> > > > It is better to say that the battery is charging.
> > > > ------------------------------------------------------------------------
> > > > 
> > > > How about this?
> > > > By the way, should I also revise the title?
> > > 
> > > POWER_SUPPLY_STATUS_NOT_CHARGING is used for AC connected, but
> > > battery not charging (e.g. because battery temperature is out
> > > of acceptable range). If you are discharging use
> > > POWER_SUPPLY_STATUS_DISCHARGING.
> > > 
> > > You should just ignore the FULLY_DISCHARGED bit in the status
> > > property. If you don't want to loose the information about fully
> > > discharged battery add POWER_SUPPLY_PROP_CAPACITY_LEVEL, which maps:
> > > 
> > > BATTERY_FULLY_CHARGED => POWER_SUPPLY_CAPACITY_LEVEL_FULL
> > > FULLY_DISCHARGED => POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL
> > > otherwise => POWER_SUPPLY_CAPACITY_LEVEL_NORMAL
> > 
> > Oops.
> > It looks like I misunderstand POWER_SUPPLY_STATUS_NOT_CHARGING.
> > As Daniel said before, we could just ignore FULLY_DISCHARGED.
> > 
> > So change like the
> > 
> > sbs-battery: fix power status when battery charging near
> > dry
> > 
> > POWER_SUPPLY_STATUS_NOT_CHARGING is used for AC connected, but
> > battery not charging (e.g. because battery temperature is out
> > of acceptable range).
> > 
> > When battery is charging near dry and BATTERY_FULL_DISCHARGED is set,
> > it is wrong to set as POWER_SUPPLY_STATUS_NOT_CHARGING.
> > Just use BATTERY_DISCHARGING to decide the power supply status is
> > discharging or charging.
> > 
> >                 if (ret & BATTERY_FULL_CHARGED)
> >                         val->intval = POWER_SUPPLY_STATUS_FULL;
> > -               else if (ret & BATTERY_FULL_DISCHARGED)
> > -                       val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
> >                 else if (ret & BATTERY_DISCHARGING)
> >                         val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
> > 
> 
> Yes, that looks fine. Can you send this correctly formated for git?

Sure, I will send a new patch for it.

YH Huang

