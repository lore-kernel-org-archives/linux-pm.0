From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Possible problem with device_move()
Date: Tue, 31 Jul 2007 16:37:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707311628150.2787-100000@iolanthe.rowland.org>
References: <200707312112.51043.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707312112.51043.rjw@sisk.pl>
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
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linux-pm@lists.linux-foundation.org, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 31 Jul 2007, Rafael J. Wysocki wrote:

> > There is a dependency in the USB subsystem, wherein I need an EHCI
> > controller to be _resumed_ after its companion UHCI or OHCI
> > controllers.  This works out, thanks to the fact that manufacturers
> > tend to give the EHCI controller the largest PCI function number and
> > the Linux PCI core enumerates functions in numerical order.  This is
> > just pure luck, however, and if anything changed I'd have to add an
> > explicit fix.
> 
> That sounds really worrying to me.
> 
> The design appears to be very fragile if such things are possible, even in
> theory.

It wouldn't break the entire resume; it would only prevent the 
USB-Persist facility from working with non-high-speed devices.  So it's 
not quite as bad as it may seem.

Still, I suppose it would be best to add a "move device A to the end of
the dpm_active list" routine for use in this sort of situation.  This 
should be easy to do.

Alan Stern
