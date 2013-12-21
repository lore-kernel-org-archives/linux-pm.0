From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [RFC PATCH v5 1/4] cpufreq: Add a cpufreq driver for Marvell
 Dove
Date: Sat, 21 Dec 2013 14:25:01 -0500
Message-ID: <20131221192500.GG2609@titan.lakedaemon.net>
References: <20131204145413.GD29200@e106331-lin.cambridge.arm.com>
 <1387316473-3250-1-git-send-email-andrew@lunn.ch>
 <1387316473-3250-2-git-send-email-andrew@lunn.ch>
 <20131220033257.GF2609@titan.lakedaemon.net>
 <20131221162645.GE20115@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36273 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331Ab3LUTZO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 Dec 2013 14:25:14 -0500
Content-Disposition: inline
In-Reply-To: <20131221162645.GE20115@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: mark.rutland@arm.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>

Andrew,

On Sat, Dec 21, 2013 at 05:26:45PM +0100, Andrew Lunn wrote:
> > > +Dove cpufreq driver
> > > +-------------------
> > > +
> > > +The Dove cpufreq driver makes use of the pmu node in the device tree.
> > 
> > I would prefer to reword this to make it OS-agnostic.  The cpufreq
> > driver is Linux-specific.
> 
> Why is it Linux specific? 

I'll admit I may be bike-shedding here, and I'm more seeking
opinion/clarification than mandating anything.  The above sentence,
imho, is describing how Linux/FreeBSD uses the node, not describing the
hardware.

thx,

Jason.
