From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] PM: Disable OOM killer during
	system-wide power	transitions
Date: Sun, 3 May 2009 11:47:18 +0200
Message-ID: <20090503094718.GB10278__33077.4229173132$1241343979$gmane$org@elf.ucw.cz>
References: <nY3-4PrO6XH.A.xtB.yw85JB@chimera> <200905020027.31244.rjw@sisk.pl>
	<20090501160931.1dbd2abc.akpm@linux-foundation.org>
	<200905021334.51261.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905021334.51261.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, alan-jenkins@tuffmail.co.uk, jens.axboe@oracle.com, Andrew Morton <akpm@linux-foundation.org>, kernel-testers@vger.kernel.org, torvalds@linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


> > Does the same apply to suspending?  If so, why?
> 
> Because I think it doesn't work anyway.  User space processes are frozen and
> effectively in TASK_UNINTERRUPTIBLE, so they won't be killed.
> 
> > I think this is an OK change, as long as the only thing which is
> > allocating memory is hibernation itself.  If random processes are still
> > doing random memory allocations at this time then their failed memory
> > allocation could be just as fatal as an oom-killing.  Moreso if they're
> > s/bin/init or whatever.
> 
> At this point all of the user space tasks are frozen.

Well, many kernel threads still remain active. But it is true that OOM
killer is unlikely to help.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
