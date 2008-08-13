From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Power management for SCSI
Date: Wed, 13 Aug 2008 15:34:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808131525530.13982-100000@iolanthe.rowland.org>
References: <200808131821.30564.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756810AbYHMTem@vger.kernel.org>
In-Reply-To: <200808131821.30564.oneukum@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@suse.cz>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

On Wed, 13 Aug 2008, Oliver Neukum wrote:

> Am Mittwoch 13 August 2008 17:44:46 schrieb Alan Stern:
> > > All children that are USB must be powered down. We know in fact t=
hat most
> > > drives don't care that the device is suspended. The problem was d=
rive
> > > enclosures that cut power upon suspension losing cached data.
> >=20
> > You misunderstood my question. =A0Are there SCSI transports other t=
han
> > USB sharing the requirement that all child devices must be suspende=
d
> > before the link can be powered down?
>=20
> I dispute that USB in general has this property.

How can you dispute that?  You said it yourself, in the top quote
above: "All children that are USB must be powered down."

> Some storage devices
> need their caches flushed. USB itself is perfectly happy with autosus=
pending
> the storage device (host) without telling the disks (devices)
>=20
> You could even argue that these storage devices violate the USB spec.

Oliver, you can't have it both ways.  Either we do spin down disks and
drain device caches before autosuspending usb-storage or we don't. =20
=46or safety's sake, obviously we should.  The overhead is minimal sinc=
e
this happens only after the idle timeout has expired.  And for devices
that don't support it (like flash storage), sd skips the spin-down
command anway.

At any rate, Stefan Richter has answered my original question. =20
=46irewire has essentially the same restrictions as USB.

Alan Stern
