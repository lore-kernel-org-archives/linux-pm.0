From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH V2 0/8] PM / OPP: Multiple regulator support
Date: Sun, 23 Oct 2016 20:08:02 -0500
Message-ID: <41a8b4a1-94d3-e086-a328-495f69815d1c@ti.com>
References: <cover.1476952750.git.viresh.kumar@linaro.org>
 <CAJZ5v0jNJBDKq+ccHKRA6JGAOXV0qT0-k1mwAcBkCv-7JtzACw@mail.gmail.com>
 <CAKohpon8f-7ppaFsb+wZH4Dj527HXRF73E8taYN9QfcojjJa3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpon8f-7ppaFsb+wZH4Dj527HXRF73E8taYN9QfcojjJa3g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,
On 10/21/2016 10:40 AM, Viresh Kumar wrote:
> On 21 October 2016 at 19:09, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Thu, Oct 20, 2016 at 10:44 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> Hi,
>>>
>>> Some platforms (like TI) have complex DVFS configuration for CPU
>>> devices, where multiple regulators are required to be configured to
>>> change DVFS state of the device. This was explained well by Nishanth
>>> earlier [1].
>>>
>>> Some thoughts went into it few months back but then it all got lost. I
>>> am trying to get that back on track with this thread.
>>>
>>> One of the major complaints around multiple regulators case was that the
>>> DT isn't responsible in any way to represent the ordering in which
>>> multiple supplies need to be programmed, before or after frequency
>>> change. It was considered in this patch and such information is left to
>>> the platform specific OPP driver now, which can register its own
>>> opp_set_rate() callback with the OPP core and the OPP core will then
>>> call it during DVFS.
>>>
>>> The patches are tested on Exynos5250 (Dual A15). I have hacked around DT
>>> and code to pass values for multiple regulators and verified that they
>>> are all properly read by the kernel (using debugfs interface).
>>>
>>> Though more testing on real (TI) platforms would be useful.
>>>
>>> This is rebased over: linux-next branch in the PM tree.
>>>
>>> V1->V2:
>>> - Ack from Rob for 1st patch
>>> - Moved the supplies structure to pm_opp.h (Dave)
>>> - Fixed an compilation warning.
>>
>> I need somebody from the OPP camp to review patches [2-8/8] for me.
>
> Sure, I have already asked Stephen yesterday to do that.

Overall this series looks good to me apart from a few small things. Most 
importantly I was able to get a working implementation using two 
regulators on ti dra7xx platform with proper sequencing built on top of 
this series. We have cpu regulator and Adaptive body bias (abb) 
regulator that must be scaled in a certain order before or after clock 
scaling and I was able to implement a rough custom set_rate to perform 
this and ran some dvfs stress tests that all worked fine.

First comment, I think the platform specific set_rate is a good place to 
hook in for adaptive voltage scaling as well. I was able to implement TI 
Class0 AVS in the same code by using the requested transition voltage as 
a reference and programming AVS voltage using that, along with scaling 
the additional regulators in sequence (the original multi regulator 
functionality). I would think some people would want to use this even 
with single regulator platforms, no? cpufreq-dt works as is for that, we 
just swap out the regulators.

This raises some concerns about dependencies/probe sequencing. Right now 
we just need to make sure the cpufreq-dt driver probes after we have 
called _set_regulators, but if our platform code fails cpufreq-dt 
currently will treat this as no regulator needed for the platform and 
operate without one, which will likely hang the system. Is there a good 
way to to guarantee this doesn't happen? My main concern is that if we 
plan to provide a platform specific set-rate function, we should have a 
way to indicate this and prevent things from progressing if it isn't yet 
ready.

Again, overall I think it solves the multi regulator problem, and it 
works well for AVS as well. For the series:

Tested-by: Dave Gerlach <d-gerlach@ti.com>

Regards,
Dave

>
> --
> viresh
>
