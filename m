From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: Hotplug events during sleep transition
Date: Sun, 25 Dec 2005 20:52:39 +0100
Message-ID: <20051225195239.GA1787@elf.ucw.cz>
References: <20051225085303.GF2183@elf.ucw.cz>
	<Pine.LNX.4.44L0.0512251133010.31812-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============41212235363268257=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512251133010.31812-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============41212235363268257==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > 	Add suspend and resume methods to usblp, but make it so they
> > > 	only cancel outstanding I/O, while relying on usbcore to fail
> > > 	any new I/O requests?
> > 
> > It is not *that* bad, actually. In system suspend/resume cases, no new
> > I/O requests can happen, because userspace is frozen. Because of
> > runtime suspend, you should handle I/O errors properly, but you should
> > handle I/O errors properly, anyway, so... looks like a solution to me.
> 
> You're right, it's not really all that bad.  Note however that in the PPC
> implementation, Ben H. does not freeze userspace before suspend to RAM.

Perhaps he'll change his mind ;-))))).

Yep, for ppc and runtime power management, this is not really
nice. But if someone forces our device into off state, perhaps
returning errors to userspace is acceptable solution?

> > > 	Unbind usblp in lieu of suspending it.
> > 
> > If this can be done in reasonable ammount of not-too-ugly code, why
> > not? I think that even Patrick can be convinced by nice patch.
> 
> This isn't very hard either.  A sample patch is given below.  I haven't 
> tested it with vanilla 2.6.15-rc6, but a similar patch works okay on 
> Greg's development tree.  Apart from the FIXMEs, it's not bad at
> all.

Well, the FIXMEs look quite nasty to my untrained eye...
								Pavel

> Index: linux-2.6.15-rc6/drivers/usb/core/usb.c
> ===================================================================
> --- linux-2.6.15-rc6.orig/drivers/usb/core/usb.c
> +++ linux-2.6.15-rc6/drivers/usb/core/usb.c
> @@ -1431,8 +1431,17 @@ static int usb_generic_suspend(struct de
>  		else
>  			mark_quiesced(intf);
>  	} else {
> -		// FIXME else if there's no suspend method, disconnect...
> -		dev_warn(dev, "no %s?\n", "suspend");
> +		dev_warn(dev, "no suspend for %s?  unbinding...\n",
> +				driver->name);
> +		up(&dev->sem);
> +
> +		/*
> +		 * FIXME: You're not supposed to do this without holding
> +		 * the USB device lock.  But we can't just grab the lock
> +		 * because our caller might already be holding it.
> +		 */
> +		usb_driver_release_interface(driver, intf);
> +		down(&dev->sem);
>  		status = 0;
>  	}
>  	return status;
> @@ -1459,9 +1468,22 @@ static int usb_generic_resume(struct dev
>  		return usb_resume_device (to_usb_device(dev));
>  	}
>  
> -	if ((dev->driver == NULL) ||
> -	    (dev->driver_data == &usb_generic_driver_data))
> +	/* try to bind interfaces that have no driver */
> +	if (dev->driver == NULL) {
> +		up(&dev->sem);
> +
> +		/*
> +		 * FIXME: You're not supposed to do this without holding
> +		 * the USB device lock.  But we can't just grab the lock
> +		 * because our caller might already be holding it.
> +		 */
> +		device_attach(dev);
> +		down(&dev->sem);
>  		return 0;
> +	}
> +
> +	if (dev->driver_data == &usb_generic_driver_data)
> +		return 0;		/* Shouldn't happen */
>  
>  	intf = to_usb_interface(dev);
>  	driver = to_usb_driver(dev->driver);
> @@ -1481,7 +1503,7 @@ static int usb_generic_resume(struct dev
>  			mark_quiesced(intf);
>  		}
>  	} else
> -		dev_warn(dev, "no %s?\n", "resume");
> +		dev_warn(dev, "no resume for %s?\n", driver->name);
>  	return 0;
>  }
>  
> Index: linux-2.6.15-rc6/drivers/usb/core/hub.c
> ===================================================================
> --- linux-2.6.15-rc6.orig/drivers/usb/core/hub.c
> +++ linux-2.6.15-rc6/drivers/usb/core/hub.c
> @@ -1838,12 +1838,6 @@ int usb_resume_device(struct usb_device 
>  
>  	usb_unlock_device(udev);
>  
> -	/* rebind drivers that had no suspend() */
> -	if (status == 0) {
> -		usb_lock_all_devices();
> -		bus_rescan_devices(&usb_bus_type);
> -		usb_unlock_all_devices();
> -	}
>  	return status;
>  }
>  
> 

-- 
Thanks, Sharp!

--===============41212235363268257==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============41212235363268257==--
