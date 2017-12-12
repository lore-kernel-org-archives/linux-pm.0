From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 2/9] ACPI/PPTT: Add Processor Properties Topology Table parsing
Date: Tue, 12 Dec 2017 02:10:15 +0100
Message-ID: <5013026.iDfypElIay@aspire.rjw.lan>
References: <20171201222330.18863-1-jeremy.linton@arm.com> <20171201222330.18863-3-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171201222330.18863-3-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, December 1, 2017 11:23:23 PM CET Jeremy Linton wrote:
> ACPI 6.2 adds a new table, which describes how processing units
> are related to each other in tree like fashion. Caches are
> also sprinkled throughout the tree and describe the properties
> of the caches in relation to other caches and processing units.
> 
> Add the code to parse the cache hierarchy and report the total
> number of levels of cache for a given core using
> acpi_find_last_cache_level() as well as fill out the individual
> cores cache information with cache_setup_acpi() once the
> cpu_cacheinfo structure has been populated by the arch specific
> code.
> 
> An additional patch later in the set adds the ability to report
> peers in the topology using find_acpi_cpu_topology()
> to report a unique ID for each processing unit at a given level
> in the tree. These unique id's can then be used to match related
> processing units which exist as threads, COD (clusters
> on die), within a given package, etc.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

This is only going to be used by ARM64 for the time being, so I need
someone from that camp to review this.

Sudeep, Hanjun, Lorenzo?

Thanks,
Rafael

