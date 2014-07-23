From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 0/2] cpufreq: ondemand: Eliminate the deadband effect
Date: Wed, 23 Jul 2014 12:01:13 +0300
Message-ID: <53CF79D9.5000804@semaphore.gr>
References: <1404147574-17422-1-git-send-email-stratosk@semaphore.gr> <1513010.lqhBUJhHsL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sema.semaphore.gr ([78.46.194.137]:45525 "EHLO
	sema.semaphore.gr" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932194AbaGWJDb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 05:03:31 -0400
In-Reply-To: <1513010.lqhBUJhHsL@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/23/2014 02:50 AM, Rafael J. Wysocki wrote:
> On Monday, June 30, 2014 07:59:32 PM Stratos Karafotis wrote:
>> Hi all,
>>
>> This patchset changes slightly the calculation of target frequency to
>> eliminate the deadband effect (explained in patch 2 changelog) that it
>> seems to slow down the CPU in low and medium loads.
>>
>> Patch 1 introduces a new relation (RELATION_C) for the next frequency
>> selection, which chooses the closest frequency to target.
>>
>> Patch 2 is the actual change to ondemand governor.
>>
>> You may find graphs with the 'deadband' effect and benchmark results:
>> https://docs.google.com/spreadsheets/d/16kDBh5lyc6YvBnoS1hUa1t2O38z0xrWvaEj5XtJ8auw/edit#gid=2072493052
>>
>> Thanks
>>
>>
>> Stratos Karafotis (2):
>>    cpufreq: Introduce new relation for freq selection
>>    cpufreq: ondemand: Eliminate the deadband effect in low loads
>>
>>   drivers/cpufreq/cpufreq_ondemand.c | 11 +++++++----
>>   drivers/cpufreq/freq_table.c       | 12 +++++++++++-
>>   include/linux/cpufreq.h            |  1 +
>>   3 files changed, 19 insertions(+), 5 deletions(-)
>
> OK, I've queued up these two patches for 3.17.  We'll see if anyone sees
> any problems related to them.  Thanks!
>

Thank you!

Stratos
