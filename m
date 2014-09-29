From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: Re: [PATCH v7 1/7] qcom: spm: Add Subsystem Power Manager driver
Date: Mon, 29 Sep 2014 15:59:18 +0530
Message-ID: <5429347E.1000004@smartplayin.com>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org> <1411779495-39724-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1411779495-39724-2-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org
List-Id: linux-pm@vger.kernel.org

Hi Lina,

After enabling CONFIG_DEBUG_SECTION_MISMATCH I see few section mismatch
warnings like:

WARNING: drivers/soc/qcom/built-in.o(.text+0x2f0): Section mismatch in
reference from the function spm_dev_probe() to the (unknown reference)
.init.rodata:(unknown)
The function spm_dev_probe() references
the (unknown reference) __initconst (unknown).
This is often because spm_dev_probe lacks a __initconst
annotation or the annotation of (unknown) is wrong.

On Saturday 27 September 2014 06:28 AM, Lina Iyer wrote:
> Based on work by many authors, available at codeaurora.org
> 
> SPM is a hardware block that controls the peripheral logic surrounding
> the application cores (cpu/l$). When the core executes WFI instruction,
> the SPM takes over the putting the core in low power state as
> configured. The wake up for the SPM is an interrupt at the GIC, which

..

> +
> +static const struct of_device_id spm_match_table[] __initconst = {
Removing __initconst fixes the warning.

> +	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
> +	  .data = &spm_reg_8974_8084_cpu },
> +	{ .compatible = "qcom,apq8084-saw2-v2.1-cpu",
> +	  .data = &spm_reg_8974_8084_cpu },
> +	{ },
> +};
> +
> +static int spm_dev_probe(struct platform_device *pdev)
> +{

Thanks
Pramod
