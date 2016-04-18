From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Mon, 18 Apr 2016 14:58:53 +0200
Message-ID: <20160418125853.GB3769@amd>
References: <87poubgnbh.fsf@intel.com>
 <20160322113012.GC26924@xo-6d-61-c0.localdomain>
 <87fuujgwsm.fsf@intel.com>
 <20160418102316.GA27936@amd>
 <877ffvgqe9.fsf@intel.com>
 <20160418103945.GA29123@amd>
 <87y48bfaye.fsf@intel.com>
 <87vb3ffap6.fsf@intel.com>
 <20160418111342.GA30694@amd>
 <87shyjf8hp.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38999 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbcDRM65 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2016 08:58:57 -0400
Content-Disposition: inline
In-Reply-To: <87shyjf8hp.fsf@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

On Mon 2016-04-18 14:42:58, Felipe Balbi wrote:
> 
> Hi,
> 
> Pavel Machek <pavel@ucw.cz> writes:
> > On Mon 2016-04-18 13:55:17, Felipe Balbi wrote:
> >> 
> >> Hi,
> >> 
> >> Felipe Balbi <balbi@kernel.org> writes:
> >> >> But cellphone user knows what he connected his charger to, and that's
> >> >> why it is useful to be able to lower the current. Even when you said
> >> >> "less is just stupid" I demonstrated it is not, at least in case when
> >> 
> >> and btw, you haven't demonstrated anything. You merely stated that it
> >> isn't without references or numbers, or any source of trustworthy
> >> information. I'm not really into 'believing'.
> >
> > You are not really into reading, either, it seems. Or into the
> > electronics. Or into physics.
> >
> > You seem to understand that charging li-ion from li-ion produces too
> > much heat. (And yes, it does, DC-DC convertors are not 100%
> > effective). Converting energy into heat is not a good idea.
> >
> > If you need numbers or references to understand basic physics, you'll
> > need to google it yourself, I'm afraid. 
> 
> still doesn't change the fact that you haven't demonstrated anything. If
> you can't be helpful and/or constructive, you may also go away and use
> whatever unsafe setup you want to use.

So you still claim that it is "stupid" to charge at anything lower
than maximum allowed current?

Even after I described the example with device running off power bank
on a train? Would you explain your reasoning?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
