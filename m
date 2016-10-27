From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3] PM / devfreq: Restart previous governor if new governor
 fails to start
Date: Thu, 27 Oct 2016 09:06:00 +0900
Message-ID: <de0f8010-31b2-8cec-f793-393c2199f44d@samsung.com>
References: <CGME20161026191715epcas1p311c2c626563a736e14c83fb0504c099e@epcas1p3.samsung.com>
 <1477509425-16936-1-git-send-email-skannan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:33932 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932332AbcJ0AGD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2016 20:06:03 -0400
In-reply-to: <1477509425-16936-1-git-send-email-skannan@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 2016년 10월 27일 04:17, Saravana Kannan wrote:
> If the new governor fails to start, switch back to old governor so that the
> devfreq state is not left in some weird limbo.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
> * Fix NULL deref for real this time.
> * Addressed some style preferences.
> 
>  drivers/devfreq/devfreq.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index bf3ea76..77c41a5 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -919,7 +919,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	struct devfreq *df = to_devfreq(dev);
>  	int ret;
>  	char str_governor[DEVFREQ_NAME_LEN + 1];
> -	struct devfreq_governor *governor;
> +	const struct devfreq_governor *governor, *prev_governor;
>  
>  	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>  	if (ret != 1)
> @@ -944,12 +944,21 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  			goto out;
>  		}
>  	}
> +	prev_governor = df->governor;
>  	df->governor = governor;
>  	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
>  	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
> -	if (ret)
> +	if (ret) {
>  		dev_warn(dev, "%s: Governor %s not started(%d)\n",
>  			 __func__, df->governor->name, ret);
> +		if (prev_governor) {

I think that prev_governor is always set. You don't need to check it.
Why do check it?

> +			df->governor = prev_governor;
> +			strncpy(df->governor_name, prev_governor->name,
> +				DEVFREQ_NAME_LEN);
> +			df->governor->event_handler(df, DEVFREQ_GOV_START,
> +						    NULL);
> +		}
> +	}
>  out:
>  	mutex_unlock(&devfreq_list_lock);
>  
> 

-- 
Best Regards,
Chanwoo Choi
