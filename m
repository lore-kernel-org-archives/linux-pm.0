From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC v1 7/8] drivers: qcom: cpu_pd: Handle cpu hotplug in
 the domain
Date: Fri, 12 Oct 2018 17:33:09 +0100
Message-ID: <20181012163309.GA14841@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-8-git-send-email-rplsssn@codeaurora.org>
 <20181011112013.GC32752@e107155-lin>
 <20181011160053.GA2371@codeaurora.org>
 <20181011161927.GC28583@e107155-lin>
 <20181011165822.GB2371@codeaurora.org>
 <20181011173733.GA26447@e107155-lin>
 <20181011210609.GD2371@codeaurora.org>
 <20181012150429.GH3401@e107155-lin>
 <CAPDyKFpNuTMav__wTvuMbxU65QpiQPftH_OXkEwztcPAG9FbTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpNuTMav__wTvuMbxU65QpiQPftH_OXkEwztcPAG9FbTw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 12, 2018 at 05:46:13PM +0200, Ulf Hansson wrote:
[...]

>
> Apologize for sidetracking the discussion, just want to fold in a few comments.
>
No need to apologize, you are just contributing to get better
understanding of the system.

> This is becoming a complicated story. May I suggest we pick the GIC as
> an example instead?
>

Sure.

> Let's assume the simple case, we have one cluster and when the cluster
> becomes powered off, the GIC needs to be re-configured and wakeups
> must be routed through some "always on" external logic.
>

OK, but is the cluster powered off with any wakeup configured(idling)
or with selected wakeups(system suspend/idle)

> The PSCI spec mentions nothing about how to manage this and not the
> rest of the SoC topology for that matter. Hence if the GIC is managed
> by Linux - then Linux also needs to take actions before cluster power
> down and after cluster power up. So, if PSCI FW can't deal with GIC,
> how would manage it?
>

To add to the complications, some of the configurations in GIC can be
done only in higher exception level. So we expect PSCI to power down
the GIC if possible and move the wakeup source accordingly based on the
platform. So PSCI F/W unable to deal with GIC is simply impossible.
It configures Group0/1 interrupts and generally Linux deals with Group 1.
E.g. First 8 SGI are put in Group 0 which is secure interrupts.

So by default, GIC driver in Linux sets MASK_ON_SUSPEND which ensures
only wake-up sources are kept enabled before entering suspend. If the
GIC is being powered down, secure side has to do it's book-keeping if
any and transfer the wakeups to any external always on wakeup controller.

> >
> > I think we are mixing the system sleep states with CPU idle here.
> > If it's system sleeps states, the we need to deal it in some system ops
> > when it's the last CPU in the system and not the cluster/power domain.
>
> What is really a system sleep state? One could consider it just being
> another idles state, having heaver residency targets and greater
> enter/exit latency values, couldn't you?
>

Yes, but theses are user triggered states where the system resources are
informed before entering it. By that I am referring system_suspend_ops.

> In the end, there is no reason to keep things powered on, unless they
> are being in used (or soon to be used), that is main point.
>

I assume by "they", you refer the GIC for example.

> We are also working on S2I at Linaro. We strive towards being able to
> show the same power numbers as for S2R, but then we need to get these
> cluster-idle things right.
>

I don't think anything prevents it. You may need to check how to execute
cpu_pm_suspend which in case S2R gets executed as syscore_suspend_ops.

We can't assume any idle states will take the GIC down and do that
always. At the same, representing this is DT is equal challenging as we
can't assume single idle state power domains. So the platform specific
firmware need to handle this transparently for OSPM.

> [...]
>
> Have a nice weekend!
>

You too have a nice one.

--
Regards,
Sudeep
