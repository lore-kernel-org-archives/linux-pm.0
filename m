From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Fwd: Re: [Suspend-devel] s2both on powerpc
Date: Fri, 6 Apr 2007 01:32:18 +0200
Message-ID: <200704060132.18897.rjw@sisk.pl>
References: <200704011837.16014.rjw@sisk.pl>
	<200704051438.50653.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704051438.50653.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: =?iso-8859-1?q?C=E9dric_Boutillier?= <cedric.boutillier@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Thursday, 5 April 2007 23:38, David Brownell wrote:
> On Sunday 01 April 2007 9:37 am, Rafael J. Wysocki wrote:
> > Alan, Dave, could you please have a look at this?
> > =

> > Rafael
> > =

> > =

> > ----------  Forwarded Message  ----------
> > =

> > Subject: Re: [Suspend-devel] s2both on powerpc
> > Date: Sunday, 1 April 2007 18:18
> > From: "C=E9dric Boutillier" <cedric.boutillier@gmail.com>
> > To: "Johannes Berg" <johannes@sipsolutions.net>
> > Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Tim Dijkstra" <newsuser@famdijk=
stra.org>,
> >	 suspend-devel@lists.sourceforge.net =

> > =

> > Hi !
> > On 4/1/07, Johannes Berg <johannes@sipsolutions.net> wrote:
> > > Have you gotten it to resume?
> > > I'd test s2both but I haven't gotten s2disk to resume yet... Need to
> > > test that patch.
> > =

> > Yes it resumes, but I am stuck at some point because after the image
> > is reloaded from swap, the system freezes when (usb) modules are
> > reloaded.
> =

> Which module?  I'm guessing just ehci-hcd, but you should try each
> of the relevant HCDs by themselves.  (And if you have any external
> USB devices connected, their drivers ... and also see whether the
> connection of the external device is itself a factor.)
> =

> There's something platform-specific going on, and some clues will
> be needed to sort it out.
> =

> All this used to work, as I recall...

This has already been handled by Alan (identified as a hardware bug, patch
is available).

Thanks,
Rafael
