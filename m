From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Should 9aafabc7fece be reverted?
Date: Fri, 20 May 2016 11:34:32 +0200
Message-ID: <20160520093432.GC4580@amd>
References: <573C9F45.5090109@ti.com>
 <201605191806.50809@pali>
 <573DE5A2.7070900@ti.com>
 <201605191818.20237@pali>
 <573DEDFF.8060305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54097 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932686AbcETJef (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 05:34:35 -0400
Content-Disposition: inline
In-Reply-To: <573DEDFF.8060305@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

Hi!

> > I think it is insane to starts generating random numbers for IDR... Hard 
> > to decide what happen if such situation occur...
> > 
> 
> That's kind of what I'm looking for though, if the userspace break is
> caused by software relying on the battery to be named "bq27200-0", then
> nothing short of hard-coding this exact name will 100% safely fix the
> N900 userspace software. And so using IDR and hoping it gives 0 is just
> a hacky work-around way of just naming the device "bq27200-0".

BTW proposals how to fix that userspace would be welcome.

We have three "power supplies", but userspace does not know how they
are connecting, resulting in strange results. For now, I have
hardware-specific layer in userspace.

https://gitlab.com/tui/tui/blob/master/ofone/hardware.py

Kernel does not really give me other choice.
									
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
