From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/4] PM: Drop shrink_all_memory (rev. 2)
	(was: Re: [PATCH 3/3] PM/Hibernate: Use memory allocations to
	free memory)
Date: Mon, 4 May 2009 21:53:36 +0200
Message-ID: <200905042153.37069.rjw__10108.9212731042$1241467152$gmane$org@sisk.pl>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905031830.49690.rjw@sisk.pl>
	<20090504093310.GC30306@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090504093310.GC30306@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel-testers@vger.kernel.org, linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday 04 May 2009, Pavel Machek wrote:
> Hi!
> 
> > I know that swsusp_shrink_memory() has problems, that's why I'd like to get rid
> > of it.
> > 
> > > I wonder if it's possible to free up the memory within 1s at all.
> > 
> > I'm not sure.
> > 
> > Apparently, the counting of saveable pages takes substantial time (0.5 s each
> > iteration on my 64-bit test box), so we can improve that by limiting the number
> > of iterations.
> 
> We could increase step size after each step. Free in 40MB step, then
> 80MB step, then 160MB step, ...

Why not just one step?  It doesn't seem to hurt performance AFAICS.

Thanks,
Rafael
