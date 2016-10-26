From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2] PM / devfreq: Restart previous governor if new governor
 fails to start
Date: Wed, 26 Oct 2016 16:22:48 +0900
Message-ID: <581059C8.3000408@samsung.com>
References: <CGME20161026012617epcas1p4c8f51ab0efde871ed15c217f62ff522e@epcas1p4.samsung.com>
 <1477445160-990-1-git-send-email-skannan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1477445160-990-1-git-send-email-skannan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 2016년 10월 26일 10:25, Saravana Kannan wrote:
> If the new governor fails to start, switch back to old governor so that the
> devfreq state is not left in some weird limbo.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
> * Fixed typo in commit text
> * Fixed potential NULL deref
> 
>  drivers/devfreq/devfreq.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index bf3ea76..243253e 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -919,7 +919,7 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  	struct devfreq *df = to_devfreq(dev);
>  	int ret;
>  	char str_governor[DEVFREQ_NAME_LEN + 1];
> -	struct devfreq_governor *governor;
> +	const struct devfreq_governor *governor, *prev_gov;
>  
>  	ret = sscanf(buf, "%" __stringify(DEVFREQ_NAME_LEN) "s", str_governor);
>  	if (ret != 1)
> @@ -944,12 +944,17 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  			goto out;
>  		}
>  	}
> +	prev_gov = df->governor;
>  	df->governor = governor;
>  	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
>  	ret = df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
> -	if (ret)
> +	if (ret) {
>  		dev_warn(dev, "%s: Governor %s not started(%d)\n",
>  			 __func__, df->governor->name, ret);
> +		df->governor = prev_gov;
> +		strncpy(df->governor_name, prev_gov->name, DEVFREQ_NAME_LEN);
> +		df->governor->event_handler(df, DEVFREQ_GOV_START, NULL);
> +	}
>  out:
>  	mutex_unlock(&devfreq_list_lock);
>  
> 

Looks good to me.
But, how about using the 'prev_governor' instead of 'prev_gov'?
because the variable name of current governor is 'governor' instead of 'gov'.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
