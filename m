From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [alsa-devel] [PATCH] usb: add USB_QUIRK_RESET_RESUME for M-Audio
 49
Date: Mon, 26 Nov 2012 16:54:07 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211261646230.2168-100000@iolanthe.rowland.org>
References: <50B3CD29.2060505@ladisch.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:44182 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756067Ab2KZVyI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Nov 2012 16:54:08 -0500
In-Reply-To: <50B3CD29.2060505@ladisch.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Oliver Neukum <oneukum@suse.de>, Takashi Iwai <tiwai@suse.de>, Jonathan Nieder <jrnieder@gmail.com>, =?ISO-8859-1?Q?Steffen_M=FCller?= <steffen.mueller@radio-frei.de>, alsa-devel@alsa-project.org, Olivier MATZ <zer0@droids-corp.org>, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, stable@vger.kernel.org, David Banks <amoebae@gmail.com>, Ralf Lang <lang@b1-systems.de>

On Mon, 26 Nov 2012, Clemens Ladisch wrote:

> Alan Stern wrote:
> > On Mon, 26 Nov 2012, Oliver Neukum wrote:
> >> On Monday 26 November 2012 14:43:13 Clemens Ladisch wrote:
> >>> usb_autopm_get_interface() cannot be called from the USB probe callback.
> >>
> >> You can use usb_autopm_get_interface_no_resume()
> >> During probe() the device is known to not be suspended.
> >
> > In fact, as far as I know you _can_ use usb_autopm_get_interface() from
> > within a probe routine.  Is there some problem with it I'm not aware of?
> 
> It returns -EACCES.

That's odd.  -EACCES occurs only when the interface or the device it
belongs to is disabled for runtime PM.  But the USB core enables
interfaces before probing, provided the driver's supports_autosuspend
flag is set.

Furthermore, -EACCES can occur in usb_autopm_get_interface() only when 
the interface or its device is not currently resumed -- but USB devices 
and interfaces are always resumed during a probe.

Do you have any idea about what's going wrong here?  Or do I need to 
investigate more closely?

Alan Stern

