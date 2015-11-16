From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 11/11] arm64: kernel: Add support for
 hibernate/suspend-to-disk.
Date: Mon, 16 Nov 2015 14:23:10 +0000
Message-ID: <20151116142309.GI20696@leverpostej>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
 <1445966960-31724-12-git-send-email-james.morse@arm.com>
 <20151114213415.GG20429@amd>
 <5649CC40.9010805@arm.com>
 <20151116124116.GC9125@amd>
 <5649E1A0.7020001@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50149 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbbKPOXR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 16 Nov 2015 09:23:17 -0500
Content-Disposition: inline
In-Reply-To: <5649E1A0.7020001@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

> >>> What is PoC and PoU?
> >>
> >> They are points in the CPU's cache hierarchy:
> >>
> >> ARM processors are of a 'modified Harvard' architecture, their paths to
> >> read instructions and data are different. The 'Point of Unification' is the
> >> first point in the cache hierarchy that is the same for both. On ARM,
> >> flush_icache_range() makes sure code written as data is pushed through any
> >> data caches to this point, and then evicts any stale copies in the
> >> instruction caches.
> >>
> >> PoC is the 'Point of Coherency', it is the first point that is the same for
> >> all devices, (e.g. a cpu with caches turned on, and one with them off), it
> >> is normally main memory. The kernel text has to be pushed to this point, so
> >> that secondary cores, while running early-boot code with their MMU and
> >> caches turned off, don't get incorrect code/data from before resume.
> >>
> >> I have resisted the urge to draw some ascii-art!
> > 
> > That's ok, you just might want to replace PoI -> 'Point of
> > Unification' and PoC -> 'Point of Coherency' in the comments. That
> > should make googling easier for people not familiar with arm
> > terminology.
> 
> There aren't any other points under arch/arm64 that use the full expansion,
> but it can't hurt to include both.

I would prefer to keep PoC/PoU as they are for consistency.

The abbreviations are provided by the architecture, and much like
register names that we do not expand, to reason about them you need to
read the architecture documentation anyway. So the short forms alone are
fine.

Mark.
