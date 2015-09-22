From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU
 hotplug
Date: Tue, 22 Sep 2015 22:53:14 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509222251070.5606@nanos>
References: <Pine.LNX.4.44L0.1509051133100.30865-100000@netrider.rowland.org> <2657565.lxWtPmdjyp@vostro.rjw.lan> <55ED9328.2010501@ti.com> <2355864.I8qZFusWfm@vostro.rjw.lan> <55EE9AA1.8020200@ti.com> <7h613kmuuv.fsf@deeprootsystems.com> <55F162FD.4050401@ti.com>
 <20150922173236.GB19183@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43200 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933703AbbIVUx7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2015 16:53:59 -0400
In-Reply-To: <20150922173236.GB19183@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Rutland <mark.rutland@arm.com>, ulf.hansson@linaro.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, k.kozlowski@samsung.com, msivasub@codeaurora.org, geert@linux-m68k.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@kernel.org>, john.stultz@linaro.org

On Tue, 22 Sep 2015, Lina Iyer wrote:
> Talking to John Stultz at Linaro Connect: Is cpuidle relevant in
> -RT kernel? I dont know much about -RT. I thought this might be point
> that we should consider.

There are definitely RT systems out there where power consumption is a
concern.
 
> As it stands today, on a 800 Mhz ARM quad core, I am seeing a latency of
> 50-70 usec for the additional runtime PM in the cpuidle. Ofcourse, there
> is a definite need to optimize and there are opportunities to do that.

RT is not about being fast. RT is about being deterministic. So if a
power sensitive RT system can afford the extra latencies induced by PM
it will tolerate them. Of course, optimizing that is not a bad thing
at all :)
 
Thanks,

	tglx
