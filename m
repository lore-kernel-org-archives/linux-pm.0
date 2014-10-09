From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v8 1/7] qcom: spm: Add Subsystem Power Manager driver
Date: Thu, 9 Oct 2014 10:18:29 -0600
Message-ID: <20141009161829.GD1277@ilina-mac.local>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
 <1412718106-17049-2-git-send-email-lina.iyer@linaro.org>
 <5435E0E3.3060906@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36460 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbaJIQSd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Oct 2014 12:18:33 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so50731pab.18
        for <linux-pm@vger.kernel.org>; Thu, 09 Oct 2014 09:18:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5435E0E3.3060906@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On Wed, Oct 08 2014 at 19:12 -0600, Stephen Boyd wrote:
>On 10/07/2014 02:41 PM, Lina Iyer wrote:
>>diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
>>index 1505fb8..a18e8fc 100644
>>--- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
>>+++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
>>@@ -2,11 +2,20 @@ SPM AVS Wrapper 2 (SAW2)
>>  The SAW2 is a wrapper around the Subsystem Power Manager (SPM) and the
>>  Adaptive Voltage Scaling (AVS) hardware. The SPM is a programmable
>>-micro-controller that transitions a piece of hardware (like a processor or
>>+power-controller that transitions a piece of hardware (like a processor or
>>  subsystem) into and out of low power modes via a direct connection to
>>  the PMIC. It can also be wired up to interact with other processors in the
>>  system, notifying them when a low power state is entered or exited.
>>+Multiple revisions of the SAW hardware is supported using these Device Nodes.
>
>s/is/are/
>
>>+SAW2 revisions differ in the register offset and configuration data. Also,
>>+same revision of the SAW in different SoCs may have different configuration
>
>the same
>
Will fix.

>+
>>+struct spm_driver_data {
>>+	void __iomem *reg_base_addr;
>
>It's not really an address, more like a reg_base or just base.
>
Sure.

>+ */
>>+int qcom_spm_set_low_power_mode(enum pm_sleep_mode mode)
>>+{
>>+	struct spm_driver_data *drv = &__get_cpu_var(cpu_spm_drv);
>
>this_cpu_ptr()
>
OK.
>>+	u32 start_index;
>>+	u32 ctl_val;
>>+
>>+	if (!drv->reg_base_addr)
>>+		return -ENXIO;
>>+
>>+	start_index = drv->reg_data->start_index[mode];
>>+
>>+	ctl_val = readl_relaxed(drv->reg_base_addr +
>>+				drv->reg_data->reg_offset[SPM_REG_SPM_CTL]);
>>+	start_index &= 0x7F;
>
>Why are we statically defining numbers larger than 0x7f? Drop this?
>
OK
>>+	start_index <<= 4;
>>+	ctl_val &= 0xFFFFF80F;
>
>Make a #define for this register field (or two)?
>
>#define SPM_CTL_INDEX 0x7f
>#define SPM_CTL_INDEX_SHIFT 4
>#define SPM_CTL_EN BIT(0)
>
>ctl_val &= ~(SPM_CTL_INDEX << SPM_CTL_INDEX_SHIFT);
>ctl_val |= start_index << SPM_CTL_INDEX_SHIFT;
>ctl_val |= SPM_CTL_EN;
>
Not liking all these macros, that would be used one time. But sure.

>>+	ctl_val |= start_index;
>>+	ctl_val |= 0x1; /* Enable the SPM CTL register */
>>+	writel_relaxed(ctl_val, drv->reg_base_addr +
>>+				drv->reg_data->reg_offset[SPM_REG_SPM_CTL]);
>
>Can we please have spm_read/write functions that take the drv, 
>register mapping enum, and optional value?
>
OK.

>>+	/* Ensure we have written the start address */
>>+	wmb();
>>+
>>+	return 0;
>>+}
>>+
>>+static struct spm_driver_data *spm_get_drv(struct platform_device *pdev)
>>+{
>>+	struct spm_driver_data *drv = NULL;
>>+	struct device_node *cpu_node, *saw_node;
>>+	u32 cpu;
>
>int instead of u32
>
>>+
>>+	for_each_possible_cpu(cpu) {
>>+		if (drv)
>>+			break;
>
>This looks weird. Why not put this at the end of the loop?
>
Yeah.. Not sure what I was thinking, seemed like a good idea at that time :(
Will change.

>>+		cpu_node = of_get_cpu_node(cpu, NULL);
>>+		if (!cpu_node)
>>+			continue;
>>+		saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
>>+		if (saw_node) {
>>+			if (saw_node == pdev->dev.of_node)
>>+				drv = &per_cpu(cpu_spm_drv, cpu);
>
>How does this work with the logical cpu map? cpu0 in hardware may be 
>cpu1 in software for example.
>
As long as the DT link to the right cpu is correct, we should be fine.
No?

>+
>>+	/* Get the SPM register data for this instance */
>
>The above three comments seem so obvious. Why do we need them?
>
>>+	drv->reg_data = match_id->data;
>>+	if (!drv->reg_data)
>>+		return -EINVAL;
>>+
>>+	/* Write the SPM sequences */
>>+	addr = reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
>>+	seq_regs = (const u32 *)drv->reg_data->seq;
>>+	for (i = 0; i < ARRAY_SIZE(drv->reg_data->seq)/4; i++)
>>+		writel_relaxed(seq_regs[i], 4 * i + addr);
>
>Just use __iowrite32_copy()? Please run sparse, seq_regs is not an 
>__iomem pointer.
>
OK
>>+
>>+	/**
>>+	 *  Write the SPM registers.
>>+	 *  An offset of 0, indicates that the SPM version does not support
>>+	 *  this register, otherwise it should be supported.
>>+	 */
>>+	writel_relaxed(drv->reg_data->spm_cfg,
>>+			reg_base + drv->reg_data->reg_offset[SPM_REG_CFG]);
>>+
>>+	if (drv->reg_data->reg_offset[SPM_REG_DLY])
>
>Is this ever false? I thought we always had these registers to configure.
>
Probably not, but in the version 1.1 of SAW2 does not configure this
register, so we dont have to and let it be in its default.

>>+		writel_relaxed(drv->reg_data->spm_dly, reg_base +
>>+				drv->reg_data->reg_offset[SPM_REG_DLY]);
>>+
>>+	if (drv->reg_data->reg_offset[SPM_REG_PMIC_DLY])
>
>Same comment.
>
>>+		writel_relaxed(drv->reg_data->pmic_dly, reg_base +
>>+				drv->reg_data->reg_offset[SPM_REG_PMIC_DLY]);
>>+
>>+	/* Write the PMIC data */
>>+	if (drv->reg_data->reg_offset[SPM_REG_PMIC_DATA_0])
>>+		for (i = 0; i < MAX_PMIC_DATA; i++)
>>+			writel_relaxed(drv->reg_data->pmic_data[i], reg_base +
>>+				drv->reg_data->reg_offset[SPM_REG_PMIC_DATA_0] +
>>+				4 * i);
>
>This looks unused. I'm not sure we even want to do it though? Would it 
>be better if we wrote these registers in the SMP boot code with 
>whatever value we're using to boot secondary CPUs? That way we don't 
>have a dependency between the SMP code and this code to know to use 
>the same values. 
No, no, these are the registers that we need to bring the core out of
Standalone PC. When I add voltage control to SPM, this register will be
modified in this driver too. One of the voltage would be active votlage
and that would shadow the running voltage for the core.

>
>We should also think about moving that SMP boot code 
>into this file so that such dependencies are implicit.
Not sure, we need this register for SMP boot. But I will be open to
your ideas in this regard.
