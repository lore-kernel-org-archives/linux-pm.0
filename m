From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v8 1/7] qcom: spm: Add Subsystem Power Manager driver
Date: Thu, 9 Oct 2014 13:20:00 -0700
Message-ID: <20141009202000.GC5493@codeaurora.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1412718106-17049-2-git-send-email-lina.iyer@linaro.org>
 <5435E0E3.3060906@codeaurora.org>
 <20141009161829.GD1277@ilina-mac.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141009161829.GD1277@ilina-mac.local>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/09, Lina Iyer wrote:
> On Wed, Oct 08 2014 at 19:12 -0600, Stephen Boyd wrote:
> >On 10/07/2014 02:41 PM, Lina Iyer wrote:
> >>+		cpu_node = of_get_cpu_node(cpu, NULL);
> >>+		if (!cpu_node)
> >>+			continue;
> >>+		saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
> >>+		if (saw_node) {
> >>+			if (saw_node == pdev->dev.of_node)
> >>+				drv = &per_cpu(cpu_spm_drv, cpu);
> >
> >How does this work with the logical cpu map? cpu0 in hardware may
> >be cpu1 in software for example.
> >
> As long as the DT link to the right cpu is correct, we should be fine.
> No?

Yes I was worried we wanted to know the physical CPU for some
reason. As long as everything is logical then we're good.

> >>+		writel_relaxed(drv->reg_data->pmic_dly, reg_base +
> >>+				drv->reg_data->reg_offset[SPM_REG_PMIC_DLY]);
> >>+
> >>+	/* Write the PMIC data */
> >>+	if (drv->reg_data->reg_offset[SPM_REG_PMIC_DATA_0])
> >>+		for (i = 0; i < MAX_PMIC_DATA; i++)
> >>+			writel_relaxed(drv->reg_data->pmic_data[i], reg_base +
> >>+				drv->reg_data->reg_offset[SPM_REG_PMIC_DATA_0] +
> >>+				4 * i);
> >
> >This looks unused. I'm not sure we even want to do it though?
> >Would it be better if we wrote these registers in the SMP boot
> >code with whatever value we're using to boot secondary CPUs? That
> >way we don't have a dependency between the SMP code and this code
> >to know to use the same values.
> No, no, these are the registers that we need to bring the core out of
> Standalone PC. When I add voltage control to SPM, this register will be
> modified in this driver too. One of the voltage would be active votlage
> and that would shadow the running voltage for the core.

Right and the SMP boot code sets that initial voltage, hence the
dependency we could try to avoid. If the SMP boot code just wrote
this register as well with whatever it set the voltage to then we
don't need to do it again here.

> 
> >
> >We should also think about moving that SMP boot code into this
> >file so that such dependencies are implicit.
> Not sure, we need this register for SMP boot. But I will be open to
> your ideas in this regard.

Otherwise we move that SMP boot code into this file so that we
can share the initial voltage with this driver via some private
per-cpu variable or something. Or we just ignore this whole thing
and just leave it hardcoded to match the SMP boot code.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
