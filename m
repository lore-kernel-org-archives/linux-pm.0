From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3] idle, Honor Hardware Disabled States
Date: Wed, 23 Mar 2016 16:05:20 -0400
Message-ID: <CAJvTdKk0qsFsN7RPQGVQ7mWbd2N9jW7kZbH4htSnMBxvwo8M2w@mail.gmail.com>
References: <1458564569-19672-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458564569-19672-1-git-send-email-prarit@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Borislav Petkov <bp@suse.de>, Andi Kleen <ak@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This patch assumes that if a package state is disabled,
the corresponding core state must be disabled.
That assumption is false.
Indeed, that is a very popular and useful configuration.

But even if that were not the case, this software is not necessary,
since the hardware handles demotion "c-state clipping" automatically.

Yes, there is a case where a certain version of a certain processor
has broken demotion, but this isn't the right fix for that.
The right fix for that is here:

https://bugzilla.kernel.org/show_bug.cgi?id=109081

and will be upstream shortly.

thanks,
-Len



On Mon, Mar 21, 2016 at 8:49 AM, Prarit Bhargava <prarit@redhat.com> wrote:
> Some Intel processors have cstates limited by MSR_PKG_CST_CONFIG_CONTROL
> (0xE2), which specifies the lowest processor-specific C-state code name
> (consuming the least power).  The intel_idle driver does not query this MSR to
> see if states are limited by hardware.  In the case of the i7-6700HQ the value
> of bits 3:0 on the MSR are 0x6, meaning that C9-SKL (0x7) and C10-SKL (0x8)
> should have been disabled.
>
> This patch adds a limit field to the cpuidle_state struct to hold the
> cstate encodings for each processor, and queries the values the values
> to confirm support.
>
> After applying this patchset the system now boots and reports that
> some states have been disabled:
>
> [root@dhcp40-125 ~]# dmesg | grep intel_idle
> [    1.163367] intel_idle: MWAIT substates: 0x11142120
> [    1.163368] intel_idle: v0.4 model 0x5E
> [    1.163369] intel_idle: lapic_timer_reliable_states 0xffffffff
> [    1.163370] intel_idle: state C9-SKL (0x7) is disabled.  Max Package limit is 0x6.
> [    1.163371] intel_idle: state C10-SKL (0x8) is disabled.  Max Package limit is 0x6.
>
> Cc: x86@kernel.org
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>
> Prarit Bhargava (3):
>   idle, rename MSR_NHM_SNB_PKG_CST_CFG_CTL to
>     MSR_PKG_CST_CONFIG_CONTROL
>   intel_idle, Introduce cstate limits and fix hardware cstate disable
>     value
>   cpuidle, Prevent users from enabling cstates that are disabled in
>     Hardware
>
>  arch/x86/include/asm/msr-index.h      |    2 +-
>  drivers/cpuidle/governors/ladder.c    |    3 ++
>  drivers/cpuidle/governors/menu.c      |    4 ++
>  drivers/cpuidle/sysfs.c               |   34 +++++++++++-
>  drivers/idle/intel_idle.c             |   93 ++++++++++++++++++++++++++++++++-
>  include/linux/cpuidle.h               |   11 +++-
>  tools/power/x86/turbostat/turbostat.8 |    2 +-
>  tools/power/x86/turbostat/turbostat.c |   10 ++--
>  8 files changed, 146 insertions(+), 13 deletions(-)
>
> --
> 1.7.9.3
>



-- 
Len Brown, Intel Open Source Technology Center
