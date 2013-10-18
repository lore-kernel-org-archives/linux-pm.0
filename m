From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH V2 Resend 31/34] cpufreq: sparc: Convert to light
 weight ->target_index() routine
Date: Fri, 18 Oct 2013 13:30:22 -0400 (EDT)
Message-ID: <20131018.133022.2019297928668290643.davem@davemloft.net>
References: <cover.1382104514.git.viresh.kumar@linaro.org>
	<cover.1382104514.git.viresh.kumar@linaro.org>
	<f138f2a9b7adeefe0dad222ceda1bea8914a3e6e.1382104515.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f138f2a9b7adeefe0dad222ceda1bea8914a3e6e.1382104515.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 18 Oct 2013 19:29:54 +0530

> This patch converts existing .target() to newly defined light weight
> .target_index() routine for this driver.
> 
> CPUFreq core will call cpufreq_frequency_table_target() before calling this
> routine and will pass index to it.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: David S. Miller <davem@davemloft.net>
