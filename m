From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] ARM: cpuidle: Support asymmetric idle definition
Date: Thu, 22 Jun 2017 16:27:52 +0200
Message-ID: <2129371.vqmlXSuh4K@aspire.rjw.lan>
References: <20170612155441.GE2261@mai> <2056969.dMlCPX6XND@aspire.rjw.lan> <9c00e3ed-693d-4ea7-7a9f-be158b7eb7c5@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48045 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750812AbdFVOfL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jun 2017 10:35:11 -0400
In-Reply-To: <9c00e3ed-693d-4ea7-7a9f-be158b7eb7c5@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Leo Yan <leo.yan@linaro.org>, open list <linux-kernel@vger.kernel.org>

On Thursday, June 22, 2017 02:25:19 PM Daniel Lezcano wrote:
> On 12/06/2017 20:49, Rafael J. Wysocki wrote:
> > On Monday, June 12, 2017 05:55:10 PM Daniel Lezcano wrote:
> >> Some hardware have clusters with different idle states. The current code does
> >> not support this and fails as it expects all the idle states to be identical.
> >>
> >> Because of this, the Mediatek mtk8173 had to create the same idle state for a
> >> big.Little system and now the Hisilicon 960 is facing the same situation.
> >>
> >> Solve this by simply assuming the multiple driver will be needed for all the
> >> platforms using the ARM generic cpuidle driver which makes sense because of the
> >> different topologies we can support with a single kernel for ARM32 or ARM64.
> >>
> >> Every CPU has its own driver, so every single CPU can specify in the DT the
> >> idle states.
> >>
> >> This simple approach allows to support the future dynamIQ system, current SMP
> >> and HMP.
> >>
> >> Tested on:
> >>  - 96boards: Hikey 620
> >>  - 96boards: Hikey 960
> >>  - 96boards: dragonboard410c
> >>  - Mediatek 8173
> >>
> >> Cc: Sudeep Holla <sudeep.holla@arm.com>
> >> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >> Tested-by: Leo Yan <leo.yan@linaro.org>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > 
> > There seems to have been quite some discussion regarding this one and I'm not
> > sure about the resolution of it.
> > 
> > I'd feel more comfortable with an ACK or Reviewed-by from Sudeep or Lorenzo here.
> 
> 
> Hi Rafael,
> 
> just a gentle reminder, Sudeep acked the patch.

Yes, I'll get to it later today, most likely.

Thanks,
Rafael
