From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Date: Wed, 10 Apr 2019 11:14:49 +0530
Message-ID: <20190410054449.zwmemg7vza557gue@vireshk-i7>
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-4-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190328101352.25657-4-quentin.perret@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, amit.kachhap@gmail.com, daniel.lezcano@linaro.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, edubezval@gmail.com, catalin.marinas@arm.com, rui.zhang@intel.com, javi.merino@kernel.org, ionela.voinescu@arm.com, dietmar.eggemann@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 28-03-19, 10:13, Quentin Perret wrote:
> +static unsigned int get_state_freq(struct cpufreq_cooling_device *cpufreq_cdev,
> +			      unsigned long state)
> +{
> +	struct cpufreq_policy *policy;
> +	unsigned long idx;
> +
> +	/* Use the Energy Model table if available */
> +	if (cpufreq_cdev->em) {
> +		idx = cpufreq_cdev->max_level - state;
> +		return cpufreq_cdev->em->table[idx].frequency;
> +	}
> +
> +	/* Otherwise, fallback on the CPUFreq table */
> +	policy = cpufreq_cdev->policy;
> +	if (policy->freq_table_sorted == CPUFREQ_TABLE_SORTED_ASCENDING)

It is not guaranteed that the frequency table is sorted in any order, isn't it ?

> +		idx = cpufreq_cdev->max_level - state;
> +	else
> +		idx = state;

-- 
viresh
