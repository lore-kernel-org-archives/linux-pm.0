From: dawei chien <dawei.chien@mediatek.com>
Subject: Re: thermal: mediatek: Add cpu power cooling model
Date: Tue, 8 Sep 2015 23:46:35 +0800
Message-ID: <1441727195.20470.40.camel@mtksdaap41>
References: <1441357309-61669-1-git-send-email-dawei.chien@mediatek.com>
	 <20150907060931.GF26760@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:34654 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753551AbbIHPql (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 11:46:41 -0400
In-Reply-To: <20150907060931.GF26760@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Sascha Hauer <s.hauer@pengutronix.de>, Eddie Huang <eddie.huang@mediatek.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Howard Chen <howard.chen@linaro.org>, Yingjoe Chen <yingjoe.chen@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>

Hi Viresh,

On Mon, 2015-09-07 at 11:39 +0530, Viresh Kumar wrote:
> On 04-09-15, 17:01, Dawei Chien wrote:
> > Use Intelligent Power Allocation (IPA) technical to add
> > static/dynamic power model for binding CPU thermal zone.
> > The power allocator governor allocates power budget to control
> > CPU temperature.
> 
> Sorry but this isn't enough really.. I don't have time to go through
> the code and understand the purpose of the series.
> 
> Please explain here in detail:
> - Why this is needed.
Power Allocator governor is able to keep SOC temperature within a
defined temperature range to avoid SOC overheat and keep it's
performance. mt8173-cpufreq.c need to register its' own power model with
power allocator thermal governor, so that power allocator governor can
allocates suitable power budget to control CPU temperature.

> - What/How you are doing it.
Measure and create dynamic/static power model, and register cooling
device of_cpufreq_power_cooling_register for MT8173.
> 
> (Don't resend, just reply to this email :) )
> 


