From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: default value of power/wakeup
Date: Wed, 22 Apr 2015 19:10:50 +0200
Message-ID: <20150422171050.GB2551@kroah.com>
References: <20150422155233.GC32576@kroah.com>
 <Pine.LNX.4.44L0.1504221213140.1630-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1504221213140.1630-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Tom Yan <tom.ty89-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 22, 2015 at 12:15:36PM -0400, Alan Stern wrote:
> On Wed, 22 Apr 2015, Greg KH wrote:
> 
> > > Index: usb-4.0/drivers/hid/hid-logitech-dj.c
> > > ===================================================================
> > > --- usb-4.0.orig/drivers/hid/hid-logitech-dj.c
> > > +++ usb-4.0/drivers/hid/hid-logitech-dj.c
> > > @@ -990,6 +990,7 @@ static int logi_dj_probe(struct hid_devi
> > >  			 const struct hid_device_id *id)
> > >  {
> > >  	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
> > > +	struct usb_device *udev = interface_to_usbdev(intf);
> > >  	struct dj_receiver_dev *djrcv_dev;
> > >  	int retval;
> > >  
> > > @@ -1078,6 +1079,9 @@ static int logi_dj_probe(struct hid_devi
> > >  		goto logi_dj_recv_query_paired_devices_failed;
> > >  	}
> > >  
> > > +	/* Keyboards are enabled for wakeup by default */
> > > +	device_set_wakeup_enable(&udev->dev, 1);
> > 
> > But this device isn't always a keyboard.  For example, mine works with a
> > mouse.  It's a "universal receiver", you can't know what type of HID
> > device is plugged into it until it connects to it.  I don't mind making
> > it auto wakeup, if that works, but the comment isn't correct.
> 
> Oh, okay, I didn't realize that.
> 
> Is there a reasonable way to enable wakeup only when the driver learns
> that a keyboard is connected?  Where would the driver do this?

I don't know if the driver ever "knows" this, as you can pair lots of
different devices to this same receiver.  There's a userspace
application that lets you manage the device, called "solaar", that this
option could be changed in.

But really, putting the device to sleep should work for it no matter if
this is a keyboard or a mouse or a joystick, as the wakeup logic is in
the receiver, not in the device on the other end of the wireless link.

Turning autosuspend works for me for my mouse connected.  It doesn't
work for one of my "real" USB keyboards when it's connected to the
machine, which is why I can't enable autosuspend for it, as it drives me
crazy.

I don't have a keyboard to test the receiver with at the moment, to see
if autosuspend works for both things connected at the same time, or for
just the keyboard.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
