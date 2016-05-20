From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Should 9aafabc7fece be reverted?
Date: Fri, 20 May 2016 11:29:27 +0200
Message-ID: <20160520092927.GB4580@amd>
References: <573C9F45.5090109@ti.com>
 <201605191806.50809@pali>
 <573DE5A2.7070900@ti.com>
 <201605191818.20237@pali>
 <573DEDFF.8060305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53929 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbcETJ3a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 05:29:30 -0400
Content-Disposition: inline
In-Reply-To: <573DEDFF.8060305@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

Hi!

> >>>>> No, it is not driver name, but device name. That is different.
> >>>>
> >>>> My bad, that's what I meant, device names should be dynamic,
> >>>> right? Relying on them being static in software would then be
> >>>> buggy (like relying on eth0 being the right NIC everytime)?
> >>>>
> >>>> I'm not familiar with the N900 software, but IDR can give out
> >>>> different numbers and may not always give the first battery #0 (it
> >>>> does now but is that a guarantee in IDR?) and if not then what is
> >>>> the userspace response to this changing?
> >>>
> >>> In case N900 would have more bq27xxx batteries, then yes. But N900
> >>> has exactly *one* bq27200 battery, so there is no IDR problem.
> >>
> >> Right, but if IDR returns 42 instead of 0 would this then break its
> >> userspace software?
> > 
> > I think it is insane to starts generating random numbers for IDR... Hard 
> > to decide what happen if such situation occur...
> > 
> 
> That's kind of what I'm looking for though, if the userspace break is
> caused by software relying on the battery to be named "bq27200-0", then
> nothing short of hard-coding this exact name will 100% safely fix the
> N900 userspace software. And so using IDR and hoping it gives 0 is just
> a hacky work-around way of just naming the device "bq27200-0".

N900 userspace is not intended to be portable. (And actually current
kernel support does not allow writing portable userspace for a
phone. It presents _3_ power supplies to userspace. How is userspace
expected to deal with that?) 

And if you ever name the single battery bq27200-42 or bq27200-1337,
you'll have a flock of angry penguins at your doorstep.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
