From: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] usb: add USB_QUIRK_RESET_RESUME for M-Audio
 49
Date: Sun, 25 Nov 2012 23:01:27 +0100
Message-ID: <50B29537.7060007@ladisch.de>
References: <4FA2D481.4070304@droids-corp.org> <4FA2DB9D.1040303@droids-corp.org> <20120604110608.GG8248@droids-corp.org> <20120605232432.GE3619@burratino> <4FD06563.7050605@droids-corp.org> <20121125094110.GA21387@elie.Belkin> <50B2815E.2090105@droids-corp.org> <20121125212100.GE24024@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121125212100.GE24024-fcEM2ccDkbL2nhBuCrrZHw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Nieder <jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?ISO-8859-1?Q?Steffen_M=FCller?= <steffen.mueller-Coi19p7x1OHFVwzeVveEFA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olivier MATZ <zer0-RqaWXwjnwG4BE+pwOMkbTQ@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Banks <amoebae-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ralf Lang <lang-shG/GajIFYqbacvFa/9K2g@public.gmane.org>, Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Jonathan Nieder wrote:
> Some USB MIDI keyboards fail to operate after a USB autosuspend.

Make that *all* USB MIDI devices with input ports.

This is not a bug in the device, but one of the many bugs introduced
with the autosuspend code in <http://git.kernel.org/linus/88a8516a2128>.

That patch does not handle input at all, i.e., when the driver wants to
read from the device, it just doesn't take it out of suspend mode.

> A workaround is to disable USB autosuspend for these devices by
> putting AUTOSUSPEND_USBID_BLACKLIST="0763:2027" (resp. 0763:019b) in
> /etc/laptop-mode/conf.d/usb-autosuspend.conf.  In the spirit of commit
> 166cb70e97bd ("usb: add USB_QUIRK_RESET_RESUME for M-Audio 88es"),
> reset the device on resume so this workaround is not needed any more.

It is not feasible to add the IDs of all USB MIDI devices.

I'm working on a fix that adds proper power management for input ports,
but this requires the driver to be reorganized a little ...


Regards,
Clemens
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
