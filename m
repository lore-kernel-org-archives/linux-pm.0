From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 3/8] clk: add support for clocks provided by SCP(System
 Control Processor)
Date: Wed, 22 Jul 2015 15:19:17 +0100
Message-ID: <55AFA665.4020906@arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com> <1433760002-24120-4-git-send-email-sudeep.holla@arm.com> <20150702172310.GF4301@codeaurora.org> <5596A1B6.8020307@arm.com> <559ADC94.4080505@codeaurora.org> <559BF858.1020301@arm.com> <20150708014606.GH30412@codeaurora.org> <55A7D79B.3080305@arm.com> <20150716193114.GA17952@codeaurora.org> <55A8E434.2010709@arm.com> <55A945DF.3@codeaurora.org> <55ACB733.2080609@arm.com> <55AE8A02.9070801@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55AE8A02.9070801@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Mike Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org



On 21/07/15 19:05, Stephen Boyd wrote:
> On 07/20/2015 01:54 AM, Sudeep Holla wrote:
>>
>>
>> On 17/07/15 19:13, Stephen Boyd wrote:
>>> On 07/17/2015 04:17 AM, Sudeep Holla wrote:
>>
>> [...]
>>
>>>>
>>>> determine_rate change shouldn't affect SCPI clock driver but I remember
>>>> seeing round_rate change too on the list which returns value using the
>>>> argument from Boris. Is that planned for v4.3 ? I would need the stable
>>>> branch from this clk_hw_set_rate_range if you decide to push. Let me
>>>> know your preferences. I will post the updated version of the patch
>>>> accordingly.
>>>>
>>>
>>> We're not going to change round_rate() so it sounds like you don't need
>>> a stable branch. But you would need this new consumer API. So you still
>>> need a branch right?
>>>
>>
>> I am fine either way. If no one else need the stable branch to be shared
>> with arm-soc, I prefer to use clock consumer API for now to avoid all
>> the troubles to you guys and switch to provider API later. I will post
>> it once the both this driver and that provider API is merged, if that's
>> fine with you ?
>
> Ok. Sounds fine as long as we don't forget.
>

It's ready indeed :), will post it when everything is in place.

Regards,
Sudeep

--->8

 From 3ddf7fe5b1286efa712d4f2ba8108ce1855f3e74 Mon Sep 17 00:00:00 2001
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Fri, 17 Jul 2015 12:19:54 +0100
Subject: [PATCH] clk: scpi: use provider clk_hw_set_rate_range API 
instead of
  consumer API

SCPI clock provider uses the consumer API clk_set_rate_range to set
min/max rate constraints on the clocks it provides.

Commit c87c640f915a ("clk: Allow providers to configure min/max rates")
added a separate provider API clk_hw_set_rate_range to set the min/max
rate of a clock.

This patch switches away from clk_set_rate_range consumer API to
clk_hw_set_rate_range provider API.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
  drivers/clk/clk-scpi.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
index 06d0558e8f46..f7c8b7a03cfe 100644
--- a/drivers/clk/clk-scpi.c
+++ b/drivers/clk/clk-scpi.c
@@ -174,7 +174,7 @@ scpi_clk_ops_init(struct device *dev, const struct 
of_device_id *match,

  	clk = devm_clk_register(dev, &sclk->hw);
  	if (!IS_ERR(clk) && max)
-		clk_set_rate_range(clk, min, max);
+		clk_hw_set_rate_range(&sclk->hw, min, max);
  	return clk;
  }

-- 
1.9.1
