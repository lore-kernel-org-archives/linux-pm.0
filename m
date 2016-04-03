From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: dtc warnings
Date: Sun, 3 Apr 2016 12:29:09 +0530
Message-ID: <20160403065909.GF2987@vireshk-i7>
References: <CAL_Jsq+=OjY8y_8x7OSm-MWYKbrHN5cbv4TLwULxhNq+gfiMtw@mail.gmail.com>
 <56FE27F9.2070100@gmail.com>
 <CAJKOXPdDyVbfSyshu4j21Ax2J-VwPpMZgAGEeO8VtgFYh4hTmw@mail.gmail.com>
 <56FE7E4A.2000601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36000 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbcDCG7R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 3 Apr 2016 02:59:17 -0400
Received: by mail-pf0-f182.google.com with SMTP id e128so99805971pfe.3
        for <linux-pm@vger.kernel.org>; Sat, 02 Apr 2016 23:59:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56FE7E4A.2000601@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Tomi Valkeinen <tomi.valkeinen@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, arm-platform-maintainers@lists.infradead.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 01-04-16, 08:57, Nishanth Menon wrote:
> On 04/01/2016 02:53 AM, Krzysztof Kozlowski wrote:
> > On Fri, Apr 1, 2016 at 4:49 PM, Tomi Valkeinen <tomi.valkeinen@gmail.com> wrote:
> >>
> >> Hi Rob,
> >>
> >> On 01/04/16 04:40, Rob Herring wrote:
> >>> You may have noticed that linux-next had gotten noisy with dtc
> >>> warnings lately. I dropped the change for a bit, but added it back
> >>> today except now it is disabled unless building with "W=1".
> >>>
> >>> There's ~25K (2500 unique) warnings generated from the ARM dts files.
> >>> Here's the ranking of warnings by dtb. OMAP is the clear winner (based
> >>> on the similar counts, probably lots of duplicates). Please help
> >>> remind contributors to test with W=1 and start to fix these.
> >>>
> >>> At least for memory nodes, I plan to whitelist allowing no
> >>> unit-address. There could be others, but none that I've seen so far.
> >>
> >> What's the correct way to fix nodes for display platform devices? For
> >> example, omap4-panda-common.dtsi has two connector nodes:
> >>
> >> dvi0: connector@0 {
> >>         compatible = "dvi-connector";
> >>         label = "dvi";
> >>         ...
> >> };
> >>
> >>
> >> hdmi0: connector@1 {
> >>         compatible = "hdmi-connector";
> >>         label = "hdmi";
> >>         ...
> >> };
> > 
> > I have the same doubts. The ePAPR says in that case "the node-name
> > alone differentiates the node from other nodes at the same level in
> > the tree.". But which is preferred? Differentiating by number or by
> > type?
> > 
> > Similarly, what to do with the opp modes (a lot of warnings) in
> > Documentation/devicetree/bindings/opp/opp.txt?

What warnings are you talking about ?

-- 
viresh
