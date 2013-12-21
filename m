From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC PATCH v5 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Sat, 21 Dec 2013 17:26:45 +0100
Message-ID: <20131221162645.GE20115@lunn.ch>
References: <20131204145413.GD29200@e106331-lin.cambridge.arm.com>
 <1387316473-3250-1-git-send-email-andrew@lunn.ch>
 <1387316473-3250-2-git-send-email-andrew@lunn.ch>
 <20131220033257.GF2609@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:37010 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755283Ab3LUQ13 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 21 Dec 2013 11:27:29 -0500
Content-Disposition: inline
In-Reply-To: <20131220033257.GF2609@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>, mark.rutland@arm.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>

> > +Dove cpufreq driver
> > +-------------------
> > +
> > +The Dove cpufreq driver makes use of the pmu node in the device tree.
> 
> I would prefer to reword this to make it OS-agnostic.  The cpufreq
> driver is Linux-specific.

Hi Jason

Why is it Linux specific? Why for example would the FreeBSD cpu freq
driver not be able to use this?

> > +
> > +Required properties:
> > +- compatibility: Must be "marvell,dove-pmu"
> > +- interrupts:	 Interrupt to know the completion of cpu frequency change.
> > +- clocks:	 phandles and clock specifiers pairs for CPU and DDR clock
> > +- clock-names: 	 "cpu" and "ddr"
> > +- reg: 		 Address ranges of the PMU. Two ranges are expected.
> 
> Shall we define the two ranges?

Yes, i will extend this, once Mark agrees to the basic idea.

Thanks
	Andrew
