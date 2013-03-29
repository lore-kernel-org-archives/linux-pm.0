From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] tools: cpufreq: Fix cpufreq-info print messages for affected[related]_cpus
Date: Fri, 29 Mar 2013 22:40:38 +0100
Message-ID: <1637142.c6PaEcqfQ4@vostro.rjw.lan>
References: <8c5305cdbe0fb20730e6b28f79a71d36a472a817.1364567091.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <8c5305cdbe0fb20730e6b28f79a71d36a472a817.1364567091.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linaro-kernel@lists.linaro.org
Cc: linux-pm@vger.kernel.org, patches@linaro.org, arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, Thomas Renninger <trenn@suse.de>
List-Id: linux-pm@vger.kernel.org

On Friday, March 29, 2013 07:56:39 PM Viresh Kumar wrote:
> Earlier definitions of affected and related cpus were:
> Related_cpus: CPUs which run at the same hardware frequency.
> Affected_cpus: CPUs which need to have their frequency coordinated by software.
> 
> These definitions were very confusing as they don't communicate the real
> difference between them.
> 
> Following are the new definitions of these variables:
> Related_cpus: All (Online & Offline) CPUs that run at the same hardware frequency.
> Affected_cpus: Online CPUs that run at the same hardware frequency.
> 
> Above definitions are more consistent with latest cpufreq core code.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Thomas Renninger is maintaining cpupower nowadays (added to CC).  I won't get
any cpupower changes without his ACK.

Thanks,
Rafael


> ---
>  tools/power/cpupower/utils/cpufreq-info.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
> index 28953c9..a81d4ec 100644
> --- a/tools/power/cpupower/utils/cpufreq-info.c
> +++ b/tools/power/cpupower/utils/cpufreq-info.c
> @@ -247,7 +247,7 @@ static void debug_output_one(unsigned int cpu)
>  
>  	cpus = cpufreq_get_related_cpus(cpu);
>  	if (cpus) {
> -		printf(_("  CPUs which run at the same hardware frequency: "));
> +		printf(_("  All (Online & Offline) CPUs that run at the same hardware frequency: "));
>  		while (cpus->next) {
>  			printf("%d ", cpus->cpu);
>  			cpus = cpus->next;
> @@ -258,7 +258,7 @@ static void debug_output_one(unsigned int cpu)
>  
>  	cpus = cpufreq_get_affected_cpus(cpu);
>  	if (cpus) {
> -		printf(_("  CPUs which need to have their frequency coordinated by software: "));
> +		printf(_("  Online CPUs that run at the same hardware frequency: "));
>  		while (cpus->next) {
>  			printf("%d ", cpus->cpu);
>  			cpus = cpus->next;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
