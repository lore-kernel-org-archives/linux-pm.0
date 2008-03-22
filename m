From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch 2.6.25-rc6 3/7] pci_choose_state() cleanup
	and fixes
Date: Sat, 22 Mar 2008 19:11:01 +0100
Message-ID: <200803221911.01670.rjw__32987.5687639744$1206209591$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803202053270.11234-100000@netrider.rowland.org>
	<200803211723.17685.rjw@sisk.pl>
	<200803221055.12541.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803221055.12541.david-b@pacbell.net>
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
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday, 22 of March 2008, David Brownell wrote:
> On Friday 21 March 2008, Rafael J. Wysocki wrote:
> > > =

> > > You seem to object to letting drivers offload this particular
> > > bit of work to infrastructure.
> > =

> > No, I don't. =A0I just don't think it's a good idea to change the exist=
ing and
> > widely used function for this purpose. =A0If I needed some specific fun=
ctionality
> > at the infrastructure level, I'd add a new function for that with a new
> > changelog etc. =A0Then, made drivers switch to that and remove the old =
one.
> =

> I see that a lot of drivers have at some point, not long ago,
> been converted to use this routine.  They previously just
> used PCI_D3 in all cases.
> =

> It seems to me that your objection boils down to the concern
> that those drivers may just have pushed their bug out a level,
> rather than actually fixing their bugs.

Or, the authors of the drivers looked at what the code in
pci_choose_state() actually did and used it on that basis.

> Which I can sympathize with ... but that doesn't change the
> fact that any driver in that position *still* has a bug that
> needs to be fixed.  And if that bug is highlighted by this
> patch ... well, there's still a driver bug to be fixed.

Well, IMHO, the safe way of doing thing would be to audit and possibly fix =
the
drivers first.  Otherwise, we may get regression reports and we'll have to
revert the patch anyway if we're unable to fix them in a timely manner.

> > > > =A0=A0=A0=A0[Note that with the new suspend/hibernation callbacks t=
here
> > > > won't be the pm_message_t argument to pass to pci_choose_state().]
> > >
> > > The pm_message_t will necessarily linger until all drivers have
> > > been converted and re-tested. =A0Which can't be an overnight thing.
> >
> > No, it can't. =A0Still, suppose a driver is using the new callbacks. =
=A0How is
> > it supposed to use pci_choose_state()?
> =

> Hey, you're the one providing those callbacks.  How were you
> going to answer that question *before* I posted this overdue
> bugfix patch for pci_choose_state()?

Then it was simple, because pci_choose_state() returned D0 only for PMSG_ON.

Also, I was going to provide a simplified version of it that wouldn't take
arguments and would return D3hot in case when platform_pci_choose_state()
was not defined.

Thanks,
Rafael
