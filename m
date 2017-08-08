From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] devfreq: add error check for sscanf in userspace
 governor
Date: Tue, 08 Aug 2017 09:51:49 +0900
Message-ID: <59890B25.9090506@samsung.com>
References: <1502111205-22560-1-git-send-email-gsantosh@codeaurora.org>
        <CGME20170807130749epcas2p3052fee64e962d1013f94a850c89550f4@epcas2p3.samsung.com>
        <1502111205-22560-2-git-send-email-gsantosh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:19986 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbdHHAvu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Aug 2017 20:51:50 -0400
In-reply-to: <1502111205-22560-2-git-send-email-gsantosh@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Mardi <gsantosh@codeaurora.org>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gsantosh@qti.qualcomm.com, skannan@quicinc.com, rgottimu@qti.qualcomm.com

Hi,

On 2017년 08월 07일 22:06, Santosh Mardi wrote:
> store_freq function of devfreq userspace governor
> executes further, even if error is returned from sscanf,
> this will result in setting up wrong frequency value.
> 
> Add proper error check to bail out if any error is returned.
> 
> Signed-off-by: Santosh Mardi <gsantosh@codeaurora.org>
> ---
>  drivers/devfreq/governor_userspace.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index 77028c2..1d0c9cc 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -53,12 +53,15 @@ static ssize_t store_freq(struct device *dev, struct device_attribute *attr,
>  	mutex_lock(&devfreq->lock);
>  	data = devfreq->data;
>  
> -	sscanf(buf, "%lu", &wanted);
> +	err = sscanf(buf, "%lu", &wanted);
> +	if (err != 1)
> +		goto out;
>  	data->user_frequency = wanted;
>  	data->valid = true;
>  	err = update_devfreq(devfreq);
>  	if (err == 0)
>  		err = count;
> +out:
>  	mutex_unlock(&devfreq->lock);
>  	return err;
>  }
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
