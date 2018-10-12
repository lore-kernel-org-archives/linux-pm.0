From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
Date: Fri, 12 Oct 2018 10:04:27 -0600
Message-ID: <20181012160427.GG2371@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181011112013.GC32752@e107155-lin>
 <20181011160053.GA2371@codeaurora.org>
 <20181011161927.GC28583@e107155-lin>
 <20181011165822.GB2371@codeaurora.org>
 <20181011173733.GA26447@e107155-lin>
 <20181011210609.GD2371@codeaurora.org>
 <20181012150429.GH3401@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181012150429.GH3401@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 12 2018 at 09:04 -0600, Sudeep Holla wrote:
>On Thu, Oct 11, 2018 at 03:06:09PM -0600, Lina Iyer wrote:
>> On Thu, Oct 11 2018 at 11:37 -0600, Sudeep Holla wrote:
>[...]
>
>> >
>> > Is DDR managed by Linux ? I assumed it was handled by higher exception
>> > levels. Can you give examples of resources used by CPU in this context.
>> > When CPU can be powered on or woken up without Linux intervention, the
>> > same holds true for CPU power down or sleep states. I still see no reason
>> > other than the firmware has no support to talk to RPMH.
>> >
>> DDR, shared clocks, regulators etc. Imagine you are running something on
>> the screen and CPUs enter low power mode, while the CPUs were active,
>> there was a need for bunch of display resources, and things the app may
>> have requested resources, while the CPU powered down the requests may
>> not be needed the full extent as when the CPU was running, so they can
>> voted down to a lower state of in some cases turn off the resources
>> completely. What the driver voted for is dependent on the runtime state
>> and the usecase currently active. The 'sleep' state value is also
>> determined by the driver/framework.
>>
>
>Why does CPU going down says that another (screen - supposedly shared)
>resource needs to be relinquished ? Shouldn't display decide that on it's
>own ? I have no idea why screen/display is brought into this discussion.

>CPU can just say: hey I am going down and I don't need my resource.
>How can it say: hey I am going down and display or screen also doesn't
>need the resource. On a multi-cluster, how will the last CPU on one know
>that it needs to act on behalf of the shared resource instead of another
>cluster.
>
Fair questions. Now how would the driver know that the CPUs have powered
down, to say, if you are not active, then you can put these resources in
low power state?
Well they don't, because sending out CPU power down notifications for
all CPUs and the cluster are expensive and can lead to lot of latency.
Instead, the drivers let the RPMH driver know that if and when the CPUs
power down, then you could request these resources to be in that low
power state. The CPU PD power off callbacks trigger the RPMH driver to
flush and request a low power state on behalf of all the drivers.

Drivers let know what their active state request for the resource is as
well as their CPU powered down state request is, in advance. The
'active' request is made immediately, while the 'sleep' request is
staged in. When the CPUs are to be powered off, this request is written
into a hardware registers. The CPU PM domain controller, after powering
down, will make these state requests in hardware thereby lowering the
standby power. The resource state is brought back into the 'active'
value before powering on the first CPU.

>I think we are mixing the system sleep states with CPU idle here.
>If it's system sleeps states, the we need to deal it in some system ops
>when it's the last CPU in the system and not the cluster/power domain.
>
I think the confusion for you is system sleep vs suspend. System sleep
here (probably more of a QC terminology), refers to powering down the
entire SoC for very small durations, while not actually suspended. The
drivers are unaware that this is happening. No hotplug happens and the
interrupts are not migrated during system sleep. When all the CPUs go
into cpuidle, the system sleep state is activated and the resource
requirements are lowered. The resources are brought back to their
previous active values before we exit cpuidle on any CPU. The drivers
have no idea that this happened. We have been doing this on QCOM SoCs
for a decade, so this is not something new for this SoC. Every QCOM SoC
has been doing this, albeit differently because of their architecture.
The newer ones do most of these transitions in hardware as opposed to an
remote CPU. But this is the first time, we are upstreaming this :)

Suspend is an altogether another idle state where drivers are notified
and relinquish their resources before the CPU powers down. Similar
things happen there as well, but at a much deeper level. Resources may
be turned off completely instead of just lowering to a low power state.

For example, suspend happens when the screen times out on a phone.
System sleep happens few hundred times when you are actively reading
something on the phone.

>> > Having to adapt DT to the firmware though the feature is fully discoverable
>> > is not at all good IMO. So the DT in this series *should work* with OSI
>> > mode if the firmware has the support for it, it's as simple as that.
>> >
>> The firmware is ATF and does not support OSI.
>>
>
>OK, to keep it simple: If a platform with PC mode only replaces the firmware
>with one that has OSI mode, we *shouldn't need* to change DT to suite it.
>I think I asked Ulf to add something similar in DT bindings.
>
Fair point and that is what this RFC intends to bring. That PM domains
are useful not just for PSCI, but also for Linux PM drivers such as this
one. We will discuss more how we can fold in platform specific
activities along with PSCI OSI state determination when the
domain->power_off is called. I have some ideas on that. Was hoping to
get to that after the inital idea is conveyed.

Thanks for your time.

Lina
