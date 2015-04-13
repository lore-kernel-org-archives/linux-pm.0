From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] cpufreq: arm_big_little: check if the frequency is
 set correctly
Date: Mon, 13 Apr 2015 16:14:34 +0100
Message-ID: <552BDD5A.8030107@arm.com>
References: <1427718438-31098-1-git-send-email-sudeep.holla@arm.com>	<CAKohponxEv3CjhVPAu2Ga5FeSSvtj_W6zGvL3oj2V247f94H=w@mail.gmail.com>	<551951F4.9070804@arm.com>	<20150331014854.25195.34023@quantum>	<551A67CD.50602@arm.com>	<20150401214814.14369.56281@quantum>	<551D03E9.508@arm.com>	<20150413050825.19585.17809@quantum>	<552B989C.30805@arm.com> <CAKohpomxRZkUWQUjHhbQ=8nTA-vXwuOvOFqFX9ocm6x9-DWysQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60148 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754039AbbDMPOh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Apr 2015 11:14:37 -0400
In-Reply-To: <CAKohpomxRZkUWQUjHhbQ=8nTA-vXwuOvOFqFX9ocm6x9-DWysQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Michael Turquette <mike.turquette@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>



On 13/04/15 11:25, Viresh Kumar wrote:
> On 13 April 2015 at 15:51, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Thanks Mike.
>>
>> Viresh, is it OK if we carry this patch until the clk framework can
>> handle this case ? I will add a *TODO* stating it's temporary change
>> and can be dropped once the clk layer handle it if that helps in any way
>> :).
>>
>> This issue is seen on TC2 when firmware is stress tested with continuous
>> DVFS requests.
>
> Sure.
>
Thanks, will repost the patches again after merge window to avoid
it getting lost during the merge window.

Regards,
Sudeep
