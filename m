From: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Subject: Re: [PATCH v5] cpufreq: Add SFI based cpufreq driver support
Date: Tue, 18 Nov 2014 11:40:31 +0530
Message-ID: <20141118061031.GA28886@intel-desktop>
References: <20141118054537.GA28516@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40187 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbaKRGJg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 18 Nov 2014 01:09:36 -0500
Content-Disposition: inline
In-Reply-To: <20141118054537.GA28516@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, vishwesh.m.rudramuni@intel.com, lenb@kernel.org, srinidhi.kasagar@intel.com

On Tue, Nov 18, 2014 at 11:15:45AM +0530, Srinidhi Kasagar wrote:
> This adds the SFI based cpu freq driver for some of the Intel's
> Silvermont based Atom architectures like Z34xx and Z35xx.
> 
> Signed-off-by: Rudramuni, Vishwesh M <vishwesh.m.rudramuni@intel.com>
> Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar@intel.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

[..]

> +static int sfi_cpufreq_register_performance(struct sfi_cpufreq_performance *pr)
> +{
> +	mutex_lock(&performance_mutex);
> +
> +	/* parse the freq table from SFI */
> +	sfi_table_parse(SFI_SIG_FREQ, NULL, NULL, parse_freq);
> +
> +	pr->state_count = sfi_cpufreq_num;
> +	if (pr->state_count <= 1) {
> +		pr_err("No p-states discovered\n");
> +		return -ENODEV;
Was in a hurry, will release the mutex in the next version. Let me
knmow if you have further comments.

Srinidhi
