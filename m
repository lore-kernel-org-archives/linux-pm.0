From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: default value of power/wakeup
Date: Mon, 20 Apr 2015 15:08:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1504201505510.1321-100000@iolanthe.rowland.org>
References: <CAGnHSE=AuGjAKq5TgoFN6iJQHOwAQmOOrBkk9D6GTz5na8wLpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGnHSE=AuGjAKq5TgoFN6iJQHOwAQmOOrBkk9D6GTz5na8wLpw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tom Yan <tom.ty89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, 21 Apr 2015, Tom Yan wrote:

> Thank you very much for your reply.
> 
> So I tried to see if there's any difference between the two devices. I
> can see that the one didn't get enabled by default has an extra
> interface with 0 for the two attributes. But does that matter? Because
> if it does, shouldn't the mouse interface prevents the other one to
> get enabled by default as well?

No, it doesn't matter.

> Seems to me the keyboard interface is the first interface for both devices:
> [tom@localhost ~]$ cat
> /sys/devices/pci0000\:00/0000\:00\:14.0/usb3/3-13/3-13\:1.0/bInterfaceSubClass
> 01
> [tom@localhost ~]$ cat
> /sys/devices/pci0000\:00/0000\:00\:14.0/usb3/3-13/3-13\:1.0/bInterfaceProtocol
> 01
> [tom@localhost ~]$ cat
> /sys/devices/pci0000\:00/0000\:00\:14.0/usb3/3-14/3-14\:1.0/bInterfaceSubClass
> 01
> [tom@localhost ~]$ cat
> /sys/devices/pci0000\:00/0000\:00\:14.0/usb3/3-14/3-14\:1.0/bInterfaceProtocol
> 01
> 
> [tom@localhost ~]$ diff <(sudo lsusb -v -s 003:002) <(sudo lsusb -v -s 003:003)
> can't get device qualifier: Resource temporarily unavailable
> can't get debug descriptor: Resource temporarily unavailable
> can't get device qualifier: Resource temporarily unavailable
> can't get debug descriptor: Resource temporarily unavailable

It's a little difficult to tell what's going on just from the diff.  
Can you post the complete lsusb -v output for both devices?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
