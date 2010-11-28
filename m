From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: can't use usb serial
Date: Sat, 27 Nov 2010 22:38:39 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1011272234340.31337-100000@netrider.rowland.org>
References: <AANLkTim6sqfwQwLUpwe8b+-pTPyRatE3DScRr0RvG=uK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTim6sqfwQwLUpwe8b+-pTPyRatE3DScRr0RvG=uK@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matteo Croce <matteo@openwrt.org>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-pm@vger.kernel.org

On Sun, 28 Nov 2010, Matteo Croce wrote:

> Hi,
> I can't use my usb serial cable with any program, any access fails with -EAGAIN
> I did a git bisect and I found that commit
> 1bfee5bc86fdaecc912e06080583eddab7263df2 broke it.
> I got the email addresses from the MAINTAINERS file, if I bothered
> anyone not involved please discard this mail

Does the patch below fix the problem?

Alan Stern


Index: usb-2.6/drivers/usb/serial/usb-serial.c
===================================================================
--- usb-2.6.orig/drivers/usb/serial/usb-serial.c
+++ usb-2.6/drivers/usb/serial/usb-serial.c
@@ -52,6 +52,7 @@ static struct usb_driver usb_serial_driv
 	.suspend =	usb_serial_suspend,
 	.resume =	usb_serial_resume,
 	.no_dynamic_id = 	1,
+	.supports_autosuspend =	1,
 };
 
 /* There is no MODULE_DEVICE_TABLE for usbserial.c.  Instead
@@ -1344,6 +1345,8 @@ int usb_serial_register(struct usb_seria
 		return -ENODEV;
 
 	fixup_generic(driver);
+	if (driver->usb_driver)
+		driver->usb_driver->supports_autosuspend = 1;
 
 	if (!driver->description)
 		driver->description = driver->driver.name;
