From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv5 3/9] devfreq: event: Add exynos-ppmu devfreq-event driver
Date: Tue, 23 Dec 2014 15:35:20 +0900
Message-ID: <54990D28.2050205@samsung.com>
References: <1419304697-14789-1-git-send-email-cw00.choi@samsung.com>
 <1419304697-14789-4-git-send-email-cw00.choi@samsung.com>
 <CAEUmHyYnb8_HNnuz8BLhMOh01+gpXfTv63P-ubYE1DK9uptonA@mail.gmail.com>
 <5498F0F4.7020700@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:12933 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbaLWGfX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Dec 2014 01:35:23 -0500
In-reply-to: <5498F0F4.7020700@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: myungjoo.ham@samsung.com, kgene.kim@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>, rafael.j.wysocki@intel.com, Mark Rutland <mark.rutland@arm.com>, a.kesavan@samsung.com, tomasz.figa@gmail.com, k.kozlowski@samsung.com, inki.dae@samsung.com, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org

Hi Varka,

On 12/23/2014 01:35 PM, Chanwoo Choi wrote:
> On 12/23/2014 12:40 PM, Varka Bhadram wrote:
>> On Tue, Dec 23, 2014 at 8:48 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>> This patch adds exynos-ppmu devfreq-event driver to get performance data
>>> of each IP for Samsung Exynos SoC. These event from Exynos PPMU provide
>>> useful information about the behavior of the SoC that you can use when
>>> analyzing system performance, and made visible and can be counted using
>>> logic in each IP.
>>>
>>> This patch is based on existing drivers/devfreq/exynos/exynos-ppmu.c
>>>
>>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>

snip.

> 
>>
>>> +       }
>>> +
>>> +       data->clk_ppmu = devm_clk_get(dev, "ppmu");
>>> +       if (IS_ERR(data->clk_ppmu)) {
>>> +               data->clk_ppmu = NULL;
>>> +               dev_warn(dev, "failed to get PPMU clock\n");
>>> +       }
>> If PPMU clk get fails..?  return PTR_ERR(data->clk_ppmu)
> 
> If Exynos SoC don't register the clock to clock tree, the clock remains on state.
> So, I print just warning message.
> 
> But, It is not proper. I'll fix it.

I faced on unthinkable issue. I'm implementing missing PPMU clock of Exynos3250 (PPMUDMC0, PPMUDMC1, PPMUFSYS).
But, I can't find the parent clock of PPMUDMC0, PPMUDMC1 and the clock of PPMUFSYS on Exynos3250 datasheet.
Like this, some PPMU clocks is not specified on Exynos SoC datasheet because some clocks should be remained
with always-on state.

So, I want to show just warning message if exynos-ppmu driver fail to get ppmu clock.

Thanks,
Chanwoo Choi

