From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 11/11] arm64: kernel: Add support for
 hibernate/suspend-to-disk.
Date: Sat, 14 Nov 2015 22:34:16 +0100
Message-ID: <20151114213415.GG20429@amd>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
 <1445966960-31724-12-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36471 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbbKNVeS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 14 Nov 2015 16:34:18 -0500
Content-Disposition: inline
In-Reply-To: <1445966960-31724-12-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

Hi!

> The implementation assumes that exactly the same kernel is booted on the
> same hardware, and that the kernel is loaded at the same physical address.

BTW... on newer implementations (and I have patch for x86, too), we
try to make it so that resume kernel does not have to be same as
suspend one. It would be nice to move there with arm64, too. 

> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> +/*
> + * Corrupt memory.
> + *

Umm. Really?

> + * Because this code has to be copied to a safe_page, it can't call out to
> + * other functions by pc-relative address. Also remember that it

PC-relative?


> + * mid-way through over-writing other functions. For this reason it contains
> + * a copy of copy_page() and code from flush_icache_range().
> + *
> + * All of memory gets written to, including code. We need to clean the kernel
> + * text to the PoC before secondary cores can be booted. Because kernel modules,

"the kernel modules" and no ","?

> + * and executable pages mapped to user space are also written as data, we
> + * clean all pages we touch to the PoU.

What is PoC and PoU?

Thanks,									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
