From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v6 07/12] drivers: base cacheinfo: Add support for ACPI
 based firmware tables
Date: Mon, 15 Jan 2018 15:06:34 +0000
Message-ID: <20180115150634.GB12531@e107155-lin>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-8-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42120 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755806AbeAOPGl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Jan 2018 10:06:41 -0500
Content-Disposition: inline
In-Reply-To: <20180113005920.28658-8-jeremy.linton@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, morten.rasmussen@arm.com, Sudeep Holla <sudeep.holla@arm.com>

On Fri, Jan 12, 2018 at 06:59:15PM -0600, Jeremy Linton wrote:
> Add a entry to to struct cacheinfo to maintain a reference to the PPTT
> node which can be used to match identical caches across cores. Also
> stub out cache_setup_acpi() so that individual architectures can
> enable ACPI topology parsing.
>

You need to reword above message as you no longer add a new entry.
Other than a minor nit below, looks good.

With those changes done,
Acked-by: Sudeep Holla <sudeep.holla@arm.com>

> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/pptt.c       |  1 +
>  drivers/base/cacheinfo.c  | 20 +++++++++++++-------
>  include/linux/cacheinfo.h |  9 +++++++++
>  3 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 2c4b3ed862a8..4f5ab19c3a08 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -329,6 +329,7 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
>  {
>  	int valid_flags = 0;
>  
> +	this_leaf->fw_unique = cpu_node;
>  	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID) {
>  		this_leaf->size = found_cache->size;
>  		valid_flags++;
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 217aa90fb036..ee51e33cc37c 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -208,16 +208,16 @@ static int cache_setup_of_node(unsigned int cpu)
>  
>  	if (index != cache_leaves(cpu)) /* not all OF nodes populated */
>  		return -ENOENT;
> -
>  	return 0;
>  }
> +

[nit] may be it looks better now but still unnecessary, please drop in
the context of $subject patch.

--
Regards,
Sudeep
