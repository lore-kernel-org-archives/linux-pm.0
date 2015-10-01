From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] soc: mediatek: Fix random hang up issue while kernel init
Date: Thu, 1 Oct 2015 18:08:31 +0800
Message-ID: <CAGS+omCm2pKczooGkMf75HjQL=oF7Ufo6DsRCvvikt0QA1jx-g@mail.gmail.com>
References: <1443162717-64831-1-git-send-email-jamesjj.liao@mediatek.com>
 <1443169573.3135.9.camel@pengutronix.de> <5607D224.4050801@gmail.com>
 <CAGS+omCXMRf4bxWancSJSq2a1pc38TYYY46Os9ASWWCRp95_ig@mail.gmail.com>
 <1443604022.3185.17.camel@pengutronix.de> <1443683750.1714.25.camel@mtksdaap41>
 <CAGS+omCpWqtKPKoyjFb=q4BxmfUGGsfvQGEZas8g8VLZKPtKbQ@mail.gmail.com> <1443691590.1714.73.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:36445 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbbJAKIw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 06:08:52 -0400
Received: by ykdt18 with SMTP id t18so73993707ykd.3
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2015 03:08:51 -0700 (PDT)
In-Reply-To: <1443691590.1714.73.camel@mtksdaap41>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Liao <jamesjj.liao@mediatek.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, Kevin Hilman <khilman@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, rjw@sisk.pl

+linux-clk +linux-pm and the genpd and clock gurus

Hi James,

On Thu, Oct 1, 2015 at 5:26 PM, James Liao <jamesjj.liao@mediatek.com> wrote:
> Hi Daniel,
>
> On Thu, 2015-10-01 at 16:07 +0800, Daniel Kurtz wrote:
>> Hmm... below is my current understanding.
>>
>> In the current software architecture, we have split the "venc"
>> subsystem register space into two parts (two dt nodes), with each node
>> handled instantiated as its own  platform device, and handled by a
>> different platform driver:
>>
>> vencsys: clock-controller@18000000 {
>>   compatible = "mediatek,mt8173-vencsys", "syscon";
>>   reg = <0 0x18000000 0 0x1000>;
>>   #clock-cells = <1>;
>> };
>>
>> /* TBD - a venc driver has not been posted to the list so I don't
>> really know yet what it will look like */
>>  venc: encoder@~18000000 {
>>    compatible = "mediatek,mt8173-venc?";
>>    reg = <0 ~0x18000000 0 ?>;
>>    clocks = <& <&vencsys CLK_VENC_CKE1>, <&vencsys CLK_VENC_CKE0>, ...;
>>    clock-names = "apb", "smi", ...;
>>    ...
>>  };
>>
>> Each independent driver must take appropriate independent action to
>> ensure that any clock required to access its associated registers is
>> enabled when accessing said registers.
>> In other words,
>>  * the venc *clock-controller* driver that must enable any clocks
>> required to access the *clock control* registers
>>  * the venc *encoder* driver must enable clocks any clocks required to
>> access the *encoder* registers
>
>> Actually, the situation is a little worse that this, since we also
>> have a 'larb' node in the same register space, whose driver must also
>> ensure that VENC_SEL is enabled before accessing its registers:
>>
>> larb3: larb@18001000 {
>>   compatible = "mediatek,mt8173-smi-larb";
>>   reg = <0 0x18001000 0 0x1000>;
>>   mediatek,smi = <&smi_common>;
>>   power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC>;
>>   clocks = <&vencsys CLK_VENC_CKE1>, <&vencsys CLK_VENC_CKE0>;
>>   clock-names = "apb", "smi";
>> };
>>
>> Personally, I am not opposed to using the power-domain enable/disable
>> as a proxy for also enabling/disabling the "subsystem register bank"
>> clock as is done in this patch and by the scpsys driver in general.
>> However, it feels a bit like an abuse of the power domain api.
>>
>> > I preferred to keep venc_sel on during VENC power on because I'm not
>> > sure there is any other framework may control VENC's registers during
>> > kernel init.
>>
>> The misunderstanding here is the interpretation of "VENC's registers".
>> In this case, the registers in question are those owned by the
>> "vencsys: clock-controller@18000000" node, and the driver accessing
>> them is drivers/clk/mediatek/clk-gate.c.
>
> The situation is more complex than you mentioned above. VENC (0x18000000
> ~ 0x1800ffff) for example, if we want to avoid hanging up while
> accessing registers, we need to:
>
>  - Prevent venc_sel off while VENC is powered on.
>  - Prevent mm_sel off while MM is powered on.
>
> First, it's not worth to control power domains in clock control path
> because it's too expensive. So we want to keep clock on before accessing
> registers or during the domain is powered on.
>
> Besides, modeling a clock controller as a consumer of power domain may
> not a good idea, because there are power domains be consumers of clocks,
> such as:
>
>         [MT8173_POWER_DOMAIN_MM] = {
>                 .name = "mm",
>                 [...]
>                 .clk_id = MT8173_CLK_MM,
>                 [...]
>         },

I see two cases where "a power domain is a consumer of a clock":
  (a) the clock is needed to access the power domain control
registers.  The clock must actually be in another power domain, since
otherwise you could never turn *on* the power domain in question.
  (b) the clock is needed to talk to the power domain that is about to
turn off, or that was just turned on - these clocks are usually used
to control some kind of bus arbitration, etc.  In this case, the
clocks are only accessed when the power domain is on.

I would argue that in both cases, the clock should in theory should
only be enabled/disabled by the power on/off routine for the duration
of time that is needed, and that it should not be "left enabled" by
the power domain on/off function...  I can see how this might be a
useful optimization - but it also seems like a way to burn extra power
by leaving on a clock that is not necessarily being used.

But - perhaps I am over thinking this, and it is standard practice to
bundle power domains with the clocks that service components in the
power domain.

> Second, if we want to avoid hanging up by enabling related top clocks in
> clock controllers, we need to clock on venc_sel and mm_sel before *each
> clock operations*, and then clock off them after clock operations. That
> means:
>
> - To check venc_cke0's state:
>  = clk_prepare mm_sel and venc_sel (where to prepare?)
>   - It may turn on related PLLs, and it can't be invoked in an atomic
> context.
>  = clk_enable mm_sel and venc_sel.
>  = Read VENC's clock register.
>  = clk_disable mm_sel and venc_sel.
>  = clk_unprepare mm_sel and venc_sel (where to unprepare?)
>   - It may turn off PLLs, and it can't be invoked in an atomic context.
>  = Return venc_cke0's state.
>
> Overhead is a reason. The clock framework's API flow (prepare - enable -
> disable - unprepare) is another reason to reject the solution in clock
> controllers, because prepare/unprepare is a non-atomic operation but
> operations to access registers may be a atomic context.

Or, alternatively, just prepare venc_sel once during init, for each
clock controller that needs it, when configuring the clock controller
node (for example, in mtk_vencsys_init()). This is similar to how we
set up 'critical clocks'.
By just preparing the clock, you tell the common clock core:
 "my clock controller will need this clock later; please make sure
that it can be enabled/disabled later during atomic context."

Thanks!
-Dan

>
>
>
> Best regards,
>
> James
>
>
>
