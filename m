From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 6/9] ACPI/PPTT: Add topology parsing code
Date: Tue, 12 Dec 2017 02:12:11 +0100
Message-ID: <9009154.M66RGdQJXA@aspire.rjw.lan>
References: <20171201222330.18863-1-jeremy.linton@arm.com> <20171201222330.18863-7-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171201222330.18863-7-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, December 1, 2017 11:23:27 PM CET Jeremy Linton wrote:
> The PPTT can be used to determine the groupings of CPU's at
> given levels in the system. Lets add a few routines to the PPTT
> parsing code to return a unique id for each unique level in the
> processor hierarchy. This can then be matched to build
> thread/core/cluster/die/package/etc mappings for each processing
> element in the system.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Why can't this be folded into patch [2/9]?

Thanks,
Rafael

