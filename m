From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: WARNING: SOMEONE RECEIVING THIS HAS BEEN HACKED (was: Re: [PATCH v2
 0/4] PXA cpufreq conversion to clock API)
Date: Sat, 15 Oct 2016 22:38:36 +0100
Message-ID: <20161015213836.GH1041@n2100.armlinux.org.uk>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
 <20161015203421.GG1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34236 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754235AbcJOVjX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Oct 2016 17:39:23 -0400
Content-Disposition: inline
In-Reply-To: <20161015203421.GG1041@n2100.armlinux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>

Guys,

Looks like gmail's been hacked (or something).  Within 50 minutes of
sending the reply below, I've received at least 10 replies with the
following headers:

In-Reply-To: <20161015203421.GG1041@n2100.armlinux.org.uk>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr> <20161015203421.GG1041@n2100.armlinux.org.uk>

from various gmail.com addresses, each and every one containing some kind
of spam.  Each reply is from a victim of spam - the replies themselves are
people replying to the spam that they have received.  The quoted message
is allegedly from me, and even includes the line:

 "On 15 Oct 2016, at 21:34, Russell King - ARM Linux <linux@armlinux.org.uk>
 wrote:"

which is the time I sent the original message.

It's either that gmail has been hacked, or one of the mailing lists in
the recipients of this message has been hacked.

On Sat, Oct 15, 2016 at 09:34:21PM +0100, Russell King - ARM Linux wrote:
> On Sat, Oct 15, 2016 at 09:57:26PM +0200, Robert Jarzmik wrote:
> > Hi,
> > 
> > This serie is a preparation to shift the cpufreq of pxa2xx platforms to clocks
> > API.
> > 
> > The first 3 patches are review and merge material :
> >  - patch 1/4 for Viresh and Rafael
> >  - patches 2/4 and 3/4 for me
> > 
> > The 4th on is for review but not merge, as the clock changes must be fully
> > reviewed and go in first as a prequisite
> 
> Have you tested whether this patch set results in functional cpufreq
> support - looking at drivers/clk/pxa, the CPU clock is read-only -
> it can't be used to change the clock rate.  So, I very much doubt this
> has been functionally tested.
> 
> Don't forget that changing the CPU clock rate needs other changes
> (like the memory clock rate) so all that code you're removing in
> patch 4 (which does the actual clock change) needs to go somewhere.
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
