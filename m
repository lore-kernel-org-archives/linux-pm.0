From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 0/9] PM: Update global suspend and
	hibernation operations framework
Date: Mon, 2 Jul 2007 16:28:25 +0200
Message-ID: <200707021628.27139.rjw__36397.1029794358$1183386359$gmane$org@sisk.pl>
References: <200706302257.17556.rjw@sisk.pl>
	<200707012128.41742.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707012128.41742.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>, Russell King <rmk@arm.linux.org.uk>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Monday, 2 July 2007 06:28, David Brownell wrote:
> On Saturday 30 June 2007, Rafael J. Wysocki wrote:
> >=20
> > The patches make the following changes:
> > * make ACPI use the new .set_target() method in 'struct pm_ops'
> > * add an ACPI helper function for the devices to determine the power =
state
> > =A0 to put the device into
> > * move the definition of 'struct pm_ops' to <include/suspend.h>
> > * change the name of 'struct pm_ops' to 'struct platform_suspend_ops'=
 and
> >   modify the names of some related functions and global variables acc=
ordingly
> > * modify 'struct platform_suspend_ops' so that .prepare() and .finish=
() don't
> >   take arguments (.enter() still takes the state argument, because so=
me
> >   platforms don't need to implement the other callbacks)
> > * make some functions normally defined in kernel/power/main.c be also=
 defined
> >   when CONFIG_PM is unset
> > * make suspend_ops be a static variable
> > * rework 'struct hibernation_ops' to add the new method analogous to
> > =A0 .set_target()
> > * rename 'struct hibernation_ops' to 'struct platform_hibernation_ops=
' (in
> >   analogy with 'struct platform_suspend_ops')
>=20
> These look like good cleanups and, in some cases, enhancements.

Thanks. :-)

Well, the patches 1/9 and 3/9-9/9 seem to be in a good shape (2/9 needs s=
ome
more work, perhaps I'll be able to do something about it later today), bu=
t I
have to wait with them for the Russell's ARM patchset to be merged.  For =
now,
I'll just include them in the hibernation and suspend patchset
(http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.22-rc7/patches/).

BTW, Russell, is there any chance that your patchest will be in -mm befor=
e
it's merged?  My patches will go through -mm anyway ...

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
