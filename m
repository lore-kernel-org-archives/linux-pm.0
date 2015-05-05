From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: A desktop environment[1] kernel wishlist
Date: Tue, 5 May 2015 08:05:32 +0200
Message-ID: <CAAObsKBRs7iD2hHa0smhz-1c2e6HW+r2_CxPhv48Cs4yH+npUQ@mail.gmail.com>
References: <1413881397.30379.7.camel@hadess.net> <CAJFHJrp8R+Na73W2Jx6BJ+JnHTGZfd61d+EracgehS+ZQoZOcg@mail.gmail.com>
 <CAAObsKDYV=Hyz0XcPkyD6=hu4WKk7PHGdSMOCZxbh_vMKHS32Q@mail.gmail.com> <2236285.G0hRnmeVkc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34782 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442AbbEEGFy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2015 02:05:54 -0400
In-Reply-To: <2236285.G0hRnmeVkc@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Chirantan Ekbote <chirantan@chromium.org>, Olof Johansson <olof@lixom.net>, John Stultz <john.stultz@linaro.org>, Bastien Nocera <hadess@hadess.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, snanda@chromium.org, Linux PM list <linux-pm@vger.kernel.org>

On 5 May 2015 at 00:19, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, May 01, 2015 11:02:19 AM Tomeu Vizoso wrote:
>> On 30 April 2015 at 20:54, Chirantan Ekbote <chirantan@chromium.org> wrote:
>> > On Thu, Apr 30, 2015 at 10:23 AM, Olof Johansson <olof@lixom.net> wrote:
>> >> Hi,
>> >>
>> >> On Thu, Apr 30, 2015 at 10:10 AM, John Stultz <john.stultz@linaro.org> wrote:
>> >>> On Thu, Apr 30, 2015 at 9:25 AM, Bastien Nocera <hadess@hadess.net> wrote:
>> >>>> On Tue, 2014-10-21 at 10:04 -0700, John Stultz wrote:
>> >>>>> On Tue, Oct 21, 2014 at 1:49 AM, Bastien Nocera <hadess@hadess.net>
>> >>>>> wrote:
>> >>>>> > Hey,
>> >>>>> >
>> >>>>> > GNOME has had discussions with kernel developers in the past, and,
>> >>>>> > fortunately, in some cases we were able to make headway.
>> >>>>> >
>> >>>>> > There are however a number of items that we still don't have
>> >>>>> > solutions
>> >>>>> > for, items that kernel developers might not realise we'd like to
>> >>>>> > rely
>> >>>>> > on, or don't know that we'd make use of if merged.
>> >>>>> >
>> >>>>> > I've posted this list at:
>> >>>>> > https://wiki.gnome.org/BastienNocera/KernelWishlist
>> >>>>> >
>> >>>>> > Let me know on-list or off-list if you have any comments about
>> >>>>> > those, so
>> >>>>> > I can update the list.
>> >>>>>
>> >>>>> As for: 'Export of "wake reason" when the system wakes up (rtc alarm,
>> >>>>> lid open, etc.) and wakealarm (/sys/class/rtc/foo/wakealarm)
>> >>>>> documentation'
>> >>>>>
>> >>>>> Can you expand more on the rational for the need here? Is this for UI
>> >>>>> for power debugging, or something else?
>> >>>>
>> >>>> This is pretty much what I had in mind:
>> >>>> https://www.chromium.org/chromium-os/chromiumos-design-docs/lucid-sleep
>> >>>>
>> >>>> I guess I didn't make myself understood.
>> >>>
>> >>> My, admittedly quick skim, of that design document seems to suggest
>> >>> that lucid sleep would be a new kernel state. That would keep the
>> >>> kernel in charge of determining the state transitions (ie:
>> >>> SUSPEND-(alarm)->LUCID-(wakelock
>> >>> release)->SUSPEND-(alarm)->LUCID-(power-button)->AWAKE). Then it seems
>> >>> userspace would be able to query the current state. This avoids some
>> >>> of the races I was concerned with trying to detect which irq woke us
>> >>> from suspend from userspace.
>> >>>
>> >
>> > Tomeu has been working on making things so that we don't need a new
>> > kernel state.  Adding him on cc so he can correct me if I say
>> > something wrong.  The current idea is to have userspace runtime
>> > suspend any unneeded devices before starting a suspend.  This way the
>> > kernel will leave them alone at resume.  This behavior already exists
>> > in the mainline kernel.
>>
>> This is right, I have one series on flight about removing any
>> non-runtime device resumes from my test platform (a nyan-big) and
>> another about entering suspend-to-idle with ticks frozen (also on
>> Tegra124/nyan-big).
>>
>> > Getting the wakeup reason can be accomplished
>> > by having the kernel emit a uevent with the wakeup reason.  This is
>> > the only change that would be necessary.
>>
>> My current opinion is that for ChromeOS there's no need for the kernel
>> to communicate a wakeup reason to userspace. From what I know it
>> should be enough for powerd/upower/whatever to constantly monitor all
>> relevant input devices and that should tell if the wakeup was caused
>> by user activity or not.
>
> Dream on.
>
> What about input events that leave no trace in the input buffers?

