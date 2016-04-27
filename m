From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpufreq: st: enable selective initialization based on the
 platform
Date: Wed, 27 Apr 2016 17:16:09 +0100
Message-ID: <5720E5C9.4050105@arm.com>
References: <1461757227-22381-1-git-send-email-sudeep.holla@arm.com>
 <20160427160746.GG4892@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36719 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269AbcD0QQM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 Apr 2016 12:16:12 -0400
In-Reply-To: <20160427160746.GG4892@dell>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org



On 27/04/16 17:07, Lee Jones wrote:
> On Wed, 27 Apr 2016, Sudeep Holla wrote:
>

[...]

>>
>> +	if ((!of_machine_is_compatible("st,stih407-b2120")) &&
>> +		(!of_machine_is_compatible("st,stih407")))
>> +		return -ENODEV;
>
> You need to check for "st,stih407" and "st,stih410".
>

Thanks, will fix it and post new version soon.

-- 
Regards,
Sudeep
