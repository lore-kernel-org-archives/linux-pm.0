From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v7 12/13] clk: qcom: gdsc: Add GDSCs in apq8084 MMCC
Date: Thu, 06 Aug 2015 16:01:45 +0530
Message-ID: <55C33791.6010506@codeaurora.org>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org> <1438076046-4706-13-git-send-email-rnayak@codeaurora.org> <55BB8C40.507@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37837 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739AbbHFKcF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2015 06:32:05 -0400
In-Reply-To: <55BB8C40.507@mm-sol.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stanimir Varbanov <svarbanov@mm-sol.com>, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org, sviau@codeaurora.org, georgi.djakov@linaro.org, linux-arm-kernel@lists.infradead.org



On 07/31/2015 08:24 PM, Stanimir Varbanov wrote:
>
> <snip>
>
>>
>> +static struct gdsc venus0_gdsc = {
>> +	.gdscr = 0x1024,
>> +	.pd = {
>> +		.name = "venus0",
>> +	},
>> +	.pwrsts = PWRSTS_OFF_ON,
>> +	.con_ids = { NULL },
>> +};
>> +
>
> Rajendra, according to downstream kernel apq8084 has second instance of
> gdsc i.e. venus1_gdsc, is that correct?

Stan, it does seem like there are 3 instances of venus gdscs', venus0,
venus0_core0 and venus0_core1. I will add the missing ones when I
repost,thanks.
