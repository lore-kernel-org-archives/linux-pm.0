From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Wed, 01 Jul 2015 09:21:46 -0300
Message-ID: <1435753306.1134542.312471953.3DCB0D87@webmail.messagingengine.com>
References: <4290667.ZqInAykFGS@vostro.rjw.lan>
 <Pine.LNX.4.44L0.1505091556001.5397-100000@netrider.rowland.org>
 <20150509202518.GB20282@khazad-dum.debian.net>
 <CAJvTdKmGFPHtO-rOwXWJr6bPDS4PuEo+g7H-uQhuMc_+kh4CuA@mail.gmail.com>
 <20150625171158.GB27230@khazad-dum.debian.net>
 <CAJvTdKmscv8andz=T4zPjhgtqHq4+k6iB3Lm+_14eqnah=Fdcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52703 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752797AbbGAMVs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2015 08:21:48 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 8EAF420D35
	for <linux-pm@vger.kernel.org>; Wed,  1 Jul 2015 08:21:47 -0400 (EDT)
In-Reply-To: <CAJvTdKmscv8andz=T4zPjhgtqHq4+k6iB3Lm+_14eqnah=Fdcw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Tue, Jun 30, 2015, at 17:04, Len Brown wrote:
> > Entering "mem" suspend mode through sysfs currently has the implied meaning
> > of "prepare the *entire* system to stay on a powered down state for
> > pontentially a _long_ time", where long means "certainly more than 10
> > seconds" ;-) This is unlikely to be written anywhere, of course, that's just
> > how it was used by the vast majority for years, at least on traditional
> > server/desktop/laptop platforms such as x86.
> 
> The _vast_ majority of systems using Linux suspend today are under
> an Android user-space.  Android has no assumption that that suspend to
> mem will necessarily stay suspended for a long time.

Indeed, however your change was not android-specific, and it is not
"comfortable" on x86-style hardware and usage patterns.

> > IMO, we would actually benefit from *adding* new system-wide sleep/suspend
> > modes that are optimized for oportunistic, short-lived system-wide sleep
> > cycles (aka "catnap") that is fast to enter and exit from, and which will be
> > triggered very frequently, instead of trying to change the assumptions and
> > expected behavior of the current "deep-sleep" mode...
> 
> Thank you for sharing your opinion.
> 
> I am going to give up trying to change your mind, and those who share
> your view.  I plan to revive my patch from 2014 which
> makes sys_sync() optional.  That will not change the historic behavior,
> and will still allow everybody to do what they want.
> Rafael has said that he can live with the resulting kernel clutter.

...

> BTW. the answer does not appear to be creating a new system sleep state.
> Android invokes "mem", and they don't seem excited about teaching
> user-space that runs on multiple platforms that  what used to be a "mem" and no
> "freeze" could be a "mem" plus a "freeze", or a "freeze" and no "mem".

Hmm, maybe we could:

1. Make the behavior of "mem" configurable (select default at compile
time, allow it to be changed at runtime).

2. Add a way to always enter the "heavyweight" (x86-style) mem sleep in
platforms where it exists.

3. Add a way to always enter the "light" (android-style) mem sleep in
platforms where it exists.

And make (2) and (3) optional (as in: you can compile out the clutter). 
That at least provides a way forward for userspace, at the price of more
gunk on the kernel side.

We already have a lot of stuff that works that way (idle and freq
governors, io elevators, etc).

That said, as long as x86 will still try to safeguard my data during mem
sleep/resume as it does today, I have no strong feelings about
light/heavy-weight "mem" sleep being strictly a compile-time selectable
thing, or a more flexible runtime-selectable behavior.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
