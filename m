From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: problem 1 (was Re: removing refrigerator does not help with s2ram
	vs. fuse deadlocks (was Re: Re: [PATCH] Remove
	process freezer from suspend to RAM pathway))
Date: Sat, 7 Jul 2007 22:55:48 +0200
Message-ID: <200707072255.48975.rjw__36167.7619549029$1183841331$gmane$org@sisk.pl>
References: <18059.6726.218205.104212@cargo.ozlabs.ibm.com>
	<20070705135758.GB22177@srcf.ucam.org>
	<20070707120827.GA3111@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070707120827.GA3111@elf.ucw.cz>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kernel development list <linux-kernel@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 7 July 2007 14:08, Pavel Machek wrote:
> Hi!
> 
> > > Now, if kernel needs FUSE services for some reason (that's the problem
> > > we hit in s2ram case, right?), we have a deadlock.
> > > 
> > > So main problem still seems to be "kernel should not depend on
> > > userland services during suspend", refrigerator or not.
> > 
> > And also "Userland should not depend on userland services", which is 
> > rather more of a problem.
> 
> No, that's not a problem. Or rather, that's different problem, called
> "problem 2" (fuse causes freezer to fail to stop processes).
> 
> But we still have "problem 1" here: after devices are suspended,
> kernel tries to use fuse's services. That is not going to work, one
> way or another, because devices are suspended and userland can't work
> reliably.
> 
> (Aha, it _may_ be it is kernel tries to use fuse's services after
> freezing userland but before freezing devices. I don't think it is).
> 
> To solve "problem 1", we need to know which part of kernel asks for
> fuse services. sysrq-t trace is likely to tell us. Can someone repeat
> the "problem 1" scenario (freezer succeeds but then it deadlocks), and
> produce sysrq-t trace? That way we can solve "problem 1".

Well, such a trace would be helpful in any case.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
