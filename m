From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] cpufreq: arm_big_little: check if the frequency is
 set correctly
Date: Mon, 13 Apr 2015 11:21:16 +0100
Message-ID: <552B989C.30805@arm.com>
References: <1427718438-31098-1-git-send-email-sudeep.holla@arm.com> <CAKohponxEv3CjhVPAu2Ga5FeSSvtj_W6zGvL3oj2V247f94H=w@mail.gmail.com> <551951F4.9070804@arm.com> <20150331014854.25195.34023@quantum> <551A67CD.50602@arm.com> <20150401214814.14369.56281@quantum> <551D03E9.508@arm.com> <20150413050825.19585.17809@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59370 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754068AbbDMKVV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Apr 2015 06:21:21 -0400
In-Reply-To: <20150413050825.19585.17809@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mike.turquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>



On 13/04/15 06:08, Michael Turquette wrote:
> Quoting Sudeep Holla (2015-04-02 01:55:05)
>>
>>
>> On 01/04/15 22:48, Michael Turquette wrote:
>>> Quoting Sudeep Holla (2015-03-31 02:24:29)

[...]

>>
>>> I'm thinking of ways to do this ... would require some surgery to the
>>> clock framework but it might give us a more elegant way to recover from
>>> a failure and roll back to a known good state.
>>>
>>
>> Agreed. I avoid doing that for 2 reasons: firstly as you said it needs
>> changes at multiple places and secondly I assumed alternate ways to
>> handle it as the designed way.
>
> So your patch for cpufreq is hopefully a temporary bandage until we fix
> the clk framework. Please feel free to add my Reviewed-by.
>

Thanks Mike.

Viresh, is it OK if we carry this patch until the clk framework can
handle this case ? I will add a *TODO* stating it's temporary change
and can be dropped once the clk layer handle it if that helps in any way
:).

This issue is seen on TC2 when firmware is stress tested with continuous
DVFS requests.

Regards,
Sudeep
