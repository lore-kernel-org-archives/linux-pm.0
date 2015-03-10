From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
Date: Tue, 10 Mar 2015 08:20:43 +0530
Message-ID: <CAKohpokT7fSniPGX2BfM61AtMoMCxEP8WDtbZ34bozUXscEWyg@mail.gmail.com>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
	<1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
	<CAKohpo=c2t4_2hdPP-vQM7xewK5SXaHBGNA9PhvTwDv3++pSTg@mail.gmail.com>
	<CALx668VypyWbVuph0ir0SRt4kqASvYzwBuyc_r5tFeoHi+HieA@mail.gmail.com>
	<CAKohpomxXTP6NdPoSmB=eq2sFqqgskS5vYtDNAT6a0VL5K6dCg@mail.gmail.com>
	<CALx668VFRdeWcK_gKhJrJehnaH5uDpA0m2OfHLqPVUq8oocXaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:34889 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbbCJCuo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2015 22:50:44 -0400
Received: by obcwo20 with SMTP id wo20so2849742obc.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2015 19:50:44 -0700 (PDT)
In-Reply-To: <CALx668VFRdeWcK_gKhJrJehnaH5uDpA0m2OfHLqPVUq8oocXaw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>, Mark Brown <broonie@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Mike Turquette <mturquette@linaro.org>, Chen Fan <fan.chen@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.k>

On 6 March 2015 at 11:19, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
> On 5 March 2015 at 17:55, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> About putting
> those stuff into regulator driver, I think you mean creating a
> "virtual regulator
> device" and put all the voltage controlling complex into the driver, right?
> Maybe it's a good idea in this case, but I am sure if this kind of
> virtual regulator is acceptable.

@Mark: Is this allowed to create virtual regulator for a CPU ?

> And the flexibility might be an issue, since we might
> use different
> PMIC for same SoC on different board.

We can talk about that separately once Mark replies to my query.


> Combining comments and suggestions from you and Sascha[1], I conclude some
> architectural changes are going to be made in the next version:
>
> 1. Use set_rate hook instead of determine_rate in clk driver, and
> switch to intermeidate
>     PLL parent and back to original CPU PLL parent explicitly in set_rate

Lets wait for Russell's answer to the query I posted before making any
progress here.
