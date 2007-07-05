From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: removing refrigerator does not help with s2ram vs. fuse deadlocks
	(was Re: Re: [PATCH] Remove process freezer from
	suspend to RAM pathway)
Date: Thu, 5 Jul 2007 16:41:39 +0200
Message-ID: <200707051641.39998.rjw@sisk.pl>
References: <18059.6726.218205.104212@cargo.ozlabs.ibm.com>
	<200707051628.12199.rjw@sisk.pl>
	<20070705142600.GB22598@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070705142600.GB22598@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 5 July 2007 16:26, Matthew Garrett wrote:
> On Thu, Jul 05, 2007 at 04:28:11PM +0200, Rafael J. Wysocki wrote:
> > On Thursday, 5 July 2007 15:57, Matthew Garrett wrote:
> > > And also "Userland should not depend on userland services", which is 
> > > rather more of a problem.
> > 
> > I think you're oversimplifying it, as far as FUSE is concerned.
> > 
> > Namely, if there are two userland tasks, A and B, and B is uninterruptible,
> > because A is blocked, then this is not a usual situation.
> 
> Fuse is one case of it occuring, and if we end up with more userspace 
> drivers then the problem is only going to get worse.

But this is a problem by itself, regardless of the freezer etc., no?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
