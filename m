From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq / Documentation: Update cpufreq MAINTAINERS entry
Date: Thu, 3 Jan 2019 09:35:46 +0530
Message-ID: <20190103040546.akeyvennctxnfcw7@vireshk-i7>
References: <7154380.sNYZWJVSaJ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7154380.sNYZWJVSaJ@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 02-01-19, 12:13, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Update the MAINTAINERS entry for cpufreq by making it clear that it
> is not just drivers and adding current documentation records to it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  MAINTAINERS |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/MAINTAINERS
> ===================================================================
> --- linux-pm.orig/MAINTAINERS
> +++ linux-pm/MAINTAINERS
> @@ -3888,7 +3888,7 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/ti/cpmac.c
>  
> -CPU FREQUENCY DRIVERS
> +CPU FREQUENCY SCALING FRAMEWORK
>  M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
>  M:	Viresh Kumar <viresh.kumar@linaro.org>
>  L:	linux-pm@vger.kernel.org
> @@ -3896,6 +3896,8 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
>  T:	git git://git.linaro.org/people/vireshk/linux.git (For ARM Updates)
>  B:	https://bugzilla.kernel.org
> +F:	Documentation/admin-guide/pm/cpufreq.rst
> +F:	Documentation/admin-guide/pm/intel_pstate.rst
>  F:	Documentation/cpu-freq/
>  F:	Documentation/devicetree/bindings/cpufreq/
>  F:	drivers/cpufreq/

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
