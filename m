Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB7346EC8D
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660676; cv=none; b=Yo5yYT2gTybX5U8WIS0PPYQkcY++CmzSh614WstaEzhla++y+eBPt9C2iefgv7Ygg4D8L8mhBiMs7hHnXyi6fsg0/u4KghoPOSh1d3n7Fy3/QWSFTnQxoHiFbDPSLcu0BK9A6p1rFl35R6imAp2Oln09iA+U7nkuBlW4mQ2+4pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660676; c=relaxed/simple;
	bh=XmrxWTkcjVspufkodyx+ge4eYe4VLMyPyPEm+0gNY1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhIlfmqcL3TCtOYUeGBwLNfPnnykzTHH33hHxPEj5+s+L7DSChMpUb0/KZFprfq2ZL5MJBrQNnLBO6765f9PZzMIDFK41zdP4CaxP45ZK4GfXG7FRZlhCeo+U1J0NyrcNLYFSNyhfazPMga6ZKdFujCAUyR6biYwsx7AZg5Gm20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU2ucBuS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU2ucBuS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4041F00ACA
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 19:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660675;
	bh=3dioA8pf9XHWq9/2SVxSD3KAwITdY7k4nNvRgGtvA/Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kU2ucBuSU1sHkOZMJsE52DPzCkyBf/i1Yy20edMov4yvyzGYP9z96ZE8s4y9yL0vu
	 RzQD3o6SdalgXGK/xXN18Y/Xz8ie3Hn+NalHxdGsdWSX1eRBvu8JRk3prksZbiqfvr
	 Z4FWrkd10jYLSbnYne/wCBnytgiT3UOZmYfsZolahVMhCLXaou4eCHyKd4nU4gCa2D
	 vs9vTeaF4vFutlpWfrjlYQavLycEe2DJ7dCrauzpQhA3JsXMShOGULe/LBxcdQie6W
	 6ZFhkFWk6oyggG/6h2HZlNV+G24PlLz13BWmVX7MBacksnzhdGmZTIHBw1k4ccrFFY
	 uGf0sIcv0Jq6g==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso10782819e87.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 12:04:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RocldYadfne4ulo3WX7EusiTaFixcRinaPVi6KYQ/qoSx3mca4eBwjLfB3fGZGYp1DKVaYeEtVvWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNJY1P7V6huMTpsAqMOQm0V4VleqNLunDzphPH6IK15uIZIb5c
	HRtAKlcFlwTHZg3t4OO5EeYAprgJ+7yjxnl93LhyswoftO7buvUYOmzFlSGKDrvKHH+HpsMwk8e
	Jp3zad+FCnJOVPOubHbb7OlH2N1sjLvs=
X-Received: by 2002:a05:6512:63ce:10b0:5b1:4c6f:92f9 with SMTP id
 2adb3069b0e04-5b28f864239mr2769254e87.20.1784660673659; Tue, 21 Jul 2026
 12:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717024502.3520445-1-zhenglifeng1@huawei.com> <20260717024502.3520445-2-zhenglifeng1@huawei.com>
In-Reply-To: <20260717024502.3520445-2-zhenglifeng1@huawei.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 21:04:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ggjYqUe+J97=iSBQ5UzqLixQaXKXf=tNre2unPZOvUyQ@mail.gmail.com>
X-Gm-Features: AUfX_mxafGdaDCgZYKegX2mf7sM8WihZClUjxldyeNLi8YDSRdv8TxjVkSFhHTs
Message-ID: <CAJZ5v0ggjYqUe+J97=iSBQ5UzqLixQaXKXf=tNre2unPZOvUyQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] ACPI: CPPC: Prepare cpc_register_resource for
 Package-type entries
To: Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, saket.dumbre@intel.com, 
	lenb@kernel.org, zhanjie9@hisilicon.com, pierre.gondois@arm.com, 
	sumitg@nvidia.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev, linuxarm@huawei.com, 
	lihuisong@huawei.com, yubowen8@huawei.com, zhangpengjie2@huawei.com, 
	wangzhi12@huawei.com, linhongye@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 4:46=E2=80=AFAM Lifeng Zheng <zhenglifeng1@huawei.c=
