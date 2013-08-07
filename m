From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/6] clk: Tegra: Add CPU0 clock driver
Date: Wed, 07 Aug 2013 12:50:59 -0600
Message-ID: <52029713.5070808@wwwdotorg.org>
References: <cover.1375886595.git.viresh.kumar@linaro.org> <8d192a13cb7e088943da40689d62bc6353bd8604.1375886595.git.viresh.kumar@linaro.org> <52028620.6000608@wwwdotorg.org> <CAKohpokVgcMfmKmjkxc9Dr3z6mBKad23uUdB4ydN_xzGHdfedQ@mail.gmail.com> <52028859.20008@wwwdotorg.org> <CAKohpokK7F7tYJnisVjF=NCRb9zUjQNzrFdXs+QsPSb4oqyytA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpokK7F7tYJnisVjF=NCRb9zUjQNzrFdXs+QsPSb4oqyytA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, swarren@nvidia.com, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 08/07/2013 11:54 AM, Viresh Kumar wrote:
> On 7 August 2013 23:18, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 08/07/2013 11:45 AM, Viresh Kumar wrote:
>>> On 7 August 2013 23:08, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>> On 08/07/2013 08:46 AM, Viresh Kumar wrote:
>>>>> This patch adds CPU0's clk driver for Tegra. It will be used by the generic
>>>>> cpufreq-cpu0 driver to get/set cpu clk.
>>>>>
>>>>> Most of the platform specific bits are picked from tegra-cpufreq.c.
>>>>
>>>> Hmmm. I'm not sure if it makes sense to represent this as a clock
>>>> object; isn't this more of a virtual construct that manages the rate of
>>>> the clock, rather than an actual clock? The actual clock already exists
>>>> as "cpu".
>>>
>>> I see it as this: There is a clock in system for cpu, call it "cpu". Now we
>>> must be able to provide get/set routines for it. A set should set the
>>> frequency to whatever is asked for and should really worry about how
>>> that is being set. This part is internal to "cpu" clk.
>>
>> Sure.
>>
>>> This is what cpufreq-cpu0 driver should expect and does. Current "cpu"
>>> clock implemented doesn't provide this facility ? And so this wrapper
>>> made sense to me.
>>
>> But the additional management logic on top of the raw clock is exactly
>> what the cpufreq driver is for. This patch series is basically moving
>> the cpufreq driver code inside the clock code instead.
> 
> Above "sure" didn't go very well with what you wrote here :)
> 
> The additional management that we are required to do isn't cpufreq
> driver specific but cpu or platform specific.

Right, and that's *exactly* what having a cpufreq driver is for; to
implement the details of CPU clock management.
