From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH 09/18] cpuidle: replace xen
 access to x86 pm_idle and default_idle
Date: Mon, 4 Apr 2011 11:33:35 -0400
Message-ID: <20110404153335.GA19168__30742.5302723006$1301931287$gmane$org@dumpdata.com>
References: <c82cf78992a66bfa7f0c82aeb20ba6922127463b.1301724243.git.len.brown@intel.com>
	<e2f656a28f548ed19c829563e5168ce48026570b.1301724243.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <e2f656a28f548ed19c829563e5168ce48026570b.1301724243.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 02, 2011 at 02:22:51AM -0400, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> When a Xen Dom0 kernel boots on a hypervisor, it gets access
> to the raw-hardware ACPI tables.  While it parses the idle tables
> for the hypervisor's beneift, it uses HLT for its own idle.
> 
> Rather than have xen scribble on pm_idle and access default_idle,
> have it simply disable_cpuidle() so acpi_idle will not load and
> architecture default HLT will be used.
Hey Len,

Looks good to me. I've also tested this on the affected Intel machine and
your patchset works fine.

> 
> cc: xen-devel@lists.xensource.com
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  arch/x86/xen/setup.c      |    3 ++-
>  drivers/cpuidle/cpuidle.c |    4 ++++
>  include/linux/cpuidle.h   |    2 ++
>  3 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
> index a8a66a5..aa02cce 100644
> --- a/arch/x86/xen/setup.c
> +++ b/arch/x86/xen/setup.c
> @@ -9,6 +9,7 @@
>  #include <linux/mm.h>
>  #include <linux/pm.h>
>  #include <linux/memblock.h>
> +#include <linux/cpuidle.h>
>  
>  #include <asm/elf.h>
>  #include <asm/vdso.h>
> @@ -354,7 +355,7 @@ void __init xen_arch_setup(void)
>  #ifdef CONFIG_X86_32
>  	boot_cpu_data.hlt_works_ok = 1;
>  #endif
> -	pm_idle = default_idle;
> +	disable_cpuidle();
>  	boot_option_idle_override = IDLE_HALT;
>  
>  	fiddle_vdso();
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index faae2c3..041df0b 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -34,6 +34,10 @@ int cpuidle_disabled(void)
>  {
>  	return off;
>  }
> +void disable_cpuidle(void)
> +{
> +	off = 1;
> +}
>  
>  #if defined(CONFIG_ARCH_HAS_CPU_IDLE_WAIT)
>  static void cpuidle_kick_cpus(void)
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 36719ea..b89f67d 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -122,6 +122,7 @@ struct cpuidle_driver {
>  };
>  
>  #ifdef CONFIG_CPU_IDLE
> +extern void disable_cpuidle(void);
>  
>  extern int cpuidle_register_driver(struct cpuidle_driver *drv);
>  struct cpuidle_driver *cpuidle_get_driver(void);
> @@ -135,6 +136,7 @@ extern int cpuidle_enable_device(struct cpuidle_device *dev);
>  extern void cpuidle_disable_device(struct cpuidle_device *dev);
>  
>  #else
> +static inline void disable_cpuidle(void) { }
>  
>  static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
>  {return -ENODEV; }
> -- 
> 1.7.5.rc0
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel
