From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v2 1/5] thermal: change "hysteresis" as optional property
Date: Fri, 4 Mar 2016 11:57:53 +0000
Message-ID: <20160304115752.GA13894@e104805>
References: <1456458227-12950-1-git-send-email-leo.yan@linaro.org>
 <1456458227-12950-2-git-send-email-leo.yan@linaro.org>
 <20160303162942.GA2445@localhost.localdomain>
 <20160304030349.GA11012@leoy-linaro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43642 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750777AbcCDL56 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Mar 2016 06:57:58 -0500
Content-Disposition: inline
In-Reply-To: <20160304030349.GA11012@leoy-linaro>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Zhang Rui <rui.zhang@intel.com>, kongxinwei <kong.kongxinwei@hisilicon.com>, Punit Agrawal <Punit.Agrawal@arm.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Fri, Mar 04, 2016 at 11:03:49AM +0800, Leo Yan wrote:
> Hi Eduardo,
> 
> On Thu, Mar 03, 2016 at 08:29:44AM -0800, Eduardo Valentin wrote:
> > Hi Leo,
> > 
> > On Fri, Feb 26, 2016 at 11:43:43AM +0800, Leo Yan wrote:
> > > The property "hysteresis" is mandatory for trip points, so if without
> > > it the thermal zone cannot register successfully. But "hysteresis" is
> > > ignored in the thermal subsystem and only inquired by several thermal
> > > sensor drivers.
> > 
> > I am not sure this a good direction to go. Remember that Linux
> > implementation not necessarily has to be the implication of the DT
> > binding. Hysteresis is a property that plays a significant role on
> > thermal control systems, which in many cases avoid overshooting cooling
> > actions. Having the DT writer to explicitly set it to 0 means that zone
> > does not suffer of overshooting and does not need hysteresis.
> 
> After review current code, the "hysteresis" is used to calculate
> temperature falling threshold with a more conservative value; so that
> finally avoid overshooting issue.
> 
> Please confirm if is my understanding correct or not?
> 
> > If the Linux thermal subsystem has a problem with handling hysteresis, I
> > would rather fix Linux code than relaxing the DT binding. Or if you
> > still believe hysteresis is really optional, I would prefer to see a
> > better justification than "Linux ignores it".

I see it the other way round, Is hysteresis a property that, without
it, the thermal code can't configure itself so it fails to create the
trip point?  The current code goes "There is no hysteresis for this
property, I don't know how to set up this trip point!".  I think we
can do better than this.

> If we think about power allocator governor, PID's two parameters are
> also used to dismiss overshooting issue: one is k_po (proportional
> term), another is k_i (integral term). So that means after we apply
> power allocator governor, we don't need parameter "hysteresis" due PID
> algorithm can automatically dismiss potential errors.

I disagree.  We shouldn't base DT decisions based on only one
governor in linux.  Having said that, AFAICS all governors currently
ignore hysteresis.

Cheers,
Javi
