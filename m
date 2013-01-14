From: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/3] PM / devfreq: account suspend/resume for stats
Date: Mon, 14 Jan 2013 23:48:00 +0900
Message-ID: <CAJ0PZbSowAauHJgRS6eLHA3Tsy-fCJ4KBEBMo=c0QpqLZjjXrw@mail.gmail.com>
References: <1357624239-13938-1-git-send-email-rajagopal.venkat@linaro.org>
	<1357624239-13938-3-git-send-email-rajagopal.venkat@linaro.org>
Reply-To: myungjoo.ham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1357624239-13938-3-git-send-email-rajagopal.venkat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Rajagopal Venkat <rajagopal.venkat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, jonghwa3.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 8, 2013 at 2:50 PM, Rajagopal Venkat
<rajagopal.venkat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> devfreq stats is not taking device suspend and resume into
> account. Fix it.
>
> Signed-off-by: Rajagopal Venkat <rajagopal.venkat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

With monitor_suspend(), we are suspending the DVFS mechanism of a
device, not the device itself.

Thus, the device may keep its frequency running and we may assume that
the frequency is constant as the DVFS mechanism is in suspend.

Why do you want to stop the statistics as well?



Again, as in the other patch, this is about the semantics of the
"devfreq statistics".

It does not seem to be a problem of which is correct and which is not,
but it seems to be a problem of which is more convenient.

Could you please give me some cases where your semantics is more helpful?



I've been using the stat feature like this:

# cat stat; run benchmark; cat stat
and look at the differences with any ops done during "run benchmark".



Cheers,
MyungJoo.

> ---
>  drivers/devfreq/devfreq.c |   15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 2843a22..4c50235 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -297,6 +297,7 @@ void devfreq_monitor_suspend(struct devfreq *devfreq)
>                 return;
>         }
>
> +       devfreq_update_status(devfreq, devfreq->previous_freq);
>         devfreq->stop_polling = true;
>         mutex_unlock(&devfreq->lock);
>         cancel_delayed_work_sync(&devfreq->work);
> @@ -313,6 +314,8 @@ EXPORT_SYMBOL(devfreq_monitor_suspend);
>   */
>  void devfreq_monitor_resume(struct devfreq *devfreq)
>  {
> +       unsigned long freq;
> +
>         mutex_lock(&devfreq->lock);
>         if (!devfreq->stop_polling)
>                 goto out;
> @@ -321,8 +324,14 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>                         devfreq->profile->polling_ms)
>                 queue_delayed_work(devfreq_wq, &devfreq->work,
>                         msecs_to_jiffies(devfreq->profile->polling_ms));
> +
> +       devfreq->last_stat_updated = jiffies;
>         devfreq->stop_polling = false;
>
> +       if (devfreq->profile->get_cur_freq &&
> +               !devfreq->profile->get_cur_freq(devfreq->dev.parent, &freq))
> +               devfreq->previous_freq = freq;
> +
>  out:
>         mutex_unlock(&devfreq->lock);
>  }
> @@ -931,11 +940,11 @@ static ssize_t show_trans_table(struct device *dev, struct device_attribute *att
>  {
>         struct devfreq *devfreq = to_devfreq(dev);
>         ssize_t len;
> -       int i, j, err;
> +       int i, j;
>         unsigned int max_state = devfreq->profile->max_state;
>
> -       err = devfreq_update_status(devfreq, devfreq->previous_freq);
> -       if (err)
> +       if (!devfreq->stop_polling &&
> +                       devfreq_update_status(devfreq, devfreq->previous_freq))
>                 return 0;
>
>         len = sprintf(buf, "   From  :   To\n");
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
