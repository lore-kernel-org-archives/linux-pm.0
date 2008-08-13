From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [linux-pm] Power management for SCSI
Date: Wed, 13 Aug 2008 18:21:29 +0200
Message-ID: <200808131821.30564.oneukum@suse.de>
References: <Pine.LNX.4.44L0.0808131138110.2151-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756476AbYHMQUl@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0808131138110.2151-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: Alan Stern <stern@rowland.harvard.edu>, James.Bottomley@hansenpartnership.com, Pavel Machek <pavel@suse.cz>, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

Am Mittwoch 13 August 2008 17:44:46 schrieb Alan Stern:
> > All children that are USB must be powered down. We know in fact tha=
t most
> > drives don't care that the device is suspended. The problem was dri=
ve
> > enclosures that cut power upon suspension losing cached data.
>=20
> You misunderstood my question. =A0Are there SCSI transports other tha=
n
> USB sharing the requirement that all child devices must be suspended
> before the link can be powered down?

I dispute that USB in general has this property. Some storage devices
need their caches flushed. USB itself is perfectly happy with autosuspe=
nding
the storage device (host) without telling the disks (devices)

You could even argue that these storage devices violate the USB spec.

	Regards
		Oliver
