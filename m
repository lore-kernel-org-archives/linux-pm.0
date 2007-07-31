From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Possible problem with device_move()
Date: Tue, 31 Jul 2007 14:17:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707311404110.7256-100000@iolanthe.rowland.org>
References: <20070731173027.02934c71@gondolin.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070731173027.02934c71@gondolin.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 31 Jul 2007, Cornelia Huck wrote:

> On Tue, 31 Jul 2007 11:11:50 -0400 (EDT),
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > I wonder if device_move() shouldn't change the order of entries in the 
> > dpm_active list so that the new parent (and all its ancestors) get 
> > moved up ahead of the device's position?  But that might cause other 
> > problems...
> 
> This may be necessary if walking the list is the single determining
> factor to the order of suspend/resume.

It is.

> Are there any other dependencies
> not covered by time of registration order? I would imagine those needed
> moving devices on the dpm_active list as well...

I'm not sure what you mean.  Devices where A needs to be suspended 
before B even though A was discovered first?  I'm not aware of anything 
like that, other than your case and Marcel's.  Right now there's no 
code in the PM core to handle such things.

There is a dependency in the USB subsystem, wherein I need an EHCI
controller to be _resumed_ after its companion UHCI or OHCI
controllers.  This works out, thanks to the fact that manufacturers
tend to give the EHCI controller the largest PCI function number and
the Linux PCI core enumerates functions in numerical order.  This is
just pure luck, however, and if anything changed I'd have to add an
explicit fix.

Alan Stern
