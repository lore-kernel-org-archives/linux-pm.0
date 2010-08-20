From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM: Compress hibernation image with LZO
Date: Sat, 21 Aug 2010 01:36:26 +0200
Message-ID: <201008210136.27065.rjw@sisk.pl>
References: <1281407348.2618.52.camel@shrek.rexursive.com>
	<1282211375.17635.96.camel@shrek.rexursive.com>
	<1282306269.3120.9.camel@shrek.rexursive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1282306269.3120.9.camel@shrek.rexursive.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bojan Smojver <bojan@rexursive.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, August 20, 2010, Bojan Smojver wrote:
> On Thu, 2010-08-19 at 19:49 +1000, Bojan Smojver wrote:
> > Not tested, but here it is
> 
> This one is tested with both nocompress option passed to the kernel and
> without. Only one minor change compared to the previous patch -
> calculation in enough_swap() also takes into account the compress v.
> nocompress.

OK, it generally looks good.

>  Documentation/power/swsusp.txt |    3 +-
>  kernel/power/Kconfig           |    2 +
>  kernel/power/hibernate.c       |   10 ++
>  kernel/power/power.h           |    1 +
>  kernel/power/swap.c            |  288 +++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 296 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
> index 9d60ab7..986dcf5 100644
> --- a/Documentation/power/swsusp.txt
> +++ b/Documentation/power/swsusp.txt
> @@ -66,7 +66,8 @@ swsusp saves the state of the machine into active swaps and then reboots or
>  powerdowns.  You must explicitly specify the swap partition to resume from with
>  ``resume='' kernel option. If signature is found it loads and restores saved
>  state. If the option ``noresume'' is specified as a boot parameter, it skips
> -the resuming.
> +the resuming. If the option ``nocompress'' is specified as a boot parameter, it
> +saves hibernation image without compression.
>  
>  In the meantime while the system is suspended you should not add/remove any
>  of the hardware, write to the filesystems, etc.
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index ca6066a..cb57eb9 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -137,6 +137,8 @@ config SUSPEND_FREEZER
>  config HIBERNATION
>  	bool "Hibernation (aka 'suspend to disk')"
>  	depends on PM && SWAP && ARCH_HIBERNATION_POSSIBLE
> +	select LZO_COMPRESS
> +	select LZO_DECOMPRESS

As I wrote, I think it's better to select CRYPTO_LZO here.

Thanks,
Rafael
