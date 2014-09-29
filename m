From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: Re: [PATCH v7 5/7] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Mon, 29 Sep 2014 16:01:26 +0530
Message-ID: <542934FE.1060506@smartplayin.com>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org> <1411779495-39724-6-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp69.ord1c.emailsrvr.com ([108.166.43.69]:51290 "EHLO
	smtp69.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751429AbaI2K1x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Sep 2014 06:27:53 -0400
In-Reply-To: <1411779495-39724-6-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org

Hi Lina

One sections mismatch warning here as well:

WARNING: drivers/cpuidle/built-in.o(.text+0x2740): Section mismatch in
reference from the function qcom_cpuidle_probe() to the (unknown
reference) .init.rodata:(unknown)
The function qcom_cpuidle_probe() references
the (unknown reference) __initconst (unknown).
This is often because qcom_cpuidle_probe lacks a __initconst
annotation or the annotation of (unknown) is wrong.

On Saturday 27 September 2014 06:28 AM, Lina Iyer wrote:
> Add cpuidle driver interface to allow cpus to go into C-States. Use the
> cpuidle DT interface common across ARM architectures to provide the
> C-State information to the cpuidle framework.
> 
>

..

> +};
> +
> +static const struct of_device_id qcom_idle_state_match[] __initconst = {
This is causing it.

> +	{ .compatible = "qcom,idle-state-wfi", .data = qcom_lpm_enter_wfi },
> +	{ .compatible = "qcom,idle-state-spc", .data = qcom_lpm_enter_spc },
> +	{ },
> +};
> +
Thanks
Pramod

