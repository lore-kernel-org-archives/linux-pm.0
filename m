From: Nitish Ambastha <nits.ambastha@gmail.com>
Subject: Re: [PATCHv3 1/1] kernel/power/autosleep.c: check for pm_suspend()
 return before queueing suspend again
Date: Thu, 23 Jul 2015 01:41:51 +0530
Message-ID: <CAHWDpXiVRrwuVy=0_w_YkYySWyaC7CrJ5b3jY0atD4WxBZM-=g@mail.gmail.com>
References: <1435604054-29711-1-git-send-email-nitish.a@samsung.com>
	<1834201.LA0RYhhP7u@vostro.rjw.lan>
	<CAHWDpXj+AjD3F+8RvRFePXCXRKq=WBh0MKy-39B2emjG+Qamxw@mail.gmail.com>
	<1909321.djDBBPKRbt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33409 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbbGVULw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 16:11:52 -0400
In-Reply-To: <1909321.djDBBPKRbt@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Nitish Ambastha <nitish.a@samsung.com>, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpgs@samsung.com

Hi Rafael,

Thank you very much for your comments and feedback
I have planned to drop this one now. Before I close, I would just
share few more comments and idea behind this.

Before queueing next suspend, we track wakeup event counts
consistently for drivers registered to wakeup events, to know if
events are pending or completed. However we cannot identify or track
the same for other drivers which are not registered with wakeup
events.
Since we can't track the events and behavior of these drivers, we
cannot predict if the next attempt of suspend will be successful on
those drivers, while the current attempt failed. This resulting in a
possibility of tight suspend resume if there is suspend failures by
these drivers more frequently.
So, my opinion was to prevent immediate suspend requests when some
drivers (which are not registered to wakeup events) failed to suspend
in current attempt. I might be wrong, but this is how I understand it.


Regards
Nitish Ambastha


On Thu, Jul 16, 2015 at 3:59 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, July 14, 2015 09:34:08 AM Nitish Ambastha wrote:
>> On Tue, Jul 14, 2015 at 5:13 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Tuesday, July 14, 2015 01:38:02 AM Nitish Ambastha wrote:
>> >> Prevent tight loop for suspend-resume when some
>> >> devices failed to suspend
>> >
>> > This *still* doesn't explain what problem you're *really* trying to address.
>> >
>> > Even if a driver returns an error code from one of its suspend callbacks,
>> > you should get final_count == initial_count in the final check and we'll
>> > schedule the timeout.
>> >
>> > So there is a failure scenarion you're trying to address where that check is
>> > not sufficient, but you're not saying what the scenario is.
>> >
>> As I mentioned earlier, if some driver failed to suspend, and during
>> resume if *somebody* called pm_stay_awake() or pm_wakeup_event()
>> meantime, and then pm_relax(), final_count and initial_count will not
>> be the same in try_to_suspend(). We observed this behavior with
>> battery monitor thread on being restarted
>
> But that means there was a valid wakeup event, doesn't it?
>
>> In these scenarios, it will be considered a *valid wakeup* event and
>> it will try to queue suspend immediately, though the actual reason of
>> resume was driver returning error code.
>
> Even if a wakeup event occurs in addition to a driver failing the suspend, it
> is still valid.
>
> So it looks like you want to schedule the timeout unconditionally in case of
> a failed suspend, but then you need to filter out -EBUSY (which is returned
> on valid wakeup events).  Essentially, that would slow down autosleep, but
> how does that help exactly?
>
> Thanks,
> Rafael
>
