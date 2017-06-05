From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: Re: [PATCH 1/4] thermal: uniphier: add UniPhier thermal driver
Date: Mon, 5 Jun 2017 17:42:28 +0900
Message-ID: <CAK7LNARtQfhx+854FHZenymX4Em4LYWSWUsH2iPp4fb9D7xXHA@mail.gmail.com>
References: <1496049345-14649-2-git-send-email-hayashi.kunihiko@socionext.com>
 <20170529164816.GA14822@localhost.localdomain> <20170530182141.6865.4A936039@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170530182141.6865.4A936039-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kunihiko Hayashi <hayashi.kunihiko-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

2017-05-30 18:21 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>:

>> > +static const struct uniphier_tm_soc_data uniphier_pxs2_tm_data = {
>> > +   .map_base        = 0xe000,
>> > +   .block_base      = 0xe000,
>> > +   .tmod_setup_addr = 0xe904,
>> > +};
>> > +
>> > +static const struct uniphier_tm_soc_data uniphier_ld20_tm_data = {
>> > +   .map_base        = 0xe000,
>> > +   .block_base      = 0xe800,
>> > +   .tmod_setup_addr = 0xe938,
>>
>> Shouldn't these be in your device tree using the register properties?
>> I see at least the map base as possible to be done in DT.

True for simple-bus.

However, the combination of "simple-mfd" and "syscon"
seems a well established strategy when
registers are mixed/interleaved in a syscon block.

(For example, chip-control@ea0000 node of
arch/arm/boot/dts/berlin2.dtsi)


> I think so.
> However, the iomap of this device are included in sysctrl(simple-mfd),
> and I can't find the method to express offset from base-address of sysctrl
> on DT, instead of map_base, in resonable way.
>
> I think that mfd node has register property then the lower node of mfd,
> that is the thermal node, can't have register property.
>
> If the driver gets offset address from DT, I'll define new property
> like 'socionext,reg_offset' in the thermal node. But I'm not sure that.

socionext,uniphier-{pxs2,ld20}-thermal is an SoC-specific compatible string.
The internal-offset is included
in the HW-spec associated with the compatible.
I believe 'socionext,reg_offset' is pointless.


-- 
Best Regards
Masahiro Yamada
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
