From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 09/10] PM / Hibernate: Publish pages restored in-place
 to arch code
Date: Sat, 5 Dec 2015 10:35:34 +0100
Message-ID: <20151205093534.GA7569@amd>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
 <1448559168-8363-10-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45134 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbbLEJfh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 5 Dec 2015 04:35:37 -0500
Content-Disposition: inline
In-Reply-To: <1448559168-8363-10-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>

On Thu 2015-11-26 17:32:47, James Morse wrote:
> Some architectures require code written to memory as if it were data to be
> 'cleaned' from any data caches before the processor can fetch them as new
> instructions.
> 
> During resume from hibernate, the snapshot code copies some pages directly,
> meaning these architectures do not get a chance to perform their cache
> maintenance. Create a new list of pages that were restored in place, so
> that the arch code can perform this maintenance when necessary.

Umm. Could the copy function be modified to do the neccessary
flushing, instead?

Alternatively, can you just clean the whole cache before jumping to
the new kernel?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
