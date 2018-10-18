From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] sched/cpufreq: Reorganize the cpufreq files
Date: Thu, 18 Oct 2018 11:54:12 +0200
Message-ID: <8585bac0-c72c-edf4-2e93-c8740a3b1b6c@linaro.org>
References: <CAJZ5v0iALqLw+Y_tKw86dh2oxnmvALhoVJxEcWWA+x1jU3GjdA@mail.gmail.com>
 <1539855372-11472-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0ikpPk12PshjB7EwtGSz6kF5WJyKgDHB8cnXaEusy38UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0ikpPk12PshjB7EwtGSz6kF5WJyKgDHB8cnXaEusy38UQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Zhang, Rui" <rui.zhang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, Amit Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Linux PM <linux-pm@vger.kernel.org>, Quentin Perret <quentin.perret@arm.com>, ionela.voinescu@arm.com, Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar <mingo@redhat.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Juri Lelli <juri.lelli@redhat.com>, Patrick Bellasi <patrick.bellasi@arm.com>
List-Id: linux-pm@vger.kernel.org

On 18/10/2018 11:42, Rafael J. Wysocki wrote:
> On Thu, Oct 18, 2018 at 11:36 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> It was suggested to set the scene for the PM components in the
>> scheduler code organization in the recent discussion about making the
>> scheduler aware of the capacity capping from the thermal framework.
>>
>> Move the cpufreq files into its own directory as suggested at:
>>
>> https://lkml.org/lkml/2018/10/18/353
>> https://lkml.org/lkml/2018/10/18/408
> 
> Fair enough, but do we need to do that right now?

I'm not planning to do more code reorg than this patch right now. Up to
you to decide if you are willing to take them.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
