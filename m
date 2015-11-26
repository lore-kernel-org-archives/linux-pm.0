From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [RFC PATCH 01/15] PM / devfreq: exynos: Add generic exynos bus
 frequency driver
Date: Thu, 26 Nov 2015 22:47:19 +0530
Message-ID: <CANAwSgQtvp_7hODvLz--5QmXMYqhOQYyBjihyRqWYv5HEk0u5A@mail.gmail.com>
References: <1448545659-32287-1-git-send-email-cw00.choi@samsung.com>
 <1448545659-32287-2-git-send-email-cw00.choi@samsung.com> <CAJ0PZbSJ26q9MWSXihQjZih0hSU=w+dR2HKxa67kJhmZtt1tJQ@mail.gmail.com>
 <CAGTfZH295rGWh4S0mPgC7GMiA04NKgDybRUVnfzZP5o9-HffMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35406 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbbKZRRk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2015 12:17:40 -0500
In-Reply-To: <CAGTfZH295rGWh4S0mPgC7GMiA04NKgDybRUVnfzZP5o9-HffMw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>

Hi Chanwoo,

On 26 November 2015 at 21:42, Chanwoo Choi <cwchoi00@gmail.com> wrote:
> On Thu, Nov 26, 2015 at 11:00 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>> On Thu, Nov 26, 2015 at 10:47 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>> This patch adds the generic exynos bus frequency driver for AMBA AXI bus
>>> of sub-blocks in exynos SoC with DEVFREQ framework. The Samsung Exynos SoC
>>> have the common architecture for bus between DRAM and sub-blocks in SoC.
>>> This driver can support the generic bus frequency driver for Exynos SoCs.
>>>
>>> In devicetree, Each bus block has a bus clock, regulator, operation-point
>>> and devfreq-event devices which measure the utilization of each bus block.
>>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>>  drivers/devfreq/Kconfig             |  15 ++
>>>  drivers/devfreq/Makefile            |   1 +
>>>  drivers/devfreq/exynos/Makefile     |   1 +
>>>  drivers/devfreq/exynos/exynos-bus.c | 443 ++++++++++++++++++++++++++++++++++++
>>>  4 files changed, 460 insertions(+)
>>>  create mode 100644 drivers/devfreq/exynos/exynos-bus.c
>>>
>>
>> Are we finally getting a common Exynos bus driver with full DT support?
>> (can this replace both Exynos4/5 drivers and support Exynos7 series?)
>
> Yes.
> This patch-set would support all Exynos SoCs for bus frequency driver.
> To make sure the support for Exynos7 series, I need to check the TRM
> document of Exynos7.  I think it is possible for support Exynos7.
>
> I'm going to test this driver on various Exynos-based board.
>
> Regards,
> Chanwoo Choi

Please do consider Exynos 542x series as well.

-Anand Moon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
