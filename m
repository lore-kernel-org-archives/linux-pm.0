Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54040DFD1
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817123; cv=none; b=asa6iaDtTgcmE7QKWTdwli/eGHsJ4/Rwnyqw5hnzWty1WutgoiDyjsa63njJNU83svuUjB0IM+FU7mQCuWGTeSnU6fxzUBBzxVcYUnEs6xjHRjz4RQK1Z9dOtOyKsJymET/000Tv9Fkl+9ZF1RW1gfWCxDx3uPjKxK4cRTLnQMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817123; c=relaxed/simple;
	bh=YIiBEy+JoI0n0KVenwBm6+hhuAWcM9sJCjRrhCGarjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpBhNFFtDwkUzB9iLZxTaEZC1uJMYnc2ObeOJm0BaWmE7VIaUUPp4KLjKlfE4nHPPm1XltmnIqBnux9YZJFv/Rsms0ET3h981fktJaQxsH5FU3D4npZ4nGYCIFGU8kK5/kPIsCeNQF0784Ny/QoZztouR/V64F4CKkWqz8cBHQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MK1qtNcH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MK1qtNcH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27CD81F00A3C
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 17:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779817122;
	bh=muX4PNSfjrVF3DnK03YI3T0ZlUY6aIICW/mdHaodh9k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MK1qtNcHvTrf0USYrYTsqspRcH5g61CrUOeKJlqEA+okijsPDDoowVcX+ZAsyKzn6
	 ZJnolxOdie1lb1uWmZ+2hkX8HZ2WbXQ5HueWrViksfgcKryOxzC9yzT7hyav4Tio9f
	 Of19HAPNwzN4yg7jEuFgsHayGFkzV6AF96dVz1tZlde0X4rakCLE2NKcHkK0JvD5SQ
	 C+ayOe2a9Boae7enbvCTOlZttovA/HIwpgfmhje4CIdmE3EjLNpyHZeTANvB35vDzO
	 CVdLVHCEU88UlsiiKJLuiJCJD+n6gITlU8/dWTkydPrrMjMAWsy8dezeWawhwbcGwK
	 cCr48HXJAl9ZA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa0cf8bca3so9909634e87.0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 10:38:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/QCRi93bn6nwSU6KO5ihFeo1PfTlPTtIUluKn2EsWw33/sWKiHYGcMvaDGCdk/qUq32jit+5HlzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmitAWxd+Ew+FbOFE8bnRglvFS6dm/8QfzeI4QbkUQY7M/C2ig
	q25Ai9n7FF+zl2jrkiTRsP/3QuL2o0fq2wjocDQ1LY+O87CC5VpqnVRmqeYVagJU0kSzy6jAfzA
	bPlR2gFkeADArBQqPP84Syitr7DTZjBs=
X-Received: by 2002:a05:6512:3d11:b0:5a8:d1ef:caad with SMTP id
 2adb3069b0e04-5aa3237d6c8mr5182458e87.4.1779817120578; Tue, 26 May 2026
 10:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514194822.1841748-1-sumitg@nvidia.com> <20260514194822.1841748-2-sumitg@nvidia.com>
In-Reply-To: <20260514194822.1841748-2-sumitg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 19:38:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g7u9srS47kcLJJzOh=ZO3toxcbr+OjZB5qVu2zyngn9Q@mail.gmail.com>
X-Gm-Features: AVHnY4I0r6q_8LO8XjW2hP2K0zKWFqUZ5HKIdN4wB8tDRQXvyO_UtkQ_1YHy03E
Message-ID: <CAJZ5v0g7u9srS47kcLJJzOh=ZO3toxcbr+OjZB5qVu2zyngn9Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] ACPI: CPPC: Add support for CPPC v4
To: Sumit Gupta <sumitg@nvidia.com>, mario.limonciello@amd.com
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com, zhenglifeng1@huawei.com, 
	zhanjie9@hisilicon.com, saket.dumbre@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	acpica-devel@lists.linux.dev, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	bbasu@nvidia.com, Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 9:49=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
te:
>
> CPPC v4 (ACPI 6.6, Section 8.4.6) adds two optional entries to the
> _CPC package:
>
> 1. OSPM Nominal Performance (8.4.6.1.2.6): A write-only register that
>    lets OSPM inform the platform what it considers nominal performance.
>    The platform classifies performance above this level as boost and
>    below as throttle for its power/thermal decisions.
>
> 2. Resource Priority (8.4.6.1.2.7): A Package of Resource Priority
>    Register Descriptor sub-packages that allow OSPM to set relative
>    priority among processors for shared resources (boost, throttle,
>    L2/L3 cache, memory bandwidth). Parsing the full structure is not
>    yet supported; such entries are marked as unsupported.
>
> Add v4 _CPC table parsing (25 entries) and update REG_OPTIONAL to
> mark the two new registers as optional.
>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>

I can apply this one if there are no objections.

The other patch in the series seems to require more work though.

