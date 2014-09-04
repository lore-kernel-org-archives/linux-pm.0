From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] PM / sleep: add configurable delay for pm_test
Date: Thu, 4 Sep 2014 10:54:50 -0700
Message-ID: <20140904175450.GB18411@ld-irv-0074>
References: <1409788535-28264-1-git-send-email-computersforpeace@gmail.com>
 <20140904071412.GA29832@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:64911 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbaIDRy5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 13:54:57 -0400
Content-Disposition: inline
In-Reply-To: <20140904071412.GA29832@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki\"" <rjw@rjwysocki.net>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>

On Thu, Sep 04, 2014 at 09:14:12AM +0200, Pavel Machek wrote:
> > When CONFIG_PM_DEBUG=y, we provide a sysfs file (/sys/power/pm_test) for
> > selecting one of a few suspend test modes, where rather than entering a
> > full suspend state, the kernel will perform some subset of suspend
> > steps, wait 5 seconds, and then resume back to normal operation.
> > 
> > This mode is useful for (among other things) observing the state of the
> > system just before entering a sleep mode, for debugging or analysis
> > purposes. However, a constant 5 second wait is not sufficient for some
> > sorts of analysis; for example, on an SoC, one might want to use
> > external tools to probe the power states of various on-chip controllers
> > or clocks.
> 
> When you are doing this kind of analysis, perhaps directly modifying
> kernel source is the way to go ...?

That's what I've been doing for now, but I have a few engineers who need
to do this sort of testing and aren't kernel developers. I could
continue to maintain my own patch for this, but I just thought I'd see
what others thought.

Is there a good reason this can't be in mainline? These features are
hidden behind a Kconfig symbol called PM_DEBUG anyway, and I think this
classifies as a pretty simple extension to the limited existing PM
debugging options.

Regards,
Brian
