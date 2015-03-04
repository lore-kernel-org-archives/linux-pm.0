From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] genirq: describe IRQF_COND_SUSPEND
Date: Wed, 4 Mar 2015 23:17:29 +0100
Message-ID: <20150304221729.GI3989@piout.net>
References: <1424771762-16343-1-git-send-email-boris.brezillon@free-electrons.com>
 <8151717.nkhnGBri9h@vostro.rjw.lan>
 <20150226191724.0ae4ca4e@bbrezillon>
 <6864616.1aRDSmSsvx@vostro.rjw.lan>
 <20150304194246.GF22156@leverpostej>
 <20150304200040.GA12126@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:51856 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752382AbbCDWRg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2015 17:17:36 -0500
Content-Disposition: inline
In-Reply-To: <20150304200040.GA12126@leverpostej>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Boris Brezillon <boris.brezillon@free-electrons.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>

tiny tiny nitpick:

On 04/03/2015 at 20:00:40 +0000, Mark Rutland wrote :
> With certain restrictions it is possible for a wakeup device to share
> and IRQ with an IRQF_NO_SUSPEND user, and the warnings introduced by
  ^ an


> +In rare cases an IRQ can be shared between a wakeup device driver and an
> +IRQF_NO_SUSPEND user. In order for this to be safe, the wakeup device driver
> +must be able to discern spurious IRQs from genuine wakeup events (signalling

And genuine question, should we use British English or American English
or we don't care ?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
