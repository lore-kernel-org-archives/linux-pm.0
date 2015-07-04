From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH 2/4] PM / devfreq: cache the last call to get_dev_status()
Date: Sat, 4 Jul 2015 12:15:51 +0900
Message-ID: <CAJ0PZbQV7t7DL3WYojPKwUc3B36juHZiv0kGANawhZYQ0VoH3g@mail.gmail.com>
References: <1435928310-15938-1-git-send-email-javi.merino@arm.com> <1435928310-15938-3-git-send-email-javi.merino@arm.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36863 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755346AbbGDDQG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 23:16:06 -0400
Received: by iecvh10 with SMTP id vh10so85765402iec.3
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2015 20:16:06 -0700 (PDT)
In-Reply-To: <1435928310-15938-3-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Fri, Jul 3, 2015 at 9:58 PM, Javi Merino <javi.merino@arm.com> wrote:
> The return value of get_dev_status() can be reused.  Cache it so that
> other parts of the kernel can reuse it instead of having to call the
> same function again.
>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
>  drivers/devfreq/devfreq.c                 |  5 +++++
>  drivers/devfreq/governor_simpleondemand.c | 33 +++++++++++++++++--------------
>  include/linux/devfreq.h                   |  7 +++++++
>  3 files changed, 30 insertions(+), 15 deletions(-)
>

What if there are two entities using the stat at the same time? If you
are going to have the status at a shared object (struct devfreq), you
need to consider racing conditions as well: two threads accessing
last_status at the same time, resulting in calling
devfreq_update_stats() while the other has called it beforehand and
using the variables in the stat struct. By doing it locally (having
stat as struct devfreq_dev_status, not a pointer), we can avoid such
problems. The object (struct devfreq_dev_status) it not guaranteed to
be accessed by the governor only.


Or do you intend to share the stat value with another entity, with the
assumption that only one will be calling devfreq_update_stats() ?
In that case, what if the one who's supposed to call
devfreq_update_stats() is paused? For example, what if the user has
switched the governor from simpleondemand to userspace or performance?


Cheers,
MyungJoo.


> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 6390d5db6816..d253a73f2b86 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -810,6 +810,11 @@ unlock:
>  }
>  EXPORT_SYMBOL(devfreq_qos_set_min);
>
> +int devfreq_update_stats(struct devfreq *df)
> +{
> +       return df->profile->get_dev_status(df->dev.parent, &df->last_status);
> +}
> +
>  static ssize_t governor_show(struct device *dev,
>                              struct device_attribute *attr, char *buf)
>  {
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index 0720ba84ca92..ae72ba5e78df 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -21,17 +21,20 @@
>  static int devfreq_simple_ondemand_func(struct devfreq *df,
>                                         unsigned long *freq)
>  {
> -       struct devfreq_dev_status stat;
> -       int err = df->profile->get_dev_status(df->dev.parent, &stat);
> +       int err;
> +       struct devfreq_dev_status *stat;
>         unsigned long long a, b;
>         unsigned int dfso_upthreshold = DFSO_UPTHRESHOLD;
>         unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
>         struct devfreq_simple_ondemand_data *data = df->data;
>         unsigned long max = (df->max_freq) ? df->max_freq : UINT_MAX;
>
> +       err = devfreq_update_stats(df);
>         if (err)
>                 return err;
>
> +       stat = &df->last_status;
> +
>         if (data) {
>                 if (data->upthreshold)
>                         dfso_upthreshold = data->upthreshold;
> @@ -43,41 +46,41 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
>                 return -EINVAL;
>
>         /* Assume MAX if it is going to be divided by zero */
> -       if (stat.total_time == 0) {
> +       if (stat->total_time == 0) {
>                 *freq = max;
>                 return 0;
>         }
>
>         /* Prevent overflow */
> -       if (stat.busy_time >= (1 << 24) || stat.total_time >= (1 << 24)) {
> -               stat.busy_time >>= 7;
> -               stat.total_time >>= 7;
> +       if (stat->busy_time >= (1 << 24) || stat->total_time >= (1 << 24)) {
> +               stat->busy_time >>= 7;
> +               stat->total_time >>= 7;
>         }
>
>         /* Set MAX if it's busy enough */
> -       if (stat.busy_time * 100 >
> -           stat.total_time * dfso_upthreshold) {
> +       if (stat->busy_time * 100 >
> +           stat->total_time * dfso_upthreshold) {
>                 *freq = max;
>                 return 0;
>         }
>
>         /* Set MAX if we do not know the initial frequency */
> -       if (stat.current_frequency == 0) {
> +       if (stat->current_frequency == 0) {
>                 *freq = max;
>                 return 0;
>         }
>
>         /* Keep the current frequency */
> -       if (stat.busy_time * 100 >
> -           stat.total_time * (dfso_upthreshold - dfso_downdifferential)) {
> -               *freq = stat.current_frequency;
> +       if (stat->busy_time * 100 >
> +           stat->total_time * (dfso_upthreshold - dfso_downdifferential)) {
> +               *freq = stat->current_frequency;
>                 return 0;
>         }
>
>         /* Set the desired frequency based on the load */
> -       a = stat.busy_time;
> -       a *= stat.current_frequency;
> -       b = div_u64(a, stat.total_time);
> +       a = stat->busy_time;
> +       a *= stat->current_frequency;
> +       b = div_u64(a, stat->total_time);
>         b *= 100;
>         b = div_u64(b, (dfso_upthreshold - dfso_downdifferential / 2));
>         *freq = (unsigned long) b;
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index ffbe1f62ec2c..be351cfacec8 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -161,6 +161,7 @@ struct devfreq {
>         struct delayed_work work;
>
>         unsigned long previous_freq;
> +       struct devfreq_dev_status last_status;
>
>         void *data; /* private data for governors */
>
> @@ -206,6 +207,7 @@ extern void devm_devfreq_unregister_opp_notifier(struct device *dev,
>
>  int devfreq_qos_set_min(struct devfreq *df, unsigned long value);
>  int devfreq_qos_set_max(struct devfreq *df, unsigned long value);
> +int devfreq_update_stats(struct devfreq *df);
>
>  #if IS_ENABLED(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)
>  /**
> @@ -302,6 +304,11 @@ static inline int devfreq_qos_set_max(struct devfreq *df, unsigned long value)
>  {
>         return -EINVAL;
>  }
> +
> +static inline int devfreq_update_stats(struct devfreq *df)
> +{
> +       return -EINVAL;
> +}
>  #endif /* CONFIG_PM_DEVFREQ */
>
>  #endif /* __LINUX_DEVFREQ_H__ */
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
MyungJoo Ham, Ph.D.
Frontier CS Lab, S/W Center, Samsung Electronics
