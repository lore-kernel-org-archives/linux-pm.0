From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] Power management for SCSI
Date: Thu, 14 Aug 2008 15:50:21 +0200
Message-ID: <20080814135021.GE2262@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0808131138110.2151-100000@iolanthe.rowland.org> <200808131821.30564.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756047AbYHNN7M@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200808131821.30564.oneukum@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-pm@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, James.Bottomley@hansenpartnership.com, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

On Wed 2008-08-13 18:21:29, Oliver Neukum wrote:
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
> I dispute that USB in general has this property. Some storage devices
> need their caches flushed. USB itself is perfectly happy with autosus=
pending
> the storage device (host) without telling the disks (devices)
>=20
> You could even argue that these storage devices violate the USB spec.

Hmm... but suspended devices have very little power budget, right?

So unless you have external power supply (2.5" frames generally
don't), you can't really suspend and stay spinned up...

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
