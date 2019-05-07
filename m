From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 10/22] powercap/intel_rapl: Support multi-die/package
Date: Tue, 7 May 2019 14:14:59 +0200
Message-ID: <20190507121459.GL2623@hirez.programming.kicks-ass.net>
References: <6f53f0e494d743c79e18f6e3a98085711e6ddd0c.1557177585.git.len.brown@intel.com>
 <9f6958c231347e639e322de8d8c3de6859559345.1557177585.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9f6958c231347e639e322de8d8c3de6859559345.1557177585.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 06, 2019 at 05:26:05PM -0400, Len Brown wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> RAPL "package" domains are actually implemented in hardware per-die.
> Thus, the new multi-die/package systems have mulitple domains
> within each physical package.
> 
> Update the intel_rapl driver to be "die aware" -- exporting multiple
> domains within a single package, when present.
> No change on single die/package systems.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/powercap/intel_rapl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 3c3c0c23180b..9202dbcef96d 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -266,7 +266,7 @@ static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
>  /* caller to ensure CPU hotplug lock is held */
>  static struct rapl_package *rapl_find_package_domain(int cpu)
>  {
> -	int id = topology_physical_package_id(cpu);
> +	int id = topology_logical_die_id(cpu);
>  	struct rapl_package *rp;
>  
>  	list_for_each_entry(rp, &rapl_packages, plist) {
> @@ -1459,7 +1459,7 @@ static void rapl_remove_package(struct rapl_package *rp)
>  /* called from CPU hotplug notifier, hotplug lock held */
>  static struct rapl_package *rapl_add_package(int cpu)
>  {
> -	int id = topology_physical_package_id(cpu);
> +	int id = topology_logical_die_id(cpu);
>  	struct rapl_package *rp;
>  	int ret;

Both functions are still misnomers. rapl_find_package_domain() does in
fact now do rapl_find_die_domain(), right? Same for rapl_add_package()
