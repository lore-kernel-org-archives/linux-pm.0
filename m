From: Peter Chen <Peter.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: default value of power/wakeup
Date: Thu, 23 Apr 2015 01:21:27 +0000
Message-ID: <BN3PR0301MB084933B354441C7D8A37221C81ED0@BN3PR0301MB0849.namprd03.prod.outlook.com>
References: <20150422171050.GB2551@kroah.com>
 <Pine.LNX.4.44L0.1504221403380.1630-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1504221403380.1630-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Tom Yan <tom.ty89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

 
> > >
> > > Oh, okay, I didn't realize that.
> > >
> > > Is there a reasonable way to enable wakeup only when the driver
> > > learns that a keyboard is connected?  Where would the driver do this?
> >
> > I don't know if the driver ever "knows" this, as you can pair lots of
> > different devices to this same receiver.  There's a userspace
> > application that lets you manage the device, called "solaar", that
> > this option could be changed in.
> >
> > But really, putting the device to sleep should work for it no matter
> > if this is a keyboard or a mouse or a joystick, as the wakeup logic is
> > in the receiver, not in the device on the other end of the wireless link.
> >
> > Turning autosuspend works for me for my mouse connected.  It doesn't
> > work for one of my "real" USB keyboards when it's connected to the
> > machine, which is why I can't enable autosuspend for it, as it drives
> > me crazy.
> >
> > I don't have a keyboard to test the receiver with at the moment, to
> > see if autosuspend works for both things connected at the same time,
> > or for just the keyboard.
> 
> Tom and I have been talking about enabling wakeup, not autosuspend.
> The question is whether or not the default wakeup setting for the receiver
> should be "enabled".
> 
> The kernel's policy is that keyboards should be enabled for wakeup, by default.
> I think that matches most people's expectations.  But when you've got a
> "universal" receiver, what then?
> 
> Should it always be enabled by default because a keyboard _might_ be
> connected?  Should it be enabled only when a keyboard is detected?
> What if multiple devices are connected at the same time?
> 

>From my point, the user option should not depend on kernel default value.
If the system you build needs some USB devices as system wakeup source,
the developers need to make sure the wakeups are enabled before system
enters suspend.

Peter 

> Shucks -- does the receiver even _work_ as a wakeup device?  It claims to, but
> that would require it to remain in wireless contact with the remote keyboard
> even while it's supposed to be in a low-power state, which rather seems to
> defeat the purpose.
> 
> Alan Stern
> 
> PS: I've got wakeup enabled for the PS/2 keyboard attached to the computer
> I'm using now, but it doesn't work.  I have to press the power button to wake
> the machine up from suspend.  Probably an issue in the BIOS or ACPI -- I
> haven't bothered to try and track it down.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in the body
> of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
