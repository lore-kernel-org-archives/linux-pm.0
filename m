From: Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Thu, 16 Nov 2017 15:02:18 +0000
Message-ID: <65fef2a1-d23f-3de2-bd91-021296c3e2f7@arm.com>
References: <cover.1510735482.git.viresh.kumar@linaro.org>
 <fcca009e0e10840ff5ee31c88b618a212ab69201.1510735482.git.viresh.kumar@linaro.org>
 <761f7963-8b6d-b002-5404-a9ad0acf84d6@linaro.org>
 <20171115154311.GA3005@localhost.localdomain>
 <CAJZ5v0j6Hk8D29h+MdMeU-PgSAFkNG-41_a7d+goVuSve0=CYw@mail.gmail.com>
 <20171115182047.GA4831@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934397AbdKPPCW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Nov 2017 10:02:22 -0500
In-Reply-To: <20171115182047.GA4831@localhost.localdomain>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Javi Merino <javi.merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>

Hi guys,

On 15/11/17 18:20, Eduardo Valentin wrote:
> On Wed, Nov 15, 2017 at 07:17:49PM +0100, Rafael J. Wysocki wrote:
>> On Wed, Nov 15, 2017 at 4:43 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
>>> On Wed, Nov 15, 2017 at 11:18:03AM +0100, Daniel Lezcano wrote:
>>>> On 15/11/2017 10:19, Viresh Kumar wrote:
>>>>> No one has used it for the last two and half years (since it was
>>>>> introduced by commit c36cf0717631 ("thermal: cpu_cooling: implement the
>>>>> power cooling device API")), get rid of it.
>>>>>
>>>>> Cc: Javi Merino <javi.merino@arm.com>
>>>>> Cc: Punit Agrawal <punit.agrawal@arm.com>
>>>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>>> ---
>>>>
>>>> Even if I agree that is not used to in the mainstream kernel, it is part
>>>> of the EAS which is currently merged in Android.
>>>>
>>>
>>> Even though we really should care about stuff that is in mainline, this
>>> specific case is about a piece of code that never made mainline, or got
>>> lost on translation from one version to another. So, I am currently
>>> nacking this patch and asking ARM/linaro folks to upstream the juno
>>> implementation that uses static power.
>>
>> However, I would like to see a clear declaration from whoever is
>> maintaining that code today that there is a plan in place to upstream
>> it and that this plan will actually be acted on.  And, better yet,
>> *when* that can be expected to happen.
>>
>> Without such a declaration I'm afraid there is no point for the
>> mainline to carry the unused code.  Which apparently gets in the way
>> somehow, or Viresh wouldn't have taken the time to attempt to remove
>> it I suppose?
> 
> 
> I agree here. This is mostly a code maintained by the linaro folks at
> this moment (daniel, please chime in if I am wrong). If no effort is
> done to get the code into mainline, there is no point in keeping the
> static component as a dead code in our tree.
> 

When it was added in lsk 3.18 in what was then a thermal driver for Juno
it was believed to have an effect in thermal mitigation, but that was
not proven later as to justify posting it upstream, and that is why the
code never made it in mainline.
The code added there can be found at:
https://git.linaro.org/landing-teams/working/arm/kernel-release.git/tree/drivers/thermal/scpi-thermal.c?h=lsk-3.18-armlt#n247

As for removing this code now, I would not want to make that decision without
spending more time to check if it impacts other customer codelines.
I'll come back with a reply to this in the next couple of days.

Thank you,
Ionela.

>>
>> Thanks,
>> Rafael
> 
