From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/3] idle, rename MSR_NHM_SNB_PKG_CST_CFG_CTL to MSR_PKG_CST_CONFIG_CONTROL
Date: Wed, 23 Mar 2016 15:56:55 -0400
Message-ID: <CAJvTdKm7SRgro0kRF-1rrX1Eo=PV2n9uTPqDiw+rRZv3ZrtdLw@mail.gmail.com>
References: <1458564569-19672-1-git-send-email-prarit@redhat.com>
	<1458564569-19672-2-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36111 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbcCWT45 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Mar 2016 15:56:57 -0400
In-Reply-To: <1458564569-19672-2-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Borislav Petkov <bp@suse.de>, Andi Kleen <ak@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>, Linux PM list <linux-pm@vger.kernel.org>

I agree with this intent, but re-names are a headache.

The last time we re-named an MSR, we had to add the new name,
try to get patches in flight to cut over to it, and then a few
releases later, remove the old name.

Right now, we have the same situation as patches in flight use this register,
so I'll not apply this patch right now.

thanks,
-Len




On Mon, Mar 21, 2016 at 8:49 AM, Prarit Bhargava <prarit@redhat.com> wrote:
> MSR 0xE2 is not a Nehalem specific register and is used by newer
> processors.  This patch renames the processor to the name given in the
> Intel SDM [1]
>
> [1] http://www.intel.com/content/www/us/en/processors/architectures-software-developer-manuals.html
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
> ---
>  arch/x86/include/asm/msr-index.h      |    2 +-
>  drivers/idle/intel_idle.c             |    4 ++--
>  tools/power/x86/turbostat/turbostat.8 |    2 +-
>  tools/power/x86/turbostat/turbostat.c |   10 +++++-----
>  4 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 984ab75..63909ba 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -42,7 +42,7 @@
>  #define MSR_FSB_FREQ                   0x000000cd
>  #define MSR_PLATFORM_INFO              0x000000ce
>
> -#define MSR_NHM_SNB_PKG_CST_CFG_CTL    0x000000e2
> +#define MSR_PKG_CST_CONFIG_CONTROL     0x000000e2
>  #define NHM_C3_AUTO_DEMOTE             (1UL << 25)
>  #define NHM_C1_AUTO_DEMOTE             (1UL << 26)
>  #define ATM_LNC_C6_AUTO_DEMOTE         (1UL << 25)
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index cd4510a..2609dff 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -814,9 +814,9 @@ static void auto_demotion_disable(void *dummy)
>  {
>         unsigned long long msr_bits;
>
> -       rdmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
> +       rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
>         msr_bits &= ~(icpu->auto_demotion_disable_flags);
> -       wrmsrl(MSR_NHM_SNB_PKG_CST_CFG_CTL, msr_bits);
> +       wrmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_bits);
>  }
>  static void c1e_promotion_disable(void *dummy)
>  {
> diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
> index 622db68..7973d2a 100644
> --- a/tools/power/x86/turbostat/turbostat.8
> +++ b/tools/power/x86/turbostat/turbostat.8
> @@ -118,7 +118,7 @@ cpu0: MSR_NHM_PLATFORM_INFO: 0x80838f3012300
>  8 * 100 = 800 MHz max efficiency
>  35 * 100 = 3500 MHz TSC frequency
>  cpu0: MSR_IA32_POWER_CTL: 0x0004005d (C1E auto-promotion: DISabled)
> -cpu0: MSR_NHM_SNB_PKG_CST_CFG_CTL: 0x1e000400 (UNdemote-C3, UNdemote-C1, demote-C3, demote-C1, UNlocked: pkg-cstate-limit=0: pc0)
> +cpu0: MSR_PKG_CST_CONFIG_CONTROL: 0x1e000400 (UNdemote-C3, UNdemote-C1, demote-C3, demote-C1, UNlocked: pkg-cstate-limit=0: pc0)
>  cpu0: MSR_NHM_TURBO_RATIO_LIMIT: 0x25262727
>  37 * 100 = 3700 MHz max turbo 4 active cores
>  38 * 100 = 3800 MHz max turbo 3 active cores
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index 3fa94e2..289ff9f 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -1384,12 +1384,12 @@ dump_nhm_cst_cfg(void)
>  {
>         unsigned long long msr;
>
> -       get_msr(base_cpu, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
> +       get_msr(base_cpu, MSR_PKG_CST_CONFIG_CONTROL, &msr);
>
>  #define SNB_C1_AUTO_UNDEMOTE              (1UL << 27)
>  #define SNB_C3_AUTO_UNDEMOTE              (1UL << 28)
>
> -       fprintf(stderr, "cpu%d: MSR_NHM_SNB_PKG_CST_CFG_CTL: 0x%08llx", base_cpu, msr);
> +       fprintf(stderr, "cpu%d: MSR_PKG_CST_CONFIG_CONTROL: 0x%08llx", base_cpu, msr);
>
>         fprintf(stderr, " (%s%s%s%s%slocked: pkg-cstate-limit=%d: %s)\n",
>                 (msr & SNB_C3_AUTO_UNDEMOTE) ? "UNdemote-C3, " : "",
> @@ -1808,7 +1808,7 @@ void check_permissions()
>   * MSR_SMI_COUNT                   0x00000034
>   *
>   * MSR_PLATFORM_INFO               0x000000ce
> - * MSR_NHM_SNB_PKG_CST_CFG_CTL     0x000000e2
> + * MSR_PKG_CST_CONFIG_CONTROL     0x000000e2
>   *
>   * MSR_PKG_C3_RESIDENCY            0x000003f8
>   * MSR_PKG_C6_RESIDENCY            0x000003f9
> @@ -1816,7 +1816,7 @@ void check_permissions()
>   * MSR_CORE_C6_RESIDENCY           0x000003fd
>   *
>   * Side effect:
> - * sets global pkg_cstate_limit to decode MSR_NHM_SNB_PKG_CST_CFG_CTL
> + * sets global pkg_cstate_limit to decode MSR_PKG_CST_CONFIG_CONTROL
>   */
>  int probe_nhm_msrs(unsigned int family, unsigned int model)
>  {
> @@ -1873,7 +1873,7 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
>         default:
>                 return 0;
>         }
> -       get_msr(base_cpu, MSR_NHM_SNB_PKG_CST_CFG_CTL, &msr);
> +       get_msr(base_cpu, MSR_PKG_CST_CONFIG_CONTROL, &msr);
>         pkg_cstate_limit = pkg_cstate_limits[msr & 0xF];
>
>         get_msr(base_cpu, MSR_PLATFORM_INFO, &msr);
> --
> 1.7.9.3
>



-- 
Len Brown, Intel Open Source Technology Center
