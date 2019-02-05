From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] drivers: devfreq: change devfreq workqueue mechanism
Date: Mon, 4 Feb 2019 16:39:48 -0800
Message-ID: <20190205003948.GG117604@google.com>
References: <CGME20190201183813eucas1p20183a08d4f75f853468a8129b048c208@eucas1p2.samsung.com>
 <1549046283-18242-1-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1549046283-18242-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com, joel@joelfernandes.org, chris.diamand@arm.com
List-Id: linux-pm@vger.kernel.org

Hi Lukasz,

On Fri, Feb 01, 2019 at 07:38:03PM +0100, Lukasz Luba wrote:
> This patch removes devfreq's custom workqueue and uses system one.
> It switches from queue_delayed_work() to schedule_delayed_work().
> It also changes deferred work to delayed work, which is now not missed
> when timer is put on CPU that entered idle state.
> The devfreq framework governor was not called, thus changing the frequency
> of the device did not happen.
> Benchmarks for stressing Dynamic Memory Controller show x2
> performance boost with this patch when 'simpleondemand_governor' is
> responsible for monitoring the device load and frequency changes.
> With this patch, the scheduled delayed work is done no mater CPUs' idle.
> It also does not wake up the system when it enters suspend (this
> functionality stays the same).
> All of the drivers in devfreq which rely on periodic, guaranteed wakeup
> intervals should benefit from it.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de7..c200b3c 100644
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
> @@ -407,9 +400,9 @@ static void devfreq_monitor(struct work_struct *work)
>   */
>  void devfreq_monitor_start(struct devfreq *devfreq)
>  {
> -	INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
> +	INIT_DELAYED_WORK(&devfreq->work, devfreq_monitor);
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

If I understand correctly this changes three things:

1. use system workqueue instead of custom one

should be fine with the cwmq's we have nowadays


2. use non-freezable workqueue

  ``WQ_FREEZABLE``
    A freezable wq participates in the freeze phase of the system
    suspend operations.  Work items on the wq are drained and no
    new work item starts execution until thawed.

I'm not entirely sure what the impact of this is.

I imagine suspend is potentially quicker because the wq isn't drained,
but could works that execute during the suspend phase be a problem?


3. use delayed work instead of deferrable work

I hadn't come across deferrable work yet:

  "Add a new deferrable delayed work init.  This can be used to schedule work
  that are 'unimportant' when CPU is idle and can be called later, when CPU
  eventually comes out of idle."

  28287033e124 ("Add a new deferrable delayed work init")

The commit message mentions that frequency changes were missed due to
deferred works being scheduled on an idle CPU. The change to a delayed
work seems reasonable to me.

It could make sense to split this change into two patches, one for the
change from deferrable to delayed work, and another for custom workqueue
to system workqueue (and possibly even a third, transitory change for
freezable to non-freezable, if it's confirmed that that's the right
thing to do).

Cheers

Matthias
