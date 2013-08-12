From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 08/35] cpufreq: cpufreq-cpu0: use
 cpufreq_table_validate_and_show()
Date: Mon, 12 Aug 2013 15:35:24 +0800
Message-ID: <20130812073522.GC25061@S2101-09.ap.freescale.net>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
 <59d56d7aea5dfb69bc7bda0c40529d3ef15efcab.1375964117.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <59d56d7aea5dfb69bc7bda0c40529d3ef15efcab.1375964117.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 08, 2013 at 07:18:10PM +0530, Viresh Kumar wrote:
> Lets use cpufreq_table_validate_and_show() instead of calling
> cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I'm not copied on the patch that introduces function
cpufreq_table_validate_and_show().  So if it does the right/equivalent
thing, for cpufreq-cpu0 and imx6q-cpufreq:

Acked-by: Shawn Guo <shawn.guo@linaro.org>

