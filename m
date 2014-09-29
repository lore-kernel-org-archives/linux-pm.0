From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Mon, 29 Sep 2014 18:22:28 +0100
Message-ID: <20140929172228.GA5929@e102568-lin.cambridge.arm.com>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
 <1411779495-39724-6-git-send-email-lina.iyer@linaro.org>
 <20140929153154.GF2165@e102568-lin.cambridge.arm.com>
 <20140929161625.GD1170@ilina-mac.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20140929161625.GD1170@ilina-mac.local>
Content-Disposition: inline
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "khilman@linaro.org" <khilman@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 29, 2014 at 05:16:25PM +0100, Lina Iyer wrote:

[...]

> >> +processors when execute the wfi instruction will gate their internal clocks.
> >> +QCOM cpus use this instruction as a trigger for the SPM state machine. Usually
> >> +with a cpu entering WFI, the SPM is configured to do clock-gating as well. The
> >> +SPM state machine waits for the interrrupt to trigger the core back in to
> >
> >s/interrrupt/interrupt/
> >
> >> +active. When all CPUs in the SoC, clock gate using the ARM wfi instruction, the
> >> +second level cache usually can also clock gate sensing no cpu activity. When a
> >> +cpu is ready to run, it needs the cache to be active before starting execution.
> >> +Allowing the SPM to execute the clock gating statemachine and waiting for
> >
> >s/statemachine/state machine/
> >
> >You are defining a generic binding for Qualcomm idle states, so it should
> >not be tied to a specific cache level (ie L2 gating), otherwise if the
> >same state shows up in a future system with L3 you are back to square
> >one.
> >
> >"Platform WFI" or something like that ? You got what I mean.
> >
> I am not, I am just explaining the difference between Architectural and
> Platform WFI and how the WFI on the core, can help L2 enter shallower
> idle states, which is true for L3 as well (provided there is enough time
> and we are not allowed to do power down states).

I wanted to say that instead of referring to L2 you can refer to the
computing system as a whole, it is a computing subsystem clock gating.

Instead of referring to L2, refer to cache hierarchy, generically.

It is just a nitpick to make your life easier in the future.

[...]

> >> +static int qcom_cpuidle_probe(struct platform_device *pdev)
> >> +{
> >> +	struct cpuidle_driver *drv = &qcom_cpuidle_driver;
> >> +	int ret;
> >> +
> >> +	qcom_idle_enter = (void *)(pdev->dev.platform_data);
> >
> >Casting a void* to a void* does not seem that useful to me, and that's valid
> >for other CPUidle drivers too, the cast can be removed unless you explain
> >to me what it is for.
> >
> Sure, I dont need it. 
> 
> Thanks for your time, Lorenzo.

You are welcome, thanks for you patience in converting the driver to the
new DT API.

Lorenzo
