From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 3/5] devfreq: add devfreq_suspend/resume() functions
Date: Thu, 06 Dec 2018 10:30:43 +0900
Message-ID: <5C087BC3.1050405@samsung.com>
References: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181205110622eucas1p23d788afd54ad34c0a2663efac8734648@eucas1p2.samsung.com>
        <1544007956-28889-4-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1544007956-28889-4-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org, krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On 2018년 12월 05일 20:05, Lukasz Luba wrote:
> This patch adds implementation for global suspend/resume for
> devfreq framework. System suspend will next use these functions.
> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/devfreq.h   |  6 ++++++
>  2 files changed, 50 insertions(+)

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 46517b6..0ae3de7 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -935,6 +935,50 @@ int devfreq_resume_device(struct devfreq *devfreq)
>  EXPORT_SYMBOL(devfreq_resume_device);
>  
>  /**
> + * devfreq_suspend() - Suspend devfreq governors and devices
> + *
> + * Called during system wide Suspend/Hibernate cycles for suspending governors
> + * and devices preserving the state for resume. On some platforms the devfreq
> + * device must have precise state (frequency) after resume in order to provide
> + * fully operating setup.
> + */
> +void devfreq_suspend(void)
> +{
> +	struct devfreq *devfreq;
> +	int ret;
> +
> +	mutex_lock(&devfreq_list_lock);
> +	list_for_each_entry(devfreq, &devfreq_list, node) {
> +		ret = devfreq_suspend_device(devfreq);
> +		if (ret)
> +			dev_err(&devfreq->dev,
> +				"failed to suspend devfreq device\n");
> +	}
> +	mutex_unlock(&devfreq_list_lock);
> +}
> +
> +/**
> + * devfreq_resume() - Resume devfreq governors and devices
> + *
> + * Called during system wide Suspend/Hibernate cycle for resuming governors and
> + * devices that are suspended with devfreq_suspend().
> + */
> +void devfreq_resume(void)
> +{
> +	struct devfreq *devfreq;
> +	int ret;
> +
> +	mutex_lock(&devfreq_list_lock);
> +	list_for_each_entry(devfreq, &devfreq_list, node) {
> +		ret = devfreq_resume_device(devfreq);
> +		if (ret)
> +			dev_warn(&devfreq->dev,
> +				 "failed to resume devfreq device\n");
> +	}
> +	mutex_unlock(&devfreq_list_lock);
> +}
> +
> +/**
>   * devfreq_add_governor() - Add devfreq governor
>   * @governor:	the devfreq governor to be added
>   */
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index d985199..fbffa74 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -205,6 +205,9 @@ extern void devm_devfreq_remove_device(struct device *dev,
>  extern int devfreq_suspend_device(struct devfreq *devfreq);
>  extern int devfreq_resume_device(struct devfreq *devfreq);
>  
> +extern void devfreq_suspend(void);
> +extern void devfreq_resume(void);
> +
>  /**
>   * update_devfreq() - Reevaluate the device and configure frequency
>   * @devfreq:	the devfreq device
> @@ -331,6 +334,9 @@ static inline int devfreq_resume_device(struct devfreq *devfreq)
>  	return 0;
>  }
>  
> +static inline void devfreq_suspend(void) {}
> +static inline void devfreq_resume(void) {}
> +
>  static inline struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
>  					   unsigned long *freq, u32 flags)
>  {
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
