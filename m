From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [alsa-devel] [PATCH] usb: add USB_QUIRK_RESET_RESUME for M-Audio
 49
Date: Mon, 26 Nov 2012 11:12:34 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1211261111130.2168-100000@iolanthe.rowland.org>
References: <9473152.Oq5ztpgF62@linux-lqwf.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <9473152.Oq5ztpgF62@linux-lqwf.site>
Sender: stable-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.de>, Jonathan Nieder <jrnieder@gmail.com>, Steffen =?ISO-8859-1?Q?M=FCller?= <steffen.mueller@radio-frei.de>, alsa-devel@alsa-project.org, Olivier MATZ <zer0@droids-corp.org>, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, stable@vger.kernel.org, David Banks <amoebae@gmail.com>, Ralf Lang <lang@b1-systems.de>
List-Id: linux-pm@vger.kernel.org

On Mon, 26 Nov 2012, Oliver Neukum wrote:

> On Monday 26 November 2012 14:43:13 Clemens Ladisch wrote:
> 
> > > If it has to be running, the easiest fix would be the patch like
> > > below.  This will turn off the autopm essentially, but better than
> > > breakage.
> > >
> > > @@ -2074,6 +2077,8 @@ static void snd_usbmidi_input_start_ep(struct snd_usb_midi_in_endpoint* ep)
> > >
> > > +	ep->autopm_reference =
> > > +		usb_autopm_get_interface(ep->umidi->iface) >= 0;
> > 
> > usb_autopm_get_interface() cannot be called from the USB probe callback.
> 
> You can use usb_autopm_get_interface_no_resume()
> During probe() the device is known to not be suspended.

In fact, as far as I know you _can_ use usb_autopm_get_interface() from
within a probe routine.  Is there some problem with it I'm not aware of?

Alan Stern
