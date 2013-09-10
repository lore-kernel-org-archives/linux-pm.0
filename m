From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: cpufreq_stats NULL deref on second system suspend
Date: Tue, 10 Sep 2013 14:53:01 -0600
Message-ID: <522F86AD.6010603@wwwdotorg.org>
References: <522E1FEF.6080803@wwwdotorg.org> <6639035.alELXsX8ZI@vostro.rjw.lan> <522E3DA2.9020707@wwwdotorg.org> <1775778.MeiRhuYy7o@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:57749 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab3IJUxG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Sep 2013 16:53:06 -0400
In-Reply-To: <1775778.MeiRhuYy7o@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>

On 09/09/2013 05:14 PM, Rafael J. Wysocki wrote:
> On Monday, September 09, 2013 03:29:06 PM Stephen Warren wrote:
>> On 09/09/2013 02:24 PM, Rafael J. Wysocki wrote:
>>> On Monday, September 09, 2013 02:01:32 PM Stephen Warren wrote:
>>>> On 09/09/2013 02:01 PM, Rafael J. Wysocki wrote:
>>>>> On Monday, September 09, 2013 01:22:23 PM Stephen Warren wrote:
>>>>>> Viresh,
>>>>>>
>>>>>> I'm seeing the crash below when suspending my system for the second time.
>>>>>>
>>>>>> I can avoid this with the following patch, which adds a check which
>>>>>> already exists in all-but-one other places that the same lookup is made:
>>>>>
>>>>> Which kernel did you test?
>>>>
>>>> next-20130909.
>>>
>>> Is it reproducible with the current mainline?
>>
>> This does not affect v3.11, but does affect current HEAD; 300893b "Merge
>> tag 'xfs-for-linus-v3.12-rc1' of git://oss.sgi.com/xfs/xfs".
> 
> What system does it break on?

A dual-core ARM system (NVIDIA Tegra20 SoC, Harmony board).

> Any chance to bisect cpufreq changes between 3.11 and the current HEAD?

Sure, it's due to 5302c3f "cpufreq: Perform light-weight init/teardown
during suspend/resume".
