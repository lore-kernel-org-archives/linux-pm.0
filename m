Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D0523ABBF;
	Mon, 27 Apr 2026 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319513; cv=none; b=f8GOL4cb+P4pvxuFSzBwD7xDv9nKqVQpAIZBoHHHg4GZyE9Tf/ygVSeAIE4HH9MbR1FNEA8mFKn6zN79Vi4CQd9Ve2lE60P5DdG9iOCc2MUsu520iXHRzeZ1V1U1vyi4YtmGzJ/6jXAxRJLUzTW4wIKgVkNZAKdo1tpyTlks4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319513; c=relaxed/simple;
	bh=LLLageJggb6XA0jICN5xnAQ9JLLp5NgyA2iF7MJNzlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISgBid1Gn7ZLOqq9GrbRN89vIkza6qqT14f3E7QPpmBaMpUv79mu91mDgqY4urKLIYm/YhVeMBFC7J3XyS2pn9Yb9KpWQRC1FiNdBS9jqXB1NOw8d7EAg7tuYlzbIFALrKjprPL7b4bKD0M9DfaCBxtpvwOgPv+YxJbthIDY1Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZMvp0si; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZMvp0si"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1006C19425;
	Mon, 27 Apr 2026 19:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777319513;
	bh=LLLageJggb6XA0jICN5xnAQ9JLLp5NgyA2iF7MJNzlk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UZMvp0sipsZwP/FpeUWCnCXnWaCKVMvM8X5bU0Q6FlekDyP+GOldrSJhEmEHZygmo
	 rMbL0Ufka90gjet2jE+Wgp6VzNv0upjaykL3odiKTXlHVMqdhbul1i0VQmtd/Fr8pa
	 +/s7lW+yWcRhwXZRWGvBJnn20ePNH5OgSvxRkKUgnCUWJ7gbpEikxlHora2sBeuPSJ
	 mqxXs8xWXj3cLEx40l8TltCCcZcrKinlrxFdSzLTsCd3tiuPEAmovGoeZBN3kcZbVb
	 jg1ESd2/dbWzHGqB2WoChADmjZrUudgpPFams2pkWXwIVF297gVNWSDuBB9AjoXAPa
	 PesacK42/kWNw==
Message-ID: <976a0bbb-1323-433b-aff5-02611526b1b6@kernel.org>
Date: Mon, 27 Apr 2026 14:51:51 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] ACPI: Add CPPC v4 definitions
Content-Language: en-US
To: =?UTF-8?Q?Rafael_J_=2E_Wysocki_=E2=8F=8E?= <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, K Prateek Nayak <kprateek.nayak@amd.com>,
 x86@kernel.org
References: <20260427035520.1427080-1-superm1@kernel.org>
 <20260427035520.1427080-3-superm1@kernel.org>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260427035520.1427080-3-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/26 22:55, Mario Limonciello (AMD) wrote:
> ACPI 6.6 introduced new optional package values for
> `OSPMNominalPerformanceRegister` and
> `ResourcePriorityRegisters`.
> 
> Add these into the defines.  As they're not used right now they are not
> wired up to anything at this time.
> 
> Link: https://uefi.org/specs/ACPI/6.6/08_Processor_Configuration_and_Control.html#cpc-continuous-performance-control
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

This patch will be dropped in favor of Sumit's patches on the same subject.

https://lore.kernel.org/linux-acpi/20260427051823.280419-1-sumitg@nvidia.com/

I will rebase the next version of the series on this instead.

> ---
>   drivers/acpi/cppc_acpi.c | 16 ++++++++++++----
>   include/acpi/cppc_acpi.h | 13 +++++++++----
>   2 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 2e91c5a977611..cbfebc50b6eab 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -755,14 +755,15 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   	 */
>   	if ((cpc_rev == CPPC_V2_REV && num_ent != CPPC_V2_NUM_ENT) ||
>   	    (cpc_rev == CPPC_V3_REV && num_ent != CPPC_V3_NUM_ENT) ||
> -	    (cpc_rev > CPPC_V3_REV && num_ent <= CPPC_V3_NUM_ENT)) {
> +	    (cpc_rev == CPPC_V4_REV && num_ent != CPPC_V4_NUM_ENT) ||
> +	    (cpc_rev > CPPC_V4_REV && num_ent <= CPPC_V4_NUM_ENT)) {
>   		pr_debug("Unexpected number of _CPC return package entries (%d) for CPU:%d\n",
>   			 num_ent, pr->id);
>   		goto out_free;
>   	}
> -	if (cpc_rev > CPPC_V3_REV) {
> -		num_ent = CPPC_V3_NUM_ENT;
> -		cpc_rev = CPPC_V3_REV;
> +	if (cpc_rev > CPPC_V4_REV) {
> +		num_ent = CPPC_V4_NUM_ENT;
> +		cpc_rev = CPPC_V4_REV;
>   	}
>   
>   	cpc_ptr->num_entries = num_ent;
> @@ -845,6 +846,13 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
>   
>   			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_BUFFER;
>   			memcpy(&cpc_ptr->cpc_regs[i-2].cpc_entry.reg, gas_t, sizeof(*gas_t));
> +		} else if (cpc_obj->type == ACPI_TYPE_PACKAGE) {
> +			/*
> +			 * CPPC v4 ResourcePriorityRegisters is a Package.
> +			 * Store NULL for now as it's not wired up to anything.
> +			 */
> +			cpc_ptr->cpc_regs[i-2].type = ACPI_TYPE_PACKAGE;
> +			cpc_ptr->cpc_regs[i-2].cpc_entry.pkg_data = NULL;
>   		} else {
>   			pr_debug("Invalid entry type (%d) in _CPC for CPU:%d\n",
>   				 i, pr->id);
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index d1f02ceec4f98..38bf9013c6e2e 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -17,16 +17,18 @@
>   #include <acpi/pcc.h>
>   #include <acpi/processor.h>
>   
> -/* CPPCv2 and CPPCv3 support */
> +/* CPPC support */
>   #define CPPC_V2_REV	2
>   #define CPPC_V3_REV	3
> +#define CPPC_V4_REV	4
>   #define CPPC_V2_NUM_ENT	21
>   #define CPPC_V3_NUM_ENT	23
> +#define CPPC_V4_NUM_ENT	25
>   
>   #define PCC_CMD_COMPLETE_MASK	(1 << 0)
>   #define PCC_ERROR_MASK		(1 << 2)
>   
> -#define MAX_CPC_REG_ENT 21
> +#define MAX_CPC_REG_ENT 23
>   
>   /* CPPC specific PCC commands. */
>   #define	CMD_READ 0
> @@ -60,8 +62,8 @@ struct cpc_reg {
>   
>   /*
>    * Each entry in the CPC table is either
> - * of type ACPI_TYPE_BUFFER or
> - * ACPI_TYPE_INTEGER.
> + * of type ACPI_TYPE_BUFFER, ACPI_TYPE_INTEGER,
> + * or ACPI_TYPE_PACKAGE (for CPPC v4 ResourcePriorityRegisters).
>    */
>   struct cpc_register_resource {
>   	acpi_object_type type;
> @@ -69,6 +71,7 @@ struct cpc_register_resource {
>   	union {
>   		struct cpc_reg reg;
>   		u64 int_value;
> +		void *pkg_data;
>   	} cpc_entry;
>   };
>   
> @@ -109,6 +112,8 @@ enum cppc_regs {
>   	REFERENCE_PERF,
>   	LOWEST_FREQ,
>   	NOMINAL_FREQ,
> +	OSPM_NOMINAL_PERF,
> +	RESOURCE_PRIO,
>   };
>   
>   /*

