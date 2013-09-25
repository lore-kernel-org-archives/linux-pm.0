From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] Thermal: x86_pkg_temp: change spin lock
Date: Wed, 25 Sep 2013 21:47:48 +0800
Message-ID: <1380116868.2422.0.camel@rzhang1-mobl4>
References: <1380045916-29833-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:55107 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755379Ab3IYNst (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Sep 2013 09:48:49 -0400
In-Reply-To: <1380045916-29833-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: eduardo.valentin@ti.com, linux-pm@vger.kernel.org

On Tue, 2013-09-24 at 11:05 -0700, Srinivas Pandruvada wrote:
> x86_pkg_temp receives thermal notifications via a callback from a
> therm_throt driver, where thermal interrupts are processed.
> This callback is pkg_temp_thermal_platform_thermal_notify. Here to
> avoid multiple interrupts from cores in a package, we disable the
> source and also set a variable to avoid scheduling delayed work function.
> This variable is protected via spin_lock_irqsave. On one buggy platform,
> we still receiving interrupts even if the source is disabled. This
> can cause deadlock/lockdep warning, when interrupt is generated while under
> spinlock in work function.
> Change spin_lock to spin_lock_irqsave and spin_unlock to
> spin_unlock_irqrestore as the data it is trying to protect can also
> be modified in a notification call called from interrupt handler.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

applied to thermal .next.

thanks,
rui
> ---
>  drivers/thermal/x86_pkg_temp_thermal.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
> index f36950e..7722cb9 100644
> --- a/drivers/thermal/x86_pkg_temp_thermal.c
> +++ b/drivers/thermal/x86_pkg_temp_thermal.c
> @@ -316,18 +316,19 @@ static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
>  	int phy_id = topology_physical_package_id(cpu);
>  	struct phy_dev_entry *phdev = pkg_temp_thermal_get_phy_entry(cpu);
>  	bool notify = false;
> +	unsigned long flags;
>  
>  	if (!phdev)
>  		return;
>  
> -	spin_lock(&pkg_work_lock);
> +	spin_lock_irqsave(&pkg_work_lock, flags);
>  	++pkg_work_cnt;
>  	if (unlikely(phy_id > max_phy_id)) {
> -		spin_unlock(&pkg_work_lock);
> +		spin_unlock_irqrestore(&pkg_work_lock, flags);
>  		return;
>  	}
>  	pkg_work_scheduled[phy_id] = 0;
> -	spin_unlock(&pkg_work_lock);
> +	spin_unlock_irqrestore(&pkg_work_lock, flags);
>  
>  	enable_pkg_thres_interrupt();
>  	rdmsrl(MSR_IA32_PACKAGE_THERM_STATUS, msr_val);
> @@ -397,6 +398,7 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
>  	int thres_count;
>  	u32 eax, ebx, ecx, edx;
>  	u8 *temp;
> +	unsigned long flags;
>  
>  	cpuid(6, &eax, &ebx, &ecx, &edx);
>  	thres_count = ebx & 0x07;
> @@ -420,19 +422,19 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
>  		goto err_ret_unlock;
>  	}
>  
> -	spin_lock(&pkg_work_lock);
> +	spin_lock_irqsave(&pkg_work_lock, flags);
>  	if (topology_physical_package_id(cpu) > max_phy_id)
>  		max_phy_id = topology_physical_package_id(cpu);
>  	temp = krealloc(pkg_work_scheduled,
>  			(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
>  	if (!temp) {
> -		spin_unlock(&pkg_work_lock);
> +		spin_unlock_irqrestore(&pkg_work_lock, flags);
>  		err = -ENOMEM;
>  		goto err_ret_free;
>  	}
>  	pkg_work_scheduled = temp;
>  	pkg_work_scheduled[topology_physical_package_id(cpu)] = 0;
> -	spin_unlock(&pkg_work_lock);
> +	spin_unlock_irqrestore(&pkg_work_lock, flags);
>  
>  	phy_dev_entry->phys_proc_id = topology_physical_package_id(cpu);
>  	phy_dev_entry->first_cpu = cpu;


