From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH -next] Thermal: x86_pkg_temp: fix krealloc() misuse in
 in pkg_temp_thermal_device_add()
Date: Fri, 21 Jun 2013 16:07:42 +0800
Message-ID: <1371802062.2170.6.camel@rzhang1-mobl4>
References: <CAPgLHd_d5DHn==OFdBsLi_Kkekd5h44Cx6m9Hj5EM_yOGJXKPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:64688 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161189Ab3FUIH7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 21 Jun 2013 04:07:59 -0400
In-Reply-To: <CAPgLHd_d5DHn==OFdBsLi_Kkekd5h44Cx6m9Hj5EM_yOGJXKPQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: eduardo.valentin@ti.com, yongjun_wei@trendmicro.com.cn, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Tue, 2013-06-18 at 21:09 +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> If krealloc() returns NULL, it doesn't free the original. So any code
> of the form 'foo = krealloc(foo, ...);' is almost certainly a bug.
> 
you mean this would probably cause a memory leak, right?

> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/thermal/x86_pkg_temp_thermal.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
> index 5de56f6..b90e84b 100644
> --- a/drivers/thermal/x86_pkg_temp_thermal.c
> +++ b/drivers/thermal/x86_pkg_temp_thermal.c
> @@ -394,6 +394,7 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
>  	char buffer[30];
>  	int thres_count;
>  	u32 eax, ebx, ecx, edx;
> +	u8 *temp;
>  
>  	cpuid(6, &eax, &ebx, &ecx, &edx);
>  	thres_count = ebx & 0x07;
> @@ -417,13 +418,14 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
>  	spin_lock(&pkg_work_lock);
>  	if (topology_physical_package_id(cpu) > max_phy_id)
>  		max_phy_id = topology_physical_package_id(cpu);
> -	pkg_work_scheduled = krealloc(pkg_work_scheduled,
> -				(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
> -	if (!pkg_work_scheduled) {
> +	temp = krealloc(pkg_work_scheduled,
> +			(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
> +	if (!temp) {

without this patch, this function will quite if krealloc returns NULL,
but with the previous pkg_work_scheduled unfreed, right?

thanks,
rui
>  		spin_unlock(&pkg_work_lock);
>  		err = -ENOMEM;
>  		goto err_ret_free;
>  	}
> +	pkg_work_scheduled = temp;
>  	pkg_work_scheduled[topology_physical_package_id(cpu)] = 0;
>  	spin_unlock(&pkg_work_lock);
>  
> 


