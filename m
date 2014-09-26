From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v6 1/5] qcom: spm: Add Subsystem Power Manager driver
Date: Fri, 26 Sep 2014 09:59:33 -0700
Message-ID: <7h61ga48sq.fsf@deeprootsystems.com>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
	<1411516281-58328-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1411516281-58328-2-git-send-email-lina.iyer@linaro.org> (Lina
	Iyer's message of "Tue, 23 Sep 2014 17:51:17 -0600")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: galak@codeaurora.org, sboyd@codeaurora.org, daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Based on work by many authors, available at codeaurora.org
>
> SPM is a hardware block that controls the peripheral logic surrounding
> the application cores (cpu/l$). When the core executes WFI instruction,
> the SPM takes over the putting the core in low power state as
> configured. The wake up for the SPM is an interrupt at the GIC, which
> then completes the rest of low power mode sequence and brings the core
> out of low power mode.
>
> The SPM has a set of control registers that configure the SPMs
> individually based on the type of the core and the runtime conditions.
> SPM is a finite state machine block to which a sequence is provided and
> it interprets the bytes  and executes them in sequence. Each low power
> mode that the core can enter into is provided to the SPM as a sequence.
>
> Configure the SPM to set the core (cpu or L2) into its low power mode,
> the index of the first command in the sequence is set in the SPM_CTL
> register. When the core executes ARM wfi instruction, it triggers the
> SPM state machine to start executing from that index. The SPM state
> machine waits until the interrupt occurs and starts executing the rest
> of the sequence until it hits the end of the sequence. The end of the
> sequence jumps the core out of its low power mode.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

[...]

> +enum {
> +	MSM_SPM_REG_SAW2_CFG,
> +	MSM_SPM_REG_SAW2_AVS_CTL,
> +	MSM_SPM_REG_SAW2_AVS_HYSTERESIS,
> +	MSM_SPM_REG_SAW2_SPM_CTL,
> +	MSM_SPM_REG_SAW2_PMIC_DLY,
> +	MSM_SPM_REG_SAW2_AVS_LIMIT,
> +	MSM_SPM_REG_SAW2_AVS_DLY,
> +	MSM_SPM_REG_SAW2_SPM_DLY,
> +	MSM_SPM_REG_SAW2_PMIC_DATA_0,
> +	MSM_SPM_REG_SAW2_PMIC_DATA_1,
> +	MSM_SPM_REG_SAW2_PMIC_DATA_2,
> +	MSM_SPM_REG_SAW2_PMIC_DATA_3,
> +	MSM_SPM_REG_SAW2_PMIC_DATA_4,
> +	MSM_SPM_REG_SAW2_PMIC_DATA_5,
> +	MSM_SPM_REG_SAW2_PMIC_DATA_6,
> +	MSM_SPM_REG_SAW2_PMIC_DATA_7,
> +	MSM_SPM_REG_SAW2_RST,
> +
> +	MSM_SPM_REG_NR_INITIALIZE = MSM_SPM_REG_SAW2_RST,
> +
> +	MSM_SPM_REG_SAW2_ID,
> +	MSM_SPM_REG_SAW2_SECURE,
> +	MSM_SPM_REG_SAW2_STS0,
> +	MSM_SPM_REG_SAW2_STS1,
> +	MSM_SPM_REG_SAW2_STS2,
> +	MSM_SPM_REG_SAW2_VCTL,
> +	MSM_SPM_REG_SAW2_SEQ_ENTRY,
> +	MSM_SPM_REG_SAW2_SPM_STS,
> +	MSM_SPM_REG_SAW2_AVS_STS,
> +	MSM_SPM_REG_SAW2_PMIC_STS,
> +	MSM_SPM_REG_SAW2_VERSION,
> +
> +	MSM_SPM_REG_NR,
> +};

Do you really need the MSM_SPM_REG_ prefix on all of these?  As these
names are all local to the driver, the extra prefix isn't needed IMO.

Also, consdiering that SPM seems to be sub-block of SAW2, the fact that
the SPM shows up twice in some of the names is a bit confusing.

Kevin
