From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
Date: Thu, 11 Oct 2018 15:06:09 -0600
Message-ID: <20181011210609.GD2371@codeaurora.org>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181011112013.GC32752@e107155-lin>
 <20181011160053.GA2371@codeaurora.org>
 <20181011161927.GC28583@e107155-lin>
 <20181011165822.GB2371@codeaurora.org>
 <20181011173733.GA26447@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181011173733.GA26447@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 11 2018 at 11:37 -0600, Sudeep Holla wrote:
>On Thu, Oct 11, 2018 at 10:58:22AM -0600, Lina Iyer wrote:
>> On Thu, Oct 11 2018 at 10:19 -0600, Sudeep Holla wrote:
>> > On Thu, Oct 11, 2018 at 10:00:53AM -0600, Lina Iyer wrote:
>> > > Sudeep,
>> > >
>> > > The CPU PD does not power off the domain from Linux. That is done from
>> > > PSCI firmware (ATF). These patches are doing the part that Linux has do,
>> > > when powering off the CPUs, to achieve a low standby power consumption.
>> > >
>> >
>> > I don't understand why Linux *has do* this part as PSCI manages CPU PM.
>> >
>> If we don't do this, then we leave a lot of power saving on the table,
>> when the CPU powered off. Why should the DDR and the shared busses and
>> clocks be idling at high power, when not needed ? PSCI has no clue to
>> what resource requests was made my Linux and its Linux's responsibility
>> to relinquish them when not needed. Therefore has to done from Linux.
>>
>
>Is DDR managed by Linux ? I assumed it was handled by higher exception
>levels. Can you give examples of resources used by CPU in this context.
>When CPU can be powered on or woken up without Linux intervention, the
>same holds true for CPU power down or sleep states. I still see no reason
>other than the firmware has no support to talk to RPMH.
>
DDR, shared clocks, regulators etc. Imagine you are running something on
the screen and CPUs enter low power mode, while the CPUs were active,
there was a need for bunch of display resources, and things the app may
have requested resources, while the CPU powered down the requests may
not be needed the full extent as when the CPU was running, so they can
voted down to a lower state of in some cases turn off the resources
completely. What the driver voted for is dependent on the runtime state
and the usecase currently active. The 'sleep' state value is also
determined by the driver/framework.

>> Even with all the unnecessary flushing it is totally worth it. OSI helps
>> alleviates this a bit because it embodies the same CPU PD concepts at
>> its core. Imagine if you didn't have CPU PM domain, the every CPU would
>> be flushing RPMH request, whenever they power down, because you never know
>> when all CPUs are going to be powered down at the same time. That is the
>> biggest benefit of OSI over PC mode in PSCI.
>>
>
>I am not saying every CPU needs to do that, last CPU can do that in PSCI.
>
Yes, the last CPU is what we are getting to with this series.. Now this
can't be done from PSCI. I will explain below.

>Oh interesting, wasn't aware RPMH really needs to care about exception
>level. For me, we know CPU is powering down, so it needs to release all
>the resource. RPMH needs to know that and any exception level can let
>RPMH know that. Sorry may be I don't have enough knowledge on SDM SoC.
>
Some resources are secure resources used in secure environments. They
cannot be requested from non-secure. Hence secure levels are voters of
their own accord.

Now, since we are considering linux and secure (infact linux,hyp,secure)
as separate voters they have to each request their votes and release
their votes separately. PSCI cannot release a request made from Linux.
This is how the SoC is designed. All exception levels will abide by
that.

>> Yes, we are close to having a platform have both, possibly.
>>
>
>Comparison numbers please :)
>
We are far from it, for that, atleast now. But we will get there.

>Having to adapt DT to the firmware though the feature is fully discoverable
>is not at all good IMO. So the DT in this series *should work* with OSI
>mode if the firmware has the support for it, it's as simple as that.
>
The firmware is ATF and does not support OSI.

Thanks,
Lina
