From: Pavel Pisa <pisa-/N2ztlQkxE7Ub/6JBqosbQ@public.gmane.org>
Subject: Re: [PATCH] PCI: add NO_D3_DURING_SLEEP flag and revert 151b61284776be2
Date: Sun, 24 Jun 2012 09:00:03 +0200
Message-ID: <201206240900.03802.pisa@cmp.felk.cvut.cz>
References: <Pine.LNX.4.44L0.1206232147420.4446-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1206232147420.4446-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello Alan,

On Sunday 24 June 2012 03:52:23 Alan Stern wrote:
> > Index: linux-3.4/drivers/pci/quirks.c
> > ===================================================================
> > --- linux-3.4.orig/drivers/pci/quirks.c 2012-06-23 16:37:14.582568585
> > +0200 +++ linux-3.4/drivers/pci/quirks.c      2012-06-23
> > 16:38:38.378571372 +0200 @@ -2942,6 +2942,8 @@
> >  }
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1c26, asus_ehci_no_d3);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1c2d, asus_ehci_no_d3);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x3b3c, asus_ehci_no_d3);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x3b34, asus_ehci_no_d3);
> >
> >  static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f,
> >                           struct pci_fixup *end)
> >
> > This quirk allows laptop suspend and resume correctly when nothing
> > is connected to the USB or even when mounted FLASH disk is connected.
> > The USB drive works correctly after resume.
>
> Do you want to submit your patch for inclusion in the kernel?  If you
> do, you should follow the instructions in
> Documentation/SubmittingPatches.
>
> Also, you should modify the comment before the asus_ehci_no_d3()
> routine.  Mention the 5 Series/3400 Series chipset in addition to the 6
> Series/C200 Series chipset.
>
> Or if you prefer, I could submit a modified version of your patch.

I know formal patch procedure but I expect, that it would be much
faster and simpler if you collect the list and add them yourself.
I expect, that there is potential to solve problems of many
other (at least ASUS) laptop configurations.

By the way, I have similar problem with my MSI laptop. So I try
to check if EHCI unbind does not help there as well.

Best wishes,

              Pavel
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
