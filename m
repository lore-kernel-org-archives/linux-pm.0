From: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC RESEND 1/3] PM / devfreq: Add watermark events
Date: Tue, 9 Dec 2014 16:17:01 +0900
Message-ID: <CAAVeFuKS7qigoL63NQHBcWKphsL9MELD_kchexBX_GiDGABidw@mail.gmail.com>
References: <1417786892-477-1-git-send-email-amerilainen@nvidia.com> <1417786892-477-2-git-send-email-amerilainen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417786892-477-2-git-send-email-amerilainen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arto Merilainen <amerilainen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, srasal-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 5, 2014 at 10:41 PM, Arto Merilainen <amerilainen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> From: Shridhar Rasal <srasal-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> This patch adds support for watermark events. These events inform
> the governor that the device load has gone below (low watermark) or
> above (high watermark) certain load value.

This is definitely a useful feature to have, as it reflects what
efficient hardware does (raise an interrupt when load goes above/under
a certain threshold). In particular Tomeu's ACTMON driver would
probably greatly benefit from it.

A few comments below:

>
> Signed-off-by: Shridhar Rasal <srasal-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Arto Merilainen <amerilainen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/devfreq/devfreq.c  | 19 +++++++++++++++++++
>  drivers/devfreq/governor.h |  1 +
>  include/linux/devfreq.h    | 26 ++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 30b538d8cc90..8333d024132a 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -1050,6 +1050,25 @@ static struct attribute *devfreq_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(devfreq);
>
> +/**
> + * devfreq_watermark_event() - Handles watermark events
> + * @devfreq: the devfreq instance to be updated
> + * @type: type of watermark event
> + */
> +int devfreq_watermark_event(struct devfreq *devfreq, int type)

Here I suppose "type" is to be an enum watermark_type - therefore it
should probably be changed to that type instead of int.

> +{
> +       if (!devfreq)
> +               return -EINVAL;
> +
> +       if (!devfreq->governor)
> +               return -EINVAL;

Let's fold these two conditions into "if (!devfreq || !devfreq->governor)"

> +
> +       return devfreq->governor->event_handler(devfreq,
> +                               DEVFREQ_GOV_WMARK, &type);
> +}
> +EXPORT_SYMBOL(devfreq_watermark_event);
> +
> +

Extra whiteline here.

>  static int __init devfreq_init(void)
>  {
>         devfreq_class = class_create(THIS_MODULE, "devfreq");
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index fad7d6321978..fb9875388f3f 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -24,6 +24,7 @@
>  #define DEVFREQ_GOV_INTERVAL                   0x3
>  #define DEVFREQ_GOV_SUSPEND                    0x4
>  #define DEVFREQ_GOV_RESUME                     0x5
> +#define DEVFREQ_GOV_WMARK                      0x6
>
>  /* Caution: devfreq->lock must be locked before calling update_devfreq */
>  extern int update_devfreq(struct devfreq *devfreq);
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index f1863dcd83ea..b5bf6c4fe286 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -21,6 +21,12 @@
>
>  struct devfreq;
>
> +enum watermark_type {

Change the name to devfreq_watermark_event maybe? We know it's a type
already from the context, and we should use the devfreq_ prefix to
avoid name collisions.

> +       NO_WATERMARK_EVENT = 0,
> +       HIGH_WATERMARK_EVENT = 1,
> +       LOW_WATERMARK_EVENT = 2

... and if the type is renamed to watermark_event, these could become
DEVFREQ_NO_WATERMARK, DEVFREQ_HIGH_WATERMARK, and
DEVFREQ_LOW_WATERMARK.

> +};
> +
>  /**
>   * struct devfreq_dev_status - Data given from devfreq user device to
>   *                          governors. Represents the performance
> @@ -68,6 +74,16 @@ struct devfreq_dev_status {
>   *                     status to devfreq, which is used by governors.
>   * @get_cur_freq:      The device should provide the current frequency
>   *                     at which it is operating.
> + * @set_high_wmark:    This is an optional callback to set high
> + *                     watermark for watermark event. The value is
> + *                     be scaled between 0 and 1000 where 1000 equals to
> + *                     100% load. Setting this value to 1000 disables
> + *                     the event
> + * @set_low_wmark:     This is an optional callback to set low
> + *                     watermark for watermark event. The value is
> + *                     be scaled between 0 and 1000 where 1000 equals to
> + *                     100% load. Setting this value to 0 disables the
> + *                     event.

>From the comment it is not clear whether the 0..1000 range corresponds
to the load between two frequencies in the frequencies table, or
covers the whole frequency table. I understand it is the former, but
it would be nice to explicitly state it.
