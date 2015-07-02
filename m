From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Wed, 1 Jul 2015 23:07:29 -0400
Message-ID: <CAJvTdKn71W0+js3D4OwK5Tx4z5KdA8hb-FyRMTuw0rdyQj9pRw@mail.gmail.com>
References: <4290667.ZqInAykFGS@vostro.rjw.lan>
	<Pine.LNX.4.44L0.1505091556001.5397-100000@netrider.rowland.org>
	<20150509202518.GB20282@khazad-dum.debian.net>
	<CAJvTdKmGFPHtO-rOwXWJr6bPDS4PuEo+g7H-uQhuMc_+kh4CuA@mail.gmail.com>
	<20150625171158.GB27230@khazad-dum.debian.net>
	<CAJvTdKmscv8andz=T4zPjhgtqHq4+k6iB3Lm+_14eqnah=Fdcw@mail.gmail.com>
	<1435753306.1134542.312471953.3DCB0D87@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:34360 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbbGBDHb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Jul 2015 23:07:31 -0400
In-Reply-To: <1435753306.1134542.312471953.3DCB0D87@webmail.messagingengine.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

>> The _vast_ majority of systems using Linux suspend today are under
>> an Android user-space.  Android has no assumption that that suspend to
>> mem will necessarily stay suspended for a long time.
>
> Indeed, however your change was not android-specific, and it is not
> "comfortable" on x86-style hardware and usage patterns.

"comfortable on x86-style and usage patterns"?
If you mean "traditional" instead of "comfortable",
where "tradition" is based on 10-year old systems, then sure.

But today, my x86 Android tablet is quite "comfortable"
without a sys_sync() in the kernel suspend path.

No, this isn't Android specific, Android is just the highest-volume demand,
making it an obvious example.

Chrome is the #1 selling "x86-style" clamshell laptop.
Chrome is not only "comfortable" with fast suspend/resume,
the Chrome developers demand it.

> That said, as long as x86 will still try to safeguard my data during mem
> sleep/resume as it does today, I have no strong feelings about
> light/heavy-weight "mem" sleep being strictly a compile-time selectable
> thing, or a more flexible runtime-selectable behavior.

The observation here is that the kernel should not force every system
to sys_sync() on every suspend.  The only question is how to best
implement that.  The obvious solution was to delete this forced policy
from the kernel, and let user-space handle it.
Rafael has not agreed to push that obvious, though less-than-gentle
solution upstream, and so I'll re-send the historic patch
that allows distros to still sync like it is 1999, if they want to:-)

thanks,
Len Brown, Intel Open Source Technology Center
