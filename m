From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH 2/4] PM / devfreq: Handle monitor suspend/resume in the
 devfreq core
Date: Thu, 14 Feb 2019 23:10:00 +0900
Message-ID: <CAGTfZH29QQCW4ecXy9VbRd3aTixyjbDgB0EE0YwDcQDZYsSCvg@mail.gmail.com>
References: <20190214013042.254790-1-mka@chromium.org> <20190214013042.254790-3-mka@chromium.org>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214013042.254790-3-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

2019=EB=85=84 2=EC=9B=94 14=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 7:16, M=
atthias Kaehlcke <mka@chromium.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> devfreq expects governors to call devfreq_monitor_suspend/resume()
> in response to DEVFREQ_GOV_SUSPEND/RESUME events. Since the devfreq
> core itself generates these events and invokes the governor's event
> handler the suspend/resume of the load monitoring can be done in the
> common code.
>
> Call devfreq_monitor_suspend/resume() when the governor reports a
> successful handling of DEVFREQ_GOV_SUSPEND/RESUME and remove these
> calls from the simpleondemand and tegra governors. Make
> devfreq_monitor_suspend/resume() static since these functions are now
> only used by the devfreq core.

The devfreq core generates the all events including
DEVFREQ_GOV_START/STOP/INTERVAL.
It is possible to make 'devfreq_monitor_*()' function as the static
instead of exported function.
And call them in devfreq.c as this patch as following:

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -728,6 +728,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
                goto err_init;
        }

+       devfreq_monitor_start(devfreq);
+
        list_add(&devfreq->node, &devfreq_list);

        mutex_unlock(&devfreq_list_lock);
@@ -760,6 +762,7 @@ int devfreq_remove_device(struct devfreq *devfreq)
        if (devfreq->governor)
                devfreq->governor->event_handler(devfreq,
                                                 DEVFREQ_GOV_STOP, NULL);
+       devfreq_monitor_stop(devfreq);
        device_unregister(&devfreq->dev);

        return 0;
