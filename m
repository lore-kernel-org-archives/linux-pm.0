From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Mon, 11 May 2015 16:34:32 -0400
Message-ID: <CAJvTdKmGFPHtO-rOwXWJr6bPDS4PuEo+g7H-uQhuMc_+kh4CuA@mail.gmail.com>
References: <4290667.ZqInAykFGS@vostro.rjw.lan>
	<Pine.LNX.4.44L0.1505091556001.5397-100000@netrider.rowland.org>
	<20150509202518.GB20282@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34653 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbbEKUee (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2015 16:34:34 -0400
In-Reply-To: <20150509202518.GB20282@khazad-dum.debian.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Sat, May 9, 2015 at 4:25 PM, Henrique de Moraes Holschuh
<hmh@hmh.eng.br> wrote:
> On Sat, 09 May 2015, Alan Stern wrote:
>> On Fri, 8 May 2015, Rafael J. Wysocki wrote:
>> > My current view on that is that whether or not to do a sync() before suspending
>> > ultimately is a policy decision and should belong to user space as such (modulo
>> > the autosleep situation when user space may not know when the suspend is going
>> > to happen).
>> >
>> > Moreover, user space is free to do as many sync()s before suspending as it
>> > wants to and the question here is whether or not the *kernel* should sync()
>> > in the suspend code path.
>> >
>> > Since we pretty much can demonstrate that having just one sync() in there is
>> > not sufficient in general, should we put two of them in there?  Or just
>> > remove the existing one and leave it to user space entirely?
>>
>> I don't know about the advantages of one sync over two.  But how about
>> adding a "syncs_before_suspend" (or just "syncs") sysfs attribute that
>> takes a small numeric value?  The default can be 0, and the user could
>> set it to 1 or 2 (or higher).
>
> IMO it would be much safer to both have that knob, and to set it to keep the
> current behavior as the default.  Userspace will adapt and change that knob
> to whatever is sufficient based on what it does before signaling the kernel
> to suspend.
>
> A regression in sync-before-suspend is sure to cause data loss episodes,
> after all.  And, as far as bikeshedding goes, IMHO syncs_before_suspend is
> self-explanatory, which would be a very good reason to use it instead of the
> shorter requires-you-to-know-what-it-is-about "syncs".
>

When I first thought about this, I had a similar view:
https://lkml.org/lkml/2014/1/23/45

But upon reflection, I do not believe that the kernel is adding value here,
instead it is imposing a policy, and that policy decision is sometimes
prohibitively expensive.
User-space can do this for itself (and in the case of desktop distros,
already does),
and so the kernel should butt-out.

thanks,
Len Brown, Intel Open Source Technology Center
