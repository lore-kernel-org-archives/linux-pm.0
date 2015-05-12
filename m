From: Sai Gurrappadi <sgurrappadi@nvidia.com>
Subject: Re: [RFCv4 PATCH 00/34] sched: Energy cost model for energy-aware
 scheduling
Date: Tue, 12 May 2015 15:07:26 -0700
Message-ID: <5552799E.2060507@nvidia.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>, peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Peter Boonstoppel <pboonstoppel@nvidia.com>
List-Id: linux-pm@vger.kernel.org


On 05/12/2015 12:38 PM, Morten Rasmussen wrote:
> Test results for ARM TC2 (2xA15+3xA7) with cpufreq enabled:
> 
> sysbench: Single task running for 3 seconds.
> rt-app [4]: mp3 playback use-case model
> rt-app [4]: 5 ~[6,13,19,25,31,38,44,50]% periodic (2ms) tasks
> 
> Note: % is relative to the capacity of the fastest cpu at the highest
> frequency, i.e. the more busy ones do not fit on little cpus.
> 
> A newer version of rt-app was used which supports a better but slightly
> different way of modelling the periodic tasks. Numbers are therefore
> _not_ comparable to the RFCv3 numbers.
> 
> Average numbers for 20 runs per test (ARM TC2).
> 
> Energy		Mainline	EAS		noEAS
> 
> sysbench	100		251*		227*
> 
> rt-app mp3	100		63		111
> 
> rt-app 6%	100		42		102
> rt-app 13%	100		58		101
> rt-app 19%	100		87		101
> rt-app 25%	100		94		104
> rt-app 31%	100		93		104
> rt-app 38%	100		114		117
> rt-app 44%	100		115		118
> rt-app 50%	100		125		126

Hi Morten,

What is noEAS? From the numbers, noEAS != Mainline?

Maybe also have some perf numbers to show that perf is in fact preserved
while lowering power.

-Sai
