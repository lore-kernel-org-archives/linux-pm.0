From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] genirq: describe IRQF_COND_SUSPEND
Date: Thu, 5 Mar 2015 12:07:02 +0000
Message-ID: <20150305120702.GB14093@leverpostej>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <8151717.nkhnGBri9h@vostro.rjw.lan>
 <20150226191724.0ae4ca4e@bbrezillon>
 <6864616.1aRDSmSsvx@vostro.rjw.lan>
 <20150304194246.GF22156@leverpostej>
 <20150304200040.GA12126@leverpostej>
 <20150304221729.GI3989@piout.net>
 <20150305110411.GC13617@leverpostej>
 <20150305113306.GP3989@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56890 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542AbbCEMHb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 5 Mar 2015 07:07:31 -0500
Content-Disposition: inline
In-Reply-To: <20150305113306.GP3989@piout.net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Boris Brezillon <boris.brezillon@free-electrons.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>

On Thu, Mar 05, 2015 at 11:33:06AM +0000, Alexandre Belloni wrote:
> On 05/03/2015 at 11:04:11 +0000, Mark Rutland wrote :
> > > > +In rare cases an IRQ can be shared between a wakeup device driver and an
> > > > +IRQF_NO_SUSPEND user. In order for this to be safe, the wakeup device driver
> > > > +must be able to discern spurious IRQs from genuine wakeup events (signalling
> > > 
> > > And genuine question, should we use British English or American English
> > > or we don't care ?
> > 
> > Have I written something that isn't valid American English there? I read
> > over this a few times and failed to spot anything obvious.
> > 
> > I'm happy to change for consistency, I generally assume that's the most
> > important thing.
> 
> I'd say signalling vs signaling. I actually had to look up which one was
> correct. I'm personally using Incorrect/Broken English so I'm definitely
> not here to give lessons.

Easy option to keep everyone happy: s/signalling/indicating/

That should be valid for the English variants I'm aware of, and it has
the same number of characters so we don't need to reflow the text.

Mark.
