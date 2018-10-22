From: Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
Date: Mon, 22 Oct 2018 13:50:34 -0600
Message-ID: <20181022195034.GD17444@codeaurora.org>
References: <20181011160053.GA2371@codeaurora.org>
 <20181011161927.GC28583@e107155-lin>
 <20181011165822.GB2371@codeaurora.org>
 <20181011173733.GA26447@e107155-lin>
 <20181011210609.GD2371@codeaurora.org>
 <20181012150429.GH3401@e107155-lin>
 <20181012160427.GG2371@codeaurora.org>
 <20181012170040.GA21057@e107155-lin>
 <20181012171910.GI2371@codeaurora.org>
 <20181012172500.GA23170@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181012172500.GA23170@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 12 2018 at 11:25 -0600, Sudeep Holla wrote:
>On Fri, Oct 12, 2018 at 11:19:10AM -0600, Lina Iyer wrote:
>> On Fri, Oct 12 2018 at 11:01 -0600, Sudeep Holla wrote:
>> > On Fri, Oct 12, 2018 at 10:04:27AM -0600, Lina Iyer wrote:
>> > > On Fri, Oct 12 2018 at 09:04 -0600, Sudeep Holla wrote:
>> >
>> > [...]
>> >
>> > Yes all these are fine but with multiple power-domains/cluster, it's
>> > hard to determine the first CPU. You may be able to identify it within
>> > the power domain but not system wide. So this doesn't scale with large
>> > systems(e.g. 4 - 8 clusters with 16 CPUs).
>> >
>> We would probably not worry too much about power savings in a msec
>> scale, if we have that big a system. The driver is a platform specific
>> driver, primarily intended for a mobile class CPU and usage. In fact, we
>> haven't done this for QC's server class CPUs.
>>
>
>OK, along as there's no attempt to make it generic and keep it platform
>specific, I am not that bothered.
>
>> > > > I think we are mixing the system sleep states with CPU idle here.
>> > > > If it's system sleeps states, the we need to deal it in some system ops
>> > > > when it's the last CPU in the system and not the cluster/power domain.
>> > > >
>> > > I think the confusion for you is system sleep vs suspend. System sleep
>> > > here (probably more of a QC terminology), refers to powering down the
>> > > entire SoC for very small durations, while not actually suspended. The
>> > > drivers are unaware that this is happening. No hotplug happens and the
>> > > interrupts are not migrated during system sleep. When all the CPUs go
>> > > into cpuidle, the system sleep state is activated and the resource
>> > > requirements are lowered. The resources are brought back to their
>> > > previous active values before we exit cpuidle on any CPU. The drivers
>> > > have no idea that this happened. We have been doing this on QCOM SoCs
>> > > for a decade, so this is not something new for this SoC. Every QCOM SoC
>> > > has been doing this, albeit differently because of their architecture.
>> > > The newer ones do most of these transitions in hardware as opposed to an
>> > > remote CPU. But this is the first time, we are upstreaming this :)
>> > >
>> >
>> > Indeed, I know mobile platforms do such optimisations and I agree it may
>> > save power. As I mentioned above it doesn't scale well with large systems
>> > and also even with single power domains having multiple idle states where
>> > only one state can do this system level idle but not all. As I mentioned
>> > in the other email to Ulf, it's had to generalise this even with DT.
>> > So it's better to have this dealt transparently in the firmware.
>> >
>> Good, then we are on agreement here.
>
It was brought to my attention that there may be some misunderstanding
here. I still believe we need to do this for small systems like the
mobile platforms and the solution may not scale well to servers. We
don't plan to extend the solution to anything other than the mobile SoC.

>No worries.
>
Thanks,
Lina
