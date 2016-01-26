From: Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
Date: Tue, 26 Jan 2016 15:35:33 +0800
Message-ID: <56A721C5.4050606@rock-chips.com>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
 <1452598189-8272-1-git-send-email-andy.yan@rock-chips.com>
 <20160120182840.GA15741@rob-hp-laptop> <56A07A6D.3010406@rock-chips.com>
 <20160125171134.GA21713@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.132]:47650 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbcAZHfs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jan 2016 02:35:48 -0500
In-Reply-To: <20160125171134.GA21713@rob-hp-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: heiko@sntech.de, arnd@arndb.de, john.stultz@linaro.org, linux@roeck-us.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, catalin.marinas@arm.com, geert+renesas@glider.be, sre@kernel.org, olof@lixom.net, dbaryshkov@gmail.com, alexandre.belloni@free-electrons.com, jun.nie@linaro.org, pawel.moll@arm.com, f.fainelli@gmail.com, will.deacon@arm.com, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, cernekee@gmail.com, linux-kernel@vger.kernel.org, dwmw2@infradead.org, mark.rutland@arm.com, maxime.ripard@free-electrons.com

Hi Rob:

On 2016=E5=B9=B401=E6=9C=8826=E6=97=A5 01:11, Rob Herring wrote:
> On Thu, Jan 21, 2016 at 02:27:57PM +0800, Andy Yan wrote:
>> Hi Rob:
>>     thanks for your review.
>> On 2016=E5=B9=B401=E6=9C=8821=E6=97=A5 02:28, Rob Herring wrote:
>>> On Tue, Jan 12, 2016 at 07:29:49PM +0800, Andy Yan wrote:
>>>> add device tree binding document for reboot-mode driver
>>>>
>>>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>>>
>>>> ---
>>>>
>>>> Changes in v2: None
>>>> Changes in v1: None
>>>>
>>>>   .../bindings/power/reset/reboot-mode.txt           | 41 ++++++++=
+++++++++
>>>>   .../bindings/power/reset/syscon-reboot-mode.txt    | 52 ++++++++=
++++++++++++++
>>>>   2 files changed, 93 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/power/reset=
/reboot-mode.txt
>>>>   create mode 100644 Documentation/devicetree/bindings/power/reset=
/syscon-reboot-mode.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/power/reset/reboot-=
mode.txt b/Documentation/devicetree/bindings/power/reset/reboot-mode.tx=
t
>>>> new file mode 100644
>>>> index 0000000..81d9f66
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/power/reset/reboot-mode.tx=
t
>>>> @@ -0,0 +1,41 @@
>>>> +Generic reboot mode core map driver
> [...]
>
>>>> +		compatible =3D "syscon-reboot-mode";
>>>> +		offset =3D <0x40>;
>>> This doc by itself is a little confusing. For example, is a child o=
f the
>>> syscon node? I would remove offset (and perhaps compatible) from th=
is
>>> example.
>>     Yes, is a child of a syscon mapped node. For example, Rockchip p=
latform
>> use a register of PMU(rk3066/rk3288) or GRF(rk3036), PMU and GRF are=
 aleady
>> mapped by syscon.
>>     offset and compatible are used by write interface driver like
>> syscon-reboot-mode.c. If you don't like it appear in the core map do=
c, I
>> will move it to the syscon-reboot-mode.txt?
> Yes, try to make this doc stand on its own. It will obviously be
> incomplete lacking information on where in the DT it goes. So perhaps=
 a
> note stating reboot-mode node location is defined in platform specifi=
c
> binding docs.
>
>>>> +
>>>> +		loader {
>>>> +			linux,mode =3D "loader";
>>>> +			loader,magic =3D <BOOT_LOADER>;
>>>> +		};
>>> Sorry, my previous suggestion was not clear. I'm suggesting get rid=
 of
>>> the subnodes and just do properties like this:
>>>
>>> loader =3D <BOOT_LOADER>;
>>> maskrom =3D <BOOT_MASKROM>;
>>>
>>> That's the same amount of information unless node names and linux,m=
ode
>>> values are going to diverge. Do they need to? I can't see a reason.
>>      Because the command"linux,mode" and value"loader,magic" is vend=
or
>> specific. I don't know what commands and how many mode other platfor=
m will
>> use. So as John says in his reply, this sort of flexibility help us =
adapt
>> the driver to different hardware/system environments.
> The only part of "reboot to fastboot" that is vendor specific would b=
e
> the magic value. While we can have custom modes, we should standardiz=
e
> the common ones as much as possible. As I pointed out in my reply to
> John, we can still support vendor specific modes with just a property=
=2E

     Based your reply to John, I rebuild the code like bellow, I hope t=
his
     is what you mean.

     DTS file:
     reboot-mode {
                         compatible =3D "syscon-reboot-mode";
                         offset =3D <0x94>;
                         mode-normal =3D <BOOT_NORMAL>;
                         mode-recovery =3D <BOOT_RECOVERY>;
                         mode-fastboot =3D <BOOT_FASTBOOT>;
                         mode-loader =3D <BOOT_LOADER>;
                         mode-maskrom =3D <BOOT_MASKROM>;
                 };


    driver:

     #define PREFIX "mode-"

     struct property *prop;
     size_t len =3D strlen(PREFIX);
     for_each_property_of_node(dev->of_node, prop) {
                 if (len > strlen(prop->name) || strncmp(prop->name,=20
PREFIX, len))
                         continue;
                 info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
                 if (!info)
                         return -ENOMEM;
                 strcpy(info->mode, prop->name + len);
                 if (of_property_read_u32(dev->of_node, prop->name,=20
&info->magic)) {
                         dev_err(dev, "reboot mode %s without magic=20
number\n",
                                 info->mode);
                         devm_kfree(dev, info);
                         continue;
                 }
                 list_add_tail(&info->list, &reboot->head);
         }


>>> We need to be clear what loader means. More specifically, it is boo=
t
>>> into bootloader shell.
>>      Actually, Rockchip platform will reboot into a bootloader downl=
oad mode
>> with this command. This mode can download faster than maskrom downlo=
ad mode.
> My point is proven. I assumed one thing and you meant something else.
> Doesn't matter what the mode is, just needs to be clear.
>
> Rob
>
>
>


