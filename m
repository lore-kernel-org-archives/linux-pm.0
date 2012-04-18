From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 18 Apr 2012 17:29:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1204181727580.1149-100000@iolanthe.rowland.org>
References: <201204182304.29249.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201204182304.29249.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 18 Apr 2012, Rafael J. Wysocki wrote:

> > Yes, there are ways to work around this.  At the moment I'm not sure 
> > what would be best; we can ask Rafael.  One big remaining puzzle: Why 
> > are the EHCI controllers the only devices that cause a crash when left 
> > in D3 during suspend?  We may never know...
> 
> Are they put into D3 by ACPI or using the native PCI PM?

PCI PM, definitely.  Maybe ACPI gets into the act as well, but I doubt 
it.  How would we tell?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
