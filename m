From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Mon, 23 Apr 2012 12:29:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204231228370.1612-100000@iolanthe.rowland.org>
References: <20120421215459.GB4772@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120421215459.GB4772-hAV9HEAGFNe6YibBOCjzsw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 22 Apr 2012, Andrey Rahmatullin wrote:

> > All right.  Maybe you posted this information earlier in the thread, 
> > but it's easier to ask again than try to find it.  What output do you 
> > get from "lspci -nv -s 1a.0"?
> 00:1a.0 0c03: 8086:1c2d (rev 05) (prog-if 20 [EHCI])
>         Subsystem: 1043:1147
>         Flags: bus master, medium devsel, latency 0, IRQ 16
>         Memory at dfe08000 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [58] Debug port: BAR=1 offset=00a0
>         Capabilities: [98] PCI Advanced Features
>         Kernel driver in use: ehci_hcd

Steve, what about you?  Do you get the same thing?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
