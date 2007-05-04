From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 4 May 2007 22:27:57 +0200
Message-ID: <200705042227.58840.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705041040540.3417-100000@iolanthe.rowland.org>
	<1178290577.7408.21.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1178290577.7408.21.camel@johannes.berg>
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
To: linux-pm@lists.linux-foundation.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday, 4 May 2007 16:56, Johannes Berg wrote:
> On Fri, 2007-05-04 at 10:51 -0400, Alan Stern wrote:
> 
> > Exactly because we are waffling on this issue.  If we settled the matter 
> > once and for all (devices must ALWAYS be reinitialized after the snapshot 
> > is restored) then we wouldn't have those problems.  (We might have other 
> > problems though...)
> 
> From what I've understood so far, ACPI is very unhappy on some machines
> if you go to S5 after hiberation. I still don't understand why, if the
> ACPI code would properly re-initialise itself (treat ACPI as a device
> and apply your "devices must ALWAYS be reinitialized after the snapshot
> is restored") then this shouldn't be possible to happen.

I agree, and that's why I suspect that the ACPI driver's .resume() routines
make some, well, ACPIish assumptions about the resume from hibernation, which
is the source of the problem.  If we separate the hibernation code from the
suspend (s2ram, standby) code completely, this issue will have to be resolved
somehow.

> And at that point I agree that the issue becomes completely orthogonal.
> 
> (btw, it's always possible right now to go to S5 instead of S4 when
> doing hibernation simply by changing /sys/power/disk to "shutdown")

That's correct.

Greetings,
Rafael
