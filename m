From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ASUS K53E fails to suspend if ehci_hcd is loaded
Date: Fri, 17 Jun 2011 11:17:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106171109370.2143-100000__25029.554431285$1308323970$gmane$org@iolanthe.rowland.org>
References: <20110617145302.GD4307@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110617145302.GD4307@belkar.wrar.name>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Rahmatullin <wrar@wrar.name>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 17 Jun 2011, Andrey Rahmatullin wrote:

> On Fri, Jun 17, 2011 at 10:14:16AM -0400, Alan Stern wrote:
> > > > Okay, the next step is to try and find out exactly where the ehci 
> > > > suspend procedure is hanging.  The patch below adds a bunch of 
> > > > printouts at various spots throughout the procedure.  Let's see what 
> > > > shows up.
> > > I don't see any of these new messages.
> > Are you sure the new ehci-hcd.ko module was loaded when you ran the 
> > test?
> Yes. I'll triple-check though.
>  
> > Another thing you should do when testing:
> > 
> > 	echo 9 >/proc/sys/kernel/printk
> > 
> > (Or equivalently, Alt-SysRq-9 on the keyboard.)  I should have
> > mentioned that before sending the test patch.  Oh well....
> I used dmesg -n8.

Okay, then you must have seen all the verbose PM debugging messages.  
Which means the last suspend callback to run was for the 1-1 device
rather than the usb1 device, right?

If so, it means I was looking in the wrong place.  1-1 is the internal
rate-matching hub, whereas usb1 is the EHCI controller's root hub.

Can you add your own dev_info() statements to the hub_quiesce() and 
hub_suspend() routines in drivers/usb/core/hub.c, or should I send a 
patch?

Alan Stern
