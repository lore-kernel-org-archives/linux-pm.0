Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0913A3F7
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335364; cv=none; b=nYkQPxNKlLOlISwN4R7yupOKbsAF88p89lwLfyw+j2keJkCUtnEYEvdyCs28IcTjlD2+d2rREZZaJx/fS3yspC+hlhC1EGFF62XuheUCe8+B/funFN09pZqiHsXaaQwjes1mM5CCxBDNTzqOOWrTA86O8NnvgrxuqE5Ai/INK0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335364; c=relaxed/simple;
	bh=stlQptqo7vJeyulBNyH6DVBNN2wqB5K8cjd6Q8e3yuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f6B/R16GebFLqUnAE7DzS1Feg7VbvpKvoKpFOZ3q+CTz7zabGCnIQ9WUdegcOJ9ET/LzdKZa0yIlvXOjIurIQDsZ2SZo7Tvk0SEOGi+SzzAYOv2s8Ji4o3uck5I2hhjMakAUy19OxMXjat95VvSiW/E8cDkoPIPAPZCH6QPFnJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWsVh7vM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWsVh7vM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA2C1F00A00
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 17:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780335361;
	bh=ERxZSK/r1UKIO3cuxf0a+8Y6osXhOPRuyhU/Ql4S/1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oWsVh7vMxSAN3MKUO6TiyTgLaSWI4rlQRa+Y2s8VllDOKDRCSg85kpR9i0iPlUwDN
	 E6vWJNPON8Hrqe+ZOi0cODkp3L9BdwAAe1+nPWFHNbTL3JBkQ3QAhJFDUEDbwMaytg
	 b4MUgSVa5CSgHEL22awzwq1PKtTB8sv73orMzdVQB8wc7dbZowzCUA+VijZn7wQ2Ub
	 O1ICphFPtcUfoS2m7CaYAgoqMWhG4OJ2dcOQQ7g/NsOW965XhdoAb2KiMUuBWKNcNB
	 xEDL39Q2AoAwVrVjSvUoJ2fcopudNgc9oLyymAEe6O4HFI8INSbAsSyqZDuvxo8upJ
	 Ms43hWqKVqAAA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa68cfc182so1537528e87.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 10:36:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ820KEtmajItZkiTOd37C+RD0+2jivIyBuT21VDkEEAXMcWdcVlyO9ysyduGN/UvuK+THVCXK8aUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjwXoPkD+21gpG4A8x/1iJWpu6dj6megY2FA8COqlxqrgdTQjv
	z85VjVreeIELPEFPD5cdPWCgfCIMekvEtz2VKdbFEZgjAkRiB3Qp/Fc7aSc1cXHyQQAboxWl2WL
	3PMeIiebHpA7zuVZFUYiib3XidVN3kHU=
X-Received: by 2002:a05:6512:2525:b0:5aa:4aa4:29f3 with SMTP id
 2adb3069b0e04-5aa6090c8c8mr3948127e87.28.1780335360125; Mon, 01 Jun 2026
 10:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527194626.185286-1-sumitg@nvidia.com> <20260527194626.185286-2-sumitg@nvidia.com>
In-Reply-To: <20260527194626.185286-2-sumitg@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jun 2026 19:35:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jFpTeX0Vxt+Ut5nkmgueJFxHjoP-mdjdDd6jkCokn-VA@mail.gmail.com>
X-Gm-Features: AVHnY4JOHev4lnx_8QKm8xKTghAWZilDNAWp87KnrhUCwRHD28LsEHnRQM8JeMA
Message-ID: <CAJZ5v0jFpTeX0Vxt+Ut5nkmgueJFxHjoP-mdjdDd6jkCokn-VA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ACPI: CPPC: Add support for CPPC v4
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, pierre.gondois@arm.com, 
	zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, mario.limonciello@amd.com, 
	saket.dumbre@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	acpica-devel@lists.linux.dev, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	mochs@nvidia.com, bbasu@nvidia.com, Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 9:47=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wro=
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

This patch is good to go AFAICS, while there are still comments on the
second one in the series.

Do you want me to apply this one separately?

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
> index ee8352830c32..9b18fb9aab7c 100644
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
> @@ -110,6 +112,8 @@ enum cppc_regs {
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
