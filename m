From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v2 00/11] add support for VBUS max current and min voltage
 limits AXP20X and AXP22X PMICs
Date: Sat, 21 Jan 2017 09:10:36 +0800
Message-ID: <CAGb2v679kG8eisNa=Bmo+o0DVm7xn7x=N9i7H7mB5n_Y2X=qLw@mail.gmail.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com> <20170112092821.5xkgpsbbsxaz3s7h@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170112092821.5xkgpsbbsxaz3s7h@lukather>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Jan 12, 2017 at 5:28 PM, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Fri, Dec 09, 2016 at 12:04:08PM +0100, Quentin Schulz wrote:
>> The X-Powers AXP209 and AXP20X PMICs are able to set a limit for the
>> VBUS power supply for both max current and min voltage supplied. This
>> series of patch adds the possibility to set these limits from sysfs.
>>
>> Also, the AXP223 PMIC shares most of its behaviour with the AXP221 but
>> the former can set the VBUS power supply max current to 100mA, unlike
>> the latter. The AXP223 VBUS power supply driver used to probe on the
>> AXP221 compatible. This series of patch introduces a new compatible for
>> the AXP223 to be able to set the current max limit to 100mA.
>>
>> With that new compatible, boards having the AXP223 see their DT updated
>> to use the VBUS power supply driver with the correct compatible.
>>
>> This series of patch also migrates from of_device_is_compatible function
>> to the data field of of_device_id to identify the compatible used to
>> probe. This improves the code readability.
>>
>> Mostly cosmetic changes in v2 and adding volatile and writeable regs to
>> AXP20X and AXP22X MFD cells for the VBUS power supply driver.
>
> Applied all the DT patches. I also fixed all the prefixes. Please make
> sure to look at what prefixes are used by a given subsystem next time.

I'm not seeing the DT patches. FYI the old DT does not work with the
new kernel driver updates. Because of the new AXP223 specific compatible
for the usb-power-supply, the updated mfd driver cannot match the old
device node, and the probe will fail at

        if (!of_device_is_available(pdev->dev.of_node))
                return -ENODEV;

I don't see an easy way out of this though. The mfd_cell structure only
takes one compatible string.

Regards
ChenYu

> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
