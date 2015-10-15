From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH Resend] cpufreq: Drop redundant check for inactive policies
Date: Wed, 14 Oct 2015 18:51:07 -0700
Message-ID: <561F068B.60506@codeaurora.org>
References: <2d6d59c2b0654872a32a9b63874b750e6b808cb5.1444713966.git.viresh.kumar@linaro.org> <90321921.5bFa9a5dDU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33671 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932105AbbJOBvJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 21:51:09 -0400
In-Reply-To: <90321921.5bFa9a5dDU@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 10/14/2015 05:35 PM, Rafael J. Wysocki wrote:
> On Tuesday, October 13, 2015 10:57:13 AM Viresh Kumar wrote:
>> We just made sure policy->cpu is online and this check will always fail
>> as the policy is active. Drop it.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Acked-by: Saravana Kannan <skannan@codeaurora.org>
>
> Applied, thanks!
>
> Rafael
>

I didn't give a clear ack/review for the series. So, to clarify my 
ack/review

For all patches except 4/5, I'm okay with either/all of this:
Reviewed-by:  Saravana Kannan <skannan@codeaurora.org>
Acked-by: Saravana Kannan <skannan@codeaurora.org>

For 4/5, I would still like us to move the sysfs creating after init. 
That part shouldn't be too hard. We don't need to create the sysfs file 
before init.

Once that's done, I wouldn't mind giving an Ack.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