@@ -1259,6 +1262,9 @@ static ssize_t polling_interval_store(struct device *=
dev,
        df->governor->event_handler(df, DEVFREQ_GOV_INTERVAL, &value);
        ret =3D count;

+       if (!ret)
+               devfreq_interval_update(devfreq, (unsigned int *)data);
+
        return ret;
 }
 static DEVICE_ATTR_RW(polling_interval);
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfre=
q.c
index 79efa1e..515fb85 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -580,13 +580,11 @@ static int tegra_governor_event_handler(struct
devfreq *devfreq,

        switch (event) {
        case DEVFREQ_GOV_START:
-               devfreq_monitor_start(devfreq);
                tegra_actmon_enable_interrupts(tegra);
                break;

        case DEVFREQ_GOV_STOP:
                tegra_actmon_disable_interrupts(tegra);
-               devfreq_monitor_stop(devfreq);
                break;

Instead,

If the governor should execute some codes before and after of
DEVFREQ_GOV_SUSPEND, DEVFREQ_GOV_RESUME,
it is impossible to change the order between devfreq_monitor_*() function
and the specific governor in the event_handler callback function of
each governor.

For example, if some govenor requires the following sequencue,
after this patch, it is not possible.

case DEVFREQ_GOV_SUSPEND:
        /* execute some code before devfreq_monitor_suspend() */
        devfreq_monitor_suspend()
        /* execute some code after devfreq_monitor_suspend() */

>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/devfreq/devfreq.c                 | 18 ++++++++----------
>  drivers/devfreq/governor.h                |  2 --
>  drivers/devfreq/governor_simpleondemand.c |  8 --------
>  drivers/devfreq/tegra-devfreq.c           |  2 --
>  4 files changed, 8 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 1d3a43f8b3a10..7fab6c4cf719b 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -447,15 +447,13 @@ EXPORT_SYMBOL(devfreq_monitor_stop);
>   * devfreq_monitor_suspend() - Suspend load monitoring of a devfreq inst=
ance
>   * @devfreq:   the devfreq instance.
>   *
> - * Helper function to suspend devfreq device load monitoing. Function
> - * to be called from governor in response to DEVFREQ_GOV_SUSPEND
> - * event or when polling interval is set to zero.
> + * Helper function to suspend devfreq device load monitoring.
>   *
>   * Note: Though this function is same as devfreq_monitor_stop(),
>   * intentionally kept separate to provide hooks for collecting
>   * transition statistics.
>   */
> -void devfreq_monitor_suspend(struct devfreq *devfreq)
> +static void devfreq_monitor_suspend(struct devfreq *devfreq)
>  {
>         mutex_lock(&devfreq->lock);
>         if (devfreq->monitor_state !=3D DEVFREQ_MONITOR_RUNNING) {
> @@ -468,17 +466,14 @@ void devfreq_monitor_suspend(struct devfreq *devfre=
q)
>         mutex_unlock(&devfreq->lock);
>         cancel_delayed_work_sync(&devfreq->work);
>  }
> -EXPORT_SYMBOL(devfreq_monitor_suspend);
>
>  /**
>   * devfreq_monitor_resume() - Resume load monitoring of a devfreq instan=
ce
>   * @devfreq:    the devfreq instance.
>   *
> - * Helper function to resume devfreq device load monitoing. Function
> - * to be called from governor in response to DEVFREQ_GOV_RESUME
> - * event or when polling interval is set to non-zero.
> + * Helper function to resume devfreq device load monitoring.
>   */
> -void devfreq_monitor_resume(struct devfreq *devfreq)
> +static void devfreq_monitor_resume(struct devfreq *devfreq)
>  {
>         unsigned long freq;
>
> @@ -501,7 +496,6 @@ void devfreq_monitor_resume(struct devfreq *devfreq)
>  out:
>         mutex_unlock(&devfreq->lock);
>  }
> -EXPORT_SYMBOL(devfreq_monitor_resume);
>
>  /**
>   * devfreq_interval_update() - Update device devfreq monitoring interval
> @@ -903,6 +897,8 @@ int devfreq_suspend_device(struct devfreq *devfreq)
>                                         DEVFREQ_GOV_SUSPEND, NULL);
>                 if (ret)
>                         return ret;
> +
> +               devfreq_monitor_suspend(devfreq);
>         }
>
>         if (devfreq->suspend_freq) {
> @@ -944,6 +940,8 @@ int devfreq_resume_device(struct devfreq *devfreq)
>                                         DEVFREQ_GOV_RESUME, NULL);
>                 if (ret)
>                         return ret;
> +
> +               devfreq_monitor_resume(devfreq);
>         }
>
>         return 0;
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index f53339ca610fc..d136792c0cc91 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -59,8 +59,6 @@ struct devfreq_governor {
>
>  extern void devfreq_monitor_start(struct devfreq *devfreq);
>  extern void devfreq_monitor_stop(struct devfreq *devfreq);
> -extern void devfreq_monitor_suspend(struct devfreq *devfreq);
> -extern void devfreq_monitor_resume(struct devfreq *devfreq);
>  extern void devfreq_interval_update(struct devfreq *devfreq,
>                                         unsigned int *delay);
>
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/=
governor_simpleondemand.c
> index c0417f0e081e0..52eb0c734b312 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -103,14 +103,6 @@ static int devfreq_simple_ondemand_handler(struct de=
vfreq *devfreq,
>                 devfreq_interval_update(devfreq, (unsigned int *)data);
>                 break;
>
> -       case DEVFREQ_GOV_SUSPEND:
> -               devfreq_monitor_suspend(devfreq);
> -               break;
> -
> -       case DEVFREQ_GOV_RESUME:
> -               devfreq_monitor_resume(devfreq);
> -               break;
> -
>         default:
>                 break;
>         }
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devf=
req.c
> index c59d2eee5d309..79efa1e51bd06 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -591,11 +591,9 @@ static int tegra_governor_event_handler(struct devfr=
eq *devfreq,
>
>         case DEVFREQ_GOV_SUSPEND:
>                 tegra_actmon_disable_interrupts(tegra);
> -               devfreq_monitor_suspend(devfreq);
>                 break;
>
>         case DEVFREQ_GOV_RESUME:
> -               devfreq_monitor_resume(devfreq);
>                 tegra_actmon_enable_interrupts(tegra);
>                 break;
>         }
> --
> 2.20.1.791.gb4d0f1c61a-goog
>


--=20
Best Regards,
Chanwoo Choi
