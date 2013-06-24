From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2] PM / QOS: correct the valid range of pm_qos_class
Date: Mon, 24 Jun 2013 14:04:52 +0200
Message-ID: <1967118.pWkF433BHI@vostro.rjw.lan>
References: <1371695637-5118-1-git-send-email-kpark3469@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:48997 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402Ab3FXLzZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 24 Jun 2013 07:55:25 -0400
In-Reply-To: <1371695637-5118-1-git-send-email-kpark3469@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kpark3469@gmail.com
Cc: linux-pm@vger.kernel.org, keun-o.park@windriver.com, len.brown@intel.com

On Thursday, June 20, 2013 11:33:57 AM kpark3469@gmail.com wrote:
> From: Sahara <keun-o.park@windriver.com>
> 
> The valid start index for pm_qos_array is not 0 but 1. There is a
> null_pm_qos at index 0 of pm_qos_array. However, null_pm_qos is not
> created as misc device so that inclusion of 0 index for checking
> pm_qos_class especially for file operations is not proper here.
> 
> Signed-off-by: Sahara <keun-o.park@windriver.com>

Queued up for 3.11.

Thanks,
Rafael


> ---
>  kernel/power/qos.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 587ddde..f2f5f6e 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -477,7 +477,7 @@ static int find_pm_qos_object_by_minor(int minor)
>  {
>  	int pm_qos_class;
>  
> -	for (pm_qos_class = 0;
> +	for (pm_qos_class = PM_QOS_CPU_DMA_LATENCY;
>  		pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
>  		if (minor ==
>  			pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
> @@ -491,7 +491,7 @@ static int pm_qos_power_open(struct inode *inode, struct file *filp)
>  	long pm_qos_class;
>  
>  	pm_qos_class = find_pm_qos_object_by_minor(iminor(inode));
> -	if (pm_qos_class >= 0) {
> +	if (pm_qos_class >= PM_QOS_CPU_DMA_LATENCY) {
>  		struct pm_qos_request *req = kzalloc(sizeof(*req), GFP_KERNEL);
>  		if (!req)
>  			return -ENOMEM;
> @@ -584,7 +584,7 @@ static int __init pm_qos_power_init(void)
>  
>  	BUILD_BUG_ON(ARRAY_SIZE(pm_qos_array) != PM_QOS_NUM_CLASSES);
>  
> -	for (i = 1; i < PM_QOS_NUM_CLASSES; i++) {
> +	for (i = PM_QOS_CPU_DMA_LATENCY; i < PM_QOS_NUM_CLASSES; i++) {
>  		ret = register_pm_qos_misc(pm_qos_array[i]);
>  		if (ret < 0) {
>  			printk(KERN_ERR "pm_qos_param: %s setup failed\n",
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
