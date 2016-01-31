From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4 11/13] PM / Hibernate: Call flush_icache_range() on
 pages restored in-place
Date: Sun, 31 Jan 2016 18:25:51 +0100
Message-ID: <20160131172551.GB3721@amd>
References: <1453977766-20907-1-git-send-email-james.morse@arm.com>
 <1453977766-20907-12-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36762 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757309AbcAaR0G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jan 2016 12:26:06 -0500
Content-Disposition: inline
In-Reply-To: <1453977766-20907-12-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>

On Thu 2016-01-28 10:42:44, James Morse wrote:
> Some architectures require code written to memory as if it were data to be
> 'cleaned' from any data caches before the processor can fetch them as new
> instructions.
> 
> During resume from hibernate, the snapshot code copies some pages directly,
> meaning these architectures do not get a chance to perform their cache
> maintenance. Modify the read and decompress code to call
> flush_icache_range() on all pages that are restored, so that the restored
> in-place pages are guaranteed to be executable on these architectures.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
