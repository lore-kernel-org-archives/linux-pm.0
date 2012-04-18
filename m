From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 18 Apr 2012 17:02:12 -0400
Message-ID: <1334782932.28106.52.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204181616430.1149-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1204181616430.1149-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2012-04-18 at 16:23 -0400, Alan Stern wrote:

> In the meantime, just to be certain of the diagnosis, here's a
> different patch for you guys to try.  This will test the ehci-hcd
> unbound path (i.e., use it with the script).  The patch removes the
> line that sets the dev->current_state to PCI_UNKNOWN when the driver is
> unbound.  Thus current_state will remain equal to PCI_D0, so
> pci_prepare_to_sleep should put the controllers into D3, which we
> expect will cause a crash.

Confirmed. The suspend locked up even with the script.

> 
> Please try this both with and without pm_test set to "platform", and 
> post the debugging dmesg output from whichever cases the computer 
> survives.
> 

Below is the dmesg output after running with pm_test set to "platform".

-- Steve


[  168.898150] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[  168.900556] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[  168.900566] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[  168.902803] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[  168.905033] ehci_hcd 0000:00:1a.0: debug port 2
[  168.911060] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[  168.911074] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xdfc08000
[  168.926501] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[  168.927782] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[  168.929028] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  168.930280] usb usb1: Product: EHCI Host Controller
[  168.931159] usb usb1: Manufacturer: Linux 3.2.5-custom+ ehci_hcd
[  168.931825] usb usb1: SerialNumber: 0000:00:1a.0
[  168.932636] hub 1-0:1.0: USB hub found
[  168.933580] hub 1-0:1.0: 2 ports detected
[  168.958631] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[  168.959979] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[  168.959985] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[  168.961010] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[  168.961888] ehci_hcd 0000:00:1d.0: debug port 2
[  168.966644] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[  168.966659] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xdfc07000
[  168.982442] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[  168.984712] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[  168.986937] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  168.989072] usb usb2: Product: EHCI Host Controller
[  168.991221] usb usb2: Manufacturer: Linux 3.2.5-custom+ ehci_hcd
[  168.993345] usb usb2: SerialNumber: 0000:00:1d.0
[  168.995824] hub 2-0:1.0: USB hub found
[  168.996495] hub 2-0:1.0: 2 ports detected
[  169.246068] usb 1-1: new high-speed USB device number 2 using ehci_hcd
[  169.378364] usb 1-1: New USB device found, idVendor=8087, idProduct=0024
[  169.380124] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[  169.382318] hub 1-1:1.0: USB hub found
[  169.384196] hub 1-1:1.0: 6 ports detected
[  169.497629] usb 2-1: new high-speed USB device number 2 using ehci_hcd
[  169.629894] usb 2-1: New USB device found, idVendor=8087, idProduct=0024
[  169.632100] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[  169.635009] hub 2-1:1.0: USB hub found
[  169.637506] hub 2-1:1.0: 6 ports detected
[  169.713401] usb 1-1.1: new full-speed USB device number 3 using ehci_hcd
[  169.809382] usb 1-1.1: New USB device found, idVendor=8086, idProduct=0189
[  169.811659] usb 1-1.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[  169.822285] wlan0: authenticate with e0:91:f5:5e:86:d4 (try 1)
[  169.825100] wlan0: authenticated
[  169.825502] wlan0: waiting for beacon from e0:91:f5:5e:86:d4
[  169.835059] wlan0: beacon received
[  169.873008] wlan0: associate with e0:91:f5:5e:86:d4 (try 1)
[  169.876767] wlan0: RX AssocResp from e0:91:f5:5e:86:d4 (capab=0x411 status=0 aid=6)
[  169.876776] wlan0: associated
[  169.881390] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[  169.889131] usb 1-1.2: new high-speed USB device number 4 using ehci_hcd
[  170.042023] usb 1-1.2: New USB device found, idVendor=13d3, idProduct=5710
[  170.044334] usb 1-1.2: New USB device strings: Mfr=3, Product=1, SerialNumber=2
[  170.046665] usb 1-1.2: Product: USB 2.0 UVC VGA WebCam
[  170.048996] usb 1-1.2: Manufacturer: Azurewave
[  170.051261] usb 1-1.2: SerialNumber: 0x0001
[  170.055819] uvcvideo: Found UVC 1.00 device USB 2.0 UVC VGA WebCam (13d3:5710)
[  170.066505] input: USB 2.0 UVC VGA WebCam as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.2/1-1.2:1.0/input/input13
[  179.996624] wlan0: no IPv6 routers present


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
