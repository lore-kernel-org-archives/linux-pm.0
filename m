From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Wed, 4 Jul 2007 13:25:55 +0200
Message-ID: <200707041325.55779.rjw__11619.2849855453$1183547964$gmane$org@sisk.pl>
References: <20070703211227.GA28758@srcf.ucam.org>
	<200707041242.59552.rjw@sisk.pl>
	<18059.32111.58643.97174@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <18059.32111.58643.97174@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 4 July 2007 12:58, Paul Mackerras wrote:
> Rafael J. Wysocki writes:
> 
> > Okay, so in fact you don't know.
> 
> Don't know what exactly?

How many drivers will be adversely affected by the $subject change.

> It has been a while since I had my head in the USB code.  I assume
> it's being maintained by competent people. :)

I'm not talking about USB.
 
> > And that's my point in this thread.
> 
> Well, I'd be interested in hearing from Matthew whether he has
> actually been using his patch in Ubuntu, and if so, what bug reports
> he has been receiving related to it?

Me too.

> > I won't fight for the freezer for what it's worth, but let's do things in the
> > _right_ _order_.  For example, let's make sure that by making the $subject
> > change we won't introduce (too many) regressions and fix the frameworks
> > that don't get it right.
> > 
> > Using the problems with FUSE as an argument for making this change immediately
> > doesn't seem to be right to me.
> 
> I can see your point, but I won't be moving powermac over to use the
> generic suspend path until the freezer is gone, since I am pretty
> confident that the drivers we care about behave sensibly, and I have
> seen a lot of traffic on linux-pm and lkml about problems caused by
> the freezer.

They are mostly related to kernel threads, that we've already agreed no to
freeze (except for the ones that want that, but they will be responsible for
getting everything right).  The initial patches for that are in -mm and more
will come.

> Also, no-one has yet answered my fundamental objection to the freezer,
> which is that the very kernel threads we would want to freeze are
> often the same ones that we must not freeze, namely the threads that
> issue I/O requests in order to satisfy incoming I/O requests.

See above.  We're moving away from freezing kernel threads.

> If there was an automatic way to construct the graph of dependencies
> (including data flows) between tasks, and derive an ordering for
> freezing that guarantees that all I/Os will get completed without
> deadlocks, then I could accept the freezer.  But we don't have
> anything like that.

No we don't.

Still, my position is this:

1) The freezer (in the modified form, with the freezing of kernel threads
limited to the ones that want to be frozen) is needed for hibernation.

2) The freezer is generally not needed for suspend, _but_ there are drivers
in the tree that rely on it being used.  Thus, at some point in time we can
remove the freezer from the suspend code path, _but_ no sooner than we are
sure that the majority of drivers is prepared for that.

3) In the meantime, if there are freezer-related problems, they should be
fixed rather than used as arguments for immediate removal of it, because of 2).

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
