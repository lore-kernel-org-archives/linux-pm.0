From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 3/8] clk: add support for clocks provided by SCP(System
 Control Processor)
Date: Mon, 20 Jul 2015 09:54:11 +0100
Message-ID: <55ACB733.2080609@arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com> <1433760002-24120-4-git-send-email-sudeep.holla@arm.com> <20150702172310.GF4301@codeaurora.org> <5596A1B6.8020307@arm.com> <559ADC94.4080505@codeaurora.org> <559BF858.1020301@arm.com> <20150708014606.GH30412@codeaurora.org> <55A7D79B.3080305@arm.com> <20150716193114.GA17952@codeaurora.org> <55A8E434.2010709@arm.com> <55A945DF.3@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54741 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755387AbbGTIyP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 20 Jul 2015 04:54:15 -0400
In-Reply-To: <55A945DF.3@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Mike Turquette <mturquette@baylibre.com>



On 17/07/15 19:13, Stephen Boyd wrote:
> On 07/17/2015 04:17 AM, Sudeep Holla wrote:

[...]

>>
>> determine_rate change shouldn't affect SCPI clock driver but I remember
>> seeing round_rate change too on the list which returns value using the
>> argument from Boris. Is that planned for v4.3 ? I would need the stable
>> branch from this clk_hw_set_rate_range if you decide to push. Let me
>> know your preferences. I will post the updated version of the patch
>> accordingly.
>>
>
> We're not going to change round_rate() so it sounds like you don't need
> a stable branch. But you would need this new consumer API. So you still
> need a branch right?
>

I am fine either way. If no one else need the stable branch to be shared
with arm-soc, I prefer to use clock consumer API for now to avoid all
the troubles to you guys and switch to provider API later. I will post
it once the both this driver and that provider API is merged, if that's
fine with you ?

Regards,
Sudeep
