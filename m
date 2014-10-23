From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH v4 0/5] Simplify hotplug/suspend handling
Date: Thu, 23 Oct 2014 14:41:20 -0700
Message-ID: <54497600.4000904@codeaurora.org>
References: <1405464473-3916-1-git-send-email-skannan@codeaurora.org> <1406250448-470-1-git-send-email-skannan@codeaurora.org> <CAKohpokebj4jkyYipVKUF24Xu4KiVCX2n2D+yj29qxBdzJ-Jdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:47096 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbaJWVlX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Oct 2014 17:41:23 -0400
In-Reply-To: <CAKohpokebj4jkyYipVKUF24Xu4KiVCX2n2D+yj29qxBdzJ-Jdw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Todd Poynor <toddpoynor@google.com>, "Srivatsa S . Bhat" <srivatsa@mit.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>

On 10/16/2014 01:53 AM, Viresh Kumar wrote:
> On 25 July 2014 06:37, Saravana Kannan <skannan@codeaurora.org> wrote:
>> Series of patchs to simplify policy/sysfs/kobj/locking handling across
>> suspend/resume
>>
>> The following have been tested so far on a 2x2 cluster environment:
>> - Boot with 2 cpus and no cpufreq driver.
>> - mod probe driver and see cpufreq sysfs files show up only for the 1st cluster.
>> - Online the rest of the 2 CPUs and have files show up correctly.
>> - rmmod the driver and see the files go away.
>> - modprobe again (or back and forth multiples times) and see it work.
>> - suspend/resume works as expected.
>> - When a cluster is offline, all read/writes to its sysfs files return an error
>>
>> v4
>> - Split it up into smaller patches
>> - Will handle physical CPU removal correctly
>> - Fixed earlier mistake of deleting code under !recover_policy
>> - Dropped some code refactor that reuses a lot of code between add/remove
>> - Dropped fix for exiting hotplug race with cpufreq driver probe/rmmod
>> - Dropped changes will come later once this series is acked.
>
> Hi Saravana,
>
> Any  updates on this? We might need some of this soon or should somebody
> else start working on this ?
>

Hey,

Sorry for the delay. Got side tracked with some commercial stuff. I'm 
still invested in finishing this up. I'll try to send out something 
within a week.

I did notice (didn't read mych) the "Locking issues with cpufreq and 
sysfs" thread. I think my patches should side step most of it.

Thanks,
Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
