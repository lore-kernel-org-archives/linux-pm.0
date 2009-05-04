From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/4] PM: Drop shrink_all_memory (rev. 2)
	(was: Re:	[PATCH 3/3] PM/Hibernate: Use memory allocations to
	free memory)
Date: Mon, 4 May 2009 11:33:10 +0200
Message-ID: <20090504093310.GC30306__35040.0987700143$1241429530$gmane$org@elf.ucw.cz>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905030220.57933.rjw@sisk.pl>
	<20090503130818.GC9661@localhost> <200905031830.49690.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905031830.49690.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: kernel-testers@vger.kernel.org, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> I know that swsusp_shrink_memory() has problems, that's why I'd like to get rid
> of it.
> 
> > I wonder if it's possible to free up the memory within 1s at all.
> 
> I'm not sure.
> 
> Apparently, the counting of saveable pages takes substantial time (0.5 s each
> iteration on my 64-bit test box), so we can improve that by limiting the number
> of iterations.

We could increase step size after each step. Free in 40MB step, then
80MB step, then 160MB step, ...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
