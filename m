From: Alexandre Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH RFC] Revert "cpufreq: dt: Identify cpu-sharing for
 platforms without operating-points-v2"
Date: Thu, 16 Jun 2016 15:57:06 +0900
Message-ID: <5db9eb89-1026-e710-755b-c7a0fa87819e@nvidia.com>
References: <20160616053524.19921-1-acourbot@nvidia.com>
 <20160616063529.GA5726@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160616063529.GA5726@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <treding@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com
List-Id: linux-pm@vger.kernel.org

On 06/16/2016 03:35 PM, Viresh Kumar wrote:
> +Rafael
>
> On 16-06-16, 14:35, Alexandre Courbot wrote:
>> This is not an actual request for revert, but rather for comments about
>> the observed behavior since I am not really familiar with cpufreq.
>>
>> I am observing a serious performance regression on Jetson TK1 since 4.7-rc1:
>> namely, moving windows under X would become unsufferably slow, and graphical
>> performance under X in general is seriously degraded. After bisecting, I
>> found the regression to be visible since commit 1530b9963eeb ("cpufreq: dt:
>> Identify cpu-sharing for platforms without operating-points-v2")
>>
>> If I revert this commit, I noticed that the CPU frequency immediately jumps to
>> a higher frequency once I start moving windows (resulting in a smooth and
>> responsive action), whereas enabling this commit causes the CPU frequency to
>> remain low (typically 204 Mhz) in that case, resulting in CPU-bound slowness.
>>
>> What happens is that with 1530b9963eeb applied, dev_pm_opp_get_sharing_cpus()
>> returns zero causing the fallback variable to remain false, whereas without it
>> opp_v1 is set to true.
>>
>> It is not clear to me whether this is a cpufreq issue or a Tegra issue, so I am
>> posting this in the hope to get clarifications from either side.
>>
>> Thanks!
>
> Yeah, you just hit a corner case. Sorry about that :(
>
> Can you try a patch that I sent to you instead? Its subject is:
>
> [PATCH] PM / OPP: 'UNKNOWN' status of opp-table->shared

Thanks, this seems to solve the issue.

> Also I would like to know one more thing. You can hit this bug only if
> some other piece of code for your platform is creating OPP table for
> the CPUs. Which code is doing that ?

Good question. I am still educating myself about OPP - adding Thierry in 
the meantime who may have an answer.
