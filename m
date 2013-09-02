From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH 05/14] arm64: kernel: cpu_{suspend/resume}
 implementation
Date: Mon, 2 Sep 2013 11:05:16 +0100
Message-ID: <20130902100515.GD2500@e102568-lin.cambridge.arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1377689766-17642-6-git-send-email-lorenzo.pieralisi@arm.com>
 <20130830172756.GK4650@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:37757 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642Ab3IBKFU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2013 06:05:20 -0400
In-Reply-To: <20130830172756.GK4650@arm.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dave P Martin <Dave.Martin@arm.com>, Will Deacon <Will.Deacon@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Yu Tang <ytang5@marvell.com>, Zhou Zhu <zzhu3@marvell.com>, "ksankaran@apm.com" <ksankaran@apm.com>, Loc Ho <lho@apm.com>, Feng Kan <fkan@apm.com>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

On Fri, Aug 30, 2013 at 06:27:56PM +0100, Catalin Marinas wrote:
> On Wed, Aug 28, 2013 at 12:35:57PM +0100, Lorenzo Pieralisi wrote:
> > Kernel subsystems like CPU idle and suspend to RAM require a generic
> > mechanism to suspend a processor, save its context and put it into
> > a quiescent state. The cpu_{suspend}/{resume} implementation provides
> > such a framework through a kernel interface allowing to save/restore
> > registers, flush the context to DRAM and suspend/resume to/from
> > low-power states where processor context may be lost.
> > 
> > Different SoCs might require different operations to be carried out
> > before a power down request is committed. For this reason the kernel
> > allows the caller of cpu_suspend to provide a function pointer (fn in
> > the cpu_suspend prototype below),
> > 
> > int cpu_suspend(unsigned long arg, int (*fn)(unsigned long));
> > 
> > called suspend finisher, that is executed after the context is saved and
> > flushed to DRAM, so that SoC/platform specific operations can be carried out
> > before issuing power down commands.
> > 
> > Context memory is allocated on the stack, whose address is stashed in a
> > per-cpu variable to keep track of it and passed to core functions that
> > save/restore the registers required by the architecture.
> > 
> > Even though, upon successful execution, the cpu_suspend function shuts
> > down the suspending processor, the warm boot resume mechanism, based
> > on the cpu_resume function, makes the resume path operate as a
> > cpu_suspend function return, so that cpu_suspend can be treated as a C
> > function by the caller, which simplifies coding the PM drivers that rely
> > on the cpu_suspend API.
> > 
> > Upon context save, the minimal amount of memory is flushed to DRAM so
> > that it can be retrieved when the MMU is off and caches are not searched.
> > 
> > The suspend finisher, depending on the required operations (eg CPU vs
> > Cluster shutdown) is in charge of flushing the cache hierarchy either
> > implicitly (by calling firmware implementations like PSCI) or explicitly
> > by executing the required cache maintainance functions.
> 
> As we discussed, I would like the finisher argument to cpu_suspend() to be
> removed and just use the default cpu_operations.cpu_suspend (currently
> smp_operations) which is populated from DT and uses PSCI as the default
> finisher. The cpuidle drivers can still pass arguments that would make
> their way into the PSCI CPU_SUSPEND call (like how deep to go) but I
> would like to avoid each cpuidle driver implementing a finisher that
> does the PSCI call.
> 
> If PSCI is not available, the cpuidle driver can register a different
> cpu_suspend method.

This makes perfect sense, I will update the code as soon as cpu_operations
struct and suspend method are put in place in generic kernel code.

Thanks,
Lorenzo

