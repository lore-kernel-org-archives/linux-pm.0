From: James Liao <jamesjj.liao@mediatek.com>
Subject: Re: [PATCH] soc: mediatek: Fix random hang up issue while kernel
 init
Date: Fri, 2 Oct 2015 11:00:38 +0800
Message-ID: <1443754838.1714.94.camel@mtksdaap41>
References: <1443162717-64831-1-git-send-email-jamesjj.liao@mediatek.com>
	 <1443169573.3135.9.camel@pengutronix.de> <5607D224.4050801@gmail.com>
	 <CAGS+omCXMRf4bxWancSJSq2a1pc38TYYY46Os9ASWWCRp95_ig@mail.gmail.com>
	 <1443604022.3185.17.camel@pengutronix.de>
	 <1443683750.1714.25.camel@mtksdaap41>
	 <CAGS+omCpWqtKPKoyjFb=q4BxmfUGGsfvQGEZas8g8VLZKPtKbQ@mail.gmail.com>
	 <1443691590.1714.73.camel@mtksdaap41>
	 <CAGS+omCm2pKczooGkMf75HjQL=oF7Ufo6DsRCvvikt0QA1jx-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAGS+omCm2pKczooGkMf75HjQL=oF7Ufo6DsRCvvikt0QA1jx-g@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Lucas Stach <l.stach@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, Kevin Hilman <khilman@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, rjw@sisk.pl
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On Thu, 2015-10-01 at 18:08 +0800, Daniel Kurtz wrote:
> I see two cases where "a power domain is a consumer of a clock":
>   (a) the clock is needed to access the power domain control
> registers.  The clock must actually be in another power domain, since
> otherwise you could never turn *on* the power domain in question.
>   (b) the clock is needed to talk to the power domain that is about to
> turn off, or that was just turned on - these clocks are usually used
> to control some kind of bus arbitration, etc.  In this case, the
> clocks are only accessed when the power domain is on.
> 
> I would argue that in both cases, the clock should in theory should
> only be enabled/disabled by the power on/off routine for the duration
> of time that is needed, and that it should not be "left enabled" by
> the power domain on/off function...  I can see how this might be a
> useful optimization - but it also seems like a way to burn extra power
> by leaving on a clock that is not necessarily being used.
> 
> But - perhaps I am over thinking this, and it is standard practice to
> bundle power domains with the clocks that service components in the
> power domain.

Yes, you are right. Power domain on/off operations need clocks to get
status of the subsystem. Keeping clocks on during power domain on is an
optimization.

But to model a clock controller as a power domain consumer, or say we
need to control power domain before clock on/off, is not a good practice
because we always consider clock operations should be light weight.
Power domains should be controlled explicitly by subsystem drivers,
instead of hiding behind clock controls.

> Or, alternatively, just prepare venc_sel once during init, for each
> clock controller that needs it, when configuring the clock controller
> node (for example, in mtk_vencsys_init()). This is similar to how we
> set up 'critical clocks'.
> By just preparing the clock, you tell the common clock core:
>  "my clock controller will need this clock later; please make sure
> that it can be enabled/disabled later during atomic context."

In current implementation, PLLs will be turned on in clk_prepare(). So
if a clock is always prepared, its parent PLL will be kept on even if
the clock is not enabled. It consumes extra power, so we don't prefer
this kind of solution.


Best regards,

James


