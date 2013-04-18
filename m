From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [V3 patch 05/19] ARM: ux500: cpuidle: replace for_each_online_cpu
 by for_each_possible_cpu
Date: Thu, 18 Apr 2013 14:08:12 +0530
Message-ID: <516FB0F4.5020109@ti.com>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org>
 <1365770165-27096-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1365770165-27096-6-git-send-email-daniel.lezcano@linaro.org>
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
Cc: andrew@lunn.ch, khilman@deeprootsystems.com, linus.walleij@linaro.org, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, nicolas.ferre@atmel.com, rob.herring@calxeda.com, rjw@sisk.pl, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

On Friday 12 April 2013 06:05 PM, Daniel Lezcano wrote:
> All the drivers are using, in their initialization function, the
> for_each_possible_cpu macro.
> 
> Using for_each_online_cpu means the driver must handle the initialization
> of the cpuidle device when a cpu is up which is not the case here.
> 
> Change the macro to for_each_possible_cpu as that fix the hotplug
> initialization and make the initialization routine consistent with the
> rest of the code in the different drivers.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-ux500/cpuidle.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
> index c29c1bf..5657d4a 100644
> --- a/arch/arm/mach-ux500/cpuidle.c
> +++ b/arch/arm/mach-ux500/cpuidle.c
> @@ -125,7 +125,7 @@ int __init ux500_idle_init(void)
>  		return ret;
>  	}
>  
> -	for_each_online_cpu(cpu) {
> +	for_each_possible(cpu) {
There should no problem with online_cpu() usage
as well as long as one is not limmiting number of
boot CPUs using the max_cpus option.

But I agree making possible_cpu() would take care
of that case as well.

Regards,
Santosh
