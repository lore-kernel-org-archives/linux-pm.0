From: Li Yang-R58472 <r58472@freescale.com>
Subject: RE: [RFC PATCH 0/5] cpuidle/ppc: Timer offload framework to support
 deep idle states
Date: Fri, 26 Jul 2013 10:05:38 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F097AD1D5@039-SN2MPN1-022.039d.mgd.msft.net>
References: <20130725090016.12500.28888.stgit@preeti.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20130725090016.12500.28888.stgit@preeti.in.ibm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>, "paulus@samba.org" <paulus@samba.org>, "shangw@linux.vnet.ibm.com" <shangw@linux.vnet.ibm.com>, "galak@kernel.crashing.org" <galak@kernel.crashing.org>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "michael@ellerman.id.au" <michael@ellerman.id.au>, "arnd@arndb.de" <arnd@arndb.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "john.stultz@linaro.org" <john.stultz@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, Zhao Chenhui-B35336 <B35336@freescale.com>, "deepthi@linux.vnet.ibm.com" <deepthi@linux.vnet.ibm.com>, "geoff@infradead.org" <geoff@infradead.org>, linux-ker
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Preeti U Murthy
> Sent: Thursday, July 25, 2013 5:03 PM
> To: benh@kernel.crashing.org; paul.gortmaker@windriver.com;
> paulus@samba.org; shangw@linux.vnet.ibm.com; galak@kernel.crashing.org;
> fweisbec@gmail.com; paulmck@linux.vnet.ibm.com; michael@ellerman.id.au;
> arnd@arndb.de; linux-pm@vger.kernel.org; rostedt@goodmis.org; rjw@sisk.pl;
> john.stultz@linaro.org; tglx@linutronix.de; Zhao Chenhui-B35336;
> deepthi@linux.vnet.ibm.com; geoff@infradead.org; linux-
> kernel@vger.kernel.org; srivatsa.bhat@linux.vnet.ibm.com;
> schwidefsky@de.ibm.com; svaidy@linux.vnet.ibm.com; linuxppc-
> dev@lists.ozlabs.org
> Subject: [RFC PATCH 0/5] cpuidle/ppc: Timer offload framework to support
> deep idle states
> 
> On PowerPC, when CPUs enter deep idle states, their local timers are
> switched off. The responsibility of waking them up at their next timer
> event, needs to be handed over to an external device. On PowerPC, we do
> not have an external device equivalent to HPET, which is currently done
> on architectures like x86. Instead we assign the local timer of one of
> the CPUs to do this job.

I don't know much about the deep idle states.  But is it necessary to turn off the timer in these states?  I mean the extra work needed on the booting CPU and re-syncing Time Base after wakeup might defeat the power consumption benefit of turning off the timer.

Btw, the Open PIC has an internal timer.  Can we use it as the wakeup event?

Regards,
Leo

> 
> This patchset is an attempt to make use of the existing timer broadcast
> framework in the kernel to meet the above requirement, except that the
> tick broadcast device is the local timer of the boot CPU.
> 
> This patch series is ported ontop of 3.11-rc1 + the cpuidle driver
> backend for powernv posted by Deepthi Dharwar recently. The current
> design and implementation supports the ONESHOT tick mode. It does not yet
> support the PERIODIC tick mode. This patch is tested with NOHZ_FULL off.
> 
> Patch[1/5], Patch[2/5]: optimize the broadcast mechanism on ppc.
> Patch[3/5]: Introduces the core of the timer offload framework on powerpc.
> Patch[4/5]: The cpu doing the broadcast should not go into tickless idle.
> Patch[5/5]: Add a deep idle state to the cpuidle state table on powernv.
> 
> Patch[5/5] is the patch that ultimately makes use of the timer offload
> framework that the patches Patch[1/5] to Patch[4/5] build.
> 
> ---
> 
> Preeti U Murthy (3):
>       cpuidle/ppc: Add timer offload framework to support deep idle
> states
>       cpuidle/ppc: CPU goes tickless if there are no arch-specific
> constraints
>       cpuidle/ppc: Add longnap state to the idle states on powernv
> 
> Srivatsa S. Bhat (2):
>       powerpc: Free up the IPI message slot of ipi call function
> (PPC_MSG_CALL_FUNC)
>       powerpc: Implement broadcast timer interrupt as an IPI message
> 
> 
>  arch/powerpc/include/asm/smp.h                  |    3 +
>  arch/powerpc/include/asm/time.h                 |    3 +
>  arch/powerpc/kernel/smp.c                       |   23 ++++--
>  arch/powerpc/kernel/time.c                      |   84
> +++++++++++++++++++++++
>  arch/powerpc/platforms/cell/interrupt.c         |    2 -
>  arch/powerpc/platforms/powernv/Kconfig          |    1
>  arch/powerpc/platforms/powernv/processor_idle.c |   48 +++++++++++++
>  arch/powerpc/platforms/ps3/smp.c                |    2 -
>  kernel/time/tick-sched.c                        |    7 ++
>  9 files changed, 161 insertions(+), 12 deletions(-)
> 
> --
> Signature
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
