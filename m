From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 2/2] PM / sleep: don't suspend parent when async child suspend_{noirq,late} fails
Date: Wed, 02 Nov 2016 04:51:08 +0100
Message-ID: <50971906.K6xak2t6Z6@vostro.rjw.lan>
References: <1476923170-111986-2-git-send-email-briannorris@chromium.org> <8017823.VJuZzSqtaY@vostro.rjw.lan> <CAKdAkRS+uUrx72DLKuyDiUMkKzxMTRXx5Pv1JBky6T8huv4Fhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54111 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1751063AbcKBDn5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Nov 2016 23:43:57 -0400
In-Reply-To: <CAKdAkRS+uUrx72DLKuyDiUMkKzxMTRXx5Pv1JBky6T8huv4Fhg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Brian Norris <briannorris@chromium.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chuansheng Liu <chuansheng.liu@intel.com>

On Tuesday, November 01, 2016 12:04:28 AM Dmitry Torokhov wrote:
> On Mon, Oct 31, 2016 at 10:25 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Thursday, October 27, 2016 09:05:34 AM Brian Norris wrote:
> >> Consider two devices, A and B, where B is a child of A, and B utilizes
> >> asynchronous suspend (it does not matter whether A is sync or async). If
> >> B fails to suspend_noirq() or suspend_late(), or is interrupted by a
> >> wakeup (pm_wakeup_pending()), then it aborts and sets the async_error
> >> variable. However, device A does not (immediately) check the async_error
> >> variable; it may continue to run its own suspend_noirq()/suspend_late()
> >> callback. This is bad.
> >>
> >> We can resolve this problem by checking the async_error flag after
> >> waiting for children to suspend, using the same logic for the noirq and
> >> late suspend cases as we already do for __device_suspend().
> >>
> >> It's easy to observe this erroneous behavior by, for example, forcing a
> >> device to sleep a bit in its suspend_noirq() (to ensure the parent is
> >> waiting for the child to complete), then return an error, and watch the
> >> parent suspend_noirq() still get called. (Or similarly, fake a wakeup
> >> event at the right (or is it wrong?) time.)
> >>
> >> Fixes: de377b397272 ("PM / sleep: Asynchronous threads for suspend_late")
> >> Fixes: 28b6fd6e3779 ("PM / sleep: Asynchronous threads for suspend_noirq")
> >> Reported-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> >> Signed-off-by: Brian Norris <briannorris@chromium.org>
> >> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >> ---
> >> v2: s/early/late/ in commit message
> >>
> >>  drivers/base/power/main.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> >> index c58563581345..eaf6b53463a5 100644
> >> --- a/drivers/base/power/main.c
> >> +++ b/drivers/base/power/main.c
> >> @@ -1040,6 +1040,9 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
> >>
> >>       dpm_wait_for_children(dev, async);
> >>
> >> +     if (async_error)
> >> +             goto Complete;
> >> +
> >
> > This is a second chech for async_error in this routine and is the first one
> > really needed after adding this?
> 
> There is really no point in waiting for children to be suspended if
> error has already been signalled; that's what first check achieves.
> The 2nd check ensures that we abort suspend if any of the children
> failed to suspend.
> 
> I'd say both checks are needed (well, 1st is helpful, 2nd is essential).

OK, fair enough.

Thanks,
Rafael

