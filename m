From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / devfreq: remove compiler error with module governors (2)
Date: Wed, 28 Nov 2012 11:22:15 +0100
Message-ID: <1637827.E9cBLQEQQc@vostro.rjw.lan>
References: <2278739.ton8Zzmpxv@vostro.rjw.lan> <1354067841-4936-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:35073 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753654Ab2K1KRb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 Nov 2012 05:17:31 -0500
In-Reply-To: <1354067841-4936-1-git-send-email-myungjoo.ham@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-pm@vger.kernel.org, myungjoo.ham@gmail.com, nm@ti.com

On Wednesday, November 28, 2012 10:57:21 AM MyungJoo Ham wrote:
> Governors compiled as modules may use these functions.

OK

Do you want me to take this directly?

Rafael


> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---
> This patch is also locataed at
> git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq for-rafael tags/pull_req_20121128
> 
>  drivers/devfreq/devfreq.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 34c00c5..a8f0173 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -235,6 +235,7 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>  		queue_delayed_work(devfreq_wq, &devfreq->work,
>  			msecs_to_jiffies(devfreq->profile->polling_ms));
>  }
> +EXPORT_SYMBOL(devfreq_monitor_start);
>  
>  /**
>   * devfreq_monitor_stop() - Stop load monitoring of a devfreq instance
> @@ -248,6 +249,7 @@ void devfreq_monitor_stop(struct devfreq *devfreq)
>  {
>  	cancel_delayed_work_sync(&devfreq->work);
>  }
> +EXPORT_SYMBOL(devfreq_monitor_stop);
>  
>  /**
>   * devfreq_monitor_suspend() - Suspend load monitoring of a devfreq instance
> @@ -273,6 +275,7 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
>  	mutex_unlock(&devfreq->lock);
>  	cancel_delayed_work_sync(&devfreq->work);
>  }
> +EXPORT_SYMBOL(devfreq_monitor_suspend);
>  
>  /**
>   * devfreq_monitor_resume() - Resume load monitoring of a devfreq instance
> @@ -297,6 +300,7 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  out:
>  	mutex_unlock(&devfreq->lock);
>  }
> +EXPORT_SYMBOL(devfreq_monitor_resume);
>  
>  /**
>   * devfreq_interval_update() - Update device devfreq monitoring interval
> @@ -343,6 +347,7 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>  out:
>  	mutex_unlock(&devfreq->lock);
>  }
> +EXPORT_SYMBOL(devfreq_interval_update);
>  
>  /**
>   * devfreq_notifier_call() - Notify that the device frequency requirements
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
