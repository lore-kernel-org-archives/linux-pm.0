From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [V2 PATCH] cpuidle: add maintainer entry
Date: Fri, 26 Apr 2013 19:01:58 +0200
Message-ID: <20130426170158.GA24282@game.jcrosoft.org>
References: <1366974344-26064-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1366974344-26064-1-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: andrew@lunn.ch, khilman@deeprootsystems.com, benh@kernel.crashing.org, linus.walleij@linaro.org, nicolas.ferre@atmel.com, paulus@samba.org, josephl@nvidia.com, kgene.kim@samsung.com, swarren@wwwdotorg.org, magnus.damm@gmail.com, viresh.kumar@linaro.org, lenb@kernel.org, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, arnd@arndb.de, linux-pm@vger.kernel.org, nsekhar@ti.com, rob.herring@calxeda.com, rjw@sisk.pl, horms@verge.net.au, ben-linux@fluff.org, horms+renesas@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

On 13:05 Fri 26 Apr     , Daniel Lezcano wrote:
> Currently the cpuidle drivers are spread across the different archs.
> 
> The patch submission for cpuidle are following different path: the cpuidle core
> code goes to linux-pm, the ARM drivers goes to arm-soc or the SoC specific
> tree, sh goes through sh arch tree, pseries goes through PowerPC and
> finally intel goes through Len's tree while acpi_idle goes under linux-pm.
> 
> That makes difficult to consolidate the code and to propagate modifications
> from the cpuidle core to the different drivers.
> 
> Hopefully, a movement has initiated to put the cpuidle drivers into the
> drivers/cpuidle directory like cpuidle-calxeda.c and cpuidle-kirkwood.c
> 
> Add an explicit maintainer entry in the MAINTAINER to clarify the situation
> and prevent new cpuidle drivers to goes to an arch directory.
> 
> The upstreaming process is unchanged: Rafael takes the patches to merge them
> into its tree but with the acked-by from the driver's maintainer. So the header
> must contains the name of the maintainer.
> 
> This organization will be the same than cpufreq.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Andrew Lunn <andrew@lunn.ch>  #for kirkwood
> Acked-by: Jason Cooper <jason@lakedaemon.net> #for kirkwood
> ---
>  MAINTAINERS                        |    9 +++++++++
>  drivers/cpuidle/cpuidle-calxeda.c  |    4 +++-
>  drivers/cpuidle/cpuidle-kirkwood.c |    5 +++--
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61677c3..45ee6dc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2217,6 +2217,15 @@ F:	drivers/cpufreq/arm_big_little.h
>  F:	drivers/cpufreq/arm_big_little.c
>  F:	drivers/cpufreq/arm_big_little_dt.c
>  
> +CPUIDLE DRIVERS
> +M:	Rafael J. Wysocki <rjw@sisk.pl>
> +M:	Daniel Lezcano <daniel.lezcano@linaro.org>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +T:	git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
> +F:	drivers/cpuidle/*
> +F:	include/linux/cpuidle.h
> +
>  CPUID/MSR DRIVER
>  M:	"H. Peter Anvin" <hpa@zytor.com>
>  S:	Maintained
> diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
> index e344b56..2233791 100644
> --- a/drivers/cpuidle/cpuidle-calxeda.c
> +++ b/drivers/cpuidle/cpuidle-calxeda.c
> @@ -1,7 +1,7 @@
>  /*
>   * Copyright 2012 Calxeda, Inc.
>   *
> - * Based on arch/arm/plat-mxc/cpuidle.c:
> + * Based on arch/arm/plat-mxc/cpuidle.c: #v3.7
>   * Copyright 2012 Freescale Semiconductor, Inc.
>   * Copyright 2012 Linaro Ltd.
>   *
> @@ -16,6 +16,8 @@
>   *
>   * You should have received a copy of the GNU General Public License along with
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
> + *
> + * Maintainer: Rob Herring <rob.herring@calxeda.com>
this need to move to the MAINTAINER file

so we get the e-mail get get_maintainer.pl
>   */
>  
>  #include <linux/cpuidle.h>
> diff --git a/drivers/cpuidle/cpuidle-kirkwood.c b/drivers/cpuidle/cpuidle-kirkwood.c
> index 53290e1..521b0a7 100644
> --- a/drivers/cpuidle/cpuidle-kirkwood.c
> +++ b/drivers/cpuidle/cpuidle-kirkwood.c
> @@ -1,6 +1,4 @@
>  /*
> - * arch/arm/mach-kirkwood/cpuidle.c
> - *
>   * CPU idle Marvell Kirkwood SoCs
>   *
>   * This file is licensed under the terms of the GNU General Public
> @@ -11,6 +9,9 @@
>   * to implement two idle states -
>   * #1 wait-for-interrupt
>   * #2 wait-for-interrupt and DDR self refresh
> + *
> + * Maintainer: Jason Cooper <jason@lakedaemon.net>
> + * Maintainer: Andrew Lunn <andrew@lunn.ch>
ditto
>   */
>  
>  #include <linux/kernel.h>
> -- 
> 1.7.9.5
> 
