From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 04/12] arm64/acpi: Create arch specific cpu to acpi id
 helper
Date: Mon, 15 Jan 2018 13:46:18 +0000
Message-ID: <20180115134618.GD5473@e107155-lin>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-5-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180113005920.28658-5-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, morten.rasmussen@arm.com, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 12, 2018 at 06:59:12PM -0600, Jeremy Linton wrote:
> Its helpful to be able to lookup the acpi_processor_id associated
> with a logical cpu. Provide an arm64 helper to do this.
> 

Makes sense to me, but wondering if we need a weak implementation for
CONFIG_ACPI. Anyways, will check when this gets used in the series.

Not sure if this can be squashed into the patch using it, anyways looks
good on its own.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
