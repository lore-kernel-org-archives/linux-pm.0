From: linux@horizon.com
Subject: Re: 2.6.22-rcX Transmeta/APM regression
Date: 30 Jun 2007 14:57:06 -0400
Message-ID: <20070630185706.3979.qmail@science.horizon.com>
References: <200706301126.41179.ak@suse.de>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706301126.41179.ak@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ak@suse.de, akpm@linux-foundation.org, linux@horizon.com
Cc: bk@suse.de, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, michal.k.k.piotrowski@gmail.com, hpa@zytor.com
List-Id: linux-pm@vger.kernel.org

Responding to various proposed fixes:

> Index: linux/arch/i386/kernel/cpu/mtrr/main.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/cpu/mtrr/main.c
> +++ linux/arch/i386/kernel/cpu/mtrr/main.c
> @@ -734,8 +734,11 @@ void mtrr_ap_init(void)
>   */
>  void mtrr_save_state(void)
>  {
> -	int cpu = get_cpu();
> +	int cpu;
>  
> +	if (!cpu_has_mtrr)
> +		return;
> +	cpu  = get_cpu();
>  	if (cpu == 0)
>  		mtrr_save_fixed_ranges(NULL);
>  	else

This does not change the symptoms in any way.

> --- a/arch/i386/kernel/cpu/mtrr/generic.c~i386-mtrr-crash-fix
> +++ a/arch/i386/kernel/cpu/mtrr/generic.c
> @@ -65,7 +65,8 @@ get_fixed_ranges(mtrr_type * frs)
>  
>  void mtrr_save_fixed_ranges(void *info)
>  {
> -	get_fixed_ranges(mtrr_state.fixed_ranges);
> +	if (cpu_has_mtrr)
> +		get_fixed_ranges(mtrr_state.fixed_ranges);
>  }
>  
>  static void print_fixed(unsigned base, unsigned step, const mtrr_type*types)

This works great, thanks!  Please consider the regression diagnosed and fixed.
