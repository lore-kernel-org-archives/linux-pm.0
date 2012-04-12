From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 12 Apr 2012 16:33:46 -0400
Message-ID: <1334262826.23924.351.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204121554320.1496-100000@iolanthe.rowland.org>
	 <Pine.LNX.4.44L0.1204121607520.1496-100000@iolanthe.rowland.org>
	 <20120412202132.GH12852@belkar.wrar.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120412202132.GH12852-hAV9HEAGFNe6YibBOCjzsw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2012-04-13 at 02:21 +0600, Andrey Rahmatullin wrote:
> On Thu, Apr 12, 2012 at 04:09:43PM -0400, Alan Stern wrote:
> > > Do this with the ehci_reset added and all the other changes present as 
> > > well.
> > 
> > More precisely, keep the ehci_reset call (in both places),
> Which both places?

Alan,

We're not experts in this code. Would it be possible to just send us a
patch to what you want changed?

Shouldn't be too hard to just make a temporary change in a git
repository, do a 'git diff' and then revert the change:

  <- make changes ->
  git diff > temp.patch
  patch -p1 -R < temp.patch


Thanks!

-- Steve

> 
> > the dev_info call, and the pci_prepare_to_sleep call.  You don't need to
> > set the configflag register to 0; the reset will do that anyway.
> 
> 


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
