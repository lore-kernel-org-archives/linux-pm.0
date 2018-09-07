From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v6 04/14] PM / EM: Expose the Energy Model in sysfs
Date: Thu, 6 Sep 2018 17:14:57 -0700
Message-ID: <fe196eda-5e97-b115-0c24-b484428d2ac2@arm.com>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-5-quentin.perret@arm.com>
 <c012c934-d861-eba6-0c67-63e8308ae37b@arm.com>
 <20180906140914.noe3yz7xrb4g5sf4@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906140914.noe3yz7xrb4g5sf4@queper01-lin>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/06/2018 07:09 AM, Quentin Perret wrote:
> Hi Dietmar,
> 
> On Wednesday 05 Sep 2018 at 23:56:43 (-0700), Dietmar Eggemann wrote:
>> On 08/20/2018 02:44 AM, Quentin Perret wrote:
>>> Expose the Energy Model (read-only) of all performance domains in sysfs
>>> for convenience. To do so, add a kobject to the CPU subsystem under the
>>> umbrella of which a kobject for each performance domain is attached.
>>>
>>> The resulting hierarchy is as follows for a platform with two
>>> performance domains for example:
>>>
>>>      /sys/devices/system/cpu/energy_model
>>>      ├── pd0
>>>      │   ├── cost
>>>      │   ├── cpus
>>>      │   ├── frequency
>>>      │   └── power
>>
>> cpus (cpumask of the perf domain), frequency (OPP's of the perf domain) and
>> power (values at those OPP's) are somehow easy to grasp, cost is definitely
>> not.
>>
>> You have this nice description in em_pd_energy() what cost actually is.
>> IMHO, might be worth repeating this at least in the patch header here.
> 
> Hmm, this patch introduces the sysfs interface, not the 'cost' field
> itself. As long as 'cost' is documented in the patch that introduces it
> we should be good no ? I mean this patch header tells you _where_ the
> fields of the structure are exposed. _What_ the structure is all about
> is a different story.

Mmmh, so maybe a EAS related documentation file explaining this 
interface as well, which can be introduced later is the solution here?

I'm just not 100% convinced that those cost values are self-explanatory 
like the other three items:

root@h960:~# ls /sys/devices/system/cpu/energy_model/pd0/
cost
cpus
frequency
power

root@h960:~# cat /sys/devices/system/cpu/energy_model/pd0/*
96 129 163 201 245
0-3
533000 999000 1402000 1709000 1844000
28 70 124 187 245

> But yeah, in any case, a reminder shouldn't hurt I guess, if you really
> want one :-)

Nothing which should hold this patch-set back though.
