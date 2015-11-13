From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH v2 2/2] clk: qcom: Make oxili GDSC parent of oxili_cx
 GDSC
Date: Fri, 13 Nov 2015 11:58:27 +0530
Message-ID: <5645830B.9000400@codeaurora.org>
References: <1443727374-1539-1-git-send-email-sboyd@codeaurora.org> <1443727374-1539-3-git-send-email-sboyd@codeaurora.org> <20151006193217.GH12338@codeaurora.org> <564564CA.5040608@codeaurora.org> <20151113061409.GI15032@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:41057 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbbKMG2f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2015 01:28:35 -0500
In-Reply-To: <20151113061409.GI15032@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mike Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Rob Clark <robdclark@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>



On 11/13/2015 11:44 AM, Stephen Boyd wrote:
> On 11/13, Rajendra Nayak wrote:
>>
>> On 10/07/2015 01:02 AM, Stephen Boyd wrote:
>>> On 10/01, Stephen Boyd wrote:
>>>> The oxili_cx GDSC is inside the power domain of the oxili GDSC.
>>>> Add the dependency so that the CX domain can properly power up.
>>>>
>>>> Reported-by: Rob Clark <robdclark@gmail.com>
>>>> Cc: Rajendra Nayak <rnayak@codeaurora.org>
>>>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>>>> ---
>>>
>>> Applied to clk-next
>>
>> I don't see this in clk-next. Was this dropped for some reason?
>>
> 
> Hm.. It's merged into Linus' tree now
> 
> b68f2c3b882202aba97a488c1fede0e99f7261e2
> 
> unless I missed something.

right, sorry, I seemed to be wrongly looking at the gcc driver instead
of mmcc.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
