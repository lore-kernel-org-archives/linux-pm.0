From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCHv3 1/1] kernel/power/autosleep.c: check for pm_suspend() return before queueing suspend again
Date: Thu, 16 Jul 2015 00:29:25 +0200
Message-ID: <1909321.djDBBPKRbt@vostro.rjw.lan>
References: <1435604054-29711-1-git-send-email-nitish.a@samsung.com> <1834201.LA0RYhhP7u@vostro.rjw.lan> <CAHWDpXj+AjD3F+8RvRFePXCXRKq=WBh0MKy-39B2emjG+Qamxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHWDpXj+AjD3F+8RvRFePXCXRKq=WBh0MKy-39B2emjG+Qamxw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nitish Ambastha <nits.ambastha@gmail.com>
Cc: Nitish Ambastha <nitish.a@samsung.com>, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpgs@samsung.com
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 14, 2015 09:34:08 AM Nitish Ambastha wrote:
> On Tue, Jul 14, 2015 at 5:13 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, July 14, 2015 01:38:02 AM Nitish Ambastha wrote:
> >> Prevent tight loop for suspend-resume when some
> >> devices failed to suspend
> >
> > This *still* doesn't explain what problem you're *really* trying to address.
> >
> > Even if a driver returns an error code from one of its suspend callbacks,
> > you should get final_count == initial_count in the final check and we'll
> > schedule the timeout.
> >
> > So there is a failure scenarion you're trying to address where that check is
> > not sufficient, but you're not saying what the scenario is.
> >
> As I mentioned earlier, if some driver failed to suspend, and during
> resume if *somebody* called pm_stay_awake() or pm_wakeup_event()
> meantime, and then pm_relax(), final_count and initial_count will not
> be the same in try_to_suspend(). We observed this behavior with
> battery monitor thread on being restarted

But that means there was a valid wakeup event, doesn't it?

> In these scenarios, it will be considered a *valid wakeup* event and
> it will try to queue suspend immediately, though the actual reason of
> resume was driver returning error code.

Even if a wakeup event occurs in addition to a driver failing the suspend, it
is still valid.

So it looks like you want to schedule the timeout unconditionally in case of
a failed suspend, but then you need to filter out -EBUSY (which is returned
on valid wakeup events).  Essentially, that would slow down autosleep, but
how does that help exactly?

Thanks,
Rafael
