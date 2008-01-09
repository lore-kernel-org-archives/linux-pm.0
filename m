From: David Brownell <david-b@pacbell.net>
Subject: Re: USB D3 vs system S3
Date: Wed, 9 Jan 2008 13:03:23 -0800
Message-ID: <200801091303.23426.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0801091213250.2880-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0801091213250.2880-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <lenb@kernel.org>, gregkh@suse.de, linux-acpi@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday 09 January 2008, Alan Stern wrote:
>=20
> > > The USB autosuspend code affects only the controller's USB interf=
ace --
> > > it doesn't touch the PCI side. =A0An autosuspended controller wil=
l remain
> > > in D0. =A0Until somebody tries writing autosuspend code for PCI
> > > devices...
> >=20
> > Is this likely to happen?
>=20
> I don't know of anybody working on it. =A0A minimal prerequisite is t=
hat=20
> PCI runtime wakeup processing needs to work right -- which it doesn't=
=2E =A0
> See=20
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0http://bugzilla.kernel.org/show_bug.cgi?id=3D=
6892

And while most of the non-PCI USB host platforms to which I have access
don't have that type of issue, their hardware isn't actually set up to
offer an analogue of runtime PCI_D3 (for example) power states.

In more detail:  they generally have some clocks that could be disabled=
,
but for various reasons they need to be left running.  Disabling those
clocks prevents wakeup from working ... yes, a multi-MHz clock just to
detect the D+ (or D-) pullup as it kicks in.  Systems using an external
PHY will sometimes offer an alternative, when the PHY can issue those
wakeup IRQs by itself, but that seems oddly uncommon.

- Dave

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
