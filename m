From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC Add no_suspend attribute V2] Let the driver
 know if it's in use
Date: Thu, 30 Apr 2009 22:27:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0904302219040.3409-100000@netrider.rowland.org>
References: <49FA374C.8000501@gandalf.sssup.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <49FA374C.8000501@gandalf.sssup.it>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Cc: Greg KH <greg@kroah.com>, linux-pm@lists.linux-foundation.org, len.brown@intel.com
List-Id: linux-pm@vger.kernel.org

On Fri, 1 May 2009, Michael Trimarchi wrote:

> > Nobody knows all the device dependencies.  That's why we're afraid that 
> > if you change the list, something will break.
> >
> >   
> But this happen for broken device? The list is a sufficient condition 
> for correct
> suspend phase but is not necesarry, because all the dependence are not 
> registerd.
> But just to understand: What are the typical situation, because I 
> suppose that
> we are not talking about broken device.

No, we're talking about normal, working devices.

I don't know that any situation is "typical", but here is one example.
In USB, a high-speed EHCI controller is accompanied by one or more
full/low-speed companion controllers (UHCI or OHCI).  They are
implemented as different PCI functions on the same PCI card, so they
are siblings in the device tree -- neither is a parent or a child of
the other.  During resume from hibernation, it is important that the
companion controllers be resumed _before_ the EHCI controller;
otherwise EHCI port handoffs won't work (you can't hand off a port to a
companion controller that hasn't been resumed yet).  It does work now,
because the companion controllers are registered before the EHCI
controller and so they come earlier in the dpm_list.

Does that give you an idea of the potential problems?  There may be 
other similar issues that nobody has ever run across and nobody knows 
about, simply because we have never changed the order of devices on the 
dpm_list.

Alan Stern
