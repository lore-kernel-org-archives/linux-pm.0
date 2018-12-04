From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Date: Tue, 4 Dec 2018 10:42:31 +0530
Message-ID: <20181204051231.mm5ixli7ckpfzvd4@vireshk-i7>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Stephen Boyd <swboyd@chromium.org>
List-Id: linux-pm@vger.kernel.org

Hi Taniya,

Sorry that I haven't been reviewing it much from last few iterations as I was
letting others get this into a better shape. Thanks for your efforts..

On 02-12-18, 09:25, Taniya Das wrote:
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c

> +struct cpufreq_qcom {
> +	struct cpufreq_frequency_table *table;
> +	void __iomem *perf_state_reg;
> +	cpumask_t related_cpus;
> +};
> +
> +static struct cpufreq_qcom *qcom_freq_domain_map[NR_CPUS];

Now that the code is much more simplified, I am not sure if you need this
per-cpu structure at all. The only place where you are using it is in
qcom_cpufreq_hw_cpu_init() and probe(). Why not merge qcom_cpu_resources_init()
completely into qcom_cpufreq_hw_cpu_init() and get rid of this structure
entirely ?

-- 
viresh
