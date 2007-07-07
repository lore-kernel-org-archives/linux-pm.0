From: Pavel Machek <pavel@ucw.cz>
Subject: problem 1 (was Re: removing refrigerator does not help with s2ram vs.
	fuse deadlocks (was Re: Re: [PATCH] Remove process
	freezer from suspend to RAM pathway))
Date: Sat, 7 Jul 2007 14:08:27 +0200
Message-ID: <20070707120827.GA3111__46267.0515677475$1183810243$gmane$org@elf.ucw.cz>
References: <18059.6726.218205.104212@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44L0.0707041104140.25704-100000@netrider.rowland.org>
	<18060.15591.556676.28935@cargo.ozlabs.ibm.com>
	<20070705091526.GA3084@elf.ucw.cz>
	<20070705135758.GB22177@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070705135758.GB22177@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Now, if kernel needs FUSE services for some reason (that's the problem
> > we hit in s2ram case, right?), we have a deadlock.
> > 
> > So main problem still seems to be "kernel should not depend on
> > userland services during suspend", refrigerator or not.
> 
> And also "Userland should not depend on userland services", which is 
> rather more of a problem.

No, that's not a problem. Or rather, that's different problem, called
"problem 2" (fuse causes freezer to fail to stop processes).

But we still have "problem 1" here: after devices are suspended,
kernel tries to use fuse's services. That is not going to work, one
way or another, because devices are suspended and userland can't work
reliably.

(Aha, it _may_ be it is kernel tries to use fuse's services after
freezing userland but before freezing devices. I don't think it is).

To solve "problem 1", we need to know which part of kernel asks for
fuse services. sysrq-t trace is likely to tell us. Can someone repeat
the "problem 1" scenario (freezer succeeds but then it deadlocks), and
produce sysrq-t trace? That way we can solve "problem 1".
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
