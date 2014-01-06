From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate: Add X86_FEATURE_APERFMPERF to cpu match parameters.
Date: Mon, 06 Jan 2014 21:45:54 +0100
Message-ID: <3133016.vzPPTWdjdX@vostro.rjw.lan>
References: <1389034756-2262-1-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1389034756-2262-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: stable-owner@vger.kernel.org
To: dirk.brandewie@gmail.com
Cc: linux-pm@vger.kernel.org, kchamart@redhat.com, jwboyer@fedoraproject.org, pbonzini@redhat.com, gleb@minantech.com, Dirk Brandewie <dirk.j.brandewie@intel.com>, All applicable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, January 06, 2014 10:59:16 AM dirk.brandewie@gmail.com wrote:
> From: Dirk Brandewie <dirk.j.brandewie@intel.com>
> 
> KVM environments do not support APERF/MPERF MSRs. intel_pstate cannot
> operate without these registers.
> 
> The previous validity checks in intel_pstate_msrs_not_valid() are
> insufficent in nested KVMs.
> 
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=1046317
> 
> Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>

OK, I'll queue it up as a fix for 3.13.

Minor nit: "Fixes:" is for the IDs of commits fixed by your patch.  To reference
a bug entry please use "Buglink" or "References" (which is preferred, because I
will change anything else to that anyway :-)).

Thanks!

> Cc: All applicable <stable@vger.kernel.org>
> ---
>  drivers/cpufreq/intel_pstate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 0f63f5d..fe91dad 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -619,7 +619,8 @@ static void intel_pstate_timer_func(unsigned long __data)
>  }
>  
>  #define ICPU(model, policy) \
> -	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)&policy }
> +	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF,\
> +			(unsigned long)&policy }
>  
>  static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
>  	ICPU(0x2a, core_params),
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
