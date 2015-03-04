From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] genirq: describe IRQF_COND_SUSPEND
Date: Wed, 04 Mar 2015 23:27:37 +0100
Message-ID: <6591581.ooCMyGoxxx@wuerfel>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com> <20150304200040.GA12126@leverpostej> <20150304221729.GI3989@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:57514 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbbCDWax (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2015 17:30:53 -0500
In-Reply-To: <20150304221729.GI3989@piout.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Mark Rutland <mark.rutland@arm.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Wednesday 04 March 2015 23:17:29 Alexandre Belloni wrote:
> On 04/03/2015 at 20:00:40 +0000, Mark Rutland wrote :
> > With certain restrictions it is possible for a wakeup device to share
> > and IRQ with an IRQF_NO_SUSPEND user, and the warnings introduced by
>   ^ an
> 
> 
> > +In rare cases an IRQ can be shared between a wakeup device driver and an
> > +IRQF_NO_SUSPEND user. In order for this to be safe, the wakeup device driver
> > +must be able to discern spurious IRQs from genuine wakeup events (signalling
> 
> And genuine question, should we use British English or American English
> or we don't care ?

I believe most developers use Incorrect English, the second most common
is American English, followed by Indian English and British English. ;-)

More seriously, just try to be consistent within one file or subsystem.

	Arnd
