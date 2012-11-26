From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] usb: add USB_QUIRK_RESET_RESUME for M-Audio
 49
Date: Mon, 26 Nov 2012 21:12:25 +0100
Message-ID: <50B3CD29.2060505@ladisch.de>
References: <Pine.LNX.4.44L0.1211261111130.2168-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1211261111130.2168-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?ISO-8859-1?Q?Steffen_M=FCller?= <steffen.mueller-Coi19p7x1OHFVwzeVveEFA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Olivier MATZ <zer0-RqaWXwjnwG4BE+pwOMkbTQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Banks <amoebae-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ralf Lang <lang-shG/GajIFYqbacvFa/9K2g@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Alan Stern wrote:
> On Mon, 26 Nov 2012, Oliver Neukum wrote:
>> On Monday 26 November 2012 14:43:13 Clemens Ladisch wrote:
>>> usb_autopm_get_interface() cannot be called from the USB probe callback.
>>
>> You can use usb_autopm_get_interface_no_resume()
>> During probe() the device is known to not be suspended.
>
> In fact, as far as I know you _can_ use usb_autopm_get_interface() from
> within a probe routine.  Is there some problem with it I'm not aware of?

It returns -EACCES.

But _no_resume() appears to work just fine.


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
