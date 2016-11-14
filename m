From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: fix
 intel_pstate_use_acpi_profile helper
Date: Mon, 14 Nov 2016 09:14:23 -0800
Message-ID: <1479143663.6544.11.camel@linux.intel.com>
References: <20161114164216.2657919-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161114164216.2657919-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, Stephane Gasparini <stephane.gasparini@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2016-11-14 at 17:41 +0100, Arnd Bergmann wrote:
> The newly added function uses two different prototypes depending
> on configuration, and one of them does not match the caller:
> 
> drivers/cpufreq/intel_pstate.c: In function ‘copy_cpu_funcs’:
> drivers/cpufreq/intel_pstate.c:1798:2: error: too few arguments to
> function ‘intel_pstate_use_acpi_profile’
> 
> This changes it to look like the other one.
Sorry about that.

> 
> Fixes: 3bea6a285476 ("cpufreq: intel_pstate: Use cpu load based
> algorithm for mobile class devices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c
> b/drivers/cpufreq/intel_pstate.c
> index 65832f8eacdc..7153cf2d8e11 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1779,7 +1779,7 @@ static void intel_pstate_use_acpi_profile(void)
>  				get_target_pstate_use_cpu_load;
>  }
>  #else
> -static inline void intel_pstate_use_acpi_profile(struct pstate_funcs
> *funcs)
> +static inline void intel_pstate_use_acpi_profile(void)
>  {
>  }
>  #endif
