From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] genirq: describe IRQF_COND_SUSPEND
Date: Fri, 06 Mar 2015 01:54:39 +0100
Message-ID: <33158689.4nZBVOb2gz@vostro.rjw.lan>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com> <20150304221729.GI3989@piout.net> <20150305110411.GC13617@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150305110411.GC13617@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, March 05, 2015 11:04:11 AM Mark Rutland wrote:
> On Wed, Mar 04, 2015 at 10:17:29PM +0000, Alexandre Belloni wrote:
> > tiny tiny nitpick:
> > 
> > On 04/03/2015 at 20:00:40 +0000, Mark Rutland wrote :
> > > With certain restrictions it is possible for a wakeup device to share
> > > and IRQ with an IRQF_NO_SUSPEND user, and the warnings introduced by
> >   ^ an
> 
> Whoops.
> 
> Rafael, are you happy to fix that up, or would you like me to resend?

Fixed, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