Mario, does your follow-up series depend on both patches in this one?

> ---
>  drivers/acpi/cppc_acpi.c | 23 +++++++++++++++++------
>  include/acpi/cppc_acpi.h |  8 ++++++--
>  2 files changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index f370be8715ae..c76cfafa3589 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -134,7 +134,7 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr=
);
>   * cpc_regs[] with the corresponding index. 0 means mandatory and 1
>   * means optional.
>   */
> -#define REG_OPTIONAL (0x1FC7D0)
> +#define REG_OPTIONAL (0x7FC7D0)
>
>  /*
>   * Use the index of the register in per-cpu cpc_regs[] to check if
> @@ -751,18 +751,19 @@ int acpi_cppc_processor_probe(struct acpi_processor=
 *pr)
>         /*
>          * Disregard _CPC if the number of entries in the return package =
is not
>          * as expected, but support future revisions being proper superse=
ts of
> -        * the v3 and only causing more entries to be returned by _CPC.
> +        * the v4 and only causing more entries to be returned by _CPC.
>          */
>         if ((cpc_rev =3D=3D CPPC_V2_REV && num_ent !=3D CPPC_V2_NUM_ENT) =
||
>             (cpc_rev =3D=3D CPPC_V3_REV && num_ent !=3D CPPC_V3_NUM_ENT) =
||
> -           (cpc_rev > CPPC_V3_REV && num_ent <=3D CPPC_V3_NUM_ENT)) {
> +           (cpc_rev =3D=3D CPPC_V4_REV && num_ent !=3D CPPC_V4_NUM_ENT) =
||
> +           (cpc_rev > CPPC_V4_REV && num_ent <=3D CPPC_V4_NUM_ENT)) {
>                 pr_debug("Unexpected number of _CPC return package entrie=
s (%d) for CPU:%d\n",
>                          num_ent, pr->id);
>                 goto out_free;
>         }
> -       if (cpc_rev > CPPC_V3_REV) {
> -               num_ent =3D CPPC_V3_NUM_ENT;
> -               cpc_rev =3D CPPC_V3_REV;
> +       if (cpc_rev > CPPC_V4_REV) {
> +               num_ent =3D CPPC_V4_NUM_ENT;
> +               cpc_rev =3D CPPC_V4_REV;
>         }
>
>         cpc_ptr->num_entries =3D num_ent;
> @@ -845,6 +846,16 @@ int acpi_cppc_processor_probe(struct acpi_processor =
*pr)
>
>                         cpc_ptr->cpc_regs[i-2].type =3D ACPI_TYPE_BUFFER;
>                         memcpy(&cpc_ptr->cpc_regs[i-2].cpc_entry.reg, gas=
_t, sizeof(*gas_t));
> +               } else if (cpc_obj->type =3D=3D ACPI_TYPE_PACKAGE && (i -=
 2) =3D=3D RESOURCE_PRIORITY) {
> +                       /*
> +                        * ACPI 6.6, s8.4.6.1.2.7 defines Resource Priori=
ty as a
> +                        * Package of Resource Priority Register Descript=
or sub-packages.
> +                        * Parsing the full structure is not yet supporte=
d.
> +                        * Mark the register as unsupported for now.
> +                        */
> +                       pr_debug("CPU:%d Resource Priority not supported\=
n", pr->id);
> +                       cpc_ptr->cpc_regs[i-2].type =3D ACPI_TYPE_INTEGER=
;
> +                       cpc_ptr->cpc_regs[i-2].cpc_entry.int_value =3D 0;
>                 } else {
>                         pr_debug("Invalid entry type (%d) in _CPC for CPU=
:%d\n",
>                                  i, pr->id);
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index d1f02ceec4f9..8693890a7275 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -17,16 +17,18 @@
>  #include <acpi/pcc.h>
>  #include <acpi/processor.h>
>
> -/* CPPCv2 and CPPCv3 support */
> +/* CPPCv2, CPPCv3 and CPPCv4 support */
>  #define CPPC_V2_REV    2
>  #define CPPC_V3_REV    3
> +#define CPPC_V4_REV    4
>  #define CPPC_V2_NUM_ENT        21
>  #define CPPC_V3_NUM_ENT        23
> +#define CPPC_V4_NUM_ENT        25
>
>  #define PCC_CMD_COMPLETE_MASK  (1 << 0)
>  #define PCC_ERROR_MASK         (1 << 2)
>
> -#define MAX_CPC_REG_ENT 21
> +#define MAX_CPC_REG_ENT 23
>
>  /* CPPC specific PCC commands. */
>  #define        CMD_READ 0
> @@ -109,6 +111,8 @@ enum cppc_regs {
>         REFERENCE_PERF,
>         LOWEST_FREQ,
>         NOMINAL_FREQ,
> +       OSPM_NOMINAL_PERF,
> +       RESOURCE_PRIORITY,
>  };
>
>  /*
> --
> 2.34.1
>
>
