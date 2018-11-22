From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 2/6] devfreq: refactor set_target frequency function
Date: Thu, 22 Nov 2018 11:52:30 +0900
Message-ID: <5BF619EE.8090006@samsung.com>
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180202eucas1p27d3aa58411abeae03181c38b91fc67de@eucas1p2.samsung.com>
        <1542823301-23563-3-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1542823301-23563-3-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org, krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

On 2018년 11월 22일 03:01, Lukasz Luba wrote:
> The refactoring is needed for the new client in devfreq: suspend.
> To avoid code duplication, move it to the new local function
> devfreq_set_target.
> 
> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
> solve issue with devfreq device's frequency during suspend/resume.
> During the discussion on LKML some corner cases and comments appeared
> related to the design. This patch address them keeping in mind suggestions
> from Chanwoo Choi.

As I commented on patch1, please remove it.

> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 62 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 37 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index e20e7e4..cf9c643 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -285,6 +285,42 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>  	return 0;
>  }
>  
> +static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
> +			      unsigned long *prev_freq, u32 flags)

Please remove the unused space in front of 'unsigned long *prev_freq'.
Use tab only for indentation.

> +{
> +	struct devfreq_freqs freqs;
> +	unsigned long cur_freq;
> +	int err = 0;
> +
> +	if (devfreq->profile->get_cur_freq)
> +		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
> +	else
> +		cur_freq = devfreq->previous_freq;
> +
> +	freqs.old = cur_freq;
> +	freqs.new = new_freq;
> +	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
> +
> +	err = devfreq->profile->target(devfreq->dev.parent, &new_freq, flags);
> +	if (err) {
> +		freqs.new = cur_freq;
> +		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> +		return err;
> +	}
> +
> +	freqs.new = new_freq;
> +	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> +
> +	if (devfreq_update_status(devfreq, new_freq))
> +		dev_err(&devfreq->dev,
> +			"Couldn't update frequency transition information.\n");
> +
> +	devfreq->previous_freq = new_freq;
> +	*prev_freq = cur_freq;
> +
> +	return err;
> +}
> +
>  /* Load monitoring helper functions for governors use */
>  
>  /**
> @@ -296,7 +332,6 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>   */
>  int update_devfreq(struct devfreq *devfreq)
>  {
> -	struct devfreq_freqs freqs;
>  	unsigned long freq, cur_freq, min_freq, max_freq;


cur_freq is not used after modification. Remove it.

>  	int err = 0;
>  	u32 flags = 0;
> @@ -333,31 +368,8 @@ int update_devfreq(struct devfreq *devfreq)
>  		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>  	}
>  
> -	if (devfreq->profile->get_cur_freq)
> -		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
> -	else
> -		cur_freq = devfreq->previous_freq;
> -
> -	freqs.old = cur_freq;
> -	freqs.new = freq;
> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
> +	return devfreq_set_target(devfreq, freq, &cur_freq, flags);

You get the 'cur_freq' from devfreq_set_taget() for devfreq_suspend_device() on patch3.
But, update_devfreq() and devfreq_resume_device() don't use the 'cur_freq' value
from devfreq_set_target().

Instead, getting 'cur_freq' for 'devfreq->resume_freq' in the devfreq_set_target().
Please remove the 'cur_freq' parameter from devfreq_set_target.

>  
> -	err = devfreq->profile->target(devfreq->dev.parent, &freq, flags);
> -	if (err) {
> -		freqs.new = cur_freq;
> -		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> -		return err;
> -	}
> -
> -	freqs.new = freq;
> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> -
> -	if (devfreq_update_status(devfreq, freq))
> -		dev_err(&devfreq->dev,
> -			"Couldn't update frequency transition information.\n");
> -
> -	devfreq->previous_freq = freq;
> -	return err;
>  }
>  EXPORT_SYMBOL(update_devfreq);
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
