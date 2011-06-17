From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ASUS K53E fails to suspend if ehci_hcd is loaded
Date: Fri, 17 Jun 2011 15:23:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106171522210.2143-100000__43885.2390427657$1308338752$gmane$org@iolanthe.rowland.org>
References: <20110617191905.GI4307@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110617191905.GI4307@belkar.wrar.name>
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
Cc: Thomas Gleixner <tglx@linutronix.de>, USB list <linux-usb@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 18 Jun 2011, Andrey Rahmatullin wrote:

> On Fri, Jun 17, 2011 at 02:54:41PM -0400, Alan Stern wrote:
> > > After "usb 1-1: usb suspend" I have a message after
> > > usb_set_device_state(udev, USB_STATE_SUSPENDED); but not the message after
> > > the next line (msleep(10);). This is at the end of usb_port_suspend();
> > 
> > Heh -- you've just reached the limit of my expertise.  I have no idea
> > why msleep(10) would hang during suspend.  It sounds like some sort of
> > problem with the clock/timer subsystem, but whatever it is, I won't be
> > able to help you fix it.  Maybe Thomas can do more.
> I've removed that msleep, now I have all proper messages up to the end of
> generic_suspend() for usb1 (all in a 0.01 second) but the system still
> hangs after them.

Maybe another msleep() somewhere else in the suspend path is hanging.

Alan Stern
