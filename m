From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [RFC] USB device persistence across
 suspend-to-disk
Date: Tue, 5 Sep 2006 09:13:18 -0700
Message-ID: <20060905091318.42c273d2.rdunlap@xenotime.net>
References: <Pine.LNX.4.44L0.0609051104260.14667-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0609051104260.14667-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Alan Stern <stern@rowland.harvard.edu>
Cc: mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>, Linux-pm@sc8-sf-spam2.sourceforge.net, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 5 Sep 2006 11:26:48 -0400 (EDT) Alan Stern wrote:

> Index: mm/Documentation/usb/persist.txt
> ===================================================================
> --- /dev/null
> +++ mm/Documentation/usb/persist.txt
> @@ -0,0 +1,154 @@
> +
> +	What is the solution?
> +
> +Setting the "persist=y" module parameter for usbcore will cause the

                persist=1 ??

> +kernel to work around these issues.  If usbcore is build into the

s/build/built/

> +main kernel instead of as a separate module, you can put
> +"usbcore.persist=1" on the boot command line.  You can also change the
> +kernel's behavior on the fly using sysfs: Type
> +
> +	echo y >/sys/module/usbcore/parameters/persist

Does sysfs treat 'y' as '1'?
Anyway, it would be Good to be consistent.

> +to turn the option on, and replace the 'y' with an 'n' to turn it off.
> +
> +The "persist" option enables a mode in which the core USB device data
> +structures are allowed to persist across a power-session disruption.
> +It works like this.  If the kernel sees that a USB host controller is
> +not in the expected state during resume (i.e., if the controller was
> +reset or otherwise had lost power) then it applies a persistence check
> +to each of the USB devices below that controller.  It doesn't try to
> +resume the device; that can't work once the power session is gone.
> +Instead it issues a USB port reset followed by a re-enumeration.
> +(This is exactly the same thing that happens whenever a USB device is
> +reset.)  If the re-enumeration shows that the device now attached to
> +that port has the same descriptors as before, including the Vendor and
> +Product IDs, then the kernel continues to use the same device
> +structure.  In effect, the kernel treats the device as though it had
> +merely been reset instead of unplugged.

so does the USB device also retain its same USB address?


> Index: mm/drivers/usb/core/message.c
> ===================================================================
> --- mm.orig/drivers/usb/core/message.c
> +++ mm/drivers/usb/core/message.c
> @@ -764,7 +764,7 @@ int usb_string(struct usb_device *dev, i
>  			err = -EINVAL;
>  			goto errout;
>  		} else {
> -			dev->have_langid = -1;
> +			dev->have_langid = 1;
>  			dev->string_langid = tbuf[2] | (tbuf[3]<< 8);
>  				/* always use the first langid listed */
>  			dev_dbg (&dev->dev, "default language 0x%04x\n",

Different patch (?).

---
~Randy

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
