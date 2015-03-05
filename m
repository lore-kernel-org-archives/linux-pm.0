From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] genirq: describe IRQF_COND_SUSPEND
Date: Thu, 5 Mar 2015 12:33:06 +0100
Message-ID: <20150305113306.GP3989@piout.net>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <8151717.nkhnGBri9h@vostro.rjw.lan>
 <20150226191724.0ae4ca4e@bbrezillon>
 <6864616.1aRDSmSsvx@vostro.rjw.lan>
 <20150304194246.GF22156@leverpostej>
 <20150304200040.GA12126@leverpostej>
 <20150304221729.GI3989@piout.net>
 <20150305110411.GC13617@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150305110411.GC13617@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Boris Brezillon <boris.brezillon@free-electrons.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 05/03/2015 at 11:04:11 +0000, Mark Rutland wrote :
> > > +In rare cases an IRQ can be shared between a wakeup device driver and an
> > > +IRQF_NO_SUSPEND user. In order for this to be safe, the wakeup device driver
> > > +must be able to discern spurious IRQs from genuine wakeup events (signalling
> > 
> > And genuine question, should we use British English or American English
> > or we don't care ?
> 
> Have I written something that isn't valid American English there? I read
> over this a few times and failed to spot anything obvious.
> 
> I'm happy to change for consistency, I generally assume that's the most
> important thing.

I'd say signalling vs signaling. I actually had to look up which one was
correct. I'm personally using Incorrect/Broken English so I'm definitely
not here to give lessons.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
