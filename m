From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Make PM core handle device
 registrations concurrent with suspend/hibernation
Date: Wed, 5 Mar 2008 11:03:52 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0803051050310.4621-100000@iolanthe.rowland.org>
References: <200803042252.51440.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803042252.51440.rjw@sisk.pl>
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
Cc: Marcel Holtmann <marcel@holtmann.org>, LKML <linux-kernel@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

On Tue, 4 Mar 2008, Rafael J. Wysocki wrote:

> > It's not clear that we want to have this check.  It would cause
> > problems if the device ordering got mixed up by device_move(), which is
> > pretty much the only way it could be triggered.
> 
> Well, isn't it actually dangerous to suspend parents before their children?
> What happens, for example, if putting the parent into D3 causes power to be
> cut from the children and then we attempt to suspend them?

It depends on the devices involved.  For PCI devices, obviously there 
will be problems of the sort you described.  But for other devices 
there might not be.

For example, the USB Bluetooth driver will sometimes create a new TTY
device and then move the existing Bluetooth device underneath it (this
description is oversimplified and probably wrong in some important
respects, but you get the idea).  Suspending the Bluetooth device
before suspending the TTY won't cause any power-related problems,
because a TTY is a purely logical device with no power implications at
all.

There might still be logical problems, of course...  We need to add a
mechanism for reordering the dpm_active list when device_move() is
called.  But first we need to get in touch with the people using
device_move() -- basically just Marcel and Cornelia -- and see what
sort of mechanism they will need.

Alan Stern
