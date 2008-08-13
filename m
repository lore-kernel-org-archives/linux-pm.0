From: Oliver Neukum <oneukum@suse.de>
Subject: Re: Power management for SCSI
Date: Wed, 13 Aug 2008 17:24:51 +0200
Message-ID: <200808131724.52461.oneukum@suse.de>
References: <Pine.LNX.4.44L0.0808131051330.2455-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756283AbYHMPYA@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0808131051330.2455-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, James.Bottomley@hansenpartnership.com, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

Am Mittwoch 13 August 2008 16:59:23 schrieb Alan Stern:
> This is a good question. =A0Most USB mass-storage devices do not act =
as a
> true SCSI bus, but I believe there are a few non-standard ones that d=
o
> -- the USB device really contains a SCSI host and arbitrary SCSI

OK, but does it make sense to have SCSI autosuspend? Or should autosusp=
end
operate on the bus the _host_ is connected to (usb, pci, ...)?

	Regards
		Oliver
