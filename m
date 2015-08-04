From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Tue, 4 Aug 2015 21:54:47 +0200
Message-ID: <20150804195447.GA28564@amd>
References: <4290667.ZqInAykFGS@vostro.rjw.lan>
 <1850836.6zSgANe26P@vostro.rjw.lan>
 <1436427171.2530.5.camel@suse.com>
 <5271193.sYRdkO0AkU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52405 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294AbbHDTyu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 15:54:50 -0400
Content-Disposition: inline
In-Reply-To: <5271193.sYRdkO0AkU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Oliver Neukum <oneukum@suse.com>, Dave Chinner <david@fromorbit.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Alan Stern <stern@rowland.harvard.edu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Fri 2015-07-10 01:22:55, Rafael J. Wysocki wrote:
> On Thursday, July 09, 2015 09:32:51 AM Oliver Neukum wrote:
> > On Thu, 2015-07-09 at 00:03 +0200, Rafael J. Wysocki wrote:
> > 
> > > Nothing and I'm not discussing that (I've said that already at least once in
> > > this thread).
> > > 
> > > What I'm questioning is the "why" of calling sys_sync() from the kernel.
> > 
> > That's strictly speaking two questions
> > 
> > 1. Why do it in the kernel
> > 
> > That is easy. It closes the window of a race condition.
> > 
> > 2. Why do it at all
> > 
> > In essence because the system becomes inactive. For example we say that
> > data hits the disk after 30s maximum. We cannot meet such a limit unless
> > we sync.
> 
> Absolute deadlines are not guaranteed to be met at all in general when
> system suspend is used, at least from the user space perspective, so the
> above is quite a bit of an overstretch.

Well, this particular deadline _was_ guaranteed before Len's patch,
and it is useful one, too:

"if notebook is not on, it is ok to pull the USB stick".

									Pavel
									-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
