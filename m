From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Tue, 30 Jun 2015 16:04:52 -0400
Message-ID: <CAJvTdKmscv8andz=T4zPjhgtqHq4+k6iB3Lm+_14eqnah=Fdcw@mail.gmail.com>
References: <4290667.ZqInAykFGS@vostro.rjw.lan>
	<Pine.LNX.4.44L0.1505091556001.5397-100000@netrider.rowland.org>
	<20150509202518.GB20282@khazad-dum.debian.net>
	<CAJvTdKmGFPHtO-rOwXWJr6bPDS4PuEo+g7H-uQhuMc_+kh4CuA@mail.gmail.com>
	<20150625171158.GB27230@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35822 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbbF3UEy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2015 16:04:54 -0400
In-Reply-To: <20150625171158.GB27230@khazad-dum.debian.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Thu, Jun 25, 2015 at 1:11 PM, Henrique de Moraes Holschuh
<hmh@hmh.eng.br> wrote:
> On Mon, 11 May 2015, Len Brown wrote:
>> On Sat, May 9, 2015 at 4:25 PM, Henrique de Moraes Holschuh
>> <hmh@hmh.eng.br> wrote:
>> > On Sat, 09 May 2015, Alan Stern wrote:
>> >> On Fri, 8 May 2015, Rafael J. Wysocki wrote:
>> >> > My current view on that is that whether or not to do a sync() before suspending
>> >> > ultimately is a policy decision and should belong to user space as such (modulo
>> >> > the autosleep situation when user space may not know when the suspend is going
>> >> > to happen).
>> >> >
>> >> > Moreover, user space is free to do as many sync()s before suspending as it
>> >> > wants to and the question here is whether or not the *kernel* should sync()
>> >> > in the suspend code path.
>> >> >
>> >> > Since we pretty much can demonstrate that having just one sync() in there is
>> >> > not sufficient in general, should we put two of them in there?  Or just
>> >> > remove the existing one and leave it to user space entirely?
>> >>
>> >> I don't know about the advantages of one sync over two.  But how about
>> >> adding a "syncs_before_suspend" (or just "syncs") sysfs attribute that
>> >> takes a small numeric value?  The default can be 0, and the user could
>> >> set it to 1 or 2 (or higher).
>> >
>> > IMO it would be much safer to both have that knob, and to set it to keep the
>> > current behavior as the default.  Userspace will adapt and change that knob
>> > to whatever is sufficient based on what it does before signaling the kernel
>> > to suspend.
>> >
>> > A regression in sync-before-suspend is sure to cause data loss episodes,
>> > after all.  And, as far as bikeshedding goes, IMHO syncs_before_suspend is
>> > self-explanatory, which would be a very good reason to use it instead of the
>> > shorter requires-you-to-know-what-it-is-about "syncs".
>>
>> When I first thought about this, I had a similar view:
>> https://lkml.org/lkml/2014/1/23/45
>>
>> But upon reflection, I do not believe that the kernel is adding value
>> here, instead it is imposing a policy, and that policy decision is
>> sometimes prohibitively expensive.  User-space can do this for itself (and
>> in the case of desktop distros, already does), and so the kernel should
>> butt-out.
>
> There is a lot of added value in my filesystems not being trashed by
> sleep/resume issues on laptops, IMHO, and the reason why we need the kernel
> itself to take care of syncing and freezing filesystems has been explained
> elsewhere in this thread.
> I thoght for a while before replying, and I think the real issue behind this
> thread is the want of a change of expected-but-implied semanthics and
> behavior for the system-wide sleep-to-memory trigger, to adequate it to a
> new reality for newer classes of devices.
>
> Entering "mem" suspend mode through sysfs currently has the implied meaning
> of "prepare the *entire* system to stay on a powered down state for
> pontentially a _long_ time", where long means "certainly more than 10
> seconds" ;-) This is unlikely to be written anywhere, of course, that's just
> how it was used by the vast majority for years, at least on traditional
> server/desktop/laptop platforms such as x86.

The _vast_ majority of systems using Linux suspend today are under
an Android user-space.  Android has no assumption that that suspend to mem
will necessarily stay suspended for a long time.

The wake-on-packet use-case is generally a much shorter suspend duration,
and more frequent number of suspend/resume cycles
than the "wake on lid-open or button-press" use case.

> On those platforms, we have to assume the user might plug/unplug devices,
> that the power supply might shut down while we're sleeping, that the entire
> process is not painless and has a reasonable chance of misbehaving (crashes
> on sleep/resume are _really_ common), etc.

The fact is that sys_sync() in the kernel suspend to mem path is too expensive
for devices which suspend/resume quickly, routinely, and reliably.

The reality that somebody can stick a broken device into their desktop
or laptop and break suspend doesn't change that.

> What is the safe and proper thing to do in that situation is not necessarily
> the best way to go about it when you actually want a somewhat different
> behavior, i.e. to "prepare the system to stay on a powered down state for a
> short while, and be very fast because this could happen at a very high
> frequency"...
>
> IMO, we would actually benefit from *adding* new system-wide sleep/suspend
> modes that are optimized for oportunistic, short-lived system-wide sleep
> cycles (aka "catnap") that is fast to enter and exit from, and which will be
> triggered very frequently, instead of trying to change the assumptions and
> expected behavior of the current "deep-sleep" mode...

Thank you for sharing your opinion.

I am going to give up trying to change your mind, and those who share
your view.  I plan to revive my patch from 2014 which
makes sys_sync() optional.  That will not change the historic behavior,
and will still allow everybody to do what they want.
Rafael has said that he can live with the resulting kernel clutter.

BTW. the answer does not appear to be creating a new system sleep state.
Android invokes "mem", and they don't seem excited about teaching user-space
that runs on multiple platforms that  what used to be a "mem" and no "freeze"
could be a "mem" plus a "freeze", or a "freeze" and no "mem".

They just want the kernel to give them a "mem" that is fast and reliable;
and they are willing to build the kernel in a way that gives them what
they want.

cheers,
Len Brown, Intel Open Source Technology Center
