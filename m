From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC 18/27] drivers: cpu-pd: Add PM Domain governor for
 CPUs
Date: Fri, 20 Nov 2015 09:42:50 -0700
Message-ID: <20151120164250.GD30342@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-19-git-send-email-lina.iyer@linaro.org>
 <20151118184245.GA28755@red-moon>
 <7hk2pdsg2a.fsf@deeprootsystems.com>
 <20151120162111.GA17930@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151120162111.GA17930@red-moon>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Kevin Hilman <khilman@kernel.org>, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, ahaslam@baylibre.com, mtitinger@baylibre.com
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 20 2015 at 09:20 -0700, Lorenzo Pieralisi wrote:
>On Thu, Nov 19, 2015 at 03:52:13PM -0800, Kevin Hilman wrote:
>> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
>>
>> > On Tue, Nov 17, 2015 at 03:37:42PM -0700, Lina Iyer wrote:
>> >> A PM domain comprising of CPUs may be powered off when all the CPUs in
>> >> the domain are powered down. Powering down a CPU domain is generally a
>> >> expensive operation and therefore the power performance trade offs
>> >> should be considered. The time between the last CPU powering down and
>> >> the first CPU powering up in a domain, is the time available for the
>> >> domain to sleep. Ideally, the sleep time of the domain should fulfill
>> >> the residency requirement of the domains' idle state.
>> >>
>> >> To do this effectively, read the time before the wakeup of the cluster's
>> >> CPUs and ensure that the domain's idle state sleep time guarantees the
>> >> QoS requirements of each of the CPU, the PM QoS CPU_DMA_LATENCY and the
>> >> state's residency.
>> >
>> > To me this information should be part of the CPUidle governor (it is
>> > already there), we should not split the decision into multiple layers.
>> >
>> > The problem you are facing is that the CPUidle governor(s) do not take
>> > cross cpus relationship into account, I do not think that adding another
>> > decision layer in the power domain subsystem helps, you are doing that
>> > just because adding it to the existing CPUidle governor(s) is invasive.
>> >
>> > Why can't we use the power domain work you put together to eg disable
>> > idle states that share multiple cpus and make them "visible" only
>> > when the power domain that encompass them is actually going down ?
>> >
>> > You could use the power domains information to detect states that
>> > are shared between cpus.
>> >
>> > It is just an idea, what I am saying is that having another governor in
>> > the power domain subsytem does not make much sense, you split the
>> > decision in two layers while there is actually one, the existing
>> > CPUidle governor and that's where the decision should be taken.
>>
>> Hmm, considering "normal" devices in "normal" power domains, and
>> following the same logic, the equivalent would be to say that the
>> decision to gate the power domain belongs to the individual drivers
>> in the domain instead of in the power domain layer.  I disagree.
>>
>> IMO, there are different decision layers because there are different
>> hardware layers.  Devices (including CPUs) are reponsible for handling
>> device-local idle states, based on device-local conditions (e.g. local
>> wakeups, timers, etc.)  and domains are responsible for handling
>> decisions based on conditions of the whole domain.
>
>After going through the series for the second time (it is quite complex and
>should probably be split) I understood your point of view and I agree with
>it, I will review it more in-depth to understand the details.
>
I have included patches from Axel and Marc, so as to get a complete
picture. My core changes are in genpd, cpu-pd and psci.c

>One thing that is not clear to me is how we would end up handling
>cluster states in platform coordinated mode with this series (and
>I am actually referring to the data we would add in the idle-states,
>such as min-residency).
>
>From what I see, the platform coordinated mode, doesnt need any of this.
We are fine as it is today. CPUs vote for the cluster state they can
enter and the f/w determines based on these votes. It makes sense and
probably easier to flatten out the cluster states and attach them to
cpuidle for that.

I couldnt find a symmetry with OS initated. May be it deserves more
discussion and brain storming.

>I admit that data for cluster states at present
>is not extremely well defined, because we have to add latencies for
>the cluster state even if the state itself may be just a cpu one (by
>definition a cluster state is entered only if all cpus in the cluster
>enter it, otherwise FW or power controller demote them automatically).
>

>I would like to take this series as an opportunity to improve the
>current situation in a clean way (and without changing the bindings,
>only augmenting them).
>
>On a side note, I think we should give up the concept of cluster
>entirely, to me they are just a group of cpus, I do not see any reason
>why we should group cpus this way and I do not like the dependencies
>of this series on the cpu-map either, I do not see the reason but I
>will go through code again to make sure I am not missing anything.
>
SoC's could have different organization of CPUs (clubbed as clusters)
and power domains the power thesee clusters. This information has to
come from the DT. Since there are no actual devices in linux for domain
management (with PSCI), I have added them to cpu-map, which already
builds up the cluster hierarchy. The only addition I had to make wa
allow these cluster nodes to be tell the kernel that they are domain
providers.

>To be clear, to me the cpumask should be created with all cpus belonging
>in a given power domain, no cluster dependency (and yes the CPU PM
>notifiers are not appropriate at present - eg on
>cpu_cluster_pm_{enter/exit} we save and restore the GIC distributor state
>even on multi-cluster systems, that's useless and has no connection with
>the real power domain topology at all, so the concept of cluster as it
>stands is shaky to say the least).
>

Lets discuss this more. I am interested in what you are thinking, will
let you go through the code.

Thanks for you time Lorenzo.

-- Lina
