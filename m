From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / QOS: correct the valid range of pm_qos_class
Date: Wed, 12 Jun 2013 13:16:42 +0200
Message-ID: <2687623.rLBRO7ohLp@vostro.rjw.lan>
References: <1371016395-20688-1-git-send-email-kpark3469@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:34860 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150Ab3FLLHa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 12 Jun 2013 07:07:30 -0400
In-Reply-To: <1371016395-20688-1-git-send-email-kpark3469@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kpark3469@gmail.com
Cc: linux-pm@vger.kernel.org, keun-o.park@windriver.com, len.brown@intel.com

On Wednesday, June 12, 2013 02:53:15 PM kpark3469@gmail.com wrote:
> From: Sahara <keun-o.park@windriver.com>
> 
> The valid start index for pm_qos_array is not 0 but 1. There is a
> null_pm_qos at index 0 of pm_qos_array. However, null_pm_qos is not
> created as misc device so that inclusion of 0 index for checking
> pm_qos_class especially for file operations is not proper here.
> 
> Signed-off-by: Sahara <keun-o.park@windriver.com>
> ---
>  kernel/power/qos.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 587ddde..ec6f0a7 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -477,7 +477,7 @@ static int find_pm_qos_object_by_minor(int minor)
>  {
>  	int pm_qos_class;
>  
> -	for (pm_qos_class = 0;
> +	for (pm_qos_class = 1;

While you're at it, can you please use PM_QOS_CPU_DMA_LATENCY instead of 1
here and below?

Rafael


>  		pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_class++) {
>  		if (minor ==
>  			pm_qos_array[pm_qos_class]->pm_qos_power_miscdev.minor)
> @@ -491,7 +491,7 @@ static int pm_qos_power_open(struct inode *inode, struct file *filp)
>  	long pm_qos_class;
>  
>  	pm_qos_class = find_pm_qos_object_by_minor(iminor(inode));
> -	if (pm_qos_class >= 0) {
> +	if (pm_qos_class >= 1) {
>  		struct pm_qos_request *req = kzalloc(sizeof(*req), GFP_KERNEL);
>  		if (!req)
>  			return -ENOMEM;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
