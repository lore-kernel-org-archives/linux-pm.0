From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/9] POWERPC: pseries: cpuidle: remove superfluous
 dev->state_count initialization
Date: Thu, 02 Jan 2014 11:11:07 +0530
Message-ID: <52C4FBF3.1060605@linux.vnet.ibm.com>
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
 <1387565251-7051-3-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1387565251-7051-3-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/21/2013 12:17 AM, Bartlomiej Zolnierkiewicz wrote:
> pseries cpuidle driver sets dev->state_count to drv->state_count so
> the default dev->state_count initialization in cpuidle_enable_device()
> (called from cpuidle_register_device()) can be used instead.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

> Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/processor_idle.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
> index a166e38..8aa8c40 100644
> --- a/arch/powerpc/platforms/pseries/processor_idle.c
> +++ b/arch/powerpc/platforms/pseries/processor_idle.c
> @@ -271,7 +271,6 @@ static void pseries_idle_devices_uninit(void)
>  static int pseries_idle_devices_init(void)
>  {
>  	int i;
> -	struct cpuidle_driver *drv = &pseries_idle_driver;
>  	struct cpuidle_device *dev;
> 
>  	pseries_cpuidle_devices = alloc_percpu(struct cpuidle_device);
> @@ -280,7 +279,6 @@ static int pseries_idle_devices_init(void)
> 
>  	for_each_possible_cpu(i) {
>  		dev = per_cpu_ptr(pseries_cpuidle_devices, i);
> -		dev->state_count = drv->state_count;
>  		dev->cpu = i;
>  		if (cpuidle_register_device(dev)) {
>  			printk(KERN_DEBUG \
> 
