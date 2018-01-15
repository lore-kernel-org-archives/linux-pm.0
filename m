From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 02/12] drivers: base: cacheinfo: setup DT cache
 properties early
Date: Mon, 15 Jan 2018 12:33:38 +0000
Message-ID: <20180115123338.GB5473@e107155-lin>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-3-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180113005920.28658-3-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, morten.rasmussen@arm.com, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 12, 2018 at 06:59:10PM -0600, Jeremy Linton wrote:
> The original intent in cacheinfo was that an architecture
> specific populate_cache_leaves() would probe the hardware
> and then cache_shared_cpu_map_setup() and
> cache_override_properties() would provide firmware help to
> extend/expand upon what was probed. Arm64 was really
> the only architecture that was working this way, and
> with the removal of most of the hardware probing logic it
> became clear that it was possible to simplify the logic a bit.
> 
> This patch combines the walk of the DT nodes with the
> code updating the cache size/line_size and nr_sets.
> cache_override_properties() (which was DT specific) is
> then removed. The result is that cacheinfo.of_node is
> no longer used as a temporary place to hold DT references
> for future calls that update cache properties. That change
> helps to clarify its one remaining use (matching
> cacheinfo nodes that represent shared caches) which
> will be used by the ACPI/PPTT code in the following patches.
> 
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <albert@sifive.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/riscv/kernel/cacheinfo.c |  1 +
>  drivers/base/cacheinfo.c      | 65 +++++++++++++++++++------------------------
>  include/linux/cacheinfo.h     |  1 +
>  3 files changed, 31 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 10ed2749e246..6f4500233cf8 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -30,6 +30,7 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
>  		CACHE_WRITE_BACK
>  		| CACHE_READ_ALLOCATE
>  		| CACHE_WRITE_ALLOCATE;
> +	cache_of_set_props(this_leaf, node);

This may be necessary but can it be done as later patch ? So far nothing
is added that may break riscv IIUC.

Palmer, Albert,

Can you confirm ? Also, as I see we can thin down arch specific
implementation on riscv if it's just using DT like ARM64. Sorry if
I am missing to see something, so thought of checking.

[...]

> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 3d9805297cda..d35299a590a4 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -99,6 +99,7 @@ int func(unsigned int cpu)					\
>  struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
>  int init_cache_level(unsigned int cpu);
>  int populate_cache_leaves(unsigned int cpu);
> +void cache_of_set_props(struct cacheinfo *this_leaf, struct device_node *np);
>

IIUC riscv is the only user for this outside of cacheinfo.c, right ?
Hopefully we can get rid of it.

Other than that, it looks OK. I will wait for response from riscv team
do that these riscv related changes can be dropped or move to later
patch if really needed.

--
Regards,
Sudeep
