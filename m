From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Sat, 7 Jul 2007 09:56:30 +0200
Message-ID: <20070707075630.GC2638__5882.15452521599$1183795057$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0707051014180.3728-100000@iolanthe.rowland.org>
	<1183676393.3388.89.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1183676393.3388.89.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kernel development list <linux-kernel@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > How will that help?  Block the kernel thread in the freezer or block it 
> > in the driver -- either way it is blocked.  So how do your deadlocks 
> > get resolved?
> 
> Because nobody is waiting on that kernel thread anyway without a freezer
> so there is no deadlock anymore.

In the deadlock we are seeing, _someone_ is waiting on userspace
thread, that leads to deadlock with freezer. We don't know who,
because we have not seen the sysrq-t dumps.

The "unknown who" will deadlock on fused frozen by driver, too. We
really need to fix the "unknown who" here.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
