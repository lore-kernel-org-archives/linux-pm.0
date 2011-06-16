From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ASUS K53E fails to suspend if ehci_hcd is loaded
Date: Thu, 16 Jun 2011 16:57:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106161656190.1697-100000__41506.1522312046$1308259837$gmane$org@iolanthe.rowland.org>
References: <20110616201228.GG7253@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110616201228.GG7253@belkar.wrar.name>
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

> On Thu, Jun 16, 2011 at 03:52:02PM -0400, Alan Stern wrote:
> > > When I try to suspend my ASUS K53E laptop, the process hangs after
> > > spinning down the disk unless I unload ehci_hcd. This happens on 2.6.38,
> > > 2.6.39 and 3.0-rc3+. Some details are at
> > > https://bugzilla.kernel.org/show_bug.cgi?id=37632
> > > What additional info can I provide to help fix this if this is possible?
> > Set CONFIG_USB_DEBUG=y and boot with "no_console_suspend" on the 
> > command line.  What appears on the console when the system is hung?
> 
> PM: Entering mem sleep
> usb usb2: usb auto-resume
> sd blah-blah syncing cache
> ehci_hcd 0000:00:1d.0: resume root hub
> usb 1-1.1: usb suspend
> sd blah-blah stopping disk
> hub 1-1:1.0: hub_suspend
> usb 1-1: unlink qh256-0001/ffff88013b411000 start 1 [1/0 us]
> usb 1-1: usb suspend
> 
> 
> and that's all.

Okay, the next step is to try and find out exactly where the ehci 
suspend procedure is hanging.  The patch below adds a bunch of 
printouts at various spots throughout the procedure.  Let's see what 
shows up.

Alan Stern


 drivers/usb/host/ehci-hub.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: usb-3.0/drivers/usb/host/ehci-hub.c
===================================================================
--- usb-3.0.orig/drivers/usb/host/ehci-hub.c
+++ usb-3.0/drivers/usb/host/ehci-hub.c
@@ -208,7 +208,7 @@ static int ehci_bus_suspend (struct usb_
 	int			mask;
 	int			changed;
 
-	ehci_dbg(ehci, "suspend root hub\n");
+	ehci_info(ehci, "suspend root hub\n");
 
 	if (time_before (jiffies, ehci->next_statechange))
 		msleep(5);
@@ -216,6 +216,7 @@ static int ehci_bus_suspend (struct usb_
 	del_timer_sync(&ehci->iaa_watchdog);
 
 	spin_lock_irq (&ehci->lock);
+ehci_info(ehci, "A\n");
 
 	/* Once the controller is stopped, port resumes that are already
 	 * in progress won't complete.  Hence if remote wakeup is enabled
@@ -242,6 +243,7 @@ static int ehci_bus_suspend (struct usb_
 	}
 	ehci->command = ehci_readl(ehci, &ehci->regs->command);
 	ehci_work(ehci);
+ehci_info(ehci, "B\n");
 
 	/* Unlike other USB host controller types, EHCI doesn't have
 	 * any notion of "global" or bus-wide suspend.  The driver has
@@ -285,6 +287,7 @@ static int ehci_bus_suspend (struct usb_
 			changed = 1;
 		}
 	}
+ehci_info(ehci, "C\n");
 
 	if (changed && ehci->has_hostpc) {
 		spin_unlock_irq(&ehci->lock);
@@ -306,6 +309,7 @@ static int ehci_bus_suspend (struct usb_
 					"succeeded" : "failed");
 		}
 	}
+ehci_info(ehci, "D\n");
 
 	/* Apparently some devices need a >= 1-uframe delay here */
 	if (ehci->bus_suspended)
@@ -314,6 +318,7 @@ static int ehci_bus_suspend (struct usb_
 	/* turn off now-idle HC */
 	ehci_halt (ehci);
 	hcd->state = HC_STATE_SUSPENDED;
+ehci_info(ehci, "E\n");
 
 	if (ehci->reclaim)
 		end_unlink_async(ehci);
@@ -324,6 +329,7 @@ static int ehci_bus_suspend (struct usb_
 		mask &= ~STS_PCD;
 	ehci_writel(ehci, mask, &ehci->regs->intr_enable);
 	ehci_readl(ehci, &ehci->regs->intr_enable);
+ehci_info(ehci, "F\n");
 
 	ehci->next_statechange = jiffies + msecs_to_jiffies(10);
 	spin_unlock_irq (&ehci->lock);
@@ -332,6 +338,7 @@ static int ehci_bus_suspend (struct usb_
 	 * want, and so we must delete any pending watchdog timer events.
 	 */
 	del_timer_sync(&ehci->watchdog);
+ehci_info(ehci, "G\n");
 	return 0;
 }
 
