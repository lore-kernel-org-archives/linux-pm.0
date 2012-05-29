From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re: [linux-pm] ehci_hcd
 related S3 lockup on ASUS laptops, again)
Date: Tue, 29 May 2012 14:50:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205291425490.1289-100000@iolanthe.rowland.org>
References: <201205291929.41060.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201205291929.41060.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Oleksij Rempel (fishor)" <bug-track@fisher-privat.net>, =?utf-8?q?D=C3=A2niel_Fraga?= <fragabr@gmail.com>, Andrey Rahmatullin <wrar@wrar.name>, Steven Rostedt <rostedt@goodmis.org>, linux-pm@lists.linux-foundation.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 29 May 2012, Rafael J. Wysocki wrote:

> On Tuesday, May 29, 2012, Alan Stern wrote:
> > On Sun, 27 May 2012, Rafael J. Wysocki wrote:
> >=20
> > > So, do you think we should apply [1/4] and [2/4] and try to work =
around the
> > > BIOS bug from https://bugzilla.kernel.org/show_bug.cgi?id=3D43278=
 (I suppose
> > > we can do that by double checking if the target state returned by=
 ACPI is
> > > in agreement with the capabilities returned by the PCI layer)?
> >=20
> > Here's one possible approach.  It only solves part of the problem, =
but
> > it ought to help with Bugzilla 43278 (D=C3=A2niel's case).  I sugge=
st that
> > we don't believe the output from _SxW if the PCI PM capability
> > indicates that PME is supported in a higher-numbered D state than _=
SxW
> > says.
> >=20
> > On D=C3=A2niel's smachine, _SxW returns D2
>=20
> No, it doesn't.  In fact, _SxW is not present for that device in his =
DSDT.

Oh -- I guess I got the machines mixed up.  Since _SxW isn't present
and _SxD is, we accept the value of _SxD as the only state in which
wakeup is supported.

ACPI apparently doesn't have any way to express: "The device is allowed=
=20
to be in either D2 or D3 during S3 sleep, but it supports wakeup only=20
in D3."  And trying to express the inexpressible, the BIOS ended up=20
being buggy.

ACPI also apparently doesn't have any way to express: "The device is=20
allowed be in D2 but not D3 during S3 sleep, even if wakeup is not=20
enabled."

> > but the controller supports PME in D3; therefore we would use D3.
>=20
> Yes, we can do that.  This goes along the lines of what I said in the=
 bug
> entry.
>=20
> > This still leaves the original problem.  It seems clear that ACPI
> > won't be sufficient to solve this -- at least, it won't help in the
> > case where the controller isn't enabled for wakeup.
> >=20
> > Therefore we really do need a quirk, probably in ehci-hcd like the=20
> > original patch.  If it is restricted to apply only in cases where t=
he=20
> > DMI information lists ASUSTeK as the manufacturer, perhaps that wil=
l be=20
> > sufficient.  (For some reason, the manufacturer field in D=C3=A2nie=
l's BIOS=20
> > isn't initialized.)
>=20
> Yeah.
>=20
> I'll have a deeper look at this later today, I think.

It's easy enough to write such a check (or perhaps more reliably, check
for a product name matching "P8Z68-V").  More difficult is knowing
whether it's the right thing to do.  We don't know the extent of the
underlying problem.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
