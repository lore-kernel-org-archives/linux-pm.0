From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
Date: Wed, 18 Mar 2015 12:29:43 +0530
Message-ID: <CAKohpon8kXzfeKUUwrRhuei0cY9iVbMHfBjDwXW=M2SAYHdtYQ@mail.gmail.com>
References: <1425458956-20665-1-git-send-email-pi-cheng.chen@linaro.org>
	<1425458956-20665-4-git-send-email-pi-cheng.chen@linaro.org>
	<CAKohpo=c2t4_2hdPP-vQM7xewK5SXaHBGNA9PhvTwDv3++pSTg@mail.gmail.com>
	<CALx668VypyWbVuph0ir0SRt4kqASvYzwBuyc_r5tFeoHi+HieA@mail.gmail.com>
	<CAKohpomxXTP6NdPoSmB=eq2sFqqgskS5vYtDNAT6a0VL5K6dCg@mail.gmail.com>
	<CALx668VFRdeWcK_gKhJrJehnaH5uDpA0m2OfHLqPVUq8oocXaw@mail.gmail.com>
	<CAKohpokT7fSniPGX2BfM61AtMoMCxEP8WDtbZ34bozUXscEWyg@mail.gmail.com>
	<20150311105307.GW28806@sirena.org.uk>
	<CAKohpom4riOhzc3hK8B2tiSwGx0zG96C7QNeQB0yZaPMd_OpLw@mail.gmail.com>
	<20150311124555.GB28806@sirena.org.uk>
	<CAKohpok=8vU6Nr21n49MHoyk=REEMkuibVk9L+0L7uLnFj==AQ@mail.gmail.com>
	<CALx668U7EoiMB8D0Num5w9oC0zZkC55uKaSOLrrBhKnLXUtoOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33802 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbbCRG7o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2015 02:59:44 -0400
Received: by oier21 with SMTP id r21so28901746oie.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2015 23:59:44 -0700 (PDT)
In-Reply-To: <CALx668U7EoiMB8D0Num5w9oC0zZkC55uKaSOLrrBhKnLXUtoOQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chen Fan <fan.chen@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@li

On 12 March 2015 at 16:45, Pi-Cheng Chen <pi-cheng.chen@linaro.org> wrote:
> The voltages of the two regulators need to be always under a limitation:
> 100mV < Vsram - Vproc < 200mV
> For now, I just calculate the OPPs of Vsram from OPPs of Vproc.
>
> Another thing I should mention, if the voltage difference of two adjacent
> OPPs is greater than 100mV, we need to set the regulator to some
> voltages which are not in OPP table considering the limitation above.
> I think that will make it more difficult to model such flow in a generic
> framework.

Actually the problem is that OPP tables are insufficient for such cases,
and we are adding work-arounds to fix that. Though it will get fixed
with the new bindings we are adding.

I am confused on what we should be doing here. Even if you write
your own driver, you will be abusing DT with incorrect information.

Even if you go around adding a new driver, I would like you to fallback
to cpufreq-dt ones the new OPP bindings are in place.
