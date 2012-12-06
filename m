From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Unreliable USB3 with NEC uPD720200 and Delock Cardreader
Date: Thu, 06 Dec 2012 13:43:28 +0100
Message-ID: <2672908.h2kiZqDT1O@vostro.rjw.lan>
References: <20121126191002.GE6504@xanatos> <20121206003344.GC5324@xanatos> <1354778234.7216.9.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1354778234.7216.9.camel@yhuang-dev>
Sender: linux-pci-owner@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, Ulrich Eckhardt <usb@uli-eckhardt.de>, Andrew Lutomirski <luto@mit.edu>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Ming Lei <ming.lei@canonical.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, December 06, 2012 03:17:14 PM Huang Ying wrote:
> On Wed, 2012-12-05 at 16:33 -0800, Sarah Sharp wrote:
> > On Wed, Nov 28, 2012 at 02:54:06PM -0800, Sarah Sharp wrote:
> > > On Mon, Nov 26, 2012 at 10:48:03PM +0100, Bj=C3=B8rn Mork wrote:
> > > > Sarah Sharp <sarah.a.sharp@linux.intel.com> writes:
> > > >=20
> > > > > It looks like both Ulrich and Andrew have the same issue.  I =
also have a
> > > > > Lenovo x220, and I confirmed that when I turn on PCI runtime =
suspend,
> > > > > the NEC host controller does not report port status changes w=
hen a new
> > > > > USB device is plugged in.
> > > > >
> > > > > I'm running 3.6.7, and I'm pretty sure that runtime suspend w=
orked for
> > > > > the NEC host on some older kernel.  I don't think the NEC hos=
t went into
> > > > > D3cold on that kernel, though.  Is there a way to disable D3c=
old and
> > > > > just use D3hot instead?
> > > >=20
> > > > Yes, you have /sys/bus/pci/devices/.../d3cold_allowed
> > > > See Documentation/ABI/testing/sysfs-bus-pci
> > > >=20
> > > > If this really is a problem with the D3cold support that went i=
nto 3.6
> > > > then I guess you should include Huang Ying in the discussions a=
s well
> > > > (CCed).
> > >=20
> > > Turning off D3 cold didn't help.  Once the PCI device is suspende=
d,
> > > connect events do not generate an interrupt.
> > >=20
> > > I'll go see if I can figure out which kernel this worked on and b=
isect.
> >=20
> > Wakeup from D3 works fine on the 3.5.0 kernel, but fails on 3.6.2. =
 I
> > haven't fully bisected yet.
> >=20
> > In debugging, I found that if you only enable runtime suspend for t=
he
> > NEC host controller, the host successfully comes out of D3 when you=
 plug
> > in a USB device.  However, if you enable runtime PM for the parent =
PCIe root
> > port, it stops working.  Disabling D3cold for both devices did not =
help.
> >=20
> > It looks like a PCI issue, so what sort of debugging info do you ne=
ed
> > from me?
>=20
> I do some debug with my NEC uPD720200, the patch is attached.  I foun=
d
> that NEC uPD720200 can not generate PME interrupt, so it can be remot=
e
> waken up only via polling.  But if the PCIe bridge connected to NEC
> uPD720200 goes into suspended, we can not poll it.  Maybe we need a w=
ay
> to disable PCIe bridge suspended if the underlying device can only be
> waken up via polling.

I think we need to be more intelligent about that.  It looks like we ca=
n
only suspend a port (or bridge in general) if all devices below it have
the pme_poll flag unset.

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
