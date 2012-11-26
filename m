From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] usb: add USB_QUIRK_RESET_RESUME for M-Audio
 49
Date: Mon, 26 Nov 2012 14:43:13 +0100
Message-ID: <50B371F1.70508@ladisch.de>
References: <4FA2D481.4070304@droids-corp.org> <4FA2DB9D.1040303@droids-corp.org> <20120604110608.GG8248@droids-corp.org> <20120605232432.GE3619@burratino> <4FD06563.7050605@droids-corp.org> <20121125094110.GA21387@elie.Belkin> <50B2815E.2090105@droids-corp.org> <20121125212100.GE24024@elie.Belkin> <50B29537.7060007@ladisch.de> <s5hlidoiu5y.wl%tiwai@suse.de> <50B36213.9090007@ladisch.de> <s5hwqx8h5w1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <s5hwqx8h5w1.wl%tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Cc: Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?ISO-8859-1?Q?Steffen_M=FCll?= =?ISO-8859-1?Q?er?= <steffen.mueller-Coi19p7x1OHFVwzeVveEFA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Olivier MATZ <zer0-RqaWXwjnwG4BE+pwOMkbTQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Banks <amoebae-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ralf Lang <lang-shG/GajIFYqbacvFa/9K2g@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
>> Takashi Iwai wrote:
>>> Clemens Ladisch wrote:
>>>> I'm working on a fix that adds proper power management for input ports,
>>>> but this requires the driver to be reorganized a little ...
>>>
>>> Doesn't a simple patch like below work?
>>
>>> +static int substream_open(struct snd_rawmidi_substream *substream, int open)
>>>  {
>>> +	if (open && umidi->opened++ == 0) {
>>> +		err = usb_autopm_get_interface(umidi->iface);
>>>
>>>  static int snd_usbmidi_input_open(struct snd_rawmidi_substream *substream)
>>>  {
>>> +	return substream_open(substream, 1);
>>
>> No, because the input URBs are submitted before the userspace device is
>> opened.
>
> Ah, right.  What's the reason of submitting input urbs for the all
> time from the beginning?  For loopback?

For not needing to count open input ports.

> If it has to be running, the easiest fix would be the patch like
> below.  This will turn off the autopm essentially, but better than
> breakage.
>
> @@ -2074,6 +2077,8 @@ static void snd_usbmidi_input_start_ep(struct snd_usb_midi_in_endpoint* ep)
>
> +	ep->autopm_reference =
> +		usb_autopm_get_interface(ep->umidi->iface) >= 0;

usb_autopm_get_interface() cannot be called from the USB probe callback.


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
