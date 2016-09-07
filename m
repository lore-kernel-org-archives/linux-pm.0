From: "dbasehore ." <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v10 5/5] drm/rockchip: Add dmc notifier in vop driver
Date: Wed, 7 Sep 2016 11:13:55 -0700
Message-ID: <CAGAzgsqQWchUMUSGtk1JG0WhyD63vuo_dLKrPCUkyNR1tz+xNQ@mail.gmail.com>
References: <1473051971-5500-1-git-send-email-hl@rock-chips.com>
 <1473051971-5500-6-git-send-email-hl@rock-chips.com> <CAOw6vb+N4ASTAu49VBPyOAUH=S4rrUBOgZOEP-RTvijEgeN7HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOw6vb+N4ASTAu49VBPyOAUH=S4rrUBOgZOEP-RTvijEgeN7HA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sean Paul <seanpaul-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, ??? <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?B?5aea5pm65oOF?= <mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jon Medhurst <tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?B?5bmz5Y+w57uELeaxpOS6keW5sw==?= <typ-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, sudeep.holla-5wv7dgnIgG8@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>Linux-pm mailing list <linux->
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 6, 2016 at 10:18 AM, Sean Paul <seanpaul-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> On Mon, Sep 5, 2016 at 1:06 AM, Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>> when in ddr frequency scaling process, vop can not do enable or
>> disable operation, since in dcf we check vop clock to see whether
>> vop work. If vop work, dcf do ddr frequency scaling when vop
>> in vblank status, and we need to read vop register to check whether
>> vop go into vblank status. If vop not work, dcf can do ddr frequency
>> any time. So when do ddr frequency scaling, you disabled or enable
>> vop, there may two bad thing happen: 1, the panel flicker(when vop from
>> disable status change to enable). 2, kernel hang (when vop from enable
>> status change to disable, dcf need to read vblank status, but if you disable
>> vop clock, it can not get the status, it will lead soc dead) So we need
>> register to devfreq notifier, and we can get the dmc status. Also, when
>> there have two vop enabled, we need to disable dmc, since dcf only base
>> on one vop vblank time, so the other panel will flicker when do ddr
>> frequency scaling.
>>
>> Signed-off-by: Lin Huang <hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> Reviewed-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>> ---
>> Changes in v10:
>> - None
>>
>> Changes in v9:
>> - None
>>
>> Changes in v8:
>> - None
>>
>> Changes in v7:
>> - None
>>
>> Changes in v6:
>> - fix a build error
>>
>> Changes in v5:
>> - improve some nits
>>
>> Changes in v4:
>> - register notifier to devfreq_register_notifier
>> - use DEVFREQ_PRECHANGE and DEVFREQ_POSTCHANGE to get dmc status
>> - when two vop enable, disable dmc
>> - when two vop back to one vop, enable dmc
>>
>> Changes in v3:
>> - when do vop eanble/disable, dmc will wait until it finish
>>
>> Changes in v2:
>> - None
>>
>> Changes in v1:
>> - use wait_event instead usleep
>>
>>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 116 ++++++++++++++++++++++++++++
>>  1 file changed, 116 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> index efbc41a..a73f3aa 100644
>> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
>> @@ -19,6 +19,8 @@
>>  #include <drm/drm_crtc_helper.h>
>>  #include <drm/drm_plane_helper.h>
>>
>> +#include <linux/devfreq.h>
>> +#include <linux/devfreq-event.h>
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>> @@ -118,6 +120,13 @@ struct vop {
>>
>>         const struct vop_data *data;
>>
>> +       struct devfreq *devfreq;
>> +       struct devfreq_event_dev *devfreq_event_dev;
>> +       struct notifier_block dmc_nb;
>> +       int dmc_in_process;
>> +       int vop_switch_status;
>> +       wait_queue_head_t wait_dmc_queue;
>> +       wait_queue_head_t wait_vop_switch_queue;
>>         uint32_t *regsbak;
>>         void __iomem *regs;
>>
>> @@ -428,11 +437,47 @@ static void vop_dsp_hold_valid_irq_disable(struct vop *vop)
>>         spin_unlock_irqrestore(&vop->irq_lock, flags);
>>  }
>>
>> +static int dmc_notify(struct notifier_block *nb, unsigned long event,
>> +                     void *data)
>> +{
>> +       struct vop *vop = container_of(nb, struct vop, dmc_nb);
>> +
>> +       if (event == DEVFREQ_PRECHANGE) {
>> +               /*
>> +                * check if vop in enable or disable process,
>> +                * if yes, wait until it finishes, use 200ms as
>> +                * timeout.
>> +                */
>> +               if (!wait_event_timeout(vop->wait_vop_switch_queue,
>> +                                       !vop->vop_switch_status, HZ / 5))
>> +                       dev_warn(vop->dev,
>> +                                "Timeout waiting for vop swtich status\n");
>> +               vop->dmc_in_process = 1;
>> +       } else if (event == DEVFREQ_POSTCHANGE) {
>> +               vop->dmc_in_process = 0;
>> +               wake_up(&vop->wait_dmc_queue);
>> +       }
>> +
>> +       return NOTIFY_OK;
>> +}
>> +
>>  static int vop_enable(struct drm_crtc *crtc)
>>  {
>>         struct vop *vop = to_vop(crtc);
>> +       int num_enabled_crtc = 0;
>>         int ret;
>>
>> +       /*
>> +        * if in dmc scaling frequency process, wait until it finishes
>> +        * use 200ms as timeout time.
>> +        */
>> +       if (!wait_event_timeout(vop->wait_dmc_queue,
>> +                               !vop->dmc_in_process, HZ / 5))
>> +               dev_warn(vop->dev,
>> +                        "Timeout waiting for dmc when vop enable\n");
>> +
>
>
> This wait_event_timeout code is terribly racey (same goes above and below).
>
>
>> +       vop->vop_switch_status = 1;
>> +
>>         ret = pm_runtime_get_sync(vop->dev);
>>         if (ret < 0) {
>>                 dev_err(vop->dev, "failed to get pm runtime: %d\n", ret);
>> @@ -479,6 +524,21 @@ static int vop_enable(struct drm_crtc *crtc)
>>
>>         drm_crtc_vblank_on(crtc);
>>
>> +       vop->vop_switch_status = 0;
>> +       wake_up(&vop->wait_vop_switch_queue);
>> +
>> +       /* check how many VOPs in use now */
>> +       drm_for_each_crtc(crtc, vop->drm_dev) {
>> +               if (crtc->state->enable)
>
> I think you really want to check active, instead of enable.
>
>> +                       num_enabled_crtc++;
>> +       }
>> +
>> +       /* if enable two vop, need to disable dmc */
>> +       if ((num_enabled_crtc > 1) && vop->devfreq) {
>> +               if (vop->devfreq_event_dev)
>> +                       devfreq_event_disable_edev(vop->devfreq_event_dev);
>> +               devfreq_suspend_device(vop->devfreq);
>> +       }
>
> This really feels like something that should be handled somewhere
> else. I don't fully understand how this works, but it seems like this
> dependency should be handled where it actually matters, rather than
> building in a seemingly arbitrary restriction in the vop driver.
>
> Even if this is the best place for it, this needs to be refactored to
> eliminate the races that exist now.
>
> Sean

DMC transitions can't happen when there is more than one display. You
would have to synchronize with more than one vblank on the DCF (which
actually changes the DDR frequency), and that's probably not going to
happen.

If this code should be done somewhere else, it needs to still be able
to check the number of displays and avoid race conditions with
displays getting enabled or disabled. I don't know enough about DRM to
know if that's possible outside of this code.

>
>>         return 0;
>>
>>  err_disable_aclk:
>> @@ -489,17 +549,31 @@ err_disable_hclk:
>>         clk_disable(vop->hclk);
>>  err_put_pm_runtime:
>>         pm_runtime_put_sync(vop->dev);
>> +       vop->vop_switch_status = 0;
>> +       wake_up(&vop->wait_vop_switch_queue);
>>         return ret;
>>  }
>>
>>  static void vop_crtc_disable(struct drm_crtc *crtc)
>>  {
>>         struct vop *vop = to_vop(crtc);
>> +       int num_enabled_crtc = 0;
>>         int i;
>>
>>         WARN_ON(vop->event);
>>
>>         /*
>> +        * if in dmc scaling frequency process, wait until it finish
>> +        * use 200ms as timeout time.
>> +        */
>> +       if (!wait_event_timeout(vop->wait_dmc_queue,
>> +                               !vop->dmc_in_process, HZ / 5))
>> +               dev_warn(vop->dev,
>> +                        "Timeout waiting for dmc when vop disable\n");
>> +
>> +       vop->vop_switch_status = 1;
>> +
>> +       /*
>>          * We need to make sure that all windows are disabled before we
>>          * disable that crtc. Otherwise we might try to scan from a destroyed
>>          * buffer later.
>> @@ -555,6 +629,24 @@ static void vop_crtc_disable(struct drm_crtc *crtc)
>>                 spin_unlock_irq(&crtc->dev->event_lock);
>>
>>                 crtc->state->event = NULL;
>> +
>> +       vop->vop_switch_status = 0;
>> +       wake_up(&vop->wait_vop_switch_queue);
>> +
>> +       /* check how many VOPs in use now */
>> +       drm_for_each_crtc(crtc, vop->drm_dev) {
>> +               if (crtc->state->enable)
>> +                       num_enabled_crtc++;
>> +       }
>> +
>> +       /*
>> +        * if num_enabled_crtc = 1 now, it means 2 vop enabled
>> +        * change to 1 vop enabled  need to enable dmc again.
>> +        */
>> +       if ((num_enabled_crtc == 1) && vop->devfreq) {
>> +               if (vop->devfreq_event_dev)
>> +                       devfreq_event_enable_edev(vop->devfreq_event_dev);
>> +               devfreq_resume_device(vop->devfreq);
>>         }
>>  }
>>
>> @@ -1413,6 +1505,8 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
>>         struct drm_device *drm_dev = data;
>>         struct vop *vop;
>>         struct resource *res;
>> +       struct devfreq *devfreq;
>> +       struct devfreq_event_dev *event_dev;
>>         size_t alloc_size;
>>         int ret, irq;
>>
>> @@ -1474,6 +1568,28 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
>>                 return ret;
>>
>>         pm_runtime_enable(&pdev->dev);
>> +
>> +       init_waitqueue_head(&vop->wait_vop_switch_queue);
>> +       vop->vop_switch_status = 0;
>> +       init_waitqueue_head(&vop->wait_dmc_queue);
>> +       vop->dmc_in_process = 0;
>> +
>> +       devfreq = devfreq_get_devfreq_by_phandle(dev, 0);
>> +       if (IS_ERR(devfreq))
>> +               goto out;
>> +
>> +       vop->devfreq = devfreq;
>> +       vop->dmc_nb.notifier_call = dmc_notify;
>> +       devfreq_register_notifier(vop->devfreq, &vop->dmc_nb,
>> +                                 DEVFREQ_TRANSITION_NOTIFIER);
>> +
>> +       event_dev = devfreq_event_get_edev_by_phandle(vop->devfreq->dev.parent,
>> +                                                     0);
>> +       if (IS_ERR(event_dev))
>> +               goto out;
>> +
>> +       vop->devfreq_event_dev = event_dev;
>> +out:
>>         return 0;
>>  }
>>
>> --
>> 2.6.6
>>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
