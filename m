From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / Domains: Propagate start and restore errors during
 runtime resume
Date: Fri, 4 Mar 2016 22:22:37 +0100
Message-ID: <CAJZ5v0iL1UNH868G_vDV2WqcP-o0M6q1YiyKF9ZQycZGYJB=zw@mail.gmail.com>
References: <1456874438-26330-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<CAPDyKFp08Qy4Ui05f4gUhRPmEHZppfO1R=yPr0bq2FC=LCGcbQ@mail.gmail.com>
	<1809964.9XIZqQIE9j@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1809964.9XIZqQIE9j@avalon>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 4, 2016 at 9:38 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Ulf,
>
> Thank you for the review.
>
> On Friday 04 March 2016 11:22:49 Ulf Hansson wrote:
>> On 2 March 2016 at 00:20, Laurent Pinchart wrote:
>> > During runtime resume the return values of the start and restore steps
>> > are ignored. As a result drivers are not notified of runtime resume
>> > failures and can't propagate them up. Fix it by returning an error if
>> > either the start or restore step fails, and clean up properly in the
>> > error path.
>> >
>> > Signed-off-by: Laurent Pinchart
>> > <laurent.pinchart+renesas@ideasonboard.com>
>> > ---
>> >
>> >  drivers/base/power/domain.c | 20 ++++++++++++++++++--
>> >  1 file changed, 18 insertions(+), 2 deletions(-)
>> >
>> > This fixes an issue I've noticed with my driver's .runtime_resume()
>> > handler returning an error that was never propagated out of
>> > pm_runtime_get_sync().
>> >
>> > A second issue then appeared. The device .runtime_error field is set to
>> > the error code returned by my .runtime_resume() handler, but it never
>> > reset. Any subsequent try to resume the device fails with -EINVAL. I'm not
>> > sure what the right way to solve that is, advices are welcome.
>> >
>> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> > index 301b785f9f56..8cfcb8d6179b 100644
>> > --- a/drivers/base/power/domain.c
>> > +++ b/drivers/base/power/domain.c
>> > @@ -485,8 +485,13 @@ static int pm_genpd_runtime_resume(struct device
>> > *dev)
>> >         if (timed && runtime_pm)
>> >                 time_start = ktime_get();
>> >
>> > -       genpd_start_dev(genpd, dev);
>> > -       genpd_restore_dev(genpd, dev);
>> > +       ret = genpd_start_dev(genpd, dev);
>> > +       if (ret)
>> > +               goto err_poweroff;
>> > +
>> > +       ret = genpd_restore_dev(genpd, dev);
>> > +       if (ret)
>> > +               goto err_stop;
>> >
>> >         /* Update resume latency value if the measured time exceeds it. */
>> >         if (timed && runtime_pm) {
>> > @@ -501,6 +506,17 @@ static int pm_genpd_runtime_resume(struct device
>> > *dev)
>> >         }
>> >
>> >         return 0;
>> > +
>> > +err_stop:
>> > +       genpd_stop_dev(genpd, dev);
>> > +err_poweroff:
>> > +       if (!dev->power.irq_safe) {
>>
>> There's a helper function for this:
>> pm_runtime_is_irq_safe()
>>
>> Perhaps, we can leave this as is here and then make a separate patch
>> converting all occurrences of the above into using the helper function
>> instead.
>
> If there are other occurrences a separate patch would make sense, I agree.
>
>> > +               mutex_lock(&genpd->lock);
>> > +               genpd_poweroff(genpd, 0);
>> > +               mutex_unlock(&genpd->lock);
>> > +       }
>> > +
>> > +       return ret;
>> >
>> >  }
>> >
>> >  static bool pd_ignore_unused;
>>
>> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Thank you. Do you plan to take the patch in your tree for v4.6 ?

I'll do that.

Thanks,
Rafael
