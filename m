From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [patch] cpufreq/pcc-cpufreq: Fix doorbell.access_width
Date: Thu, 23 Jun 2016 23:13:39 +0200
Message-ID: <119a72eb-b691-77cf-9d3a-55b67a50f410@intel.com>
References: <1466579229.3188.14.camel@gmail.com>
 <1466664342.5839.39.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35160 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189AbcFWVOI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 23 Jun 2016 17:14:08 -0400
In-Reply-To: <1466664342.5839.39.camel@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On 6/23/2016 8:45 AM, Mike Galbraith wrote:
> Commit 920de6ebfab8 apparently exposed a latent bug, doorbell.access_width
> is initialized to 64, but per Lv Zheng, it should be 4, and indeed, making
> that change does bring pcc-cpufreq back to life.
>
> Suggested-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> ---
>   drivers/cpufreq/pcc-cpufreq.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -487,7 +487,7 @@ static int __init pcc_cpufreq_probe(void
>   	doorbell.space_id = reg_resource->space_id;
>   	doorbell.bit_width = reg_resource->bit_width;
>   	doorbell.bit_offset = reg_resource->bit_offset;
> -	doorbell.access_width = 64;
> +	doorbell.access_width = 4;
>   	doorbell.address = reg_resource->address;
>   
>   	pr_debug("probe: doorbell: space_id is %d, bit_width is %d, "


OK, I picked this up from the LKML patchwork (will push to Linus 
tomorrow), but next time please CC patches related to ACPI to linux-acpi 
and PM patches to linux-pm (so this one should have gone to both, 
ideally).  They are much easier to handle/review then and more people 
are likely to look at them too.


Thanks,

Rafael


