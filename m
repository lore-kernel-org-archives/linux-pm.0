From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpufreq: scpi-cpufreq: signedness bug in
 scpi_get_dvfs_info()
Date: Thu, 24 Dec 2015 09:53:52 +0000
Message-ID: <567BC0B0.6070406@arm.com>
References: <1450178204-26172-1-git-send-email-sudeep.holla@arm.com>
 <CAPKp9ubzg3hfondHoiR1qgc057Dobrz+1KoPp69-TEy9-_yZiA@mail.gmail.com>
 <1952184.nII0v5K5QD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32768 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752564AbbLXJxz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 24 Dec 2015 04:53:55 -0500
In-Reply-To: <1952184.nII0v5K5QD@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>



On 24/12/15 01:45, Rafael J. Wysocki wrote:
> On Wednesday, December 23, 2015 11:20:04 AM Sudeep Holla wrote:
>> Hi Rafael,
>>
>> On Tue, Dec 15, 2015 at 11:16 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> From: Dan Carpenter <dan.carpenter@oracle.com>
>>>
>>> The "domain" variable needs to be signed for the error handling to work.
>>>
>>> Fixes: 8def31034d03 ('cpufreq: arm_big_little: add SCPI interface driver')
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>>   drivers/cpufreq/scpi-cpufreq.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Hi Rafael,
>>>
>>> This patch seem to have slipped through the cracks somehow. I don't see
>>> in patchwork too. So I am resending so that you can pick for your next
>>> rc fix if you plan to send one else for -next
>>>
>>
>> This got missed again, can you please ensure to pull this for your next -rc.
>> If you have none planned, please pull this for-next.
>
> Applied now, thanks!
>
> I'm going to push it for -rc7.
>

Thanks, sorry for the nags.

-- 
Regards,
Sudeep
