From: dawei chien <dawei.chien@mediatek.com>
Subject: Re: [PATCH v3 0/2] thermal: mediatek: Add cpu power cooling model
Date: Wed, 11 Nov 2015 20:00:45 +0800
Message-ID: <1447243245.11462.19.camel@mtksdaap41>
References: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
	 <20151028154449.GH3716@ubuntu> <1446461181.10039.28.camel@mtksdaap41>
	 <20151102121034.GA3639@ubuntu> <1446721761.4016.56.camel@mtksdaap41>
	 <20151106032046.GK3773@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:33799 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752173AbbKKMAu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2015 07:00:50 -0500
In-Reply-To: <20151106032046.GK3773@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>

On Fri, 2015-11-06 at 08:50 +0530, Viresh Kumar wrote:
> On 05-11-15, 19:09, dawei chien wrote:
> > Thank you for your kindly explaining, now I could understand what I
> > miss, I will send device tree binding on next version such like
> > following description.
> > 
> > --- a/Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
> > +++ b/Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
> > @@ -10,6 +10,17 @@ Required properties:
> >         Please refer to
> > Documentation/devicetree/bindings/clk/clock-bindings.txt for
> >         generic clock consumer properties.
> >  - proc-supply: Regulator for Vproc of CPU cluster.
> > +- dynamic-power-coefficient:
> > +       Usage: optional
> > +       Value type: <prop-encoded-array>
> > +       Definition: A u32 value that represents an indicative
> > +       running time dynamic power coefficient in
> > +       fundamental units of mW/MHz/uVolt^2.
> > +       The dynamic energy consumption of the CPU
> > +       is proportional to the square of the
> > +       Voltage (V) and the clock frequency (f).
> > +       Pdyn = dynamic-power-coefficient * V^2 * f
> > +       where voltage is in uV, frequency is in MHz.
> 
> Please check with Punit if he is planning to add the same.
Punit just sent the patch for this binding[1] yesterday, so I will re-send next version once his patch has been reviewed.
> > Thank you for your kindly explaining, Now I know I should develop and
> > test on mainline branch since this is where I try to add code.
> > 
> > However, please understanding currently mt8173_cpufreq.c is not ready
> > for OPPV2 in mainline as far, that's the reason why currently I can't
> > reuse OPPV2 and extend for static power table. My propose is for adding
> > CPU cooling device for our own product.
> 
> Firstly, we don't care. You are pushing something to mainline, you
> have to get it tested someway on mainline.
> 
> Secondly, there are *almost* no changes required to the mtk cpufreq
> driver for OPPV2. Just update your DT in a similar way it is done for
> one of the exynos platforms and it should just work fine.
> 
In our platform, thermal throttling is good enough with dynamic power
only, so my plan is to send dynamic power model first in next version.

Regarding static power model, we will continue discussing with ARM to
find a better solution.

Thanks.

[1] https://lkml.org/lkml/2015/11/9/542

BR,
Dawei


