From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/4] PM: Drop shrink_all_memory (rev. 2)
	(was: Re: [PATCH 3/3] PM/Hibernate: Use memory allocations to
	free memory)
Date: Sun, 3 May 2009 18:30:48 +0200
Message-ID: <200905031830.49690.rjw__27025.8297598504$1241368368$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905030220.57933.rjw@sisk.pl>
	<20090503130818.GC9661@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090503130818.GC9661@localhost>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, Andrew Morton <akpm@linux-foundation.org>, kernel-testers@vger.kernel.org, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 03 May 2009, Wu Fengguang wrote:
> 
> Hi Rafael,

Hi,

> I happened to be doing some benchmarks on the older shrink_all_memory(),
> Hopefully it can be a useful reference point for the new design.
> 
> The current swsusp_shrink_memory()/shrink_all_memory() are terribly
> inefficient: it takes 7-9s to free up 1.4G memory:

One reason may be that it takes too many steps to do it,

> [  131.899389] PM: Freed 1413380 kbytes in 7.03 seconds (201.04 MB/s)
> [  732.757916] PM: Freed 1490116 kbytes in 9.37 seconds (159.03 MB/s)

because the new way doesn't seem to do any better.

> Below are the logs I collected by injecting printks. There are
> basically two major problems:
> - swsusp_shrink_memory() scans the whole 2G memory again and again;
> - shrink_all_memory() is slow. It won't reclaim pages at all with
>   small priority values, because it's batching size is 10000 pages.

I know that swsusp_shrink_memory() has problems, that's why I'd like to get rid
of it.

> I wonder if it's possible to free up the memory within 1s at all.

I'm not sure.

Apparently, the counting of saveable pages takes substantial time (0.5 s each
iteration on my 64-bit test box), so we can improve that by limiting the number
of iterations.

Well, perhaps we can do it all in one shot after all, I'll think how to do that.

Thanks,
Rafael
