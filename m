From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 08/12] arm64: Add support for ACPI based firmware
 tables
Date: Mon, 15 Jan 2018 13:54:42 +0000
Message-ID: <20180115135442.GF5473@e107155-lin>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-9-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180113005920.28658-9-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, morten.rasmussen@arm.com, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 12, 2018 at 06:59:16PM -0600, Jeremy Linton wrote:
> The /sys cache entries should support ACPI/PPTT generated cache
> topology information. Lets detect ACPI systems and call
> an arch specific cache_setup_acpi() routine to update the hardware
> probed cache topology.
> 
> For arm64, if ACPI is enabled, determine the max number of cache
> levels and populate them using the PPTT table if one is available.
> 

Looks good,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
