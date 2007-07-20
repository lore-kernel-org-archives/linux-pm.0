From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation considerations
Date: Fri, 20 Jul 2007 12:59:42 +0200
Message-ID: <200707201259.44181.rjw__30684.9545370371$1184928971$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707181021300.3759-100000@iolanthe.rowland.org>
	<200707181647.32620.rjw@sisk.pl>
	<200707200740.38158.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707200740.38158.a1426z@gawab.com>
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
To: Al Boldi <a1426z@gawab.com>
Cc: david@lang.hm, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Friday, 20 July 2007 06:40, Al Boldi wrote:
> Rafael J. Wysocki wrote:
> > On Wednesday, 18 July 2007 16:29, Alan Stern wrote:
> > >
> > > Never mind.  It seems clear that this approach will suffer the same
> > > drawback as the proposal for removing the freezer from the
> > > suspend-to-RAM pathway.  Namely, device drivers will have to be changed
> > > to prevent user I/O requests from proceeding while devices are supposed
> > > to be quiescent or in a low-power state.
> >
> > I agree.
> >
> > > If a driver fails to handle this properly, its device could be
> > > reactivated in order to service a user request before the memory
> > > snapshot is made.  This could easily ruin the snapshot.
> >
> > That's why I've been saying for quite some time that we first need to take
> > care of the drivers. :-)
> >
> > IMO we've reached the point at which, whatever we want to do next, the
> > drivers are in the way.
> 
> Correct, but only if we want ACPI support.

No, in general.

> Granted, we need a separation of  
> the hibernate/suspend PM functions, but in the absence of ACPI, all we need 
> right now are dump/restore routines for the crashkernel.

IMO you aren't right, but I guess there's no point in trying to convince you.

> Next, we should be looking into reducing the kexec'd kernel environment size, 
> which currently, at 16MB, is way too big, and even at 1MB would be 
> problematic for small systems.
> 
> So, ACPI should really be the least of our worries, and the reason why people 
> are fixating on ACPI is probably because they have nothing else to fixate 
> on.

Yeah, right.  Please read the $subject message again.  And sorry, but IMO your
previous replies to it haven't addressed any of the original points.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
