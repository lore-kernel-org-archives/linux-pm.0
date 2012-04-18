From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 18 Apr 2012 14:11:40 -0400
Message-ID: <1334772700.28106.48.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204181317550.1149-100000@iolanthe.rowland.org>
	 <1334769847.28106.47.camel@gandalf.stny.rr.com>
	 <20120418174610.GA10142@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120418174610.GA10142-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2012-04-18 at 18:46 +0100, Mark Brown wrote:
> On Wed, Apr 18, 2012 at 01:24:07PM -0400, Steven Rostedt wrote:
> 
> > Hmm, if the system is going down into suspend, what's the purpose of
> > putting the individual devices into low-power states. The entire system
> > will become a low-power state once it hits suspend, wont it?
> 
> Embedded platforms tend to rely on drivers doing this, either because
> the system suspend just suspends a portion of the system or because
> suspending the core on the system relies on the devices having being
> quiesced (or a combination of both).

I guess this explains why MS has a separate OS for embedded devices.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
