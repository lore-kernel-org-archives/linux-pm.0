From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ASUS K53E fails to suspend if ehci_hcd is loaded
Date: Fri, 17 Jun 2011 12:11:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106171206480.2143-100000__6102.66938242621$1308327164$gmane$org@iolanthe.rowland.org>
References: <20110617155739.GE4307@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110617155739.GE4307@belkar.wrar.name>
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

> On Fri, Jun 17, 2011 at 11:17:01AM -0400, Alan Stern wrote:
> > Okay, then you must have seen all the verbose PM debugging messages.  
> > Which means the last suspend callback to run was for the 1-1 device
> > rather than the usb1 device, right?
> > 
> > If so, it means I was looking in the wrong place.  1-1 is the internal
> > rate-matching hub, whereas usb1 is the EHCI controller's root hub.
> > 
> > Can you add your own dev_info() statements to the hub_quiesce() and 
> > hub_suspend() routines in drivers/usb/core/hub.c, or should I send a 
> > patch?
> After "usb 1-1.1: usb suspend" I see a full "start hub_suspend,
> hub_quiesce, rest of hub_suspend" path for 1-1:1.0 (I've used &intf->dev
> in suspend and hub->intfdev in quiesce as a 1st arg for dev_info()), then
> "usb 1-1: usb suspend" and after that it hangs.

Ah, okay.  I feel stupid; I should have realized that would happen.
Anyway, the next place to look is in usb_port_suspend(), also in hub.c.

If you want to go a few levels higher as well, usb_port_suspend() is
called from generic_suspend() in generic.c.  That routine, in turn, is
called from usb_suspend_device() in driver.c -- udriver->suspend should
always be equal to generic_suspend.

Alan Stern
