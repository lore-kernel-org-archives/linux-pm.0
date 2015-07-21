From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v4 3/8] clk: add support for clocks provided by SCP(System
 Control Processor)
Date: Tue, 21 Jul 2015 11:05:54 -0700
Message-ID: <55AE8A02.9070801@codeaurora.org>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com> <1433760002-24120-4-git-send-email-sudeep.holla@arm.com> <20150702172310.GF4301@codeaurora.org> <5596A1B6.8020307@arm.com> <559ADC94.4080505@codeaurora.org> <559BF858.1020301@arm.com> <20150708014606.GH30412@codeaurora.org> <55A7D79B.3080305@arm.com> <20150716193114.GA17952@codeaurora.org> <55A8E434.2010709@arm.com> <55A945DF.3@codeaurora.org> <55ACB733.2080609@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52157 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541AbbGUSF5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2015 14:05:57 -0400
In-Reply-To: <55ACB733.2080609@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Mike Turquette <mturquette@baylibre.com>

On 07/20/2015 01:54 AM, Sudeep Holla wrote:
>
>
> On 17/07/15 19:13, Stephen Boyd wrote:
>> On 07/17/2015 04:17 AM, Sudeep Holla wrote:
>
> [...]
>
>>>
>>> determine_rate change shouldn't affect SCPI clock driver but I remember
>>> seeing round_rate change too on the list which returns value using the
>>> argument from Boris. Is that planned for v4.3 ? I would need the stable
>>> branch from this clk_hw_set_rate_range if you decide to push. Let me
>>> know your preferences. I will post the updated version of the patch
>>> accordingly.
>>>
>>
>> We're not going to change round_rate() so it sounds like you don't need
>> a stable branch. But you would need this new consumer API. So you still
>> need a branch right?
>>
>
> I am fine either way. If no one else need the stable branch to be shared
> with arm-soc, I prefer to use clock consumer API for now to avoid all
> the troubles to you guys and switch to provider API later. I will post
> it once the both this driver and that provider API is merged, if that's
> fine with you ?

Ok. Sounds fine as long as we don't forget.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

