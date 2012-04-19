From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 19 Apr 2012 14:08:41 -0400
Message-ID: <1334858921.28106.66.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204190934500.2070-100000@iolanthe.rowland.org>
	 <1334852575.28106.62.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334852575.28106.62.camel-f9ZlEuEWxVcI6MkJdU+c8EEOCMrvLtNR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2012-04-19 at 12:22 -0400, Steven Rostedt wrote:

> I removed all previous patches and added this one. But without the
> script, it locks up again in suspend.
> 
> I'll rebuild again just to make sure I didn't screw something up.

Rebuilt with mrproper, and confirming the patch was added.

It still locked up. But, I looked at your patch and mine and realized
that mine applied with some "FUZZ".

Mine:

@@ -1723,6 +1723,8 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
        pci_power_t target_state = pci_target_state(dev);
        int error;
 
+       if (1)
+               target_state = PCI_D0;
        if (target_state == PCI_POWER_ERROR)
                return -EIO;

Yours:

@@ -1713,6 +1713,8 @@ int pci_prepare_to_sleep(struct pci_dev
        pci_power_t target_state = pci_target_state(dev);
        int error;
 
+       if (1)
+               target_state = PCI_D0;
        if (target_state == PCI_POWER_ERROR)
                return -EIO;

Mine applied to pci_finish_runtime_suspend not pci_prepare_to_sleep :-p
I'm using 3.2.5.

/me fixes, recompiles and retests

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
