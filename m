From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 2/7] drivers: devfreq: change devfreq workqueue
 mechanism
Date: Thu, 14 Feb 2019 13:11:25 +0900
Message-ID: <aa254c1d-7e0b-b3d3-be68-669aa234b400@samsung.com>
References: <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222431eucas1p1697607e6536a90283cf7dad37fa74dbb@eucas1p1.samsung.com>
        <1550010238-24002-3-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550010238-24002-3-git-send-email-l.luba@partner.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

This patch depends on first patch. Firstly, we need to discuss
the first patch and then I'll review this patch.
[1] [PATCH v3 1/7] drivers: devfreq: change deferred work into delayed

On 19. 2. 13. 오전 7:23, Lukasz Luba wrote:
> There is no need for creating another workqueue in the system,
> the existing one should meet the requirements.
> This patch removes devfreq's custom workqueue and uses system one.
> It switches from queue_delayed_work() to schedule_delayed_work().
> It also does not wake up the system when it enters suspend (this
> functionality stays the same).
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0c9bff8..c200b3c 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -31,13 +31,6 @@
>  
>  static struct class *devfreq_class;
>  
> -/*
> - * devfreq core provides delayed work based load monitoring helper
> - * functions. Governors can use these or can implement their own
> - * monitoring mechanism.
> - */
> -static struct workqueue_struct *devfreq_wq;
> -
>  /* The list of all device-devfreq governors */
>  static LIST_HEAD(devfreq_governor_list);
>  /* The list of all device-devfreq */
> @@ -391,8 +384,8 @@ static void devfreq_monitor(struct work_struct *work)
>  	if (err)
>  		dev_err(&devfreq->dev, "dvfs failed with (%d) error\n", err);
>  
> -	queue_delayed_work(devfreq_wq, &devfreq->work,
> -				msecs_to_jiffies(devfreq->profile->polling_ms));
> +	schedule_delayed_work(&devfreq->work,
> +			      msecs_to_jiffies(devfreq->profile->polling_ms));
>  	mutex_unlock(&devfreq->lock);
>  }
>  
> @@ -409,7 +402,7 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>  {
>  	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
>  	if (devfreq->profile->polling_ms)
> -		queue_delayed_work(devfreq_wq, &devfreq->work,
> +		schedule_delayed_work(&devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  }
>  EXPORT_SYMBOL(devfreq_monitor_start);
> @@ -473,7 +466,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  
>  	if (!delayed_work_pending(&devfreq->work) &&
>  			devfreq->profile->polling_ms)
> -		queue_delayed_work(devfreq_wq, &devfreq->work,
> +		schedule_delayed_work(&devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  
>  	devfreq->last_stat_updated = jiffies;
> @@ -516,7 +509,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>  
>  	/* if current delay is zero, start polling with new delay */
>  	if (!cur_delay) {
> -		queue_delayed_work(devfreq_wq, &devfreq->work,
> +		schedule_delayed_work(&devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  		goto out;
>  	}
> @@ -527,7 +520,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>  		cancel_delayed_work_sync(&devfreq->work);
>  		mutex_lock(&devfreq->lock);
>  		if (!devfreq->stop_polling)
> -			queue_delayed_work(devfreq_wq, &devfreq->work,
> +			schedule_delayed_work(&devfreq->work,
>  			      msecs_to_jiffies(devfreq->profile->polling_ms));
>  	}
>  out:
> @@ -1430,12 +1423,6 @@ static int __init devfreq_init(void)
>  		return PTR_ERR(devfreq_class);
>  	}
>  
> -	devfreq_wq = create_freezable_workqueue("devfreq_wq");
> -	if (!devfreq_wq) {
> -		class_destroy(devfreq_class);
> -		pr_err("%s: couldn't create workqueue\n", __FILE__);
> -		return -ENOMEM;
> -	}
>  	devfreq_class->dev_groups = devfreq_groups;
>  
>  	return 0;
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
