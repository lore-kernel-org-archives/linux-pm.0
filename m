From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH 1/7] cpufreq: remove redundant CPUFREQ_INCOMPATIBLE notifier
 event
Date: Wed, 06 Apr 2016 14:29:21 -0700
Message-ID: <57057FB1.2050904@codeaurora.org>
References: <cover.1438571116.git.viresh.kumar@linaro.org> <406f55ac8030043f0349b084878c9b8d04f7ad86.1438571116.git.viresh.kumar@linaro.org> <4897937.47p7WB7CoU@vostro.rjw.lan> <20150910003918.GL5266@linux> <CAJZ5v0jRDFJF6_mNvE7JknuUG-Tz1mDFMXw5rOEJP4GqXZtprA@mail.gmail.com> <57057201.9030109@codeaurora.org> <CAJZ5v0iUdkYrEzKrGDEiDnexsxfY7o9xOHPoWELk88gau=gAhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48118 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920AbcDFV3Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:29:25 -0400
In-Reply-To: <CAJZ5v0iUdkYrEzKrGDEiDnexsxfY7o9xOHPoWELk88gau=gAhA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Fabian Frederick <fabf@skynet.be>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>, open@codeaurora.org, "list@codeaurora.org:ACPI" <linux-acpi@vger.kernel.org>open@codeaurora.org, "list@codeaurora.org:DOCUMENTATION" <linux-doc@vger.kernel.org>open@codeaurora.org, "list@codeaurora.org:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Nicholas Mc Guire <hofrat@osadl.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Wolfram Sang <wsa@the-dreams.de>

On 04/06/2016 02:21 PM, Rafael J. Wysocki wrote:
> On Wed, Apr 6, 2016 at 10:30 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
>> On 09/09/2015 05:53 PM, Rafael J. Wysocki wrote:
>>>
>>> Hi,
>>>
>>> On Thu, Sep 10, 2015 at 2:39 AM, Viresh Kumar <viresh.kumar@linaro.org>
>>> wrote:
>>>>
>>>> On 10-09-15, 01:26, Rafael J. Wysocki wrote:
>>>>>
>>>>> On Monday, August 03, 2015 08:36:14 AM Viresh Kumar wrote:
>>>>>>
>>>>>> What's being done from CPUFREQ_INCOMPATIBLE, can also be done with
>>>>>> CPUFREQ_ADJUST. There is nothing special with CPUFREQ_INCOMPATIBLE
>>>>>> notifier.
>>>>>
>>>>>
>>>>> The above part of the changelog is a disaster to me. :-(
>>>>>
>>>>> It not only doesn't explain what really goes on, but it's actively
>>>>> confusing.
>>>>>
>>>>> What really happens is that the core sends CPUFREQ_INCOMPATIBLE
>>>>> notifications
>>>>> unconditionally right after sending the CPUFREQ_ADJUST ones, so the
>>>>> former is
>>>>> just redundant and it's more efficient to merge the two into one.
>>>>
>>>>
>>>> Undoubtedly this looks far better :)
>>>>
>>>> But, isn't this series already applied some time back ?
>>>
>>>
>>> Right, never mind.  For some reason that patch was left in the "New"
>>> state.
>>>
>>> The code is OK.
>>
>>
>>
>> I guess I didn't notice this change when it was sent out.
>>
>> The comment that was deleted in this patch clearly states why the
>> INCOMPATIBLE notifier is needed. Some client might want to boost the CPU min
>> freq for performance or other reasons, but thermal might want to limit it.
>> So, by having thermal register for INCOMPATIBLE notifiers to enforce the
>> limits, we provide a way to guarantee it gets the final say.
>>
>> The real fix should have been to change drivers/thermal/cpu_cooling.c to use
>> CPUFREQ_INCOMPATIBLE instead of CPUFREQ_ADJUST.
>>
>> Is there something I'm missing? If not, can we please revert this patch?
>
> Well, nobody was using that event.
>

True, but that's more of a bug in drivers/thermal/cpu-cooling.c and 
drivers/acpi/processor_thermal.c. We should revert this patch and fix 
those drivers. Does that seem acceptable to you?

-Saravana


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
