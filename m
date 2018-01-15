From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] x86/centaur: Mark TSC invariant
Date: Mon, 15 Jan 2018 10:49:04 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1801151044520.1810@nanos>
References: <1515980145-3693-1-git-send-email-timguo@zhaoxin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:39399 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932521AbeAOJtM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jan 2018 04:49:12 -0500
In-Reply-To: <1515980145-3693-1-git-send-email-timguo@zhaoxin.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: TimGuo <timguo@zhaoxin.com>
Cc: mingo@redhat.com, hpa@zytor.com, mingo@kernel.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brucechang@via-alliance.com, cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com, benjaminpan@viatech.com

On Mon, 15 Jan 2018, TimGuo wrote:

> Centaur CPU has a constant frequency TSC and that TSC does not stop in C-States.
> But because the flags are not set for that CPU, the TSC is treated as non constant
> frequency and assumed to stop in C-States, which makes it an unreliable and unusable
> clock source. Setting those flags tells the kernel that the TSC is usable, so it
> will select it over HPET. The effect of this is that reading time stamps (from kernel
> or userspace) will be faster and more efficient.
> 
> Signed-off-by: TimGuo <timguo@zhaoxin.com>
> ---
>  arch/x86/kernel/cpu/centaur.c | 4 ++++
>  drivers/acpi/processor_idle.c | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
> index 68bc6d9..c578cd2 100644
> --- a/arch/x86/kernel/cpu/centaur.c
> +++ b/arch/x86/kernel/cpu/centaur.c
> @@ -106,6 +106,10 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
>  #ifdef CONFIG_X86_64
>         set_cpu_cap(c, X86_FEATURE_SYSENTER32);

This is still white space damaged, i.e. TAB is converted to spaces.

Please talk to your IT departement.

Thanks,

	tglx
