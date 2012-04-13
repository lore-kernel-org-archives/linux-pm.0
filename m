From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Fri, 13 Apr 2012 11:35:04 -0400
Message-ID: <1334331304.23924.363.camel@gandalf.stny.rr.com>
References: <Pine.LNX.4.44L0.1204131008010.1185-100000@iolanthe.rowland.org>
	 <1334330949.23924.360.camel@gandalf.stny.rr.com>
	 <1334331148.23924.361.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1334331148.23924.361.camel-f9ZlEuEWxVcI6MkJdU+c8EEOCMrvLtNR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2012-04-13 at 11:32 -0400, Steven Rostedt wrote:
> On Fri, 2012-04-13 at 11:29 -0400, Steven Rostedt wrote:
> 
> > > 
> > > Second, if you do
> > > 
> > > 	echo 0 >/sys/bus/usb/devices/usb1/bConfigurationValue
> > 
> > This never returned. I did the echo, and the command locked up.
> > 
> > (process 3077)
> > 
> > cat /proc/3077/wchan 
> > usb_disconnect
> > 

Oh, and the "non modified" kernel I used was 3.1.4. The modified ones
was 3.2.5 (instead of removing the changes, I just used this one).

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
