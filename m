From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [linux-pm] Power management for SCSI
Date: Fri, 15 Aug 2008 09:16:23 +0200
Message-ID: <200808150916.24258.oneukum@suse.de>
References: <Pine.LNX.4.44L0.0808141819470.2148-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756006AbYHOHPd@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0808141819470.2148-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, James.Bottomley@hansenpartnership.com, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

Am Freitag 15 August 2008 00:25:28 schrieb Alan Stern:
> On Thu, 14 Aug 2008, Oliver Neukum wrote:
> 
> > The core problem is that you insist on a rigid bottom-to-top flow of
> > autosuspensions. That's good for systems like USB and PCI which
> > are trees for PM purposes. It makes no sense for true busses with
> > equal members on the bus.
> 
> My framework is tree-oriented because it's based on the driver model, 
> which uses a tree of devices.

Which uses a tree because PCI and USB are.

> Even on a true bus, the members can't be entirely equal -- one of them 
> has to be closer to the CPU than the others are.  If that one member is 
> in a low-power state then the CPU can't communicate with anything on 
> the bus, unlike when one of the other members is in a low-power state.

Yes, that means under some circumstances you cannot suspend the
member closest to the CPU, but under others you can. In a tree this question
is very simply answered, on a bus you will actually need to compute whether
you need the connection to the bus.

It is true that you won't need the bus if all other members on the bus have
been suspended, but that's not very good because physically spinning
down and up a disk is a very expensive operation, while suspending a host
adapter can be trivial.

	Regards
		Oliver
