From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 21:56:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902162144010.24097-100000__17872.8458159187$1234839563$gmane$org@netrider.rowland.org>
References: <200902170002.37973.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902170002.37973.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 17 Feb 2009, Rafael J. Wysocki wrote:

> On Monday 16 February 2009, Alan Stern wrote:
> > On Mon, 16 Feb 2009, Rafael J. Wysocki wrote:
> > 
> > > OK, so I think there are two things that user space may be allowed to do as
> > > far as putting devices into low power states is concerned:
> > > * disable/enable the automatic power management of the device (provided that
> > >   the driver supports the automatic PM)
> > 
> > Set the automatic PM parameters (idle timeout, state to go to, etc.).  
> 
> Yes.  I'm not sure about the state part, though.

Maybe, maybe not.  IMO it's too early to tell whether anyone will need 
this ability, so we shouldn't rule it out.

> > What about situations where we want to distinguish between the power 
> > state of the device itself and the power state of the link?  For a disk 
> > drive we may want to power the link on and off quite a lot, as that 
> > has low latency, but spinning the disk up and down takes a long time 
> > and so should have a longer idle-time value.
> 
> Well, I'm not sure at the moment.
> 
> Do you have any suggestions?

Not very well fleshed-out ones.  I've got a vague idea for allowing a
disk to have a 3-level power arrangement: full power, link disabled but
drive still spinning, and device suspended.  Arranging for automatic
transitions among those states will be a little clumsy but it can be
done.  As an example of the clumsiness, this scheme requires that the
drive has _two_ idle-timeout values, one for the link and one for the
drive itself.

Another possibility is to set up independent runtime PM for the
transport and the device.  This means allowing the possibility that the
transport is suspended while its child (the device) is not.  This is a
little simpler (there's only one idle-timeout per device, since the
link is treated as an independent device), but it violates the
principle of never suspending a parent while there is an active child.

Alan Stern