om> wrote:
>
> CPPC v4 (ACPI 6.6, Section 8.4.6.1.2.7) introduces the Resource
> Priority entry, which is a Package of sub-packages rather than a
> plain Integer or Buffer register.  The existing cpc_register_resource
> union only accommodates Integer and Buffer (register descriptor)
> fields.
>
> Add a Package variant to the cpc_entry union so that nested
> structures such as RESOURCE_PRIORITY can store their element count
> and a dynamically allocated array of child cpc_register_resource
> descriptors.
>
> Update the CPC_SUPPORTED() macro to recognise Package-type entries
> with a non-zero element count, and switch the unsupported-Package
> fallback from a zero Integer to an empty Package (count =3D 0,
> elements =3D NULL) so that CPC_SUPPORTED() correctly reports such
> entries as unsupported.
>
> No functional change intended; the new Package fields are not yet
> consumed by any caller.
>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 19 +++++++++++++------
>  include/acpi/cppc_acpi.h |  8 ++++++++
>  2 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 9f572f481241..d7e654f2a66c 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -124,10 +124,16 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_p=
tr);
>                                 (reg)->bit_offset =3D=3D 0 &&            =
   \
>                                 (reg)->access_width =3D=3D 0)
>
> -/* Evaluates to True if an optional cpc field is supported */
> -#define CPC_SUPPORTED(cpc) ((cpc)->type =3D=3D ACPI_TYPE_INTEGER ?      =
   \
> -                               !!(cpc)->cpc_entry.int_value :          \
> -                               !IS_NULL_REG(&(cpc)->cpc_entry.reg))
> +/*
> + * Evaluates to True if an optional cpc field is supported.
> + * Integer: non-zero value; Buffer: non-NULL register; Package: non-empt=
y.
> + */
> +#define CPC_SUPPORTED(cpc) (((cpc)->type =3D=3D ACPI_TYPE_INTEGER &&    =
   \
> +                            !!(cpc)->cpc_entry.int_value) ||           \
> +                           ((cpc)->type =3D=3D ACPI_TYPE_BUFFER &&      =
   \
> +                            !IS_NULL_REG(&(cpc)->cpc_entry.reg)) ||    \
> +                           ((cpc)->type =3D=3D ACPI_TYPE_PACKAGE &&     =
   \
> +                            (cpc)->cpc_entry.package.count !=3D 0))

My immediate concern regarding this change in particular is that it
potentially causes invalid data structures to be used as "supported".

Suppose that some defective platform firmware supplies a package in a
field that by the spec can only be a buffer and the length of that
package is greater than zero.  The macro will produce 'true' then
which is invalid.

It looks like there should be three different macros like the above
for the three different types of _CPC fields: the buffer/integer ones,
the buffer-only ones and the single package field.

And I'm not sure how much of a value there is in complicating the
overall parsing of all fields just in order to be able to handle the
last special one in a "generic" fashion.

As this stands now, it is a "no" from me, sorry.

>
>  /*
>   * Each bit indicates the optionality of the register in per-cpu
> @@ -859,8 +865,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *=
pr)
>                          * Mark the register as unsupported for now.
>                          */
>                         pr_debug("CPU:%d Resource Priority not supported\=
n", pr->id);
> -                       cpc_ptr->cpc_regs[i-2].type =3D ACPI_TYPE_INTEGER=
;
> -                       cpc_ptr->cpc_regs[i-2].cpc_entry.int_value =3D 0;
> +                       cpc_ptr->cpc_regs[i-2].type =3D ACPI_TYPE_PACKAGE=
;
> +                       cpc_ptr->cpc_regs[i-2].cpc_entry.package.count =
=3D 0;
> +                       cpc_ptr->cpc_regs[i-2].cpc_entry.package.elements=
 =3D NULL;
>                 } else {
>                         pr_debug("Invalid entry type (%d) in _CPC for CPU=
:%d\n",
>                                  i, pr->id);
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index 8693890a7275..1839582b80be 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -71,6 +71,14 @@ struct cpc_register_resource {
>         union {
>                 struct cpc_reg reg;
>                 u64 int_value;
> +               /*
> +                * CPPC v4: nested Package (e.g. RESOURCE_PRIORITY),
> +                * elements dynamically allocated
> +                */
> +               struct {
> +                       u32 count;
> +                       struct cpc_register_resource *elements;
> +               } package;
>         } cpc_entry;
>  };
>
> --
> 2.33.0
>
