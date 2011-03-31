From: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/9] x86 idle cruft removal - v2
Date: Thu, 31 Mar 2011 12:09:13 +0530
Message-ID: <4D942191.2080408__19539.1821362593$1301553623$gmane$org@linux.vnet.ibm.com>
References: <1300950508-22746-1-git-send-email-lenb@kernel.org>
	<1301551404-8263-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1301551404-8263-1-git-send-email-lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 03/31/2011 11:33 AM, Len Brown wrote:
> unchanged:
>
> [PATCH 1/9] x86 idle: remove "no-hlt" cmdline param
> [PATCH 2/9] x86 idle: remove NOP cpuinfo_x86.hlt_works_ok flag
> [PATCH 3/9] x86 idle: remove NOP halt_works()
> [PATCH 4/9] x86 idle floppy: delete disable_hlt()/enable_hlt()
> [PATCH 5/9] x86 idle: remove NOP hlt_use_halt()
>
> new:
>
> [PATCH 6/9] x86 idle APM: delete apm_cpu_idle(), and its use of pm_idle
> [PATCH 7/9] x86 idle: do not EXPORT_SYMBOL pm_idle and default_idle
> [PATCH 8/9] x86 idle: move mwait_idle_with_hints() to where it is used
> [PATCH 9/9] x86 idle: delete mwait_idle()
>
>
>   Documentation/kernel-parameters.txt |   11 +--
>   arch/x86/Kconfig                    |   11 --
>   arch/x86/include/asm/processor.h    |   14 +--
>   arch/x86/include/asm/system.h       |    7 -
>   arch/x86/kernel/acpi/cstate.c       |   24 ++++
>   arch/x86/kernel/apm_32.c            |  232 -----------------------------------
>   arch/x86/kernel/cpu/bugs.c          |   13 +--
>   arch/x86/kernel/cpu/proc.c          |    2 -
>   arch/x86/kernel/process.c           |  127 +++-----------------
>   arch/x86/kernel/setup.c             |    4 +-
>   arch/x86/xen/setup.c                |    3 -
>   drivers/acpi/processor_idle.c       |    1 -
>   drivers/block/floppy.c              |   35 ------
>   13 files changed, 45 insertions(+), 439 deletions(-)
>
> What is next:
>
> handle c1e_idle() vs default_idle()
> 	run-time check for AMD workaround enable as part of default_idle?
> give xen_arch_setup default_idle() w/o having it touch pm_idle
> 	perhaps it can simply set a flag to disable cpuidle...
> 		which is what would run if the xen kernel were
> 		booted on raw iron.  Or can we handle this
> 		at compile time?

I guess it may be good to have a method to override cpuidle and
force it to call default_idle from inside cpuidle_idle_call(). This
could be useful for users other than xen in future. Ofcourse this 
override should not touch pm_idle (which would be removed anyway).

Provision is already there to call default_idle from inside
cpuidle_idle_call(); we can use that after checking a flag?? Can
we use something like boot_option_idle_override? Or set/unset
flag through an API?

> delete pm_idle
> 	x86 will then use default_idle or cpuidle
> allow cpuidle to use default_idle to handle the period
> 	where it polls because cpus have not yet registered

If we remove pm_idle and directly call cpuidle, the
check already exists to call default_idle until a cpuidle
driver (and cpus) is registered.

-Trinabh
