From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 1/2] PM-runtime: move runtime accounting on ktime_get_mono_fast_ns()
Date: Tue, 5 Feb 2019 09:39:59 +0100
Message-ID: <CAKfTPtCqj62fYHYDth0evMqBYxY9JgqVBngDe57D4XqBKw35UA@mail.gmail.com>
References: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
 <1549297553-17647-2-git-send-email-vincent.guittot@linaro.org> <CAPDyKFrzs5PvrK_23HARKYkytPr3LF4S7j5rJ6LJANKmm7BMrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrzs5PvrK_23HARKYkytPr3LF4S7j5rJ6LJANKmm7BMrA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Biju Das <biju.das@bp.renesas.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thara Gopinath <thara.gopinath@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 5 Feb 2019 at 09:10, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 4 Feb 2019 at 17:25, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >
> > Similarly to what happened whith autosuspend, a deadlock has been raised
> > with runtime accounting in the sequence:
> >
> > change_clocksource
> >     ...
> >     write_seqcount_begin
> >     ...
> >     timekeeping_update
> >         ...
> >         sh_cmt_clocksource_enable
> >             ...
> >             rpm_resume
> >                 update_pm_runtime_accounting
> >                     ktime_get
> >                         do
> >                             read_seqcount_begin
> >                         while read_seqcount_retry
> >     ....
> >     write_seqcount_end
> >
> > Move runtime accounting on ktime_get_mono_fast_ns()
> > With ktime_get_mono_fast_ns, the timestamp is not guaranteed to be
> > monotonic across an update of timekeeping and as a result time can goes
> > backward. Add a test to skip accounting for such situation which should
> > stay exceptional.
> >
> > Fixes: a08c2a5a3194 ("PM-runtime: Replace jiffies-based accounting with ktime-based accounting")
> > Reported-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks

>
> Kind regards
> Uffe
>
>
> > ---
> >  drivers/base/power/runtime.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 1caa394..50740da 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -66,13 +66,22 @@ static int rpm_suspend(struct device *dev, int rpmflags);
> >   */
> >  void update_pm_runtime_accounting(struct device *dev)
> >  {
> > -       u64 now = ktime_to_ns(ktime_get());
> > +       u64 now = ktime_get_mono_fast_ns();
> > +       u64 last = dev->power.accounting_timestamp;
> >         u64 delta;
> >
> > -       delta = now - dev->power.accounting_timestamp;
> > -
> >         dev->power.accounting_timestamp = now;
> >
> > +       /*
> > +        * Because ktime_get_mono_fast_ns() is not monotonic during
> > +        * timekeeping update, we must ensure that now is after the last saved
> > +        * timesptamp
> > +        */
> > +       if (now < last)
> > +               return;
> > +
> > +       delta = now - last;
> > +
> >         if (dev->power.disable_depth > 0)
> >                 return;
> >
> > @@ -1312,7 +1321,7 @@ void pm_runtime_enable(struct device *dev)
> >
> >                 /* About to enable runtime pm, set accounting_timestamp to now */
> >                 if (!dev->power.disable_depth)
> > -                       dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
> > +                       dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
> >         } else {
> >                 dev_warn(dev, "Unbalanced %s!\n", __func__);
> >         }
> > --
> > 2.7.4
> >
