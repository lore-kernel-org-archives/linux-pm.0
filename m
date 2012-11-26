From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH] usb: add USB_QUIRK_RESET_RESUME for M-Audio
 49
Date: Mon, 26 Nov 2012 13:35:31 +0100
Message-ID: <50B36213.9090007@ladisch.de>
References: <4FA2D481.4070304@droids-corp.org> <4FA2DB9D.1040303@droids-corp.org> <20120604110608.GG8248@droids-corp.org> <20120605232432.GE3619@burratino> <4FD06563.7050605@droids-corp.org> <20121125094110.GA21387@elie.Belkin> <50B2815E.2090105@droids-corp.org> <20121125212100.GE24024@elie.Belkin> <50B29537.7060007@ladisch.de> <s5hlidoiu5y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58617 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755357Ab2KZMfh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Nov 2012 07:35:37 -0500
In-Reply-To: <s5hlidoiu5y.wl%tiwai@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Nieder <jrnieder@gmail.com>, =?ISO-8859-1?Q?Steffen_M=FCll?= =?ISO-8859-1?Q?er?= <steffen.mueller@radio-frei.de>, alsa-devel@alsa-project.org, Olivier MATZ <zer0@droids-corp.org>, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Oliver Neukum <oneukum@suse.de>, stable@vger.kernel.org, David Banks <amoebae@gmail.com>, Ralf Lang <lang@b1-systems.de>

Takashi Iwai wrote:> At Sun, 25 Nov 2012 23:01:27 +0100,
> Clemens Ladisch wrote:
>>
>> Jonathan Nieder wrote:
>>> Some USB MIDI keyboards fail to operate after a USB autosuspend.
>>
>> Make that *all* USB MIDI devices with input ports.
>>
>> This is not a bug in the device, but one of the many bugs introduced
>> with the autosuspend code in <http://git.kernel.org/linus/88a8516a2128>.
>>
>> That patch does not handle input at all, i.e., when the driver wants to
>> read from the device, it just doesn't take it out of suspend mode.
>>
>>> A workaround is to disable USB autosuspend for these devices by
>>> putting AUTOSUSPEND_USBID_BLACKLIST="0763:2027" (resp. 0763:019b) in
>>> /etc/laptop-mode/conf.d/usb-autosuspend.conf.  In the spirit of commit
>>> 166cb70e97bd ("usb: add USB_QUIRK_RESET_RESUME for M-Audio 88es"),
>>> reset the device on resume so this workaround is not needed any more.
>>
>> It is not feasible to add the IDs of all USB MIDI devices.
>>
>> I'm working on a fix that adds proper power management for input ports,
>> but this requires the driver to be reorganized a little ...
>
> Doesn't a simple patch like below work?

> +static int substream_open(struct snd_rawmidi_substream *substream, int open)
>  {
> +	if (open && umidi->opened++ == 0) {
> +		err = usb_autopm_get_interface(umidi->iface);
>
>  static int snd_usbmidi_input_open(struct snd_rawmidi_substream *substream)
>  {
> +	return substream_open(substream, 1);

No, because the input URBs are submitted before the userspace device is
opened.  (And usb_autopm_get_interface() cannot be called from the USB
probe callback.)


Regards,
Clemens
