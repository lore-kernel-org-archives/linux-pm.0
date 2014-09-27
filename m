From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: Re: [PATCH v7 1/7] qcom: spm: Add Subsystem Power Manager driver
Date: Sat, 27 Sep 2014 13:37:46 +0530
Message-ID: <54267052.7020907@smartplayin.com>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org> <1411779495-39724-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1411779495-39724-2-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org
List-Id: linux-pm@vger.kernel.org


On 27-09-2014 06:28 AM, Lina Iyer wrote:
> Based on work by many authors, available at codeaurora.org
> 

..

> +int qcom_spm_set_low_power_mode(enum spm_mode mode)
> +{
> +	struct spm_driver_data *drv = &__get_cpu_var(cpu_spm_drv);
> +	u32 start_addr = 0;
initialization not necessary.

> +	u32 ctl_val;
> +
> +	if (!drv || !drv->reg_data)

..

> +#endif  /* __QCOM_SPM_H */
> 
