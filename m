From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
Date: Fri, 12 Oct 2018 17:46:13 +0200
Message-ID: <CAPDyKFpNuTMav__wTvuMbxU65QpiQPftH_OXkEwztcPAG9FbTw@mail.gmail.com>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181011112013.GC32752@e107155-lin> <20181011160053.GA2371@codeaurora.org>
 <20181011161927.GC28583@e107155-lin> <20181011165822.GB2371@codeaurora.org>
 <20181011173733.GA26447@e107155-lin> <20181011210609.GD2371@codeaurora.org> <20181012150429.GH3401@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012150429.GH3401@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <ilina@codeaurora.org>
Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On 12 October 2018 at 17:04, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Thu, Oct 11, 2018 at 03:06:09PM -0600, Lina Iyer wrote:
>> On Thu, Oct 11 2018 at 11:37 -0600, Sudeep Holla wrote:
> [...]
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
> Why does CPU going down says that another (screen - supposedly shared)
> resource needs to be relinquished ? Shouldn't display decide that on it's
> own ? I have no idea why screen/display is brought into this discussion.
> CPU can just say: hey I am going down and I don't need my resource.
> How can it say: hey I am going down and display or screen also doesn't
> need the resource. On a multi-cluster, how will the last CPU on one know
> that it needs to act on behalf of the shared resource instead of another
> cluster.

Apologize for sidetracking the discussion, just want to fold in a few comments.

This is becoming a complicated story. May I suggest we pick the GIC as
an example instead?

Let's assume the simple case, we have one cluster and when the cluster
becomes powered off, the GIC needs to be re-configured and wakeups
must be routed through some "always on" external logic.

The PSCI spec mentions nothing about how to manage this and not the
rest of the SoC topology for that matter. Hence if the GIC is managed
by Linux - then Linux also needs to take actions before cluster power
down and after cluster power up. So, if PSCI FW can't deal with GIC,
how would manage it?

>
> I think we are mixing the system sleep states with CPU idle here.
> If it's system sleeps states, the we need to deal it in some system ops
> when it's the last CPU in the system and not the cluster/power domain.

What is really a system sleep state? One could consider it just being
another idles state, having heaver residency targets and greater
enter/exit latency values, couldn't you?

In the end, there is no reason to keep things powered on, unless they
are being in used (or soon to be used), that is main point.

We are also working on S2I at Linaro. We strive towards being able to
show the same power numbers as for S2R, but then we need to get these
cluster-idle things right.

[...]

Have a nice weekend!

Kind regards
Uffe
