From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH] PM / Domains: Make pm_genpd_init() available to modules
Date: Mon, 17 Aug 2015 09:47:47 +0530
Message-ID: <55D1606B.3020201@codeaurora.org>
References: <1439446917-32304-1-git-send-email-rnayak@codeaurora.org> <20150813181128.GP26614@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58005 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbbHQERx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Aug 2015 00:17:53 -0400
In-Reply-To: <20150813181128.GP26614@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: ulf.hansson@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org


On 08/13/2015 11:41 PM, Stephen Boyd wrote:
> On 08/13, Rajendra Nayak wrote:
>> Export symbol pm_genpd_init so it can be used in loadable
>> kernel modules
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> ---
>
> I'd like to take this through the clk tree somehow so that we can
> merge the rest of the GDSC series this coming cycle.

Ulf/Rafael, if you don't have any issues with the patch, and are fine
with Stephen taking this through the clk tree, would you be able to ack
this please? thanks.

regards,
Rajendra
