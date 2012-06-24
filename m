From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH] PCI: add NO_D3_DURING_SLEEP flag and revert 151b61284776be2
Date: Sat, 23 Jun 2012 21:52:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206232147420.4446-100000@netrider.rowland.org>
References: <201206232320.15186.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201206232320.15186.pisa-/N2ztlQkxE7Ub/6JBqosbQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Pisa <pisa-/N2ztlQkxE7Ub/6JBqosbQ@public.gmane.org>
Cc: linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 23 Jun 2012, Pavel Pisa wrote:

> Hello Alan and all others,
> 
> I have observed similar lock during suspend to RAM on ASUS K52F
> 
> Handle 0x0002, DMI type 2, 15 bytes
> Base Board Information
>         Manufacturer: ASUSTeK Computer Inc.
>         Product Name: K52F
> 
> BIOS Information
>         Vendor: American Megatrends Inc.
>         Version: K52F.218
>         Release Date: 07/12/2011
> 
> 00:00.0 Host bridge [0600]: Intel Corporation Core Processor DRAM Controller [8086:0044] (rev 18)
> 00:02.0 VGA compatible controller [0300]: Intel Corporation Core Processor Integrated Graphics Controller [8086:0046] (rev 18)
> 00:16.0 Communication controller [0780]: Intel Corporation 5 Series/3400 Series Chipset HECI Controller [8086:3b64] (rev 06)
> ...
> 00:1a.0 USB Controller [0c03]: Intel Corporation 5 Series/3400 Series Chipset USB2 Enhanced Host Controller [8086:3b3c] (rev 06)
> 00:1d.0 USB Controller [0c03]: Intel Corporation 5 Series/3400 Series Chipset USB2 Enhanced Host Controller [8086:3b34] (rev 06)
> 
> When I unbind EHCI controllers
>   # Unbind ehci_hcd for first device 0000:00:1a.0:
>   echo -n "0000:00:1a.0" >/sys/bus/pci/drivers/ehci_hcd/unbind
>   # Unbind ehci_hcd for second device 0000:00:1d.0:
>   echo -n "0000:00:1d.0" >/sys/bus/pci/drivers/ehci_hcd/unbind
> then laptop goes to suspend after
>   echo mem >/sys/power/state  
> and when power button is pressed it restores to functional state.
> It works quite stable repeatedly.
> 
> This is similar to the problem solved by your patch.
> 
> I have tried 3.4.4 with kernel and added quirk
> 
> ---
>  drivers/pci/quirks.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-3.4/drivers/pci/quirks.c
> ===================================================================
> --- linux-3.4.orig/drivers/pci/quirks.c 2012-06-23 16:37:14.582568585 +0200
> +++ linux-3.4/drivers/pci/quirks.c      2012-06-23 16:38:38.378571372 +0200
> @@ -2942,6 +2942,8 @@
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1c26, asus_ehci_no_d3);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1c2d, asus_ehci_no_d3);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x3b3c, asus_ehci_no_d3);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x3b34, asus_ehci_no_d3);
> 
>  static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
>                           struct pci_fixup *end)
> 
> This quirk allows laptop suspend and resume correctly when nothing
> is connected to the USB or even when mounted FLASH disk is connected.
> The USB drive works correctly after resume.

Do you want to submit your patch for inclusion in the kernel?  If you 
do, you should follow the instructions in 
Documentation/SubmittingPatches.

Also, you should modify the comment before the asus_ehci_no_d3() 
routine.  Mention the 5 Series/3400 Series chipset in addition to the 6 
Series/C200 Series chipset.

Or if you prefer, I could submit a modified version of your patch.

> DVB tuner is connected
> 
> Bus 002 Device 003: ID 0b48:300d TechnoTrend AG TT-connect CT-3650 CI
> 
> then suspend proceeds correctly but resume locks hard again.
> 
> This seems to be problem in dvb_usb_ttusb2 driver.
> 
> But anyway I think, that adding 0x3b3c and 0x3b34 to the quirk list
> could help more people.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
