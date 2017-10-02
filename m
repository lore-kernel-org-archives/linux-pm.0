From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2 5/6] arm64: Fixup users of topology_physical_package_id
Date: Mon, 2 Oct 2017 14:56:21 -0700
Message-ID: <20171002215621.GS457@codeaurora.org>
References: <20170919184751.25110-1-jeremy.linton@arm.com>
 <20170919184751.25110-6-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170919184751.25110-6-jeremy.linton@arm.com>
Sender: linux-clk-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, mturquette@baylibre.com, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com
List-Id: linux-pm@vger.kernel.org

On 09/19, Jeremy Linton wrote:
> There are a few arm64 specific users (cpufreq, psci, etc) which really
> want the cluster rather than the topology_physical_package_id(). Lets
> convert those users to topology_cod_id(). That way when we start
> differentiating the socket/cluster they will continue to behave correctly.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---

For:

>  drivers/clk/clk-mb86s7x.c        | 2 +-

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
