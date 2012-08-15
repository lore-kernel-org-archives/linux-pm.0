From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpuidle: Prevent null pointer dereference in
	cpuidle_coupled_cpu_notify
Date: Wed, 15 Aug 2012 22:23:17 +0200
Message-ID: <201208152223.17623.rjw@sisk.pl>
References: <1344945151.2674.56.camel@linaro1.home>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1344945151.2674.56.camel@linaro1.home>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Colin Cross <ccross@android.com>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 14, 2012, Jon Medhurst (Tixy) wrote:
> When a kernel is built to support multiple hardware types it's possible
> that CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is set but the hardware the
> kernel is run on doesn't support cpuidle and therefore doesn't load a
> driver for it. In this case, when the system is shut down,
> cpuidle_coupled_cpu_notify() gets called with cpuidle_devices set to
> NULL. There are quite possibly other circumstances where this
> situation can also occur and we should check for it.
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>

Applied to the linux-next branch of the linux-pm.git tree as v3.6 material.

Thanks,
Rafael


> ---
> 
> Would a better fix be to delay registering the notifier until
> cpuidle_coupled_register_device() is called? Though following through
> with that logic would require unregistering the notifier when cpuidle
> driver is unregistered and it still seems possible that there would
> still be a window of opportunity for things to go wrong.
> 
> 
>  drivers/cpuidle/coupled.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
> index 2c9bf26..c78a5ff 100644
> --- a/drivers/cpuidle/coupled.c
> +++ b/drivers/cpuidle/coupled.c
> @@ -681,7 +681,7 @@ static int cpuidle_coupled_cpu_notify(struct notifier_block *nb,
>  	mutex_lock(&cpuidle_lock);
>  
>  	dev = per_cpu(cpuidle_devices, cpu);
> -	if (!dev->coupled)
> +	if (!dev || !dev->coupled)
>  		goto out;
>  
>  	switch (action & ~CPU_TASKS_FROZEN) {
> 
