From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/3] power: validate wakeup source before activating it.
Date: Thu, 07 May 2015 00:39:10 +0200
Message-ID: <2269869.Sl61WOPXPd@vostro.rjw.lan>
References: <1430938267-14951-1-git-send-email-jinqian@android.com> <2043095.ifDvYKem54@vostro.rjw.lan> <CA+yUs=yZ=Ngn3iqr31XQiVCNbULit737ALdg_Ezov3N8T_TnCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+yUs=yZ=Ngn3iqr31XQiVCNbULit737ALdg_Ezov3N8T_TnCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jin Qian <jinqian@android.com>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, May 06, 2015 03:11:48 PM Jin Qian wrote:
> Hi Rafael,
> 
> I kept braces since checkpatch.pl didn't report error or warning. The
> if condition has two lines, a brace make the statement more clear I
> think.

Well, you don't have to break the "if" line. :-)

As per CodingStyle, the braces should not be there.


> I removed the format string since ws->name can be random strings if
> the wakeup_source is not registered (i.e. using prepare functions).
> It's not very useful to print name if we have stack dump from
> WARN_ONCE.

OK


> On Wed, May 6, 2015 at 3:00 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, May 06, 2015 11:51:07 AM Jin Qian wrote:
> >> A rogue wakeup source not registered in wakeup_sources list is not visible
> >> from wakeup_sources_stats_show. Check if the wakeup source is registered
> >> properly by looking at the timer struct.
> >>
> >> Signed-off-by: Jin Qian <jinqian@android.com>
> >> ---
> >>  drivers/base/power/wakeup.c | 19 +++++++++++++++++++
> >>  1 file changed, 19 insertions(+)
> >>
> >> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> >> index 7726200..aead738 100644
> >> --- a/drivers/base/power/wakeup.c
> >> +++ b/drivers/base/power/wakeup.c
> >> @@ -351,6 +351,20 @@ int device_set_wakeup_enable(struct device *dev, bool enable)
> >>  }
> >>  EXPORT_SYMBOL_GPL(device_set_wakeup_enable);
> >>
> >> +/**
> >> + * wakeup_source_not_registered - validate the given wakeup source.
> >> + * @ws: Wakeup source to be validated.
> >> + */
> >> +static bool wakeup_source_not_registered(struct wakeup_source *ws)
> >> +{
> >> +     /*
> >> +      * Use timer struct to check if the given source is initialized
> >> +      * by wakeup_source_add.
> >> +      */
> >> +     return ws->timer.function != pm_wakeup_timer_fn ||
> >> +                ws->timer.data != (unsigned long)ws;
> >> +}
> >> +
> >>  /*
> >>   * The functions below use the observation that each wakeup event starts a
> >>   * period in which the system should not be suspended.  The moment this period
> >> @@ -391,6 +405,11 @@ static void wakeup_source_activate(struct wakeup_source *ws)
> >>  {
> >>       unsigned int cec;
> >>
> >> +     if (WARN_ONCE(wakeup_source_not_registered(ws),
> >> +                     "unregistered wakeup source\n")) {
> >> +             return;
> >> +     }
> >
> > The braces are not necessary and you can use format strings with WARN_ONCE()
> > too IIRC.
> >
> >> +
> >>       /*
> >>        * active wakeup source should bring the system
> >>        * out of PM_SUSPEND_FREEZE state
> >>
> >
> > --
> > I speak only for myself.
> > Rafael J. Wysocki, Intel Open Source Technology Center.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
