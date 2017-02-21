From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 3/6] PM / QOS: Add 'performance' request
Date: Tue, 21 Feb 2017 16:37:01 +0100
Message-ID: <CAPDyKFpDtPm6aej=m3JNzzL7MiH9nX4CU1MwzN1stpqFe+18vQ@mail.gmail.com>
References: <cover.1486611268.git.viresh.kumar@linaro.org> <9820795796278bc66baa3f41220f8524cbdda537.1486611268.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9820795796278bc66baa3f41220f8524cbdda537.1486611268.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@baylibre.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 9 February 2017 at 04:41, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Add a new QOS request type: DEV_PM_QOS_PERFORMANCE.
>
> This is required to support runtime performance constraints for the
> devices. Also allow notifiers to be registered against it, which can be
> used by frameworks like genpd.

To me, this is a too slim description of why/what/how.

Just by reading from this change log, sounds like we already have
OPPs. So I think it would be useful to explain why those isn't
suitable here.

>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/power/pm_qos_interface.txt |  2 +-
>  drivers/base/power/qos.c                 | 69 +++++++++++++++++++++++++++-----
>  include/linux/pm_qos.h                   |  4 ++
>  3 files changed, 63 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/power/pm_qos_interface.txt b/Documentation/power/pm_qos_interface.txt
> index c7989d140428..a0a45ecbc1a8 100644
> --- a/Documentation/power/pm_qos_interface.txt
> +++ b/Documentation/power/pm_qos_interface.txt
> @@ -172,7 +172,7 @@ type.
>
>  The callback is called when the aggregated value of the device constraints list
>  is changed. Currently it only supports the notifier to be registered for resume

/s /only /

> -latency device PM QoS.
> +latency and performance device PM QoS.
>
>  int dev_pm_qos_remove_notifier(device, notifier, type):
>  Removes the notification callback function for the device.
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 9adc208cf1fc..cf070468a7ca 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -163,6 +163,10 @@ static int apply_constraint(struct dev_pm_qos_request *req,
>                         req->dev->power.set_latency_tolerance(req->dev, value);
>                 }
>                 break;
> +       case DEV_PM_QOS_PERFORMANCE:
> +               ret = pm_qos_update_target(&qos->performance, &req->data.pnode,
> +                                          action, value);
> +               break;
>         case DEV_PM_QOS_FLAGS:
>                 ret = pm_qos_update_flags(&qos->flags, &req->data.flr,
>                                           action, value);
> @@ -191,12 +195,13 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
>         if (!qos)
>                 return -ENOMEM;
>
> -       n = kzalloc(sizeof(*n), GFP_KERNEL);
> +       n = kzalloc(2 * sizeof(*n), GFP_KERNEL);
>         if (!n) {
>                 kfree(qos);
>                 return -ENOMEM;
>         }
>         BLOCKING_INIT_NOTIFIER_HEAD(n);
> +       BLOCKING_INIT_NOTIFIER_HEAD(n + 1);

Hmm, why do we need a separate notifier list type here. Shouldn't we
just propagate the type of the notification as a part the notification
itself.

In other words, dev_pm_qos_add_notifier() doesn't need to take the
extra "type" parameter, but instead the notification type will be sent
to the receiver as part of the notification callback.

That should simplify a lot, both for these changes but also for
following changes to genpd.

And that said, perhaps we should add new enum definition type which
specifies which notification messages the dev PM QoS notifier supports
- to avoid confusion. Then it's up to the receiver to act upon those
messages it supports.

>
>         c = &qos->resume_latency;
>         plist_head_init(&c->list);
> @@ -213,6 +218,14 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
>         c->no_constraint_value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
>         c->type = PM_QOS_MIN;
>
> +       c = &qos->performance;
> +       plist_head_init(&c->list);
> +       c->target_value = PM_QOS_PERFORMANCE_DEFAULT_VALUE;
> +       c->default_value = PM_QOS_PERFORMANCE_DEFAULT_VALUE;
> +       c->no_constraint_value = PM_QOS_PERFORMANCE_DEFAULT_VALUE;
> +       c->type = PM_QOS_MAX;
> +       c->notifiers = n + 1;
> +
>         INIT_LIST_HEAD(&qos->flags.list);
>
>         spin_lock_irq(&dev->power.lock);
> @@ -271,6 +284,11 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
>                 apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
>                 memset(req, 0, sizeof(*req));
>         }
> +       c = &qos->performance;
> +       plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
> +               apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
> +               memset(req, 0, sizeof(*req));
> +       }
>         f = &qos->flags;
>         list_for_each_entry_safe(req, tmp, &f->list, data.flr.node) {
>                 apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
> @@ -382,6 +400,7 @@ static int __dev_pm_qos_update_request(struct dev_pm_qos_request *req,
>         switch(req->type) {
>         case DEV_PM_QOS_RESUME_LATENCY:
>         case DEV_PM_QOS_LATENCY_TOLERANCE:
> +       case DEV_PM_QOS_PERFORMANCE:
>                 curr_value = req->data.pnode.prio;
>                 break;
>         case DEV_PM_QOS_FLAGS:
> @@ -492,11 +511,9 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
>  int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
>                             enum dev_pm_qos_req_type type)
>  {
> +       struct dev_pm_qos *qos;
>         int ret = 0;
>
> -       if (WARN_ON(type != DEV_PM_QOS_RESUME_LATENCY))
> -               return -EINVAL;
> -
>         mutex_lock(&dev_pm_qos_mtx);
>
>         if (IS_ERR(dev->power.qos))
> @@ -504,10 +521,26 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
>         else if (!dev->power.qos)
>                 ret = dev_pm_qos_constraints_allocate(dev);
>
> -       if (!ret)
> -               ret = blocking_notifier_chain_register(dev->power.qos->resume_latency.notifiers,
> +       if (ret)
> +               goto unlock;
> +
> +       qos = dev->power.qos;
> +
> +       switch (type) {
> +       case DEV_PM_QOS_RESUME_LATENCY:
> +               ret = blocking_notifier_chain_register(qos->resume_latency.notifiers,
> +                                                      notifier);
> +               break;
> +       case DEV_PM_QOS_PERFORMANCE:
> +               ret = blocking_notifier_chain_register(qos->performance.notifiers,
>                                                        notifier);
> +               break;
> +       default:
> +               WARN_ON(1);

No WARN_ON, please.

> +               ret = -EINVAL;
> +       }
>
> +unlock:
>         mutex_unlock(&dev_pm_qos_mtx);
>         return ret;
>  }

[...]

Kind regards
Uffe
