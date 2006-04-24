From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] Suspending usb function of PCMCIA multi-functional card
Date: Mon, 24 Apr 2006 11:47:27 -0700
Message-ID: <200604241147.27832.david-b@pacbell.net>
References: <380D9721A8E2114485644D71E87C6AB201BB4772@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB201BB4772@PNE-HJN-MBX01.wipro.com>
Content-Disposition: inline
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: linux-pm@lists.osdl.org
Cc: rasmit.ranjan@wipro.com, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Friday 21 April 2006 6:00 am, rasmit.ranjan@wipro.com wrote:
> Hi all,
>     I have a PCMCIA multi functional card hosting a usb and a serial
> port.
> The device tree for the usb is as follows:
>     
>  /sys/bus/pcmcia/devices/1-1/hcd/usb5/5-0:1.0/...............
> 
> 1-1 represents usb functionality of my PCMCIA card connected to socket
> no1. Similarlly my serial port will be listed as 1-0.
> 
> Now when I suspend 1-1 without suspening any down stream devices, it
> allows me to do. I mean, the content of the .../power/state file is
> changed to 3.

The PM framework doesn't pay attention to the power hierarchy except
during system suspend state transitions.  This seems more buglike than
anything else, but it's not yet been fixed.  That is, if you write to
a sysfs power/state file, nothing verifies that the child devices are
already in a compatible state.  (I suspect it needs to be a driver
responsibility, and that's how the USB stack now expects to run.)

There are some fixes lurking in the vicinity of this problem, which are
as yet un-merged, but I don't know that they touch the issues you saw.


> Which means my usb_generic_suspend is not getting called 
> otherwise it would have failed. Also PCMCIA client driver is notified of
> this suspend. I did not find any noticeable changes by suspending 1-1.
> 
> Then how this suspend is handled ? As the content of the power state
> file is changed, means power management is marking the node(1-1) as
> suspended. Then which function does this ?

Somewhere in the drivers/base/power directory; trace the execution
paths, you'll see it.  The information in power/state sometimes gets
munched without the assent of the driver which allegedly controls it.

Again, this seems more buglike than anything else, especially since
(as I recall things) most code paths through the PM core do the right
thing and leave drivers in control of the suspend state they report.
(Modulo recent bug additions ... I understand a patch changed things
there again, adding policy about what values are legal.  That likely
causes trouble for drivers.)

- Dave



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
