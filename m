From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] devfreq: fix initialization of current frequency in last
 status
Date: Wed, 1 Jun 2016 09:30:27 +0100
Message-ID: <20160601083027.GB2898@e104805>
References: <1464690309-27809-1-git-send-email-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35697 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488AbcFAIaa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 Jun 2016 04:30:30 -0400
Content-Disposition: inline
In-Reply-To: <1464690309-27809-1-git-send-email-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, myungjoo.ham@samsung.com, kyungmin.park@samsung.com

On Tue, May 31, 2016 at 11:25:09AM +0100, Lukasz Luba wrote:
> Some systems need current frequency from last_status for calculation
> but it is zeroed during initialization. When the device starts there is
> no history, but we can assume that the last frequency was the
> same as the initial frequency (which is also used in 'previous_freq').
> The log shows the result of this misinterpreted value.
> [    2.042847] ... Failed to get voltage for frequency 0: -34
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

Looks good to me,

Reviewed-by: Javi Merino <javi.merino@arm.com>

> ---
>  drivers/devfreq/devfreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 984c5e9..a3f2c3b 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -515,6 +515,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	devfreq->profile = profile;
>  	strncpy(devfreq->governor_name, governor_name, DEVFREQ_NAME_LEN);
>  	devfreq->previous_freq = profile->initial_freq;
> +	devfreq->last_status.current_frequency = profile->initial_freq;
>  	devfreq->data = data;
>  	devfreq->nb.notifier_call = devfreq_notifier_call;
>  
> -- 
> 1.9.1
> 
