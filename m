From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] soc: mediatek: Fix random hang up issue while kernel init
Date: Fri, 2 Oct 2015 17:25:29 +0800
Message-ID: <CAGS+omBQLVGeWrNoD+8L_J0C9DjzkXO_cfph2tQgMGiPBJq2vw@mail.gmail.com>
References: <1443162717-64831-1-git-send-email-jamesjj.liao@mediatek.com>
 <1443169573.3135.9.camel@pengutronix.de> <5607D224.4050801@gmail.com>
 <CAGS+omCXMRf4bxWancSJSq2a1pc38TYYY46Os9ASWWCRp95_ig@mail.gmail.com>
 <1443604022.3185.17.camel@pengutronix.de> <1443683750.1714.25.camel@mtksdaap41>
 <CAGS+omCpWqtKPKoyjFb=q4BxmfUGGsfvQGEZas8g8VLZKPtKbQ@mail.gmail.com>
 <1443691590.1714.73.camel@mtksdaap41> <CAGS+omCm2pKczooGkMf75HjQL=oF7Ufo6DsRCvvikt0QA1jx-g@mail.gmail.com>
 <1443754838.1714.94.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1443754838.1714.94.camel@mtksdaap41>
Sender: linux-clk-owner@vger.kernel.org
To: James Liao <jamesjj.liao@mediatek.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, Kevin Hilman <khilman@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, rjw@sisk.pl
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 2, 2015 at 11:00 AM, James Liao <jamesjj.liao@mediatek.com> wrote:
> Hi Daniel,
>
> On Thu, 2015-10-01 at 18:08 +0800, Daniel Kurtz wrote:
>> I see two cases where "a power domain is a consumer of a clock":
>>   (a) the clock is needed to access the power domain control
>> registers.  The clock must actually be in another power domain, since
>> otherwise you could never turn *on* the power domain in question.
>>   (b) the clock is needed to talk to the power domain that is about to
>> turn off, or that was just turned on - these clocks are usually used
>> to control some kind of bus arbitration, etc.  In this case, the
>> clocks are only accessed when the power domain is on.
>>
>> I would argue that in both cases, the clock should in theory should
>> only be enabled/disabled by the power on/off routine for the duration
>> of time that is needed, and that it should not be "left enabled" by
>> the power domain on/off function...  I can see how this might be a
>> useful optimization - but it also seems like a way to burn extra power
>> by leaving on a clock that is not necessarily being used.
>>
>> But - perhaps I am over thinking this, and it is standard practice to
>> bundle power domains with the clocks that service components in the
>> power domain.
>
> Yes, you are right. Power domain on/off operations need clocks to get
> status of the subsystem. Keeping clocks on during power domain on is an
> optimization.
>
> But to model a clock controller as a power domain consumer, or say we
> need to control power domain before clock on/off, is not a good practice
> because we always consider clock operations should be light weight.
> Power domains should be controlled explicitly by subsystem drivers,
> instead of hiding behind clock controls.
>
>> Or, alternatively, just prepare venc_sel once during init, for each
>> clock controller that needs it, when configuring the clock controller
>> node (for example, in mtk_vencsys_init()). This is similar to how we
>> set up 'critical clocks'.
>> By just preparing the clock, you tell the common clock core:
>>  "my clock controller will need this clock later; please make sure
>> that it can be enabled/disabled later during atomic context."
>
> In current implementation, PLLs will be turned on in clk_prepare(). So
> if a clock is always prepared, its parent PLL will be kept on even if
> the clock is not enabled. It consumes extra power, so we don't prefer
> this kind of solution.

Actually, I should have proposed adding prepare / unprepare callbacks
to mtk_clk_gate_ops in which we prepare_enable/disable_unprepare
venc_sel (& mm_sel).
This should correctly track all of the clk reference counting needed
to access the venc clock control registers.


However, this would not actually solve the issue that this patch is
trying to fix, since nobody would have called the
prepare_clk(venc_cke0) before clk_disable_unused_subtree(venc_cke0).
Bummer.

I think the crux of the original issue is that the mediatek/clk-gate.c
is_enabled() callbacks may be called at a point in time when venc_sel
is disabled but VENC PD is enabled.
So, perhaps an easier, but still a little hacky way out is to keep the
clk & PD problems separate, and just check __clk_is_enabled(venc_sel)
before reading the venc clk status register.

WDYT?

By the way, I'm not really opposed to your current implementation
either, I was just helping Matthias & Lucas understand in enough
detail that they can help review.

-Dan

>
>
> Best regards,
>
> James
>
>
