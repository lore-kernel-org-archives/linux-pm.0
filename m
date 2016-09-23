From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 4/4] cpuidle/menu: add per cpu pm_qos_resume_latency
 consideration
Date: Fri, 23 Sep 2016 03:36:30 +0200
Message-ID: <fdf44e20-c7a1-5e2b-22e8-36852bf2c02a@intel.com>
References: <1472114562-2736-1-git-send-email-alex.shi@linaro.org>
 <1472114562-2736-4-git-send-email-alex.shi@linaro.org>
 <57D80709.4040500@linaro.org> <3288596.DV966QMpDZ@vostro.rjw.lan>
 <CAKfTPtDWq1ju2O8TSDGEJh0S_LdPw9CgjnzE5m0P8aOg3iDYuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:36302 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965135AbcIWBgg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Sep 2016 21:36:36 -0400
In-Reply-To: <CAKfTPtDWq1ju2O8TSDGEJh0S_LdPw9CgjnzE5m0P8aOg3iDYuA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alex Shi <alex.shi@linaro.org>, open list <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arjan van de Ven <arjan@linux.intel.com>, Rik van Riel <riel@redhat.com>

On 9/14/2016 10:28 AM, Vincent Guittot wrote:
> Hi Rafael,
>
> On 14 September 2016 at 00:10, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Tuesday, September 13, 2016 10:02:49 PM Alex Shi wrote:
>>> Hi Daniel & Rafael,
>>>
>>> Any comments on this patch?
>> I actually am not sure about the whole series.
>>
>> I know your motivation, but honestly the changes here may not be the best way
>> to achieve what you need.
>>
>> You may think that the changes are trivial, but in fact they are not.  There
>> are side effects and I'm not sure about the resulting user space interface
>> at all.
> This patchset has got 2 parts:
> - one part is about taking into account per-device resume latency
> constraint when selecting the idle state of a CPU. This value can
> already be set by kernel (even if it's probably not done yet) but this
> constraint is never taken into account
> - the other part is about exposing the resume latency to userspace.
> This part might raise more discussion but I see one example that could
> take advantage of this. When you have several clusters of CPUs and you
> want to dedicate some CPUs  to latency sensitive activity and prevent
> deep sleep  state on these CPUs but you want to let the other CPUs
> using all C-state

The first very basic question about this I have is whether or not the 
device PM QoS mechanism is suitable for the task at hand at all.

It certainly hasn't been invented with it in mind.

Thanks,
Rafael