You mean that it can happen that, barring bugs on hw or fw, the kernel
knows what device "caused" the wakeup but doesn't have enough
information to report the full event (key pressed, touchpad motion,
etc) to userspace?

> What about events occuring between the time you've decided to suspend and
> you actually suspended?

What about them? How would wakeup_type help us there?

Regards,

Tomeu

>> Once userspace is thawed, the power management daemon would read any
>> pending events from the input devices and would decide whether to stay
>> on dark resume or whether to unfreeze renderer daemons and power up
>> the display, unpause any audio streams, etc.
>
> And what about if it decideds to suspend again and a wakeup event
> requiring you to bring up the UI occurs exactly at that time?
>
> You really have the same race as Android does here, but in addition to that
> you want to deterimne how far to go with the resume on the basis of what
> wakeup sources are involved.
>
> I'm leaving the below for the benefit of linux-pm readers.
>
>> For the GNOME folks, this is how it's done in ChromeOS:
>>
>> https://chromium.googlesource.com/chromiumos/platform2/+/master/power_manager/powerd/system/input_watcher.cc
>>
>> Of course, this depends on events not getting lost. In the ChromeOS
>> case, the firmware is under the control of the OS developers, so any
>> bugs can be fixed.
>>
>> For GNOME and other desktop environments who aim to run on systems
>> whose firmware cannot be fixed, I think it could make sense for the
>> kernel to synthesize such events if it happens to have enough
>> information to do so.
>>
>> Besides this issue, I think that what "only" remains to be done in the
>> kernel is to speed up resumes so no hacks are needed downstream. The
>> infrastructure for this already exists in the form of
>> power.direct_complete and suspend-to-idle and the work that remains is
>> mostly platform-specific.
>>
>> This is to say that GNOME could start implementing lucid sleep right
>> now, though the user experience might not be ideal yet because resumes
>> might take longer than desired. But it might not matter to GNOME as
>> much as it does to ChromeOS because they aren't in control of the hw
>> anyway?
>>
>> Regards,
>>
>> Tomeu
>>
>> >>> That said, the Power Manager section in that document sounds a little
>> >>> racy as it seems to rely on asking userspace if suspend is ok, rather
>> >>> then using userspace wakelocks, so I'm not sure how well baked this
>> >>> doc is.
>> >>>
>> >
>> > I'm not sure I understand what you are saying here.  If you're saying
>> > that the kernel is asking userspace if suspend is ok, then I can say
>> > that that's definitely not the case.  Currently from the kernel's
>> > perspective a lucid sleep resume isn't really different from a regular
>> > resume.  We have a hack in each driver that we care about that
>> > basically boils down to an if statement that skips re-initialization
>> > if we are entering lucid sleep.  If userspace tries to access that
>> > device in lucid sleep, it just gets an error.  This has actually
>> > caused us some headache (see the GPU process section of the doc),
>> > which is why we'd like to switch to using the runtime suspend approach
>> > I mentioned above.
>> >
>> > If instead you're saying that the power manager needs to ask the rest
>> > of userspace whether suspend is ok, you can think of the current
>> > mechanism as a sort of timed wake lock.  Daemons that care about lucid
>> > sleep register with the power manager when they start up.  The power
>> > manager then waits for these daemons to report readiness while in
>> > lucid sleep before starting another suspend.  So each daemon
>> > effectively acquires a wake lock when the system enters lucid sleep
>> > and releases the wake lock when it reports readiness to the power
>> > manager or the timeout occurs.
>> >
>> >>> Olof: Can you comment on who's working on that design doc?   Also the
>> >>> discussion around using freezing cgroups separately to distinguish
>> >>> between lucid and awake is interesting, but I wonder if we need to
>> >>> make wakeup_sources/wakelocks cgroup aware, or has that already been
>> >>> done?
>> >>
>> >
>> > Currently cgroup process management is handled by the Chrome browser
>> > since the only processes we freeze are Chrome renderers.  A renderer
>> > is basically a process that hosts the content for a single tab,
>> > extension, plugin, etc.  Freezing occurs when the system is about to
>> > enter suspend from the fully awake state and thawing occurs during the
>> > reverse transition.  We've made no changes to the cgroup code and have
>> > been using it as is.
>> >
>> >>
>> >> Sameer and Chirantan have both been deeply involved in that project,
>> >> adding them on cc here.
>> >>
>> >>
>> >> -Olof
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> > Please read the FAQ at  http://www.tux.org/lkml/
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
