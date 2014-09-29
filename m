From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v7 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Mon, 29 Sep 2014 10:16:25 -0600
Message-ID: <20140929161625.GD1170@ilina-mac.local>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
 <1411779495-39724-6-git-send-email-lina.iyer@linaro.org>
 <20140929153154.GF2165@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140929153154.GF2165@e102568-lin.cambridge.arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "khilman@linaro.org" <khilman@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 29 2014 at 09:31 -0600, Lorenzo Pieralisi wrote:
>Hi Lina,
>
>On Sat, Sep 27, 2014 at 01:58:13AM +0100, Lina Iyer wrote:
>> +The idle states supported by the QCOM SoC are defined as -
>> +
>> +    * WFI
>> +    * Retention
>> +    * Standalone Power Collapse (Standalone PC or SPC)
>> +    * Power Collapse (PC)
>> +
>> +WFI: WFI does a little more in addition to architectural clock gating.  ARM
>
>This may be misleading. Call it PlatformWFI or something like that, not WFI if
>that's not what it is.
>
Hmm.. Not elegant. Let me see what I can do.

>> +processors when execute the wfi instruction will gate their internal clocks.
>> +QCOM cpus use this instruction as a trigger for the SPM state machine. Usually
>> +with a cpu entering WFI, the SPM is configured to do clock-gating as well. The
>> +SPM state machine waits for the interrrupt to trigger the core back in to
>
>s/interrrupt/interrupt/
>
>> +active. When all CPUs in the SoC, clock gate using the ARM wfi instruction, the
>> +second level cache usually can also clock gate sensing no cpu activity. When a
>> +cpu is ready to run, it needs the cache to be active before starting execution.
>> +Allowing the SPM to execute the clock gating statemachine and waiting for
>
>s/statemachine/state machine/
>
>You are defining a generic binding for Qualcomm idle states, so it should
>not be tied to a specific cache level (ie L2 gating), otherwise if the
>same state shows up in a future system with L3 you are back to square
>one.
>
>"Platform WFI" or something like that ? You got what I mean.
>
I am not, I am just explaining the difference between Architectural and
Platform WFI and how the WFI on the core, can help L2 enter shallower
idle states, which is true for L3 as well (provided there is enough time
and we are not allowed to do power down states).

>> +interrupt on behalf of the processor has a benefit of guaranteeing that the
>> +system state is conducive for the core to resume execution.
>> +
>> +Retention: Retention is a low power state where the core is clockgated and the
>> +memory and the registers associated with the core are retained.  The voltage
>> +may be reduced to the minimum value needed to keep the processor registers
>> +active. Retention is triggered when the core executes wfi instruction. The SPM
>
>I think that saying "..is triggered when the core executes wfi instruction"
>is not necessary. I am not aware of any other _proper_ way of entering
>an ARM idle state other than executing wfi and I hope I will never have to
>to become aware of one.
>
Hopefully so :)

>> +should be configured to execute the retention sequence and would wait for
>> +interrupt, before restoring the cpu to execution state. Retention may have a
>> +slightly higher latency than WFI.
>> +
>> +Standalone PC: A cpu can power down and warmboot if there is a sufficient time
>> +between now and the next know wake up. SPC mode is used to indicate a core
>
>s/know/known/
>
>> +entering a power down state without consulting any other cpu or the system
>> +resources. This helps save power only on that core. Like WFI and Retention, the
>> +core executes wfi and the SPM programmed to do SPC would use the cpu control
>> +logic to power down the core's supply and restore it back when woken up by an
>> +interrupt.  Applying power and reseting the core causes the core to warmboot
>
>s/reseting/resetting/
>
>> +back into secure mode which trampolines the control back to the kernel. To
>> +enter a power down state the kernel needs to call into the secure layer which
>> +would then execute the ARM wfi instruction. Failing to do so, would result in a
>> +crash enforced by the warm boot code in the secure layer. On a SoC with
>> +write-back L1 cache, the cache would need to be flushed.
>> +Power Collapse: This state is similiar to the SPC mode, but distinguishes
>
>s/similiar/similar/
>
>> +itself in the fact that the cpu acknowledges and permits the SoC to enter
>
>s/in the fact that/in that/
>
>> +deeper sleep modes. In a hierarchical power domain SoC, this means L2 and other
>> +caches can be flushed, system bus, clocks - lowered, and SoC main XO turned off
>> +and voltages reduced, provided all cpus enter this state. In other words, it is
>> +a coupled idle state.  Since the span of low power modes possible at this state
>
>Careful with the wording here. "Coupled" idle states are defined in the
>kernel for systems where the CPUs must enter power down with a specific
>ordering. I do not think "Power Collapse" is a "coupled" state from this
>perspective, it seems to me more like a "cluster" state, a state that is
>entered when all (not necessarily coordinated) CPUs in the cluster enter
>that state. Feel free to call it a hierarchical state, if it makes sense
>to you.
>
Okay. I thought I changed it from coupled to cluster.. I will change it
to cluster.

>> +is vast, the exit latency and the residency of this low power mode would be
>> +considered high even though at a cpu level, this essentially is cpu power down.
>> +The SPM in this state also may handshake with the Resource power manager
>> +processor in the SoC to indicate a complete subsystem shut down.
>> +
>> +The idle-state for QCOM SoCs are distinguished by the compatible property of
>> +the node. They indicate to the cpuidle driver the entry point to use for
>
>What node ? Please be specific. Moreover, the compatible string has a
>standard DT meaning and it does not indicate anything. This is a DT idle states
>binding and that's where it should stop, anything else is a kernel
>implementation detail, or put it differently, it must not define how the
>kernel translates that compatible property into data structures/control
>code.
>
Hmm. I'll take it out.

>> +cpuidle. The devicetree representation of the idle state should be -
>> +
>> +Required properties:
>> +
>> +- compatible: Must be "arm,idle-state"
>> +		and one of -
>> +			"qcom,idle-state-wfi",
>> +			"qcom,idle-state-ret",
>> +			"qcom,idle-state-spc",
>> +			"qcom,idle-state-pc",
>> +
>> +static struct cpuidle_driver qcom_cpuidle_driver = {
>> +	.name	= "qcom_cpuidle",
>> +	.owner	= THIS_MODULE,
>> +};
>> +
>> +static const struct of_device_id qcom_idle_state_match[] __initconst = {
>
>If it can be built as a module, __initconst should be removed (and
>that's true for my Exynos patch too).
>
Yes, fixing it.
>> +	{ .compatible = "qcom,idle-state-wfi", .data = qcom_lpm_enter_wfi },
>> +	{ .compatible = "qcom,idle-state-spc", .data = qcom_lpm_enter_spc },
>> +	{ },
>> +};
>> +
>> +static int qcom_cpuidle_probe(struct platform_device *pdev)
>> +{
>> +	struct cpuidle_driver *drv = &qcom_cpuidle_driver;
>> +	int ret;
>> +
>> +	qcom_idle_enter = (void *)(pdev->dev.platform_data);
>
>Casting a void* to a void* does not seem that useful to me, and that's valid
>for other CPUidle drivers too, the cast can be removed unless you explain
>to me what it is for.
>
Sure, I dont need it. 

Thanks for your time, Lorenzo.

Lina
