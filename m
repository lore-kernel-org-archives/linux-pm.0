From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [RFC RESEND 0/3] Add watermark support to devfreq
Date: Tue, 9 Dec 2014 14:25:41 +0100
Message-ID: <CAAObsKBA9ckYYB89q0QLprx2zJbVFcH3=5qvKiCsPaatqe58dQ@mail.gmail.com>
References: <1417786892-477-1-git-send-email-amerilainen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417786892-477-1-git-send-email-amerilainen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arto Merilainen <amerilainen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "srasal-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <srasal-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 5 December 2014 at 14:41, Arto Merilainen <amerilainen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> (Sorry for the spam. I am resending the series because I noted that
> some of the email addresses were mistyped)
>
> Currently main mechanism to implement scaling using devfreq is
> polling and the device profile is free to set polling interval.
> However, in many cases this approach is not optimal; We may
> unnecessarily use CPU time to determine load on engine that
> is idle most of time - or we may simply read load when we
> already know that the device is busy.
>
> In some cases a device itself has counters to track its activity
> and possibility to raise interrupts when load goes above or below
> certain threshold.

Hi Arto,

this is very interesting stuff, thanks for sending.

Regarding the question of whether the ACTMON driver should use this
generic governor, I think it comes down to whether we are able to
reach the best compromise between performance and power usage with it.

I see that the logic of the downstream ACTMON driver is much more
complex, as it takes into account the activity caused by the CPU
complex and gives it more weight than the total. It also sets
watermarks for the running average over the last 128 samples. The
frequency of the CPU is also taken into account.

Besides that, there's several factors and adjustments that I can only
think that have been determined through experimentation and
measurement and that in that case are very likely to be specific to a
given board and/or SoC.

It also takes into account consecutive watermark breaches and boosts
the frequency accordingly.

It would be great if you could ask within NVIDIA for the rationale
behind the way of calculating the target frequency downstream, as it
would allow us to better discern what can be made generic and what
belongs to the ACTMON driver itself.

It would be also good if we can find other SoCs that have similar
functionality, so we can make sure that what we end up adding to the
generic framework is of use to others.

Besides the above general points, two more specific comments:

* why not use the opp freq table from the DT (operating-points)
instead of freq_table?

* why having wmark_simple at all? And if we don't actually want it,
guess we can drop the event type arg?

Thanks,

Tomeu


> This series adds support for watermark events to devfreq and
> introduces two example governors. The first patch adds two
> callbacks to the device profile (for setting watermark) and
> adds a new function call to devfreq that informs of crossed
> watermark.
>
> The added governors demonstrate usage of the new API. The first
> governor (watermark simple) sets device to trigger low watermark
> event when load goes below 10% and high watermark interrupt when
> the load goes above 60%. Watermark active tries to keep load at
> certain level and it actively sets thresholds based on the
> frequency table in order get interrupts only when the load value
> would affect to the current frequency in re-estimation.
>
> Arto Merilainen (1):
>   PM / devfreq: Add watermark active governor
>
> Shridhar Rasal (2):
>   PM / devfreq: Add watermark events
>   PM / devfreq: Add watermark simple governor
>
>  drivers/devfreq/Kconfig                 |  18 +++
>  drivers/devfreq/Makefile                |   2 +
>  drivers/devfreq/devfreq.c               |  19 +++
>  drivers/devfreq/governor.h              |   1 +
>  drivers/devfreq/governor_wmark_active.c | 276 ++++++++++++++++++++++++++++++++
>  drivers/devfreq/governor_wmark_simple.c | 245 ++++++++++++++++++++++++++++
>  include/linux/devfreq.h                 |  26 +++
>  7 files changed, 587 insertions(+)
>  create mode 100644 drivers/devfreq/governor_wmark_active.c
>  create mode 100644 drivers/devfreq/governor_wmark_simple.c
>
> --
> 1.8.1.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
