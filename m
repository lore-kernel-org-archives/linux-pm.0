From: Rob Herring <robh@kernel.org>
Subject: Re: dtc warnings
Date: Mon, 4 Apr 2016 00:16:56 -0500
Message-ID: <20160404051656.GV17806@rob-hp-laptop>
References: <CAL_Jsq+=OjY8y_8x7OSm-MWYKbrHN5cbv4TLwULxhNq+gfiMtw@mail.gmail.com>
 <56FE27F9.2070100@gmail.com>
 <CAJKOXPdDyVbfSyshu4j21Ax2J-VwPpMZgAGEeO8VtgFYh4hTmw@mail.gmail.com>
 <56FE7E4A.2000601@ti.com>
 <20160403065909.GF2987@vireshk-i7>
 <20160403080854.GA12133@kozik-lap>
 <CAKohpomijKf3m07Lc3+fWawxAPwe83F8k9akz1LOTokpZNL2ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50257 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754657AbcDDFRC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 Apr 2016 01:17:02 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpomijKf3m07Lc3+fWawxAPwe83F8k9akz1LOTokpZNL2ig@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Rob Herring <rob.herring@linaro.org>, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, arm-platform-maintainers@lists.infradead.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Sun, Apr 03, 2016 at 05:57:00PM +0530, Viresh Kumar wrote:
> On 3 April 2016 at 13:38, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> > Warnings coming from recent linux-next:
> >
> >   DTC     arch/arm/boot/dts/exynos5800-peach-pi.dtb
> > Warning (unit_address_vs_reg): Node /opp_table0/opp@1800000000 has a unit name, but no reg property
> > Warning (unit_address_vs_reg): Node /opp_table0/opp@1700000000 has a unit name, but no reg property
> 
> @Rob: What should we be doing about these warnings?
> OPP-entries don't have a reg property obviously and we
> discussed earlier if naming them based on freq is fine or
> not.

We can whitelist opp nodes in dtc, use oppN instead, or ignore the 
warnings for now. 

Rob
