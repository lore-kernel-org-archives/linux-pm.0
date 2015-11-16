From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 11/11] arm64: kernel: Add support for
 hibernate/suspend-to-disk.
Date: Mon, 16 Nov 2015 13:41:16 +0100
Message-ID: <20151116124116.GC9125@amd>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
 <1445966960-31724-12-git-send-email-james.morse@arm.com>
 <20151114213415.GG20429@amd>
 <5649CC40.9010805@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56147 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbbKPMlT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 07:41:19 -0500
Content-Disposition: inline
In-Reply-To: <5649CC40.9010805@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

Hi!

> On 14/11/15 21:34, Pavel Machek wrote:
> >> The implementation assumes that exactly the same kernel is booted on the
> >> same hardware, and that the kernel is loaded at the same physical address.
> > 
> > BTW... on newer implementations (and I have patch for x86, too), we
> > try to make it so that resume kernel does not have to be same as
> > suspend one. It would be nice to move there with arm64, too. 
> 
> Yes, that is a neat trick, can I leave it as future work?

Yes. But it is really not hard.

> >> + * Because this code has to be copied to a safe_page, it can't call out to
> >> + * other functions by pc-relative address. Also remember that it
> > 
> > PC-relative?
> 
> The linker may (often!) use program-counter relative addresses for loads
> and stores. This code gets copied, so the linker doesn't know where the
> code will be executed from, so any instructions using pc-relative addresses
> will get the wrong result, (if they reference something outside the
> function).

I was wondering if it should be spelled "PC-relative", not
"pc-relative" :-).

> >> + * and executable pages mapped to user space are also written as data, we
> >> + * clean all pages we touch to the PoU.
> > 
> > What is PoC and PoU?
> 
> They are points in the CPU's cache hierarchy:
> 
> ARM processors are of a 'modified Harvard' architecture, their paths to
> read instructions and data are different. The 'Point of Unification' is the
> first point in the cache hierarchy that is the same for both. On ARM,
> flush_icache_range() makes sure code written as data is pushed through any
> data caches to this point, and then evicts any stale copies in the
> instruction caches.
> 
> PoC is the 'Point of Coherency', it is the first point that is the same for
> all devices, (e.g. a cpu with caches turned on, and one with them off), it
> is normally main memory. The kernel text has to be pushed to this point, so
> that secondary cores, while running early-boot code with their MMU and
> caches turned off, don't get incorrect code/data from before resume.
> 
> I have resisted the urge to draw some ascii-art!

That's ok, you just might want to replace PoI -> 'Point of
Unification' and PoC -> 'Point of Coherency' in the comments. That
should make googling easier for people not familiar with arm
terminology.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
