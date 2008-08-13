From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Power management for SCSI
Date: Wed, 13 Aug 2008 11:46:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808131145160.2151-100000@iolanthe.rowland.org>
References: <200808131724.52461.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753451AbYHMPqp@vger.kernel.org>
In-Reply-To: <200808131724.52461.oneukum@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, James.Bottomley@hansenpartnership.com, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

On Wed, 13 Aug 2008, Oliver Neukum wrote:

> Am Mittwoch 13 August 2008 16:59:23 schrieb Alan Stern:
> > This is a good question. =A0Most USB mass-storage devices do not ac=
t as a
> > true SCSI bus, but I believe there are a few non-standard ones that=
 do
> > -- the USB device really contains a SCSI host and arbitrary SCSI
>=20
> OK, but does it make sense to have SCSI autosuspend? Or should autosu=
spend
> operate on the bus the _host_ is connected to (usb, pci, ...)?

That's the situation we're in now.  Autosuspend operates on the USB=20
bus, but it can't do anything with usb-storage because the child SCSI=20
devices don't do a SCSI autosuspend.

Alan Stern
