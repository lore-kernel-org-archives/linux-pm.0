From: Tyler Hall <tylerwhall-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] thermal: armada: read stable temp on Armada XP
Date: Wed, 25 Feb 2015 14:47:11 -0500
Message-ID: <CAOjnSCZa+H+KRDJ+rug4OoinYEVN_fRrh4-fd4u_zzMEVNzjbQ@mail.gmail.com>
References: <1423608615-6575-1-git-send-email-tylerwhall@gmail.com>
 <20150224183616.GD3448@developer.amazonguestwifi.org> <CAOjnSCaH5NtcYGdfQ+=XY9ZJtjYEEgLWKCGUeFXBsM1f+va-LA@mail.gmail.com>
 <54EDF3E6.6040409@free-electrons.com> <20150225183901.GD2306@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150225183901.GD2306-ld4jwAGwUXRveXEdyy5Li2QTnQI6vUnv7KzsFvvc4iU@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Gregory, Eduardo,

On Wed, Feb 25, 2015 at 05:10:14PM +0100, Gregory CLEMENT wrote:
> By using it by default do you mean removing marvell,armadaxp-thermal
> and adding armadaxp-filtered-thermal instead ?

Yes, replacing it in device tree. For me,
/sys/class/thermal/thermal_zone0/temp returns the same temperature but
with less variability between samples. My intent was to switch the
source of the data and not affect user space other than providing a
more stable reading.

> Tyler,
> In the meantime could you double check your values? The temperature on my board
> seemed broken on my board. If needed I can check on an other board. By the way
> on which board/product did you try it?

I'm on a custom board with the 4-core MV78460. In addition to my
patch, this is new device tree entry.

                        thermal@184c4 {
                               compatible = "marvell,armadaxp-filtered-thermal";
                               reg = <0x184c4 0x4
                                        0x184d0 0x4>;
                                status = "okay";
                        };

I dumped some raw samples of the temperature fields in each of these
registers. This CSV contains the raw values converted to decimal.
http://pastebin.com/Umc3cy5L
The first column is the current register at 0x182b0 27:19 and the
second is the register at 0x184c4 9:1.

Here's a quick plot of a larger sample size while the temperature was rising.
https://imgur.com/E9HlSBx
The blue value is the current 0x182b0 register which seems to bounce
around the green value from 0x184c4.

I'll try a test of instantiating both at the same time and comparing
the final output of the driver.

On Wed, Feb 25, 2015 at 1:39 PM, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Does that new thermal sensors only improve the stability or does it
>> also modify the value?
>>
>> In the second case it will more or less break the user space expectation.
>
> Yeah, I agree here. We need to understand if this is:
> (1) a fix of which register to use. In that case, the old dtbs are
> essentially wrong, and the driver would need to adapt, I would say.
> (2) a way to report better temperature extrapolations. then, this is
> essentially a new temp sensor, and we should have two separated
> compatible. in other words, just keep the patch the way it is.

This *might* be a different physical sensor, or it could be from the
same source with some averaging/filtering applied in hardware. The
conversion formula is the same, however, and I get similar raw values
from both.

> Yes. Typically I ask to see the complete series, even if I am not taking
> the DTS changes. That is, you send a complete series, with changes in
> the kernel code and in the DTS, copying the required audience (from
> kernel side and from DT side). Once the changes are accepted, the
> patches will be picked by the correct tree maintainer. It is common that
> DTS changes go via the platform tree, to avoid conflicts though.

Thanks for the clarification. I'll send both in the next version as I
suspect there will be a v2 of this change.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
