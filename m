From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 0/8] CPUs capacity information for heterogeneous
 systems
Date: Mon, 7 Dec 2015 13:18:43 +0000
Message-ID: <20151207131843.GP8644@n2100.arm.linux.org.uk>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <20151207120244.GE14571@e106622-lin>
 <20151207121135.GN8644@n2100.arm.linux.org.uk>
 <20151207123654.GG14571@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:59683 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046AbbLGNSw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 08:18:52 -0500
Content-Disposition: inline
In-Reply-To: <20151207123654.GG14571@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On Mon, Dec 07, 2015 at 12:36:54PM +0000, Juri Lelli wrote:
> On 07/12/15 12:11, Russell King - ARM Linux wrote:
> > It looks like the second patch doesn't yet have the backing from the DT
> > people, which prevents the remainder of the patch set progressing.  That's
> > the sticking point which needs to be resolved.
> > 
> 
> Agreed. That is exactly the point for which I was seeking more feedback.
> OTOH, 7/8 and 8/8 may potentially work without the DT bindings, as they
> simply expose a sysfs attribute. If you, and others, see value in them,
> I can easily put them at the top of the series and post a v2. Thoughts?

I've no idea, sorry.  When it comes to stuff like CPU level power
management, the hardware I have is very limited in its capabilities
(no support even for S2RAM.)  I've also never managed to get
big.LITTLE working on my platforms that should support it.

Eg, I gave up with the TC2 tile in Versatile Express.  I forget the
details, but getting it booting was exceedingly difficult, and no one
really seemed interested in helping.  So my TC2 tile is collecting
dust while the CA9x4 tile lives in the platform - which is now part of
the nightly build/boot test farm.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
