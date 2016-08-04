From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: event: remove duplicate
 devfreq_event_get_drvdata()
Date: Thu, 04 Aug 2016 19:30:26 +0900
Message-ID: <57A31942.2060507@samsung.com>
References: <CGME20160804102847epcas1p498c32c32d5aaec87e607ff4adb07070a@epcas1p4.samsung.com>
 <1470306525-5515-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1470306525-5515-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, linux-kernel@vger.kernel.org, Lin Huang <hl@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Dear all,

Please ignore this patch. This patch fix the bug.
So, I should send it on stable@verger.kernel.org. 
But the stable mailing list is missing. So, I'll resend it.

Regards,
Chanwoo Choi

On 2016년 08월 04일 19:28, Chanwoo Choi wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> there define two devfreq_event_get_drvdata() function in devfreq-event.h
> when disable CONFIG_PM_DEVFREQ_EVENT, it will lead to build fail. So
> remove devfreq_event_get_drvdata() function.
> 
> Fixes: f262f28c1470 ("PM / devfreq: event: Add devfreq_event class")
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  include/linux/devfreq-event.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
> index 0a83a1e648b0..4db00b02ca3f 100644
> --- a/include/linux/devfreq-event.h
> +++ b/include/linux/devfreq-event.h
> @@ -148,11 +148,6 @@ static inline int devfreq_event_reset_event(struct devfreq_event_dev *edev)
>  	return -EINVAL;
>  }
>  
> -static inline void *devfreq_event_get_drvdata(struct devfreq_event_dev *edev)
> -{
> -	return ERR_PTR(-EINVAL);
> -}
> -
>  static inline struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(
>  					struct device *dev, int index)
>  {
> 
