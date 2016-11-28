From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: intel_pstate: fix intel_pstate_exit_perf_limits
 prototype
Date: Mon, 28 Nov 2016 09:44:52 +0530
Message-ID: <20161128041452.GB14931@vireshk-i7>
References: <20161125165036.195969-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35186 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753171AbcK1EO4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Nov 2016 23:14:56 -0500
Received: by mail-pg0-f46.google.com with SMTP id p66so52330943pga.2
        for <linux-pm@vger.kernel.org>; Sun, 27 Nov 2016 20:14:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161125165036.195969-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 25-11-16, 17:50, Arnd Bergmann wrote:
> The addition of the generic governor support marked the
> intel_pstate_exit_perf_limits as inline, which fixed a warning,
> but it introduced another warning:
> 
> drivers/cpufreq/intel_pstate.c: In function ‘intel_pstate_exit_perf_limits’:
> drivers/cpufreq/intel_pstate.c:483:1: error: no return statement in function returning non-void [-Werror=return-type]
> 
> This changes it back to a 'void' return type, and changes the
> corresponding intel_pstate_init_acpi_perf_limits() function to
> be inline as well for consistency.
> 
> Fixes: 001c76f05b01 ("cpufreq: intel_pstate: Generic governors support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/intel_pstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 7159dbde0160..8921686b8cd2 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -474,11 +474,11 @@ static void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
>  }
>  
>  #else
> -static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
> +static inline void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
>  {
>  }
>  
> -static inline int intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
> +static inline void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
>  {
>  }
>  #endif

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
