From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [alsa-devel] [PATCH] usb: add USB_QUIRK_RESET_RESUME for M-Audio 49
Date: Mon, 26 Nov 2012 14:54:28 +0100
Message-ID: <9473152.Oq5ztpgF62@linux-lqwf.site>
References: <4FA2D481.4070304@droids-corp.org> <s5hwqx8h5w1.wl%tiwai@suse.de> <50B371F1.70508@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <50B371F1.70508@ladisch.de>
Sender: stable-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, Jonathan Nieder <jrnieder@gmail.com>, Steffen =?ISO-8859-1?Q?M=FCller?= <steffen.mueller@radio-frei.de>, alsa-devel@alsa-project.org, Olivier MATZ <zer0@droids-corp.org>, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, stable@vger.kernel.org, David Banks <amoebae@gmail.com>, Ralf Lang <lang@b1-systems.de>
List-Id: linux-pm@vger.kernel.org

On Monday 26 November 2012 14:43:13 Clemens Ladisch wrote:

> > If it has to be running, the easiest fix would be the patch like
> > below.  This will turn off the autopm essentially, but better than
> > breakage.
> >
> > @@ -2074,6 +2077,8 @@ static void snd_usbmidi_input_start_ep(struct snd_usb_midi_in_endpoint* ep)
> >
> > +	ep->autopm_reference =
> > +		usb_autopm_get_interface(ep->umidi->iface) >= 0;
> 
> usb_autopm_get_interface() cannot be called from the USB probe callback.

You can use usb_autopm_get_interface_no_resume()
During probe() the device is known to not be suspended.

	Regards
		Oliver
