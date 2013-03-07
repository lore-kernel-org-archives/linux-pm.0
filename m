From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH] cpufreq: ARM big LITTLE: Add generic cpufreq driver and
 its DT glue
Date: Wed, 6 Mar 2013 16:49:46 -0800
Message-ID: <CAHLZz11PR6E7-yhrxwRi=HWo9tWByH5FUArDqfXQh6N0C_x0tQ@mail.gmail.com>
References: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org>
	<20130305105251.GL17833@n2100.arm.linux.org.uk>
	<CAKohpo=cBkHZnSa8ZsM=k7RRN+RZDXFUWDM82EXXBSQcM-8Vhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=cBkHZnSa8ZsM=k7RRN+RZDXFUWDM82EXXBSQcM-8Vhw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, rjw@sisk.pl, Steve.Bannister@arm.com, linux-pm@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, robin.randhawa@arm.com, linux-arm-kernel@lists.infradead.org, mark.hambleton@broadcom.com, linaro-kernel@lists.linaro.org, charles.garcia-tobin@arm.com
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 6, 2013 at 4:32 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

>         clk[cluster] = clk_get_sys(name, NULL);
> -       if (!IS_ERR(clk[cluster])) {
> +       if (!IS_ERR_OR_NULL(clk[cluster])) {
>                 pr_debug("%s: clk: %p & freq table: %p, cluster: %d\n",
>                                 __func__, clk[cluster], freq_table[cluster],
>                                 cluster);


You seem pretty attached to IS_ERR_OR_NULL here.

Harvey
