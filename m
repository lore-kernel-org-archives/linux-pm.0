From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 10 Jul 2015 01:22:55 +0200
Message-ID: <5271193.sYRdkO0AkU@vostro.rjw.lan>
References: <4290667.ZqInAykFGS@vostro.rjw.lan> <1850836.6zSgANe26P@vostro.rjw.lan> <1436427171.2530.5.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62638 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750866AbbGIW40 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 18:56:26 -0400
In-Reply-To: <1436427171.2530.5.camel@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: Dave Chinner <david@fromorbit.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Alan Stern <stern@rowland.harvard.edu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Thursday, July 09, 2015 09:32:51 AM Oliver Neukum wrote:
> On Thu, 2015-07-09 at 00:03 +0200, Rafael J. Wysocki wrote:
> 
> > Nothing and I'm not discussing that (I've said that already at least once in
> > this thread).
> > 
> > What I'm questioning is the "why" of calling sys_sync() from the kernel.
> 
> That's strictly speaking two questions
> 
> 1. Why do it in the kernel
> 
> That is easy. It closes the window of a race condition.
> 
> 2. Why do it at all
> 
> In essence because the system becomes inactive. For example we say that
> data hits the disk after 30s maximum. We cannot meet such a limit unless
> we sync.

Absolute deadlines are not guaranteed to be met at all in general when
system suspend is used, at least from the user space perspective, so the
above is quite a bit of an overstretch.

> There are additional issues, such as a system appearing inactive during
> suspension and frankly the far greater likelihood of a crash.

I prefer the Alan's point, to be honest: it's a tradeoff between some extra
safety and some extra suspend overhead.  Unfortunately, though, we don't have
any numbers allowing us to estimate how much extra safety it provides and so
to justify it quantitatively, so to speak.

Thanks,
Rafael

