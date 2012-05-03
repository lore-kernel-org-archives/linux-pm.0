From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCHv3 2/5] cpuidle: fix error handling in
	__cpuidle_register_device
Date: Thu, 3 May 2012 22:50:26 +0200
Message-ID: <201205032250.26434.rjw@sisk.pl>
References: <1335816551-27756-1-git-send-email-ccross@android.com>
	<1335816551-27756-3-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1335816551-27756-3-git-send-email-ccross@android.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kay Sievers <kay.sievers@vrfy.org>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, Colin Cross <ccross@android.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Arjan van de Ven <arjan@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Monday, April 30, 2012, Colin Cross wrote:
> Fix the error handling in __cpuidle_register_device to include
> the missing list_del.  Move it to a label, which will simplify
> the error handling when coupled states are added.
> 
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Tested-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Colin Cross <ccross@android.com>

Reviewed-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  drivers/cpuidle/cpuidle.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 3e3e3e4..4540672 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -403,13 +403,18 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
>  
>  	per_cpu(cpuidle_devices, dev->cpu) = dev;
>  	list_add(&dev->device_list, &cpuidle_detected_devices);
> -	if ((ret = cpuidle_add_sysfs(cpu_dev))) {
> -		module_put(cpuidle_driver->owner);
> -		return ret;
> -	}
> +	ret = cpuidle_add_sysfs(cpu_dev);
> +	if (ret)
> +		goto err_sysfs;
>  
>  	dev->registered = 1;
>  	return 0;
> +
> +err_sysfs:
> +	list_del(&dev->device_list);
> +	per_cpu(cpuidle_devices, dev->cpu) = NULL;
> +	module_put(cpuidle_driver->owner);
> +	return ret;
>  }
>  
>  /**
> 
