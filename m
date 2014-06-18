From: Sebastian Capella <sebcape@gmail.com>
Subject: Re: [PATCH v4 1/6] Documentation: arm: define DT idle states bindings
Date: Wed, 18 Jun 2014 11:20:11 -0700
Message-ID: <CAPd3N-9J7m_cqLgG0PgkGaZvnqSr9WrdOtWAC5_gA4_9qjSOfQ@mail.gmail.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1402503520-8611-2-git-send-email-lorenzo.pieralisi@arm.com>
	<alpine.LFD.2.11.1406111240010.25775@knanqh.ubzr>
	<20140613164954.GA16745@e102568-lin.cambridge.arm.com>
	<alpine.LFD.2.11.1406131306160.25775@knanqh.ubzr>
	<20140618173648.GB31573@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:54930 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbaFRSUM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jun 2014 14:20:12 -0400
In-Reply-To: <20140618173648.GB31573@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie>

On Wed, Jun 18, 2014 at 10:36 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Fri, Jun 13, 2014 at 06:33:35PM +0100, Nicolas Pitre wrote:
>> On Fri, 13 Jun 2014, Lorenzo Pieralisi wrote:
>>
>> > On Wed, Jun 11, 2014 at 07:15:16PM +0100, Nicolas Pitre wrote:
>> > >
>> > > ...__[EXEC]__|__[PREP]--|__[ENTRY]__|__[IDLE]__|___[EXIT]_--|__[EXEC]__...
>> > >              |          |           |          |            |
>> > >              |<-- entry-latency --->|
>> > >                                                |<- exit-  ->|
>> > >                                                |  latency   |
>> > >              |<-------------- min-residency --------------->|
>> > >                         |<----- worst_wakeup_latency ------>|
>> > >
>> > > entry-latency: Worst case latency required to enter the idle state.  The
>> > > exit_latency may be guaranteed only after entry-latency has passed.
>> > >
>> > > min-residency: Minimum period, including preparation, entry and exit,
>> > > for a given power mode to be worthwhile energy wise.  It must be at
>> > > least equal to entry_latency + exit_latency.
>
> Ok, a minor tweak to the diagram above, min-residency should include
> energy costs related to idle entry and exit, but not the exit-latency
> itself, as long as the energy costs implied by exiting the state are
> factored out in the min-residency-us property.

This makes sense to me..

It includes accounting for the energy cost vs WFI of prep/entry/exit,
but timing is from the end of the previous exec, until the event is
expected to trigger.

Thanks!

Sebastian
