From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v6 2/4] power: reset: add reboot mode driver
Date: Mon, 28 Mar 2016 17:05:24 +0900
Message-ID: <56F8E5C4.5010000@samsung.com>
References: <1458646525-491-1-git-send-email-andy.yan@rock-chips.com>
 <1458646642-591-1-git-send-email-andy.yan@rock-chips.com>
 <CAJKOXPcKzGTAicbsXK-cC9WQT0vBhpSG_q2GCn37+72x2hdhsQ@mail.gmail.com>
 <56F39F36.5050702@rock-chips.com> <56F8D078.6040503@samsung.com>
 <56F8DFED.50905@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:52332 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754246AbcC1IFi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Mar 2016 04:05:38 -0400
In-reply-to: <56F8DFED.50905@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: robh+dt@kernel.org, sre@kernel.org, heiko@sntech.de, john.stultz@linaro.org, arnd@arndb.de, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, catalin.marinas@arm.com, olof@lixom.net, alexandre.belloni@free-electrons.com, dbaryshkov@gmail.com, jun.nie@linaro.org, pawel.moll@arm.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, matthias.bgg@gmail.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, f.fainelli@gmail.com, linux@arm.linux.org.uk, mbrugger@suse.com, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, linux-kernel@vger.kernel.org, wxt@rock-chips.com, dwmw2@infradead.org, mark.rutland@arm.com

On 28.03.2016 16:40, Andy Yan wrote:
> Hi Krzysztof :
>=20
> On 2016=E5=B9=B403=E6=9C=8828=E6=97=A5 14:34, Krzysztof Kozlowski wro=
te:
>> On 24.03.2016 17:03, Andy Yan wrote:
>>> Hi Krzystof:
>> (...)
>>
>>>>> +static int get_reboot_mode_magic(struct reboot_mode_driver *rebo=
ot,
>>>>> +                                const char *cmd)
>>>>> +{
>>>>> +       const char *normal =3D "normal";
>>>>> +       int magic =3D 0;
>>>>> +       struct mode_info *info;
>>>>> +
>>>>> +       if (!cmd)
>>>>> +               cmd =3D normal;
>>>>> +
>>>>> +       list_for_each_entry(info, &reboot->head, list) {
>>>>> +               if (!strcmp(info->mode, cmd)) {
>>>>> +                       magic =3D info->magic;
>>>>> +                       break;
>>>>> +               }
>>>>> +       }
>>>>> +
>>>>> +       return magic;
>>>> In absence of 'normal' mode (it is not described as required prope=
rty)
>>>> the magic will be '0'. It would be nice to document that in bindin=
gs.
>>>> Imagine someone forgets about this and will wonder why 0x0 is writ=
ten
>>>> to his precious register on normal reboot...
>>>      If the magic value is '0', we won't touch the register, please=
 see
>>> reboot_mode_notify bellow.
>> Ah, indeed... so we cannot use value of '0' for magic (e.g. to clear=
 any
>> existing value for normal reboot)?
>=20
>     It seems that the value '0' cannot be used.

How about mentioning it in bindings documentation?

(...)

>>>>> +               strcpy(info->mode, prop->name + len);
>>>> Ehm, and how do you protect that name of mode is shorter than 32
>>>> characters?
>>>      How about info->mode =3D prop->name + len ?
>> I don't get your answer.
>> As fair as I read the code, the prop->name can be very long and you =
are
>> copying it from 5 character. If the name of the mode has bazillion
>> characters then again my question: how do you protect that it will f=
it
>> in 32 bytes of 'mode'?
>=20
>     What I mean is set info->mode as a pointer point to prop->name + =
len
>=20
>    struct mode_info {
>             char *mode;
>             ..........
>             .........
>    }
>=20
>    info->mode =3D prop->name + len

Ahh, I get it. Then I guess you should also do of_node_get() and
of_node_put()... and use kstrdup_const(). Looks good but I am not
familiar with overlays and life-cycle of OF nodes (documentation for th=
e
life-cycle is a todo list item: Documentation/devicetree/todo.txt).

Best regards,
Krzysztof

