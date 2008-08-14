From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [linux-pm] Power management for SCSI
Date: Thu, 14 Aug 2008 08:08:26 +0200
Message-ID: <200808140808.27022.oneukum@suse.de>
References: <Pine.LNX.4.44L0.0808131525530.13982-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754389AbYHNGHl@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0808131525530.13982-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Pavel Machek <pavel@suse.cz>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

Am Mittwoch 13 August 2008 21:34:30 schrieb Alan Stern:
> On Wed, 13 Aug 2008, Oliver Neukum wrote:
>=20
> > Am Mittwoch 13 August 2008 17:44:46 schrieb Alan Stern:
> > > > All children that are USB must be powered down. We know in fact=
 that most
> > > > drives don't care that the device is suspended. The problem was=
 drive
> > > > enclosures that cut power upon suspension losing cached data.
> > >=20
> > > You misunderstood my question. =A0Are there SCSI transports other=
 than
> > > USB sharing the requirement that all child devices must be suspen=
ded
> > > before the link can be powered down?
> >=20
> > I dispute that USB in general has this property.
>=20
> How can you dispute that?  You said it yourself, in the top quote
> above: "All children that are USB must be powered down."

But the children are SCSI, not USB.

> > Some storage devices
> > need their caches flushed. USB itself is perfectly happy with autos=
uspending
> > the storage device (host) without telling the disks (devices)
> >=20
> > You could even argue that these storage devices violate the USB spe=
c.
>=20
> Oliver, you can't have it both ways.  Either we do spin down disks an=
d
> drain device caches before autosuspending usb-storage or we don't.

That is true.

> For safety's sake, obviously we should.  The overhead is minimal sinc=
e
> this happens only after the idle timeout has expired.  And for device=
s
> that don't support it (like flash storage), sd skips the spin-down
> command anway.

But you cannot make the conclusion that the ultimate children should ha=
ve
any autosuspend attributes. We can implement autosuspend in usb storage
and propagate the suspend calls down the tree without SCSI knowing abou=
t
autosuspend.

Such a system would have it drawbacks, but it'd be a lot simpler.

	Regards
		Oliver
