From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [linux-pm] Power management for SCSI
Date: Thu, 14 Aug 2008 23:43:55 +0200
Message-ID: <200808142343.56505.oneukum@suse.de>
References: <Pine.LNX.4.44L0.0808141141570.2846-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754821AbYHNVnK@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0808141141570.2846-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, James.Bottomley@hansenpartnership.com, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

Am Donnerstag 14 August 2008 17:47:02 schrieb Alan Stern:
> > I don't really argue against flushing the caches. But I cannot that=
 this would
> > demand that we should implement autopsuspend for SCSI. It seems lik=
e
> > overengineering to me.
>=20
> Think of it in two parts: idle-timeout detection and autosuspend. =A0
> Presumably you don't object to the idle-timeout detection (which is=20
> needed for powering down links in general), and you don't argue again=
st=20
> the cache-flushing part of autosuspend. =A0Taken together, that's abo=
ut=20
> 90% of my proposal. =A0So what is the objectionable 10%?

The core problem is that you insist on a rigid bottom-to-top flow of
autosuspensions. That's good for systems like USB and PCI which
are trees for PM purposes. It makes no sense for true busses with
equal members on the bus.

	Regards
		Oliver
