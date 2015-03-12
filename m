From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: Re: [PATCH v2 3/4] cpufreq: mediatek: add Mediatek cpufreq driver
Date: Thu, 12 Mar 2015 19:15:56 +0800
Message-ID: <CALx668U7EoiMB8D0Num5w9oC0zZkC55uKaSOLrrBhKnLXUtoOQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:42548 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034AbbCLLP6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2015 07:15:58 -0400
Received: by lams18 with SMTP id s18so14983073lam.9
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2015 04:15:57 -0700 (PDT)
In-Reply-To: <CAKohpok=8vU6Nr21n49MHoyk=REEMkuibVk9L+0L7uLnFj==AQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chen Fan <fan.chen@mediatek.com>, Howard Chen <ibanezchen@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Kumar Gala <galak@codeaurora.org>, Matthias Brugger <matthias.bgg@gmail.com>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@li

On Thu, Mar 12, 2015 at 5:28 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 11 March 2015 at 18:15, Mark Brown <broonie@kernel.org> wrote:
>> Ugh, no - that's a hideous bodge which is only going to create trouble
>> later.  Remember, DT is an ABI and should describe the hardware so if
>> we're doing bodges that are visible there to shoehorn things onto our
>> implementation that's bad.  The concerns that Pi-Cheng had about what
>> happens if the PMIC gets changed definitely seem relevant here too.
>
> Hmm..
>
>> Why not just write a custom cpufreq driver if it's too hard to abstract?
>
> Hmm, probably all that can be solved with the new OPP bindings where
> we can have support for multiple regulator or clock sources to the CPU.
>
> @Pi-cheng: How are you going to pass voltages for both the regulators
> as OPPs today only support a single regulator, in case you have to write
> your own driver.

The voltages of the two regulators need to be always under a limitation:
100mV < Vsram - Vproc < 200mV
For now, I just calculate the OPPs of Vsram from OPPs of Vproc.

Another thing I should mention, if the voltage difference of two adjacent
OPPs is greater than 100mV, we need to set the regulator to some
voltages which are not in OPP table considering the limitation above.
I think that will make it more difficult to model such flow in a generic
framework.

Best Regards,
Pi-Cheng

>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
