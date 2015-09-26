From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 1/5] ACPI: Introduce CPU performance controls using CPPC
Date: Sat, 26 Sep 2015 02:05:07 +0200
Message-ID: <10036388.hkOY1zLhN4@vostro.rjw.lan>
References: <cover.1441830300.git.ashwin.chaugule@linaro.org> <de2aab7944aea82d7f846e96c193bf577507cdcd.1441830300.git.ashwin.chaugule@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <de2aab7944aea82d7f846e96c193bf577507cdcd.1441830300.git.ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, rwells@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 09, 2015 04:27:04 PM Ashwin Chaugule wrote:
> CPPC stands for Collaborative Processor Performance Controls
> and is defined in the ACPI v5.0+ spec. It describes CPU
> performance controls on an abstract and continuous scale
> allowing the platform (e.g. remote power processor) to flexibly
> optimize CPU performance with its knowledge of power budgets
> and other architecture specific knowledge.
> 
> This patch adds a shim which exports commonly used functions
> to get and set CPPC specific controls for each CPU. This enables
> CPUFreq drivers to gather per CPU performance data and use
> with exisiting governors or even allows for customized governors
> which are implemented inside CPUFreq drivers.
> 
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Reviewed-by: Al Stone <al.stone@linaro.org>
> ---

[cut]

> +
> +/**
> + * acpi_get_psd_map - Map the CPUs in a common freq domain as indicated
> + * 	in the respective _PSD entries.

One minor nit: this needs to be one-line in a proper kerneldoc.

> + * @all_cpu_data: This array of pointers contains all the CPU specific
> + *	details to access CPPC registers and freq domain information for each
> + *	CPU.

Ditto.

You can add more description below.

[cut]

> +int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> +	struct cpc_register_resource *delivered_reg, *reference_reg;
> +	u64 delivered, reference;
> +	int ret = 0;
> +
> +	if (!cpc_desc) {
> +		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
> +		return -ENODEV;
> +	}
> +
> +	delivered_reg = &cpc_desc->cpc_regs[DELIVERED_CTR];
> +	reference_reg = &cpc_desc->cpc_regs[REFERENCE_CTR];
> +
> +	spin_lock(&pcc_lock);

I still have the question about this lock.

Why does it have to be a spinlock?

Rafael

