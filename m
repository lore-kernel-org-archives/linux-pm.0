From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 08/11] powercap/intel_rapl: Support multi-die/package
Date: Wed, 20 Feb 2019 12:02:00 +0100
Message-ID: <20190220110200.GD17969@hirez.programming.kicks-ass.net>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <3349c9e551eecbfe849320c0e938daf4e0126734.1550545163.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3349c9e551eecbfe849320c0e938daf4e0126734.1550545163.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 18, 2019 at 10:40:10PM -0500, Len Brown wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> On the new dual-die/package systems, the RAPL MSR becomes die-scope.
> Thus instead of one powercap device per physical package, now there
> should be one powercap device for each unique die on these systems.
> 
> This patch introduces intel_rapl driver support for new
> dual-die/package systems.
> 
> On the hardwares that do not have multi-die, topology_unique_die_id()
> equals topology_physical_package_id(), thus there is no functional change.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/powercap/intel_rapl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
> index 6057d9695fed..e004707283da 100644
> --- a/drivers/powercap/intel_rapl.c
> +++ b/drivers/powercap/intel_rapl.c
> @@ -266,7 +266,7 @@ static struct rapl_domain *platform_rapl_domain; /* Platform (PSys) domain */
>  /* caller to ensure CPU hotplug lock is held */
>  static struct rapl_package *rapl_find_package(int cpu)
>  {
> -	int id = topology_physical_package_id(cpu);
> +	int id = topology_unique_die_id(cpu);
>  	struct rapl_package *rp;
>  
>  	list_for_each_entry(rp, &rapl_packages, plist) {
> @@ -1457,7 +1457,7 @@ static void rapl_remove_package(struct rapl_package *rp)
>  /* called from CPU hotplug notifier, hotplug lock held */
>  static struct rapl_package *rapl_add_package(int cpu)
>  {
> -	int id = topology_physical_package_id(cpu);
> +	int id = topology_unique_die_id(cpu);
>  	struct rapl_package *rp;
>  	int ret;

And now your new function names are misnomers.
