From: Nitish Ambastha <nits.ambastha@gmail.com>
Subject: Re: [PATCHv2 1/1] kernel/power/autosleep.c: check for pm_suspend()
 return before queueing suspend again
Date: Sat, 4 Jul 2015 23:36:52 +0530
Message-ID: <CAHWDpXhP=hgU8cNczzrvbFf0MW8DsGzg+GVdZ8K-hRJ5P+niaQ@mail.gmail.com>
References: <1435581297-20271-1-git-send-email-nitish.a@samsung.com>
	<2619760.zM2C8Nu9I9@vostro.rjw.lan>
	<CAHWDpXg=t9R1zZgfVb+M41pxifVOEhCvMB=EBw=C0pWTe19+ZQ@mail.gmail.com>
	<3120244.uQuxSPo26i@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33543 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755184AbbGEJed (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 5 Jul 2015 05:34:33 -0400
In-Reply-To: <3120244.uQuxSPo26i@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Nitish Ambastha <nitish.a@samsung.com>, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpgs@samsung.com

On Wed, Jul 1, 2015 at 1:31 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, July 01, 2015 12:52:43 AM Nitish Ambastha wrote:
> > Hi Rafael
> >
> > Thanks for your feedback
> >
> > On Tue, Jun 30, 2015 at 1:37 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > On Monday, June 29, 2015 09:56:18 PM Rafael J. Wysocki wrote:
> > >> On Tuesday, June 30, 2015 12:24:14 AM Nitish Ambastha wrote:
> > >> > Prevent tight loop for suspend-resume when some
> > >> > devices failed to suspend
> > >> > If some devices failed to suspend, we monitor this
> > >> > error in try_to_suspend(). pm_suspend() is already
> > >> > an 'int' returning function, how about checking return
> > >> > from pm_suspend() before queueing suspend again?
> > >> >
> > >> > For devices which do not register for pending events,
> > >> > this will prevent tight loop for suspend-resume in
> > >> > suspend abort scenarios due to device suspend failures
> > >
> > > Having said the below I'm not sure why the current code doesn't cover this
> > > for you?
> > >
> > > That would be the final_count == initial_count case, no?
> > >
> > Agree, this should cover most of the cases, however there are some
> > cases where final_count may not match initial_count here
> >
> > A couple of such scenario I came across is
> > 1) when tasks are restarted again due to suspend failure, sometimes
> > battery kernel thread acquires lock for battery monitoring resulting
> > in either pm_get_wakeup_count() returning false or increment in
> > final_count from initial_count
>
> Locks should not have any effect on the return value of pm_get_wakeup_count()
> and if false is returned by it, a wakeup event was being processed when it
> was called.
>
'lock' was not a correct term used, sorry about it.
By 'lock', I actually meant battery monitoring acquiring 'wake lock' here
i.e pm_wakeup_event/pm_stay_awake().

when battery kernel thread calls pm_stay_awake() or pm_wakeup_event()
momentarily and then pm_relax(), after being restarted on suspend failure,
this affects the wakeup event count

> In turn, if pm_get_wakeup_count() returns false or final_count != initial_count,
> this means that *somebody* called pm_wakeup_event() or equivalent in the meantime
> and there *was* a valid wakeup event (regardless of or in addition to the driver
> error).
>
ok, as I understand, if some driver failed to suspend, and during resume
if *somebody* called pm_stay_awake() or pm_wakeup_event() meantime,
and then pm_relax(), final_count and initial_count will not be
same in try_to_suspend(), and it will be considered as a *valid wakeup*
event, though the actual reason of resume was suspend failure.
In this condition, it will again try to queue suspend

Will it be a reasonable idea to wait in this case, before queueing
suspend as some drivers failed to suspend in the current attempt?

> > 2) In some platforms, power transitions are carried from User space
> > (power manager), these power-manager tries to hold some wake lock
> > after being restarted on resume
>
> And what exactly is the failing scenario in that case?
>
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
