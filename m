From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v4 00/10] arm, arm64, cpufreq: frequency- and
 cpu-invariant accounting support for task scheduler
Date: Thu, 31 Aug 2017 12:27:16 +0100
Message-ID: <38de527f-7a4e-7344-bba0-906c7920d03f@arm.com>
References: <20170825143206.30467-1-dietmar.eggemann@arm.com>
 <11249770.4iDhbWWonU@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <11249770.4iDhbWWonU@aspire.rjw.lan>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Raphael,

On 31/08/17 00:34, Rafael J. Wysocki wrote:
> On Friday, August 25, 2017 4:31:56 PM CEST Dietmar Eggemann wrote:

[...]

>> [1] https://marc.info/?l=linux-kernel&m=149625018223002&w=2
>> [2] https://marc.info/?l=linux-kernel&m=150118402232039&w=2
>> [3] https://marc.info/?l=linux-pm&m=149933474313566&w=2
>> [4] http://arminfo.emea.arm.com/help/topic/com.arm.doc.den0056a/DEN0056A_System_Control_and_Management_Interface.pdf
>> [5] https://marc.info/?l=linux-kernel&m=149690865010019&w=2
>>
>> Dietmar Eggemann (10):
>>   drivers base/arch_topology: free cpumask cpus_to_visit
>>   cpufreq: provide default frequency-invariance setter function
>>   cpufreq: arm_big_little: invoke frequency-invariance setter function
>>   cpufreq: dt: invoke frequency-invariance setter function
>>   drivers base/arch_topology: provide frequency-invariant accounting
>>     support
>>   drivers base/arch_topology: allow inlining cpu-invariant accounting
>>     support
>>   arm: wire frequency-invariant accounting support up to the task
>>     scheduler
>>   arm: wire cpu-invariant accounting support up to the task scheduler
>>   arm64: wire frequency-invariant accounting support up to the task
>>     scheduler
>>   arm64: wire cpu-invariant accounting support up to the task scheduler
>>
>>  arch/arm/include/asm/topology.h   |  8 ++++++++
>>  arch/arm64/include/asm/topology.h |  8 ++++++++
>>  drivers/base/arch_topology.c      | 29 +++++++++++++++++++++++------
>>  drivers/cpufreq/arm_big_little.c  | 10 +++++++++-
>>  drivers/cpufreq/cpufreq-dt.c      | 12 ++++++++++--
>>  drivers/cpufreq/cpufreq.c         |  6 ++++++
>>  include/linux/arch_topology.h     | 18 +++++++++++++++++-
>>  include/linux/cpufreq.h           |  3 +++
>>  8 files changed, 84 insertions(+), 10 deletions(-)
>>
>>
> 
> FWIW, patches [2-4/10] in this series are fine by me, but I guess you
> need to talk to Viresh about the [3-4/10] anyway.

Thanks for the review! Viresh already gave me his 'Acked-by' for
[3-4/10] during the v3 review.

Since this patch-set touches different subsystems I wonder via which
tree it should go upstream? Could it go via your linux-pm tree or should
I ask Greg K-H?

Thanks,

-- Dietmar

[...]
