From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [linux-sunxi] [PATCH 6/8] ARM: dts: axp209: Add usb_power_supply
 child node to the ax209 node
Date: Fri, 31 Jul 2015 14:14:28 +0800
Message-ID: <CAGb2v67nM7pauyjyhBdfgX7p_Rud6TEsNqphB+gx4ROekVqtbw@mail.gmail.com>
References: <1433885881-19809-1-git-send-email-hdegoede@redhat.com>
 <1433885881-19809-7-git-send-email-hdegoede@redhat.com> <CAGb2v66X79dK84hG8NVTho-kPPMNcKXQspvT2pCM8Zbmnme53A@mail.gmail.com>
 <20150731075104.48c467e6@pluto.restena.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:60924 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbbGaGOy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 Jul 2015 02:14:54 -0400
In-Reply-To: <20150731075104.48c467e6@pluto.restena.lu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans De Goede <hdegoede@redhat.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>

On Fri, Jul 31, 2015 at 1:51 PM, Bruno Pr=C3=A9mont
<bonbons@linux-vserver.org> wrote:
> Hi ChenYu,
>
> On Fri, 31 Jul 2015 13:31:53 +0800 Chen-Yu Tsai wrote:
>> Hi Hans,
>>
>> On Wed, Jun 10, 2015 at 5:37 AM, Hans de Goede <hdegoede@redhat.com>=
 wrote:
>> > Add a node representing the usb power supply part of the axp209 pm=
ic, note
>> > that the usb power supply and the (to be added later) ac power sup=
ply will
>> > each have their own child-node, so that they can be separately spe=
cified
>> > as power-supply for other nodes using a power-supply property with=
 a
>> > phandle pointing to the right axp209 child-node.
>> >
>> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> > ---
>> >  arch/arm/boot/dts/axp209.dtsi | 5 +++++
>> >  1 file changed, 5 insertions(+)
>> >
>> > diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp=
209.dtsi
>> > index 24c935c..051ab3b 100644
>> > --- a/arch/arm/boot/dts/axp209.dtsi
>> > +++ b/arch/arm/boot/dts/axp209.dtsi
>> > @@ -89,4 +89,9 @@
>> >                         regulator-name =3D "ldo5";
>> >                 };
>> >         };
>> > +
>> > +       usb_power_supply: usb_power_supply {
>> > +               compatible =3D "x-powers,axp202-usb-power-supply";
>> > +               status =3D "disabled";
>>
>> Is there any reason to have this disabled by default?
>> AFAIK this is not something configurable in hardware,
>> and the driver just gives readouts and status updates.
>
> There are some devices that only have 'AC-IN' instead of usb/otg powe=
r
> (set-top boxes) so having the devices tell what power sources they
> have makes sense (otherwise those that have ac-in instead of otg woul=
d
> have to disable usb_power_supply) and avoids confusion by explicitly
> stating presence in device dts.

That's true. But this is a bit of hardware inside the AXP.
If it's power isn't routed, it should report it, shouldn't it?

And normal users would probably expect to read the input
voltage/current/status through sysfs (or maybe hwmon?),
instead of not finding the device and having to look through
the DTS.

If you're using a distro, you might not have the kernel sources
around, and digging through the in-system device tree isn't that
straightforward if you don't know where to look.

> NB: I should hopefully get my battery supply driver ported this WE,
> ac-in/rtc are done, this WE. I'm going to default-off for them as wel=
l
> (note that for some extra details should be provided in dts).

I'm guessing we won't be using the axp288 one?

Thanks
ChenYu

> Bruno
>
>> ChenYu
>>
>> > +       };
>> >  };
>> > --
>> > 2.3.6
