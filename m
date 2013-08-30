From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH 05/14] arm64: kernel: cpu_{suspend/resume}
 implementation
Date: Fri, 30 Aug 2013 18:27:56 +0100
Message-ID: <20130830172756.GK4650@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1377689766-17642-6-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1377689766-17642-6-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Feng Kan <fkan@apm.com>, Russell King <linux@arm.linux.org.uk>, Graeme Gregory <graeme.gregory@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, Yu Tang <ytang5@marvell.com>, Nicolas Pitre <nico@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Loc Ho <lho@apm.com>, Colin Cross <ccross@android.com>, "ksankaran@apm.com" <ksankaran@apm.com>, Dave P Martin <Dave.Martin@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Zhou Zhu <zzhu3@marvell.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 28, 2013 at 12:35:57PM +0100, Lorenzo Pieralisi wrote:
> Kernel subsystems like CPU idle and suspend to RAM require a generic
> mechanism to suspend a processor, save its context and put it into
> a quiescent state. The cpu_{suspend}/{resume} implementation provides
> such a framework through a kernel interface allowing to save/restore
> registers, flush the context to DRAM and suspend/resume to/from
> low-power states where processor context may be lost.
> 
> Different SoCs might require different operations to be carried out
> before a power down request is committed. For this reason the kernel
> allows the caller of cpu_suspend to provide a function pointer (fn in
> the cpu_suspend prototype below),
> 
> int cpu_suspend(unsigned long arg, int (*fn)(unsigned long));
> 
> called suspend finisher, that is executed after the context is saved and
> flushed to DRAM, so that SoC/platform specific operations can be carried out
> before issuing power down commands.
> 
> Context memory is allocated on the stack, whose address is stashed in a
> per-cpu variable to keep track of it and passed to core functions that
> save/restore the registers required by the architecture.
> 
> Even though, upon successful execution, the cpu_suspend function shuts
> down the suspending processor, the warm boot resume mechanism, based
> on the cpu_resume function, makes the resume path operate as a
> cpu_suspend function return, so that cpu_suspend can be treated as a C
> function by the caller, which simplifies coding the PM drivers that rely
> on the cpu_suspend API.
> 
> Upon context save, the minimal amount of memory is flushed to DRAM so
> that it can be retrieved when the MMU is off and caches are not searched.
> 
> The suspend finisher, depending on the required operations (eg CPU vs
> Cluster shutdown) is in charge of flushing the cache hierarchy either
> implicitly (by calling firmware implementations like PSCI) or explicitly
> by executing the required cache maintainance functions.

As we discussed, I would like the finisher argument to cpu_suspend() to be
removed and just use the default cpu_operations.cpu_suspend (currently
smp_operations) which is populated from DT and uses PSCI as the default
finisher. The cpuidle drivers can still pass arguments that would make
their way into the PSCI CPU_SUSPEND call (like how deep to go) but I
would like to avoid each cpuidle driver implementing a finisher that
does the PSCI call.

If PSCI is not available, the cpuidle driver can register a different
cpu_suspend method.

-- 
Catalin
