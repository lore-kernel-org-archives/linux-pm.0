From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [RFC PATCH v15 02/11] ARM: qcom: Add Subsystem Power Manager
 (SPM) driver
Date: Thu, 12 Mar 2015 16:50:08 -0600
Message-ID: <20150312225008.GH497@linaro.org>
References: <1425914206-22295-1-git-send-email-lina.iyer@linaro.org>
 <1425914206-22295-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425914206-22295-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 09 2015 at 09:17 -0600, Lina Iyer wrote:

[...]

>+static int qcom_pm_collapse(unsigned long int unused)
>+{
>+	qcom_scm_cpu_power_down(QCOM_SCM_L2_ON);

Rebase against latest SCM patches. Change to QCOM_SCM_CPU_PWR_DOWN_L2_ON.
>+
>+	/*
>+	 * Returns here only if there was a pending interrupt and we did not
>+	 * power down as a result.
>+	 */
>+	return -1;
>+}
>+
>+static int qcom_cpu_standby(int cpuarg)
>+{
>+	spm_set_low_power_mode(PM_SLEEP_MODE_STBY);
>+	cpu_do_idle();
>+
>+	return 0;
>+}
>+
>+static int qcom_cpu_spc(int cpu)
>+{
>+	int ret;
>+
>+	spm_set_low_power_mode(PM_SLEEP_MODE_SPC);
>+	cpu_pm_enter();
Remove this. This is now done by cpuidle driver.

>+	ret = cpu_suspend(0, qcom_pm_collapse);
>+	/*
>+	 * ARM common code may execute WFI, and if the SPM mode is not reset,
>+	 * then we may accidently do power down state.
>+	 * SPM is configured to reset to do STBY, but that relies on the
>+	 * SPM state machine to be executed. When an interrupt is pending as we
>+	 * enter idle state, SPM would not execute its state machine, so the
>+	 * SPM may remain configured to do power down state.
>+	 * Reset the state back to standby.
>+	 */
>+	spm_set_low_power_mode(PM_SLEEP_MODE_STBY);
>+	cpu_pm_exit();
And this..
