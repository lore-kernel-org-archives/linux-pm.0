From: mark gross <markgross@thegnar.org>
Subject: Re: [PATCH] PM / QOS: correct the valid range of pm_qos_class
Date: Tue, 9 Jul 2013 06:29:18 -0700
Message-ID: <20130709132918.GA14761@mgross-G62>
References: <1371090717-22198-1-git-send-email-kpark3469@gmail.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:51228 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab3GIN3V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jul 2013 09:29:21 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so5481024pbc.30
        for <linux-pm@vger.kernel.org>; Tue, 09 Jul 2013 06:29:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1371090717-22198-1-git-send-email-kpark3469@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kpark3469@gmail.com
Cc: linux-pm@vger.kernel.org, keun-o.park@windriver.com, len.brown@intel.com, rjw@sisk.pl

On Thu, Jun 13, 2013 at 11:31:57AM +0900, kpark3469@gmail.com wrote:
> From: Sahara <keun-o.park@windriver.com>
> 
> The valid start index for pm_qos_array is not 0 but 1. There is a
> null_pm_qos at index 0 of pm_qos_array. However, null_pm_qos is not
> created as misc device so that inclusion of 0 index for checking
> pm_qos_class especially for file operations is not proper here.
> 
> Signed-off-by: Sahara <keun-o.park@windriver.com>
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
why not: for (pm_qos_class = PM_QOS_RESERVED + 1;?

I don't like assigning symantics implying DMA_LATENCY is the first qos class.
This is implicitly assuming an order I don't think is proper to assume.

humph.  this has already been merged.  My gripe is WRT style anyway.

surves me right for not paying attention. I'll post an stylistic tweak later.

--mark


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
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
