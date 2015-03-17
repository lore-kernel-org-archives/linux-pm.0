From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v5 1/3] of: Add binding for NVIDIA Tegra ACTMON node
Date: Tue, 17 Mar 2015 10:25:54 +0100
Message-ID: <CAAObsKBbxrRfqJGN1NH1V3YqMBG_qv1WZnFDZKzuHTake4PZyA@mail.gmail.com>
References: <1418719298-25314-1-git-send-email-tomeu.vizoso@collabora.com>
 <1418719298-25314-2-git-send-email-tomeu.vizoso@collabora.com> <CAL_JsqLRWLrNHbtOxWMm1MnkuppAL9CJh4BGk2RgyrniFuxo0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34589 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086AbbCQJ0Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2015 05:26:16 -0400
In-Reply-To: <CAL_JsqLRWLrNHbtOxWMm1MnkuppAL9CJh4BGk2RgyrniFuxo0g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Alexandre Courbot <gnurou@gmail.com>, Mikko Perttunen <mikko.perttunen@kapsi.fi>, Arto Merilainen <amerilainen@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 9 January 2015 at 16:16, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, Dec 16, 2014 at 2:41 AM, Tomeu Vizoso
> <tomeu.vizoso@collabora.com> wrote:
>> This block gathers statistics about various counters and can be configured to
>> fire interrupts when thresholds are crossed.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>
>> ---
>>
>> v2:     * Add operating-points property
>> ---
>>  .../devicetree/bindings/arm/tegra/actmon.txt       | 38 ++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/actmon.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/tegra/actmon.txt b/Documentation/devicetree/bindings/arm/tegra/actmon.txt
>> new file mode 100644
>> index 0000000..b4069df
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/tegra/actmon.txt
>> @@ -0,0 +1,38 @@
>> +Tegra124 Activity Monitor driver
>> +
>> +Required properties:
>> +
>> +- compatible: should be "nvidia,tegra124-actmon"
>> +- reg: offset and length of the register set for the device
>> +- interrupts: standard interrupt property
>> +- clocks: Must contain a phandle and clock specifier pair for each entry in clock-names. See ../clock/clock-bindings.txt for details.
>> +- clock-names: Must include the following entries:
>> +  - actmon
>> +  - emc
>> +- resets: Must contain an entry for each entry in reset-names. See ../reset/reset.txt for details.
>> +- reset-names: Must include the following entries:
>> +  - actmon
>> +- operating-points: Supported operating points. See ../power/opp.txt for details.
>
> FYI, we are looking to deprecate this and do something more
> extensible[1]. I'm not saying don't use this, but input on the new one
> would be helpful. This is also the 2nd bus scaling binding I've
> reviewed this week (Exynos being the other). I like the simplicity of
> this, but would like something common even more.

I see, but this one is modelling just the ACTMON IP block, which just
gathers statistics and can fire interrupts when some thresholds are
surpassed. Memory bus scaling itself is performed by the EMC driver
(External memory clock).

> This somewhat seems like it is in the wrong place. Is this for scaling
> internal buses or DDR? Is it the activity monitor that also does the
> frequency changes? I would expect the DDR controller to do that and
> then the OPPs should be part of the DDR controller.

You are right, in the next version I have removed the OPP data from
the ACTMON node and the driver now uses the CCF API to find out what
frequencies are supported by the EMC clock.

Thanks,

Tomeu

> Rob
>
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/308629.html
>
>> +
>> +Example:
>> +       actmon@6000c800 {
>> +               compatible = "nvidia,tegra124-actmon";
>> +               reg = <0x0 0x6000c800 0x0 0x400>;
>> +               interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
>> +               clocks = <&tegra_car TEGRA124_CLK_ACTMON>,
>> +                        <&tegra_car TEGRA124_CLK_EMC>;
>> +               clock-names = "actmon", "emc";
>> +               resets = <&tegra_car 119>;
>> +               reset-names = "actmon";
>> +               operating-points = <
>> +                       /* kHz  uV */
>> +                       102000  800000
>> +                       204000  800000
>> +                       300000  820000
>> +                       396000  850000
>> +                       528000  880000
>> +                       600000  910000
>> +                       792000  980000
>> +                       924000  1010000
>> +               >;
>> +       };
>> --
>> 1.9.3
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
