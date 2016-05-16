From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [PATCH-V2 5/5] ARM: multi_v7_defconfig: bcm2835: add bcm2835-thermal driver
Date: Mon, 16 May 2016 20:17:45 +0200
Message-ID: <40E50EF4-240B-4E40-8344-1F9042EC1473@martin.sperl.org>
References: <1463145186-12906-1-git-send-email-kernel@martin.sperl.org> <1463145186-12906-6-git-send-email-kernel@martin.sperl.org> <5739F8AC.8080003@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5739F8AC.8080003-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org


> On 16.05.2016, at 18:43, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> On 05/13/2016 06:13 AM, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>> 
>> Add the thermal driver to list of compiled modules in
>> multi_v7_defconfig.
>> 
>> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>> ---
>> arch/arm/configs/multi_v7_defconfig | 1 +
>> 1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 2823490..5f0f5a3 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -422,6 +422,7 @@ CONFIG_CPU_THERMAL=y
>> CONFIG_ROCKCHIP_THERMAL=y
>> CONFIG_RCAR_THERMAL=y
>> CONFIG_ARMADA_THERMAL=y
>> +CONFIG_BCM2835_THERMAL=y
> 
> Does this need to be built into the kernel?
> 
Not necessarily, but as most other drivers in this context
are built in this one was added as such as well.

If the policy is different, then I can change it...


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
