From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH V2 00/17] thermal: cpu_cooling: improve interaction with
 cpufreq core
Date: Mon, 24 Apr 2017 11:43:11 +0100
Message-ID: <21699d92-64f1-1819-0a30-4f38cb786bf6@arm.com>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
 <20170417173431.GA10447@localhost.localdomain>
 <20170418103818.GQ28191@vireshk-i7>
 <3925c07c-1442-9e00-6f50-c4ae900ed834@arm.com>
 <20170419052206.GA5436@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1168737AbdDXKnQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Apr 2017 06:43:16 -0400
In-Reply-To: <20170419052206.GA5436@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linaro-kernel@lists.linaro.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

Hi Viresh,

I was out of office.
I run your v3 (from git) with some basic tests.
IPA does not work, at least v3 does not crash the kernel.
I didn't have time to go through the patches to narrow down
the problem.

If you would like to run some basic test,
you can find it here [1].

I am happy to check v4 when it is ready.

Best regards,
Lukasz

[1] 
https://github.com/ARM-software/lisa/blob/master/ipynb/thermal/ThermalSensorCharacterisation.ipynb

On 19/04/17 06:22, Viresh Kumar wrote:
> On 18-04-17, 15:40, Lukasz Luba wrote:
>> Hi Viresh,
>>
>> I have checkout your branch at newest commit:
>> 908063832c268f8add94
>> I have built it and run it on my Juno r2.
>> I have some python tests for IPA and I run one of them.
>>
>> I seen a few issues so I have created a patch just
>> to be able to run IPA.
>> My next email will have the patch so you can see the changes.
>>
>> IPA does not work with this patch set.
>> I have tested two source codes from your repo:
>> 1. your change 908063832c268f8add94
>> 2. your base 8f506e0faf4e2a4a0bde9f9b1
>>
>> In case 1. IPA does not work - temperature rises to 83degC
>> in case 2. works - temperature is limited to 65degC.
>
> Yeah, there were some cases power specific cases that weren't covered in my
> tests and thanks a lot for testing it out. I have pushed my branch again and it
> has all your fixes (a bit refined) in it.
>
>> On Monday I can allocate more time for it.
>
> My branch should just work now. Please see if you can allocate 10-15 min today
> to give it a try, so that we can get it in earlier. I will send a V3 today and
> your Tested-by would be very much appreciated.
>
> Thanks Lukasz.
>
