From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RESEND][PATCH 1/3] thermal: mediatek: Add cpu dynamic power
 cooling model.
Date: Wed, 20 Apr 2016 20:40:42 -0700
Message-ID: <20160421034040.GA26525@localhost.localdomain>
References: <1458029437-12846-1-git-send-email-dawei.chien@mediatek.com>
 <CAJZ5v0hpkyMCVhvYy4JzR1A5OZKs7dqDOB64aQXmjXiLM0F=BQ@mail.gmail.com>
 <57176ECF.6020705@gmail.com>
 <12007858.UuqVGafLHV@vostro.rjw.lan>
 <20160421030141.GA4845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36662 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbcDUDkq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 23:40:46 -0400
Content-Disposition: inline
In-Reply-To: <20160421030141.GA4845@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Dawei Chien <dawei.chien@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, Punit

On Wed, Apr 20, 2016 at 08:01:41PM -0700, Eduardo Valentin wrote:
> On Thu, Apr 21, 2016 at 02:41:24AM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, April 20, 2016 01:58:07 PM Matthias Brugger wrote:
> > > Hi Rafael,
> > > 
> > > On 13/04/16 06:52, Rafael J. Wysocki wrote:
> > > > On Tue, Apr 12, 2016 at 7:38 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > >> Hi Rafael,
> > > >>
> > > >> On 15-03-16, 16:10, Dawei Chien wrote:
> > > >>> MT8173 cpufreq driver select of_cpufreq_power_cooling_register registering
> > > >>> cooling devices with dynamic power coefficient.
> > > >>>
> > > >>> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> > > >>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > >>
> > > >> Can you please apply this patch from Dawei ?
> > > >
> > > > I can, but I'm traveling this week, so that's rather going to happen next week.
> > > >
> > > 
> > > I don't see the patch in linux-next, did you forget to pick/push it?
> > 
> > No, I didn't.  I just didn't have the time to get to them before.
> > 
> > Now, given that they are thermal patches, they really should go in via
> > linux-soc-thermal.git.
> > 
> > Eduardo, any chance to take care of these?
> 
> Yes I can add this one, given that they have the proper acked-by. I was
> a bit hesitant to just get them because they are touching
> drivers/cpufreq. 
> 
> Anyways, I am adding this to my branch to the next merge window.

Added the driver changes. The dt parts should go via your platform tree.
And you can add my 
Acked-by: Eduardo Valentin <edubezval@gmail.com>

on the dt changes.

> 
> 
> > 
> > Thanks,
> > Rafael
> > 
