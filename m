From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/9] x86 idle cruft removal - v2
Date: Fri, 01 Apr 2011 00:24:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1104010020280.2797__48097.333595115$1301631933$gmane$org@x980>
References: <1300950508-22746-1-git-send-email-lenb@kernel.org>
	<1301551404-8263-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1301551404-8263-1-git-send-email-lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: x86@kernel.org
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Thanks for the review feedback that this change is too sudden.
How about this plan with a 4-month delay?

cheers,
-Len Brown, Intel Open Source Technology Center

2.6.39-rc1
----------

x86 idle: deprecate floppy disable_hlt
	feature-removal.txt for 2.6.40 (4 months)
	WARN_ONCE on use
	cc: stable@kernel.org

x86 idle APM: deprecate apm_cpu_idle
	feature-removal.txt for 2.6.40 (4 months)
	#warning on CONFIG_APM_CPU_IDLE remove in 2.6.40
	WARN_ONCE in apm_cpu_idle()
	cc: stable@kernel.org

x86 idle: export pm_idle only for CONFIG_APM_MODULE
	like we do for default_idle(),
	EXPORT_SYMBOL(pm_idle) only on CONFIG_APM_MODULE

x86 idle: deprecate "no-hlt" cmdline param
	feature-removal.txt for 2.6.40 (4 months)
	cc stable@kernel.org
	WARN_ONCE if used, ask if idle=poll is sufficient
	same as idle=poll, except no-hlt also disables
		HLT in machine_halt().

x86 idle: deprecate "idle=mwait"
	feature-removal.txt for 2.6.40 (4 months)
	cc stable@kernel.org
	WARN_ONCE on invocation

x86 idle: re-name ce1_idle
	rename for clarity, no functional change

2.6.40-merge
------
x86 idle: move mwait_idle_with_hints()
	out of process.c to cstate.c, make static

x86 idle floppy: remove deprecated disable_hlt/enable_hlt

x86 idle: delete deprecated idle=mwait
	default_idle() can use HLT

cpuidle: add cmdline "cpuidle=off"
	allow falling back to native default_idle

x86 idle xen: stop touching pm_idle and default_idle
	Xen Dom0 kernel only needs HLT, but include
	CPU_IDLE, ACPI etc for running on bare hardware.
	So when running in Xen Dom0 mode, disable cpuidle
	to fall back to default_idle.

x86 idle APM: remove deprecated apm_cpu_idle()
	and its use of pm_idle

x86 idle cpuidle: delete public use of pm_idle
	make pm_idle and default_idle static to process.c
	add return value from cpu_idle_call()
	invoke cpu_idle_call from cpu_idle() rather than via pm_idle

	cpu_idle() {
		...
		if (cpu_idle_call())
			pm_idle();	/* non cpuidle default */
	}

x86 idle: remove "no-hlt" cmdline param
	remove deprecated "no-hlt"
	use idle=poll instead

x86 idle: remove cpuinfo_x86.hlt_works_ok flag
	it became a NOP when "no-hlt" was removed

x86 idle: remove hlt_works()
	it became a NOP when cpuinfo_x86.hlt_works_ok was removed
