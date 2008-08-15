From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] Power management for SCSI
Date: Fri, 15 Aug 2008 11:25:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808151110380.23570-100000@netrider.rowland.org>
References: <200808150916.24258.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759661AbYHOPZ3@vger.kernel.org>
In-Reply-To: <200808150916.24258.oneukum@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, James.Bottomley@hansenpartnership.com, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, teheo@novell.com
List-Id: linux-pm@vger.kernel.org

On Fri, 15 Aug 2008, Oliver Neukum wrote:

> Am Freitag 15 August 2008 00:25:28 schrieb Alan Stern:
> > On Thu, 14 Aug 2008, Oliver Neukum wrote:
> > 
> > > The core problem is that you insist on a rigid bottom-to-top flow of
> > > autosuspensions. That's good for systems like USB and PCI which
> > > are trees for PM purposes. It makes no sense for true busses with
> > > equal members on the bus.
> > 
> > My framework is tree-oriented because it's based on the driver model, 
> > which uses a tree of devices.
> 
> Which uses a tree because PCI and USB are.

How do you know?  Is that just a guess based on some of Greg KH's and
Pat Mochel's previous activities?  Did you ask them?

> > Even on a true bus, the members can't be entirely equal -- one of them 
> > has to be closer to the CPU than the others are.  If that one member is 
> > in a low-power state then the CPU can't communicate with anything on 
> > the bus, unlike when one of the other members is in a low-power state.
> 
> Yes, that means under some circumstances you cannot suspend the
> member closest to the CPU, but under others you can. In a tree this question
> is very simply answered, on a bus you will actually need to compute whether
> you need the connection to the bus.

I don't see why any computation is needed.  If the CPU will need to
communicate with any devices on the bus (i.e., if any of these devices
are not idle) then you need the connection to the bus, otherwise you
don't.  It's exactly the same with a tree.  The fact that the 
interconnections form a bus rather than a tree is irrelevant.

(Viewed in logical terms, even a true bus can be described as a tree.  
The nodes are partially ordered by their communication paths to the 
CPU.)

More to the point is whether you should ever suspend any of these 
devices if there can be multiple initiators.  But that's a separate 
question.

> It is true that you won't need the bus if all other members on the bus have
> been suspended, but that's not very good because physically spinning
> down and up a disk is a very expensive operation, while suspending a host
> adapter can be trivial.

What is your point?  You seem to be saying that it would be nice to
suspend a host adapter at times when some of the SCSI targets beneath
it are not suspended.  I agree, but how would you determine whether
such a thing was safe?

Alan Stern
