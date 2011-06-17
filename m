From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: ASUS K53E fails to suspend if ehci_hcd is loaded
Date: Fri, 17 Jun 2011 14:54:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1106171447210.2143-100000__45832.8318935402$1308336949$gmane$org@iolanthe.rowland.org>
References: <20110617183329.GH4307@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110617183329.GH4307@belkar.wrar.name>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrey Rahmatullin <wrar@wrar.name>, Thomas Gleixner <tglx@linutronix.de>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 18 Jun 2011, Andrey Rahmatullin wrote:

> After "usb 1-1: usb suspend" I have a message after
> usb_set_device_state(udev, USB_STATE_SUSPENDED); but not the message after
> the next line (msleep(10);). This is at the end of usb_port_suspend();

Heh -- you've just reached the limit of my expertise.  I have no idea
why msleep(10) would hang during suspend.  It sounds like some sort of
problem with the clock/timer subsystem, but whatever it is, I won't be
able to help you fix it.  Maybe Thomas can do more.

Alan Stern
