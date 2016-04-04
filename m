From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: dtc warnings
Date: Mon, 04 Apr 2016 14:56:45 +0900
Message-ID: <5702021D.3080103@samsung.com>
References: <CAL_Jsq+=OjY8y_8x7OSm-MWYKbrHN5cbv4TLwULxhNq+gfiMtw@mail.gmail.com>
 <56FE27F9.2070100@gmail.com>
 <CAJKOXPdDyVbfSyshu4j21Ax2J-VwPpMZgAGEeO8VtgFYh4hTmw@mail.gmail.com>
 <56FE7E4A.2000601@ti.com> <20160403065909.GF2987@vireshk-i7>
 <20160403080854.GA12133@kozik-lap>
 <CAKohpomijKf3m07Lc3+fWawxAPwe83F8k9akz1LOTokpZNL2ig@mail.gmail.com>
 <20160404051656.GV17806@rob-hp-laptop> <20160404055000.GA3622@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:26317 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbcDDF4y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2016 01:56:54 -0400
In-reply-to: <20160404055000.GA3622@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>
Cc: Rob Herring <rob.herring@linaro.org>, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, arm-platform-maintainers@lists.infradead.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 04.04.2016 14:50, Viresh Kumar wrote:
> On 04-04-16, 00:16, Rob Herring wrote:
>> On Sun, Apr 03, 2016 at 05:57:00PM +0530, Viresh Kumar wrote:
>>> On 3 April 2016 at 13:38, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
>>>> Warnings coming from recent linux-next:
>>>>
>>>>   DTC     arch/arm/boot/dts/exynos5800-peach-pi.dtb
>>>> Warning (unit_address_vs_reg): Node /opp_table0/opp@1800000000 has a unit name, but no reg property
>>>> Warning (unit_address_vs_reg): Node /opp_table0/opp@1700000000 has a unit name, but no reg property
> 
> Something isn't right in my setup, as I am not hitting these:
> 
> $ make CROSS_COMPILE="arm-linux-gnueabihf-" ARCH=arm O=../bexynos dtbs

You need W=1 (that was recent change by Rob to not pollute everyone's
builds).

Best regards,
Krzysztof

