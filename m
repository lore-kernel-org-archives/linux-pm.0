Return-Path: <SRS0=Mo7e=IG=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CA6C433E0
	for <linux-pm@archiver.kernel.org>; Mon,  8 Mar 2021 09:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F39651B8
	for <linux-pm@archiver.kernel.org>; Mon,  8 Mar 2021 09:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhCHJuu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Mar 2021 04:50:50 -0500
Received: from foss.arm.com ([217.140.110.172]:35012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhCHJul (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Mar 2021 04:50:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62C2DD6E;
        Mon,  8 Mar 2021 01:50:41 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E9833F73C;
        Mon,  8 Mar 2021 01:50:39 -0800 (PST)
Subject: Re: [PATCH v5 1/4] PM / devfreq: Register devfreq as a cooling device
 on demand
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, cwchoi00@gmail.com
Cc:     lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20210308091646.28096-1-daniel.lezcano@linaro.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <ffed675b-4edd-26e8-1147-08ab200a651a@arm.com>
Date:   Mon, 8 Mar 2021 09:51:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210308091646.28096-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/03/2021 09:16, Daniel Lezcano wrote:
> Currently the default behavior is to manually having the devfreq
> backend to register themselves as a devfreq cooling device.
> 
> Instead of adding the code in the drivers for the thermal cooling
> device registering, let's provide a flag in the devfreq's profile to
> tell the common devfreq code to register the newly created devfreq as
> a cooling device.
> 
> Suggested-by: Chanwoo Choi <cwchoi00@gmail.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   V5:
>     - Changed subject prefix by:  PM / devfreq
>   V4:
>     - Replaced thermal_cooling_device_unregister() by
>       devfreq_cooling_unregister()
>   V3:
>     - Rebased on linux-pm branch without units.h
>     - Set the cdev to NULL in case of error
>     - Added description for the cdev field in the devfreq structure
>   V2:
>     - Added is_cooling_device boolean in profile structure
>     - Register cooling device when the is_cooling_device boolean is set
>     - Remove devfreq cooling device registration in the backend drivers
>   V1:
>     - Register devfreq as a cooling device unconditionnally
> ---
>   drivers/devfreq/devfreq.c | 13 +++++++++++++
>   include/linux/devfreq.h   |  8 ++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index bf3047896e41..8a535d4d6083 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -11,6 +11,7 @@
>   #include <linux/kmod.h>
>   #include <linux/sched.h>
>   #include <linux/debugfs.h>
> +#include <linux/devfreq_cooling.h>
>   #include <linux/errno.h>
>   #include <linux/err.h>
>   #include <linux/init.h>
> @@ -26,6 +27,7 @@
>   #include <linux/hrtimer.h>
>   #include <linux/of.h>
>   #include <linux/pm_qos.h>
> +#include <linux/thermal.h>
>   #include "governor.h"
>   
>   #define CREATE_TRACE_POINTS
> @@ -935,6 +937,15 @@ struct devfreq *devfreq_add_device(struct device *dev,
>   
>   	mutex_unlock(&devfreq_list_lock);
>   
> +	if (devfreq->profile->is_cooling_device) {
> +		devfreq->cdev = devfreq_cooling_em_register(devfreq, NULL);
> +		if (IS_ERR(devfreq->cdev)) {
> +			dev_info(dev, "Failed to register devfreq "
> +				 "cooling device\n");

Please don't split strings across multiple lines (it makes grepping for 
them harder). With that fixed:

Reviewed-by: Steven Price <steven.price@arm.com>

> +			devfreq->cdev = NULL;
> +		}
> +	}
> +
>   	return devfreq;
>   
>   err_init:
> @@ -960,6 +971,8 @@ int devfreq_remove_device(struct devfreq *devfreq)
>   	if (!devfreq)
>   		return -EINVAL;
>   
> +	devfreq_cooling_unregister(devfreq->cdev);
> +
>   	if (devfreq->governor) {
>   		devfreq->governor->event_handler(devfreq,
>   						 DEVFREQ_GOV_STOP, NULL);
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 26ea0850be9b..aba7ace11b72 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -98,11 +98,15 @@ struct devfreq_dev_status {
>    * @freq_table:		Optional list of frequencies to support statistics
>    *			and freq_table must be generated in ascending order.
>    * @max_state:		The size of freq_table.
> + *
> + * @is_cooling_device: A self-explanatory boolean giving the device a
> + *                     cooling effect property.
>    */
>   struct devfreq_dev_profile {
>   	unsigned long initial_freq;
>   	unsigned int polling_ms;
>   	enum devfreq_timer timer;
> +	bool is_cooling_device;
>   
>   	int (*target)(struct device *dev, unsigned long *freq, u32 flags);
>   	int (*get_dev_status)(struct device *dev,
> @@ -156,6 +160,7 @@ struct devfreq_stats {
>    * @suspend_count:	 suspend requests counter for a device.
>    * @stats:	Statistics of devfreq device behavior
>    * @transition_notifier_list: list head of DEVFREQ_TRANSITION_NOTIFIER notifier
> + * @cdev:	Cooling device pointer if the devfreq has cooling property
>    * @nb_min:		Notifier block for DEV_PM_QOS_MIN_FREQUENCY
>    * @nb_max:		Notifier block for DEV_PM_QOS_MAX_FREQUENCY
>    *
> @@ -198,6 +203,9 @@ struct devfreq {
>   
>   	struct srcu_notifier_head transition_notifier_list;
>   
> +	/* Pointer to the cooling device if used for thermal mitigation */
> +	struct thermal_cooling_device *cdev;
> +
>   	struct notifier_block nb_min;
>   	struct notifier_block nb_max;
>   };
> 

