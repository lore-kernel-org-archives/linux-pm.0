From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
Date: Tue, 22 May 2018 14:07:04 +0100
Message-ID: <20180522130704.GA31065@e107155-lin>
References: <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
 <1526988585-21678-1-git-send-email-ilialin@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1526988585-21678-1-git-send-email-ilialin@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilia Lin <ilialin@codeaurora.org>
Cc: viresh.kumar@linaro.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tue, May 22, 2018 at 02:29:45PM +0300, Ilia Lin wrote:
> In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO processors,
> the CPU frequency subset and voltage value of each OPP varies
> based on the silicon variant in use. Qualcomm Process Voltage Scaling Tables
> defines the voltage and frequency value based on the msm-id in SMEM
> and speedbin blown in the efuse combination.
> The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the SoC
> to provide the OPP framework with required information.
> This is used to determine the voltage and frequency value for each OPP of
> operating-points-v2 table when it is parsed by the OPP framework.
> 
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

[...]

> +
> +	switch (msm8996_version) {
> +	case MSM8996_V3:
> +		versions = 1 << (unsigned int)(*speedbin);
> +		break;
> +	case MSM8996_SG:
> +		versions = 1 << ((unsigned int)(*speedbin) + 4);
> +		break;
> +	default:
> +		BUG();
> +		break;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_dev = get_cpu_device(cpu);
> +		if (NULL == cpu_dev) {
> +			ret = -ENODEV;
> +			goto free_opp;
> +		}
> +
> +		opp_tables[cpu] = dev_pm_opp_set_supported_hw(cpu_dev,
> +							      &versions, 1);

Will be not get NULL for all CPUs except 0 ?
I haven't seen the patches from Viresh yet, if that prevents getting NULL
or not.

--
Regards,
Sudeep
