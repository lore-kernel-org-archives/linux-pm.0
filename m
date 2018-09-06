From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v6 04/14] PM / EM: Expose the Energy Model in sysfs
Date: Wed, 5 Sep 2018 23:56:43 -0700
Message-ID: <c012c934-d861-eba6-0c67-63e8308ae37b@arm.com>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-5-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820094420.26590-5-quentin.perret@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>, peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/20/2018 02:44 AM, Quentin Perret wrote:
> Expose the Energy Model (read-only) of all performance domains in sysfs
> for convenience. To do so, add a kobject to the CPU subsystem under the
> umbrella of which a kobject for each performance domain is attached.
> 
> The resulting hierarchy is as follows for a platform with two
> performance domains for example:
> 
>     /sys/devices/system/cpu/energy_model
>     ├── pd0
>     │   ├── cost
>     │   ├── cpus
>     │   ├── frequency
>     │   └── power

cpus (cpumask of the perf domain), frequency (OPP's of the perf domain) 
and power (values at those OPP's) are somehow easy to grasp, cost is 
definitely not.

You have this nice description in em_pd_energy() what cost actually is. 
IMHO, might be worth repeating this at least in the patch header here.

[...]
