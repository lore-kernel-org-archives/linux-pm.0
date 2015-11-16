From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 10/11] PM / Hibernate: clean cached pages on
 architectures that require it
Date: Mon, 16 Nov 2015 13:36:15 +0100
Message-ID: <20151116123615.GB9125@amd>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
 <1445966960-31724-11-git-send-email-james.morse@arm.com>
 <20151114202623.GC20429@amd>
 <5649CB9B.30102@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56024 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbbKPMgR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 07:36:17 -0500
Content-Disposition: inline
In-Reply-To: <5649CB9B.30102@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>

On Mon 2015-11-16 12:27:07, James Morse wrote:
> On 14/11/15 20:26, Pavel Machek wrote:
> > On Tue 2015-10-27 17:29:19, James Morse wrote:
> >> Some architectures require code written to memory as if it were data to be
> >> 'cleaned' from any data caches so that the processor can fetch them as new
> >> instructions.
> >>
> >> During resume from hibernate, the snapshot code copies some pages directly,
> >> meaning these architectures do not get a chance to perform their cache
> >> maintenance. Add a call to flush_icache_range(), which is provided by
> >> architectures that require it, to perform the maintenance.
> >>
> >> This mirrors the kernel's behaviour when loading kernel modules and when
> >> mapping executable pages to user space.
> >>
> >> Signed-off-by: James Morse <james.morse@arm.com>
> > 
> > Looks reasonable.
> > 
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> Thanks!
> 
> > 
> >> ---
> >>  kernel/power/snapshot.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> >> index 5235dd4e1e2f..139fc449ad75 100644
> >> --- a/kernel/power/snapshot.c
> >> +++ b/kernel/power/snapshot.c
> >> @@ -1196,9 +1197,12 @@ static unsigned int count_data_pages(void)
> >>  static inline void do_copy_page(long *dst, long *src)
> >>  {
> >>  	int n;
> >> +	unsigned long __maybe_unused start = (unsigned long)dst;
> > 
> > Why the "maybe unused"?
> 
> To avoid a build warning on x86_64, and any other architectures that don't
> use the arguments in their flush_icache_range() implementation.

That's wrong fix, I believe.

flush_icache_range() should use their arguments. We should not have
all the callers caring about this.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
