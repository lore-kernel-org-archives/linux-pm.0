From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH V4 3/4] ARM: bcm2835: add thermal node to device-tree of
 bcm283x
Date: Tue, 13 Sep 2016 11:17:23 +0200
Message-ID: <e0bff5b1-533c-fdc0-3e61-54974571e385@i2se.com>
References: <1473407397-29395-1-git-send-email-kernel@martin.sperl.org>
 <1473407397-29395-4-git-send-email-kernel@martin.sperl.org>
 <19cc8fbf-6ceb-995e-850d-9d82bdaff8d0@i2se.com>
 <8876586A-98F8-4AAF-AD90-86EB12C22FDC@martin.sperl.org>
 <2117811305.32861.15854341-2f8e-4e20-95f4-e76f81e6fd56.open-xchange@email.1und1.de>
 <185DA6B2-AFC0-4199-A361-0164381AD317@martin.sperl.org>
 <677965855.33392.597ccfbe-225b-403b-8ffa-3f42292996d4.open-xchange@email.1und1.de>
 <704dd583-5bd8-fa77-a4ab-18f0845b9c4e@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <704dd583-5bd8-fa77-a4ab-18f0845b9c4e-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Cc: Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Am 13.09.2016 um 11:06 schrieb Martin Sperl:
>
>
> On 09.09.2016 21:02, Stefan Wahren wrote:
>> bcm2837.dtsi
>>
>> &thermal {
>>             compatible = "brcm,bcm2837-thermal";
>>             status = "okay";
>> };
>
> Note that there is only a bcm2837.dtsi in arm64/boot/dts/broadcom/
> but not in arm/boot/dts - at least with the current upstream kernel.
>
> So I will just patch those dtsi that exist right now.

That's correct as long as the bcm2837.dtsi change is a separate patch
for ARM64 and this was the reason for my "warning" in my first reply.

Stefan

>
> Martin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
