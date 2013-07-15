From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH -next] Thermal: x86_pkg_temp: fix krealloc() misuse in
 in pkg_temp_thermal_device_add()
Date: Mon, 15 Jul 2013 16:19:36 +0800
Message-ID: <1373876376.3034.0.camel@rzhang1-mobl4>
References: <CAPgLHd_d5DHn==OFdBsLi_Kkekd5h44Cx6m9Hj5EM_yOGJXKPQ@mail.gmail.com>
	 <1371802062.2170.6.camel@rzhang1-mobl4>
	 <CAPgLHd_T+ez7_fifC9sY33EKcuAa_A+P6w6gK72nn=4hjzp87Q@mail.gmail.com>
	 <51DF4F7C.10906@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26590 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab3GOITm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Jul 2013 04:19:42 -0400
In-Reply-To: <51DF4F7C.10906@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, eduardo.valentin@ti.com, yongjun_wei@trendmicro.com.cn, linux-pm@vger.kernel.org

On Thu, 2013-07-11 at 17:36 -0700, Srinivas Pandruvada wrote:
> Tested this patch and it works fine.
> 
> Thanks,
> Srinivas
> 
> On 06/21/2013 01:49 AM, Wei Yongjun wrote:
> > On 06/21/2013 04:07 PM, Zhang Rui wrote:
> >> On Tue, 2013-06-18 at 21:09 +0800, Wei Yongjun wrote:
> >>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> >>>
> >>> If krealloc() returns NULL, it doesn't free the original. So any code
> >>> of the form 'foo = krealloc(foo, ...);' is almost certainly a bug.
> >>>
> >> you mean this would probably cause a memory leak, right?
> > Yes.
> >
> >>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

applied to thermal-next.

thanks,
rui
> >>> ---
> >>>   drivers/thermal/x86_pkg_temp_thermal.c | 8 +++++---
> >>>   1 file changed, 5 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
> >>> index 5de56f6..b90e84b 100644
> >>> --- a/drivers/thermal/x86_pkg_temp_thermal.c
> >>> +++ b/drivers/thermal/x86_pkg_temp_thermal.c
> >>> @@ -394,6 +394,7 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
> >>>   	char buffer[30];
> >>>   	int thres_count;
> >>>   	u32 eax, ebx, ecx, edx;
> >>> +	u8 *temp;
> >>>   
> >>>   	cpuid(6, &eax, &ebx, &ecx, &edx);
> >>>   	thres_count = ebx & 0x07;
> >>> @@ -417,13 +418,14 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
> >>>   	spin_lock(&pkg_work_lock);
> >>>   	if (topology_physical_package_id(cpu) > max_phy_id)
> >>>   		max_phy_id = topology_physical_package_id(cpu);
> >>> -	pkg_work_scheduled = krealloc(pkg_work_scheduled,
> >>> -				(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
> >>> -	if (!pkg_work_scheduled) {
> >>> +	temp = krealloc(pkg_work_scheduled,
> >>> +			(max_phy_id+1) * sizeof(u8), GFP_ATOMIC);
> >>> +	if (!temp) {
> >> without this patch, this function will quite if krealloc returns NULL,
> >> but with the previous pkg_work_scheduled unfreed, right?
> > Yes, without patch, previous pkg_work_scheduled will unfreed if krealloc
> > return NULL.
> >
> >> thanks,
> >> rui
> >>>   		spin_unlock(&pkg_work_lock);
> >>>   		err = -ENOMEM;
> >>>   		goto err_ret_free;
> >>>   	}
> >>> +	pkg_work_scheduled = temp;
> >>>   	pkg_work_scheduled[topology_physical_package_id(cpu)] = 0;
> >>>   	spin_unlock(&pkg_work_lock);
> >>>   
> >>>
> >>
> >>
> >
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


