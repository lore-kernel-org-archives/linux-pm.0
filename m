From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: scpi: use new scpi_ops functions to remove
 duplicate code
Date: Tue, 2 May 2017 09:57:18 +0100
Message-ID: <0587f9f7-0813-2348-3717-687ed1df3e0e@arm.com>
References: <1493371296-12465-1-git-send-email-sudeep.holla@arm.com>
 <1493371296-12465-2-git-send-email-sudeep.holla@arm.com>
 <20170428092456.GF21517@vireshk-i7> <1644626.pZFp7GD5Yb@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750767AbdEBI5V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 May 2017 04:57:21 -0400
In-Reply-To: <1644626.pZFp7GD5Yb@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 28/04/17 22:34, Rafael J. Wysocki wrote:
> On Friday, April 28, 2017 02:54:56 PM Viresh Kumar wrote:
>> On 28-04-17, 10:21, Sudeep Holla wrote:
>>> scpi_ops now provide APIs to get the transition_latency and to add
>>> OPPs to the devices making those logic redundant here.
>>>
>>> This patch makes use of those APIs and removes the redunant code in
>>> this driver.
>>>
>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>>  drivers/cpufreq/scpi-cpufreq.c | 38 ++++++--------------------------------
>>>  1 file changed, 6 insertions(+), 32 deletions(-)
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>>
> 
> OK
> 
> Sudeep, please route this through ARM.

Sure, thanks.

-- 
Regards,
Sudeep
