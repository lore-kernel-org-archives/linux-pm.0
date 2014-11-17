From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v9 2/9] qcom: spm: Add Subsystem Power Manager driver
Date: Mon, 17 Nov 2014 22:32:18 +0100
Message-ID: <546A6962.9090801@linaro.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org> <1414194024-55547-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1414194024-55547-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/25/2014 01:40 AM, Lina Iyer wrote:

Hi Lina,

[ ... ]

> +static inline void spm_register_write(struct spm_driver_data *drv,
> +					enum spm_reg reg, u32 val)
> +{
> +	if (drv->reg_data->reg_offset[reg])
> +		writel_relaxed(val, drv->reg_base +
> +				drv->reg_data->reg_offset[reg]);

Why not use writel and don't use 'wmb' below ?

> +}
> +

[ ... ]

> +	spm_register_write(drv, SPM_REG_SPM_CTL, ctl_val);
> +
> +	/* Ensure we have written the start address */
> +	wmb();



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
