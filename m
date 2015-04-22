From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH 1/1] x86: replace cpu_up hard-coded mdelay with variable
Date: Wed, 22 Apr 2015 01:40:10 -0400
Message-ID: <CAP=VYLqofSyGmApHWF4wvidAZ+C0GCV7ScCYnSU2REaCPGywkg@mail.gmail.com>
References: <1429404795-23260-1-git-send-email-lenb@kernel.org> <87d69aab88c14d65ae1e7be55050d1b689b59b4b.1429402494.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87d69aab88c14d65ae1e7be55050d1b689b59b4b.1429402494.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 18, 2015 at 8:53 PM, Len Brown <lenb@kernel.org> wrote:
> From: Len Brown <len.brown@intel.com>
>

[...]

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b7d31ca..d2a91da 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -884,6 +884,21 @@ config SCHED_MC
>           making when dealing with multi-core CPU chips at a cost of slightly
>           increased overhead in some places. If unsure say N here.
>
> +config X86_INIT_MDELAY
> +       int "Milliseconds to wait to de-assert INIT upon CPU startup" if SMP
> +       range 0 10
> +       default "10"
> +       ---help---
> +         This allows you to specify how long the BSP will delay
> +         between asserting INIT and de-asserting INIT when starting another CPU.
> +         This delay is paid on each cpu-online operation, including boot-time,
> +         resume from suspend, and resume from hibernate.  The the value of

Happened to notice a 2x "The the..." when I came across this in linux-next
today and was reading the help out of curiousity...

P.
--

> +         10 millisec was specified by Multi-Processor Spec 1.4 in 1997.
> +         But modern hardware does not require any delay.
> +
> +         The kernel boot-time parameter "cpu_init_mdelay="
> +         will over-ride this build-time default.
> +
>  source "kernel/Kconfig.preempt"
>
>  config UP_LATE_INIT
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index febc6aa..973621f 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -555,6 +555,20 @@ wakeup_secondary_cpu_via_nmi(int apicid, unsigned long start_eip)
>         return (send_status | accept_status);
>  }
>
> +unsigned int x86_init_mdelay = CONFIG_X86_INIT_MDELAY;
> +static int __init cpu_init_mdelay(char *str)
> +{
> +       unsigned int tmp;
> +
> +       get_option(&str, &tmp);
> +       pr_info("x86_init_mdelay set to %d, was %d", tmp, x86_init_mdelay);
> +       x86_init_mdelay = tmp;
> +       return 0;
> +}
> +
> +early_param("cpu_init_mdelay", cpu_init_mdelay);
> +
> +
>  static int
>  wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
>  {
> @@ -586,7 +600,7 @@ wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
>         pr_debug("Waiting for send to finish...\n");
>         send_status = safe_apic_wait_icr_idle();
>
> -       mdelay(10);
> +       mdelay(x86_init_mdelay);
>
>         pr_debug("Deasserting INIT\n");
>
> --
> 2.4.0.rc1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
