From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: default value of power/wakeup
Date: Wed, 22 Apr 2015 12:15:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1504221213140.1630-100000@iolanthe.rowland.org>
References: <20150422155233.GC32576@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:49924 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965900AbbDVQPh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 12:15:37 -0400
In-Reply-To: <20150422155233.GC32576@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Tom Yan <tom.ty89@gmail.com>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, 22 Apr 2015, Greg KH wrote:

> > Index: usb-4.0/drivers/hid/hid-logitech-dj.c
> > ===================================================================
> > --- usb-4.0.orig/drivers/hid/hid-logitech-dj.c
> > +++ usb-4.0/drivers/hid/hid-logitech-dj.c
> > @@ -990,6 +990,7 @@ static int logi_dj_probe(struct hid_devi
> >  			 const struct hid_device_id *id)
> >  {
> >  	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
> > +	struct usb_device *udev = interface_to_usbdev(intf);
> >  	struct dj_receiver_dev *djrcv_dev;
> >  	int retval;
> >  
> > @@ -1078,6 +1079,9 @@ static int logi_dj_probe(struct hid_devi
> >  		goto logi_dj_recv_query_paired_devices_failed;
> >  	}
> >  
> > +	/* Keyboards are enabled for wakeup by default */
> > +	device_set_wakeup_enable(&udev->dev, 1);
> 
> But this device isn't always a keyboard.  For example, mine works with a
> mouse.  It's a "universal receiver", you can't know what type of HID
> device is plugged into it until it connects to it.  I don't mind making
> it auto wakeup, if that works, but the comment isn't correct.

Oh, okay, I didn't realize that.

Is there a reasonable way to enable wakeup only when the driver learns
that a keyboard is connected?  Where would the driver do this?

Alan Stern

