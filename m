From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Sat, 21 Apr 2012 13:22:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204211321190.475-100000@netrider.rowland.org>
References: <1334969624.28106.82.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334969624.28106.82.camel-f9ZlEuEWxVcI6MkJdU+c8EEOCMrvLtNR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 20 Apr 2012, Steven Rostedt wrote:

> On Fri, 2012-04-20 at 20:42 -0400, Alan Stern wrote:
> 
> > (Does anybody know if USB wakeup works on these machines under
> > Windows?)
> 
> I still have my windows partition on this box. Do you happen to know how
> to tell Windows to wake up on USB?

No idea.

> > What about runtime wakeup?  You can test it easily enough.  Write 
> > "auto" to the power/control attribute for the two controllers.  This 
> > should cause the controllers (or at least one of them) to go into 
> > runtime suspend.  Does it then wake up when you plug in a USB device?
> 
> Do you want me to do this with one of you patches, or with the script
> applied?

No patches, and the script doesn't matter because the test doesn't 
involve putting the computer to sleep.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
