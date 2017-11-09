From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] x86: use cpufreq_quick_get() for /proc/cpuinfo "cpu MHz"
 again
Date: Thu, 9 Nov 2017 17:06:41 +0100
Message-ID: <6583ed1f-3ea3-c7fd-7e69-1430c8387e54@intel.com>
References: <20171109103814.70688-1-chao.wang@ucloud.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:58332 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751264AbdKIQGq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Nov 2017 11:06:46 -0500
In-Reply-To: <20171109103814.70688-1-chao.wang@ucloud.cn>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: WANG Chao <chao.wang@ucloud.cn>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Vikas Shivappa <vikas.shivappa@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Mathias Krause <minipli@googlemail.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>

Hi Linus,

On 11/9/2017 11:38 AM, WANG Chao wrote:
> Commit 941f5f0f6ef5 (x86: CPU: Fix up "cpu MHz" in /proc/cpuinfo) caused
> a serious performance issue when reading from /proc/cpuinfo on system
> with aperfmperf.
>
> For each cpu, arch_freq_get_on_cpu() sleeps 20ms to get its frequency.
> On a system with 64 cpus, it takes 1.5s to finish running `cat
> /proc/cpuinfo`, while it previously was done in 15ms.

Honestly, I'm not sure what to do to address this ATM.

The last requested frequency is only available in the non-HWP case, so 
it cannot be used universally.

> Some programs use /proc/cpuinfo during startup or runtime, eg. QEMU.
> This patch will restore the previous behavior and let user space happy.
>
> Fixes: 941f5f0f6ef5 (x86: CPU: Fix up "cpu MHz" in /proc/cpuinfo)
> Cc: stable@kernel.org   # 4.13
> Signed-off-by: WANG Chao <chao.wang@ucloud.cn>
> ---
>   arch/x86/kernel/cpu/Makefile | 2 +-
>   arch/x86/kernel/cpu/proc.c   | 4 +---
>   2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
> index 236999c54edc..c60922a66385 100644
> --- a/arch/x86/kernel/cpu/Makefile
> +++ b/arch/x86/kernel/cpu/Makefile
> @@ -22,7 +22,7 @@ obj-y			+= common.o
>   obj-y			+= rdrand.o
>   obj-y			+= match.o
>   obj-y			+= bugs.o
> -obj-y			+= aperfmperf.o
> +obj-$(CONFIG_CPU_FREQ)	+= aperfmperf.o
>   
>   obj-$(CONFIG_PROC_FS)	+= proc.o
>   obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
> diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> index 4378a729b933..6b7e17bf0b71 100644
> --- a/arch/x86/kernel/cpu/proc.c
> +++ b/arch/x86/kernel/cpu/proc.c
> @@ -78,10 +78,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>   		seq_printf(m, "microcode\t: 0x%x\n", c->microcode);
>   
>   	if (cpu_has(c, X86_FEATURE_TSC)) {
> -		unsigned int freq = arch_freq_get_on_cpu(cpu);
> +		unsigned int freq = cpufreq_quick_get(cpu);
>   
> -		if (!freq)
> -			freq = cpufreq_quick_get(cpu);
>   		if (!freq)
>   			freq = cpu_khz;
>   		seq_printf(m, "cpu MHz\t\t: %u.%03u\n",
