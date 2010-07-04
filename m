From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [REGRESSION] usb devices don't wake up the system
Date: Sun, 04 Jul 2010 18:44:42 +0300
Message-ID: <1278258282.3571.10.camel@localhost.localdomain>
References: <Pine.LNX.4.44L0.1007040848250.16841-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-/UWZIHN4froclqXsmEIG"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1007040848250.16841-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--=-/UWZIHN4froclqXsmEIG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2010-07-04 at 08:51 -0400, Alan Stern wrote:
> On Sun, 4 Jul 2010, Maxim Levitsky wrote:
> 
> > > Alan. thanks for saving me from another bisect...
> > > latest git tip works again.
> > 
> > I mean, I think that
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=48826626263d4a61d06fd8c5805da31f925aefa0
> > 
> > fixed the problem.
> 
> Ah, yes.  Well, I can't claim a lot of credit for that because I'm the 
> person who introduced the regression in the first place!  But at least 
> it's working okay now.
> 
> > > (of course I need to explicitly enable power/wakeup on the mouse), but I
> > > can live with that.)
> > > 
> > > 
> > > I want to note that I still need to enable wakeup in /power/acpi/wakeup
> > > to make USB mouse wakeup the system.
> > > This isn't a regression, but I thought that I don't need that anymore.
> 
> You shouldn't.  Which setting in /proc/acpi/wakeup needs to be enabled?

The wakeup GPE for UHCI controller which is connected to the mouse.

maxim@MAIN:/sys/bus/pci/devices/0000:00:1d.0/usb5$ cat /proc/acpi/wakeup 
Device	S-state	  Status   Sysfs node
SLPB	  S4	*enabled   
P32	  S4	*disabled  pci:0000:00:1e.0
UAR1	  S4	*disabled  pnp:00:0a
ILAN	  S4	*disabled  pci:0000:00:19.0
PEGP	  S4	*disabled  
PEX0	  S4	*disabled  pci:0000:00:1c.0
PEX1	  S4	*disabled  pci:0000:00:1c.1
PEX2	  S4	*disabled  pci:0000:00:1c.2
PEX3	  S4	*disabled  pci:0000:00:1c.3
PEX4	  S4	*disabled  pci:0000:00:1c.4
PEX5	  S4	*disabled  
UHC1	  S3	*enabled   pci:0000:00:1d.0
UHC2	  S3	*disabled  pci:0000:00:1d.1
UHC3	  S3	*disabled  pci:0000:00:1d.2
UHC4	  S3	*disabled  
EHCI	  S3	*disabled  pci:0000:00:1d.7
EHC2	  S3	*disabled  pci:0000:00:1a.7
UH42	  S3	*disabled  pci:0000:00:1a.0
UHC5	  S3	*disabled  pci:0000:00:1a.1
AZAL	  S3	*disabled  pci:0000:00:1b.0



maxim@MAIN:/sys/bus/pci/devices/0000:00:1d.0/usb5$ cd 5-1/
5-1:1.0/   driver/    ep_00/     power/     subsystem/ 
maxim@MAIN:/sys/bus/pci/devices/0000:00:1d.0/usb5$ cd 5-1/
maxim@MAIN:/sys/bus/pci/devices/0000:00:1d.0/usb5/5-1$ 
maxim@MAIN:/sys/bus/pci/devices/0000:00:1d.0/usb5/5-1$ 
maxim@MAIN:/sys/bus/pci/devices/0000:00:1d.0/usb5/5-1$ cat idVendor 
1241
maxim@MAIN:/sys/bus/pci/devices/0000:00:1d.0/usb5/5-1$ lsusb
Bus 007 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 006 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 005 Device 003: ID 1241:1166 Belkin MI-2150 Trust Mouse
Bus 005 Device 002: ID 06a3:ff52 Saitek PLC Cyborg 3D Rumble Force Joystick
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
maxim@MAIN:/sys/bus/pci/devices/0000:00:1d.0/usb5/5-1$ 



Also, I tried to enable wakeup on the USB mouse using udev rule.

I did that rule for a test (very broad for testing):

SUBSYSTEM=="usb", ACTION=="add", ATTR{power/wakeup}="enabled"

I found that running udevd --debug confirms that it writes that attribute 
(Log of mouse attach attached :-). (I connected  it to different port now)

According to the log, udev does write 'enabled' to
/sys/devices/pci0000:00/0000:00:1a.0/usb3/3-2/power/wakeup

but:

maxim@MAIN:~$ cat /sys/devices/pci0000:00/0000:00:1a.0/usb3/3-2/power/wakeup
disabled


This looks like kernel bug.



I am not against the default of disabled wakeup, it fact I welcome that, 
but I think that udev rule should work to enable it back.

Best regards,
	Maxim Levitsky

--=-/UWZIHN4froclqXsmEIG
Content-Type: application/x-gzip; name="udev_log.txt.gz"
Content-Disposition: attachment; filename="udev_log.txt.gz"
Content-Transfer-Encoding: base64

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


--=-/UWZIHN4froclqXsmEIG
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-/UWZIHN4froclqXsmEIG--
