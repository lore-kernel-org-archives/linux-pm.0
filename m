From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Date: Mon, 7 Feb 2011 20:14:03 +0100
Message-ID: <201102072014.04259.rjw__10466.3657992662$1297106253$gmane$org@sisk.pl>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Len Brown <len.brown@intel.com>, linux-embedded@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, February 07, 2011, Mark Brown wrote:
> It is very rare to find a current system which is both sufficiently
> resource constrained to want to compile out power management support
> and sufficiently power insensitive to be able to tolerate doing so.
> Since having the configuration option requires non-zero effort to
> maintain, with ifdefery in most drivers, but it is used with vanishing
> rarity it is simpler to just remove the option.
> 
> Begin doing so by hiding it from users - this should attract complaints
> from any active users. The option is left disabled for the IA64 Ski
> simulator which is a partial simulator for IA64 systems mostly missing
> device support. This is a very limited use case which is unlikely to
> ever want to enable most drivers.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  kernel/power/Kconfig |   21 ++-------------------
>  1 files changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 2657299..99e3c52 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -1,23 +1,6 @@
>  config PM
> -	bool "Power Management support"
> -	depends on !IA64_HP_SIM
> -	---help---
> -	  "Power Management" means that parts of your computer are shut
> -	  off or put into a power conserving "sleep" mode if they are not
> -	  being used.  There are two competing standards for doing this: APM
> -	  and ACPI.  If you want to use either one, say Y here and then also
> -	  to the requisite support below.
> -
> -	  Power Management is most important for battery powered laptop
> -	  computers; if you have a laptop, check out the Linux Laptop home
> -	  page on the WWW at <http://www.linux-on-laptops.com/> or
> -	  Tuxmobil - Linux on Mobile Computers at <http://www.tuxmobil.org/>
> -	  and the Battery Powered Linux mini-HOWTO, available from
> -	  <http://www.tldp.org/docs.html#howto>.
> -
> -	  Note that, even if you say N here, Linux on the x86 architecture
> -	  will issue the hlt instruction if nothing is to be done, thereby
> -	  sending the processor to sleep and saving power.
> +	bool
> +	default y if !IA64_HP_SIM
>  
>  config PM_DEBUG
>  	bool "Power Management Debug Support"

I think it would be better to simply rename CONFIG_PM_OPS into CONFIG_PM.

However, there's a number of things that I'm afraid wouldn't build correctly
if none of CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME were set in that case.

Anyway, I'll try to prepare a patch doing that and see what happens.
Stay tuned.

Thanks,
Rafael
