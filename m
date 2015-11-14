From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 10/11] PM / Hibernate: clean cached pages on
 architectures that require it
Date: Sat, 14 Nov 2015 21:26:24 +0100
Message-ID: <20151114202623.GC20429@amd>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
 <1445966960-31724-11-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:34774 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbbKNU00 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 14 Nov 2015 15:26:26 -0500
Content-Disposition: inline
In-Reply-To: <1445966960-31724-11-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>

On Tue 2015-10-27 17:29:19, James Morse wrote:
> Some architectures require code written to memory as if it were data to be
> 'cleaned' from any data caches so that the processor can fetch them as new
> instructions.
> 
> During resume from hibernate, the snapshot code copies some pages directly,
> meaning these architectures do not get a chance to perform their cache
> maintenance. Add a call to flush_icache_range(), which is provided by
> architectures that require it, to perform the maintenance.
> 
> This mirrors the kernel's behaviour when loading kernel modules and when
> mapping executable pages to user space.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Looks reasonable.

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  kernel/power/snapshot.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 5235dd4e1e2f..139fc449ad75 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1196,9 +1197,12 @@ static unsigned int count_data_pages(void)
>  static inline void do_copy_page(long *dst, long *src)
>  {
>  	int n;
> +	unsigned long __maybe_unused start = (unsigned long)dst;

Why the "maybe unused"?

>  	for (n = PAGE_SIZE / sizeof(long); n; n--)
>  		*dst++ = *src++;
> +
> +	flush_icache_range(start, start+PAGE_SIZE);
>  }

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
