From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 8/8] ARM / shmobile: Support for I/O PM
	domains for SH7372 (v5)
Date: Tue, 14 Jun 2011 22:12:40 +0900
Message-ID: <BANLkTi=-1Fpp9L17T7CwxoO9JfSes4FeKg__15567.1241031543$1308057325$gmane$org@mail.gmail.com>
References: <201106112223.04972.rjw@sisk.pl> <201106112240.11621.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106112240.11621.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Sun, Jun 12, 2011 at 5:40 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Use the generic power domains support introduced by the previous
> patch to implement support for power domains on SH7372.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

Thanks for your work on this. I just tried this on my Mackerel board,
but I can't seem to get the pd_power_up() and pd_power_down()
callbacks to be executed. It is probably a misconfiguration from my
side.

Here's some feedback on the sh7372-specific code:

> --- linux-2.6.orig/arch/arm/mach-shmobile/Kconfig
> +++ linux-2.6/arch/arm/mach-shmobile/Kconfig
> @@ -19,6 +19,7 @@ config ARCH_SH7372
> =A0 =A0 =A0 =A0select CPU_V7
> =A0 =A0 =A0 =A0select SH_CLK_CPG
> =A0 =A0 =A0 =A0select ARCH_WANT_OPTIONAL_GPIOLIB
> + =A0 =A0 =A0 select PM_GENERIC_DOMAINS

We want to support a single ARM binary for multiple boards, so this
should be enabled for all SoCs in mach-shmobile as a whole.

> --- linux-2.6.orig/arch/arm/mach-shmobile/pm-sh7372.c
> +++ linux-2.6/arch/arm/mach-shmobile/pm-sh7372.c
> @@ -15,16 +15,97 @@
> =A0#include <linux/list.h>
> =A0#include <linux/err.h>
> =A0#include <linux/slab.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/platform_device.h>
> =A0#include <asm/system.h>
> =A0#include <asm/io.h>
> =A0#include <asm/tlbflush.h>
> =A0#include <mach/common.h>
> +#include <mach/sh7372.h>
>
> =A0#define SMFRAM 0xe6a70000
> =A0#define SYSTBCR 0xe6150024
> =A0#define SBAR 0xe6180020
> =A0#define APARMBAREA 0xe6f10020
>
> +#define SPDCR 0xe6180008
> +#define SWUCR 0xe6180014
> +#define PSTR 0xe6180080
> +
> +struct sh7372_domain_data {
> + =A0 =A0 =A0 unsigned int bit_shift;
> +};

Is it possible to make struct sh7372_domain_data include struct
generic_pm_domain? I suspect so since these two data types seem to be
linked together. I guess container_of() can be used for conversion
between the types?

> +
> +static int pd_power_down(struct dev_pm_domain *domain)
> +{
> + =A0 =A0 =A0 struct sh7372_domain_data *dd =3D domain->platform_data;
> + =A0 =A0 =A0 unsigned int mask =3D 1 << dd->bit_shift;
> +
> + =A0 =A0 =A0 if (__raw_readl(PSTR) & mask) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(mask, SPDCR);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (__raw_readl(SPDCR) & mask) {}

This probably wants a cpu_relax() in the polling loop. I realize that
my prototype hack lacked that...

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("sh7372 power domain down 0x%08x -=
> PSTR =3D 0x%08x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mask, __raw_readl(PSTR));
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int pd_power_up(struct dev_pm_domain *domain)
> +{
> + =A0 =A0 =A0 struct sh7372_domain_data *dd =3D domain->platform_data;
> + =A0 =A0 =A0 unsigned int mask =3D 1 << dd->bit_shift;
> +
> + =A0 =A0 =A0 if (!(__raw_readl(PSTR) & mask)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(mask, SWUCR);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (__raw_readl(SWUCR) & mask) {}

Same cpu_relax() here.

> +static int __init sh7372_power_domains_init(void)
> +{
> + =A0 =A0 =A0 sh7372_init_domain(&sh7372_a4lc_domain, &sh7372_a4lc_domain=
_data);
> + =A0 =A0 =A0 return 0;
> +}
> +core_initcall(sh7372_power_domains_init);

This initcall is going to be executed regardless which SoC we're
running on. We only want it called for sh7372 though.

If you look at other SoC-specific code then you will notice that
initcalls are only used for functions in mach-shmobile/ that are
common for all SoCs implemented under mach-shmobile.

You most likely want to initialize from sh7372_pm_init(), but for that
to work you probably have to reorder your code inside mackerel_init().

Thanks,

/ magnus
