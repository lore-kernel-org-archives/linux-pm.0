From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
Date: Fri, 12 Oct 2018 16:04:29 +0100
Message-ID: <20181012150429.GH3401@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181011112013.GC32752@e107155-lin>
 <20181011160053.GA2371@codeaurora.org>
 <20181011161927.GC28583@e107155-lin>
 <20181011165822.GB2371@codeaurora.org>
 <20181011173733.GA26447@e107155-lin>
 <20181011210609.GD2371@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181011210609.GD2371@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lina Iyer <ilina@codeaurora.org>
Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 11, 2018 at 03:06:09PM -0600, Lina Iyer wrote:
> On Thu, Oct 11 2018 at 11:37 -0600, Sudeep Holla wrote:
[...]

> >
> > Is DDR managed by Linux ? I assumed it was handled by higher exception
> > levels. Can you give examples of resources used by CPU in this context.
> > When CPU can be powered on or woken up without Linux intervention, the
> > same holds true for CPU power down or sleep states. I still see no reason
> > other than the firmware has no support to talk to RPMH.
> >
> DDR, shared clocks, regulators etc. Imagine you are running something on
> the screen and CPUs enter low power mode, while the CPUs were active,
> there was a need for bunch of display resources, and things the app may
> have requested resources, while the CPU powered down the requests may
> not be needed the full extent as when the CPU was running, so they can
> voted down to a lower state of in some cases turn off the resources
> completely. What the driver voted for is dependent on the runtime state
> and the usecase currently active. The 'sleep' state value is also
> determined by the driver/framework.
>

Why does CPU going down says that another (screen - supposedly shared)
resource needs to be relinquished ? Shouldn't display decide that on it's
own ? I have no idea why screen/display is brought into this discussion.
CPU can just say: hey I am going down and I don't need my resource.
How can it say: hey I am going down and display or screen also doesn't
need the resource. On a multi-cluster, how will the last CPU on one know
that it needs to act on behalf of the shared resource instead of another
cluster.

I think we are mixing the system sleep states with CPU idle here.
If it's system sleeps states, the we need to deal it in some system ops
when it's the last CPU in the system and not the cluster/power domain.

[...]

> > Oh interesting, wasn't aware RPMH really needs to care about exception
> > level. For me, we know CPU is powering down, so it needs to release all
> > the resource. RPMH needs to know that and any exception level can let
> > RPMH know that. Sorry may be I don't have enough knowledge on SDM SoC.
> >
> Some resources are secure resources used in secure environments. They
> cannot be requested from non-secure. Hence secure levels are voters of
> their own accord.
>

I still don't think RPMH can more than refcounting and all I am saying
is for CPU's EL3 can manage that refcount on behalf of all ELx

> Now, since we are considering linux and secure (infact linux,hyp,secure)
> as separate voters they have to each request their votes and release
> their votes separately. PSCI cannot release a request made from Linux.

Why should Linux make that request at the first instance as CPU is
already up and running.

> This is how the SoC is designed. All exception levels will abide by
> that.
>
> > > Yes, we are close to having a platform have both, possibly.
> > >
> >
> > Comparison numbers please :)
> >
> We are far from it, for that, atleast now. But we will get there.
>

Hopefully one day. We are waiting for that day for few years now :)

> > Having to adapt DT to the firmware though the feature is fully discoverable
> > is not at all good IMO. So the DT in this series *should work* with OSI
> > mode if the firmware has the support for it, it's as simple as that.
> >
> The firmware is ATF and does not support OSI.
>

OK, to keep it simple: If a platform with PC mode only replaces the firmware
with one that has OSI mode, we *shouldn't need* to change DT to suite it.
I think I asked Ulf to add something similar in DT bindings.

--
Regards,
Sudeep
