From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 2/4] PM / devfreq: Handle monitor suspend/resume in the
 devfreq core
Date: Thu, 14 Feb 2019 09:47:19 -0800
Message-ID: <20190214174719.GZ117604@google.com>
References: <20190214013042.254790-1-mka@chromium.org>
 <20190214013042.254790-3-mka@chromium.org>
 <CAGTfZH29QQCW4ecXy9VbRd3aTixyjbDgB0EE0YwDcQDZYsSCvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGTfZH29QQCW4ecXy9VbRd3aTixyjbDgB0EE0YwDcQDZYsSCvg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cwchoi00@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On Thu, Feb 14, 2019 at 11:10:00PM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> 2019년 2월 14일 (목) 오후 7:16, Matthias Kaehlcke <mka@chromium.org>님이 작성:
> >
> > devfreq expects governors to call devfreq_monitor_suspend/resume()
> > in response to DEVFREQ_GOV_SUSPEND/RESUME events. Since the devfreq
> > core itself generates these events and invokes the governor's event
> > handler the suspend/resume of the load monitoring can be done in the
> > common code.
> >
> > Call devfreq_monitor_suspend/resume() when the governor reports a
> > successful handling of DEVFREQ_GOV_SUSPEND/RESUME and remove these
> > calls from the simpleondemand and tegra governors. Make
> > devfreq_monitor_suspend/resume() static since these functions are now
> > only used by the devfreq core.
> 
> The devfreq core generates the all events including
> DEVFREQ_GOV_START/STOP/INTERVAL.
> It is possible to make 'devfreq_monitor_*()' function as the static
> instead of exported function.
> And call them in devfreq.c as this patch as following:
> 
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -728,6 +728,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>                 goto err_init;
>         }
> 
> +       devfreq_monitor_start(devfreq);
> +
>         list_add(&devfreq->node, &devfreq_list);
> 
>         mutex_unlock(&devfreq_list_lock);
> @@ -760,6 +762,7 @@ int devfreq_remove_device(struct devfreq *devfreq)
>         if (devfreq->governor)
>                 devfreq->governor->event_handler(devfreq,
>                                                  DEVFREQ_GOV_STOP, NULL);
> +       devfreq_monitor_stop(devfreq);
>         device_unregister(&devfreq->dev);
> 
>         return 0;
> @@ -1259,6 +1262,9 @@ static ssize_t polling_interval_store(struct device *dev,
>         df->governor->event_handler(df, DEVFREQ_GOV_INTERVAL, &value);
>         ret = count;
> 
> +       if (!ret)
> +               devfreq_interval_update(devfreq, (unsigned int *)data);
> +
>         return ret;
>  }
>  static DEVICE_ATTR_RW(polling_interval);
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 79efa1e..515fb85 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -580,13 +580,11 @@ static int tegra_governor_event_handler(struct
> devfreq *devfreq,
> 
>         switch (event) {
>         case DEVFREQ_GOV_START:
> -               devfreq_monitor_start(devfreq);
>                 tegra_actmon_enable_interrupts(tegra);
>                 break;
> 
>         case DEVFREQ_GOV_STOP:
>                 tegra_actmon_disable_interrupts(tegra);
> -               devfreq_monitor_stop(devfreq);
>                 break;

indeed, that's similar to "[4/4] PM / devfreq: Handle monitor
start/stop in the devfreq core" of this series.

> Instead,
> 
> If the governor should execute some codes before and after of
> DEVFREQ_GOV_SUSPEND, DEVFREQ_GOV_RESUME,
> it is impossible to change the order between devfreq_monitor_*() function
> and the specific governor in the event_handler callback function of
> each governor.
> 
> For example, if some govenor requires the following sequencue,
> after this patch, it is not possible.
> 
> case DEVFREQ_GOV_SUSPEND:
>         /* execute some code before devfreq_monitor_suspend() */
>         devfreq_monitor_suspend()
>         /* execute some code after devfreq_monitor_suspend() */

I agree that the patch introduces this limitation, however I'm not
convinced it is a problem in practice.

For suspend we'd essentially end up with:

governor_suspend
  governor->suspend

  monitor_suspend
    update_status

    stop polling

What would a governor want to do after polling is stopped? Is there
any real world or halfway reasonable hypothetical example?


And for resume:

governor_resume
  governor->resume

  monitor_resume
    start polling

Same question here, what would the governor realistically want to do
after polling has started that it couldn't have done before?

Cheers

Matthias
