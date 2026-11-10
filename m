Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340494;
	b=euXGYNQqcWZThMN3qqvyoC2Ar4p4BlEF8F2yrOTPYq5QPDPsmhdlwribKJKzc9WlcEBZ
	 uLtoz15NzkE/ejSr0BAYB1ytrrkI3W0NL1nSoZsgExbBOwdN5CyK44YMNAqdNGVWSOZVj
	 Y1RoXZEiosfXUlTk/rpwewY5PcJuTmxsncVxxeM+/WDFAVqE31Rxjvloa/Z3/cMiLPFoq
	 NOFCw9q/Ne1CrGHpPh5lxvWApSSEQ6D/9N/uFHB1RTgytcHq8lnUXQ90WQlKllagHxhrm
	 PN98NeenMkRBFS9v0RvzNsdRZPeZC9p5Gm/f3kARclNeLAclm4kTV2oaUn0VwoTBamg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340494;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SYgaRUuDxnOaDCME46E8/042cKSyi3hzeBixsY9TViU=;
	b=gZB8WwTY0ivPAl3zuYhCW5twdbuXat9mVJ46ktaetT+3CwuFUnWlbJXSdhu9aY8Rm4sV
	 EaAattatXZKcpwZZp/QolSqHNlwTyb6T2ihov5A+GXBoIv/HAbdzEwp7zQCsPRAXCx1oK
	 bwDUbsClPLvqJlsZ2wSygwvn3gF2HthLFOzttadwUu2xVFqqxEIl+Jw4kbOT5E7OQxUVp
	 R6KJkPPXItXuDEr1NGbjdPUy+PYLfo7cdcQRAWuaGDg9N8NPAKxm5MsP0l0eoAAjQIDX+
	 Ca0UbdQ+WFBm8qCtjD2yHVSL0sVyx6Enng3YuAyKE4TgbVVoPVCYm1z+WVehMdiFpTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVlZQqhq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233C2606A320
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BVlZQqhq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AF31F008A5
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 19:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794340493;
	bh=SYgaRUuDxnOaDCME46E8/042cKSyi3hzeBixsY9TViU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BVlZQqhqESwQuWE9uZaJJ10jlSznTu9o73rl35RmmzRH83BQ5yKeX5BJz1w9wgS6Z
	 2tiSm5BbFQUllm1E58aFgd9HbD59a74QHhhebje6RYlijE87U+xB1dJyCp3IJt26H3
	 1zzcgxeb9ePHIaSkVXD0O0MKzFKjEBm7kkqWO49JrqecwcTAiCuBc8Uv6YByV2gDLT
	 ufTR3MaU0/lMLscL4jrEPK+By8T1Azshtg0VMSEe7aIJ/8ya25dS6WVamyr0FJCu0R
	 iu4l/TiPVRgBnQpCWIuPJzunN9uvvULGk+UJCsui1Kz5lWsrtfaZQNU5UwXsO/aZG7
	 IJ4ImE138b61g==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ab30b3212aso18989591fa.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 11:54:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF91ZJv4iR7a2JQJi6TlJWZPk1wSyvMGhzV4Ev4oMNX9mJuodD6YWEnPtlt+wnWtJB2+WCMUynYGQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9D/9NHOlz/kQuRV25aFIfjiMY/Rfzu49jO/IfznQR8n+t/svsa
	YwcuhsJ9LtDRJH5+L9hQjTxxDq7j8de6Kf4mjG/Y0R30BYOm2U0M/Of2nqahd72tt5ikY8KV3IX
	cf8I1xBoEHcUoHBXvQnQV2UawN2YLAyA=
X-Received: by 2002:a05:6512:3054:b0:5c1:595d:f8b3 with SMTP id
 2adb3069b0e04-5c15d5fb7d9mr47197e87.27.1794340492277; Tue, 10 Nov 2026
 11:54:52 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103114109.74400-1-k.chen@smail.nju.edu.cn>
In-Reply-To: <20261103114109.74400-1-k.chen@smail.nju.edu.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 20:54:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gU+J3vSx1CZDCo45m91kvuezQYYLy1OPQNkS-VcvLW6w@mail.gmail.com>
X-Gm-Features: AclHuK_0qw5ZqpsbW0elAllgk_QcpY_tHPK1WkVzkyizDyOE9ffdgm3c4IJ2LfY
Message-ID: <CAJZ5v0gU+J3vSx1CZDCo45m91kvuezQYYLy1OPQNkS-VcvLW6w@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: pcc-cpufreq: validate the ACPI interface data
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Matthew Garrett <mjg@redhat.com>, Dave Jones <davej@redhat.com>, Thomas Renninger <trenn@suse.de>, 
	Naga Chumbalkar <nagananda.chumbalkar@hp.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 12:42=E2=80=AFPM Kang Chen <k.chen@smail.nju.edu.cn>=
 wrote:
>
> pcc_get_offset() reads elements[0] and elements[1] from the PCCP
> package without checking that the package has two elements.  A
> zero-length package dereferences elements[0] out of bounds, and a
> one-element package reads elements[1] out of bounds.
>
> It also uses the returned 64-bit values as byte offsets into the
> ioremap()ed PCCH region after truncating them to u32, without checking
> the mapping size.  A firmware-provided PCCP method can therefore make
> the driver clear or program an address outside the mapping.
>
> The PCCH and _OSC replies have the same problem: pcc_cpufreq_evaluate()
> reads elements[0..3] of the PCCH package and casts its two buffer
> elements without checking the package count or the buffer lengths, and
> pcc_cpufreq_do_osc() reads two u32 values from an _OSC buffer without
> checking that it is at least eight bytes long.  A short or malformed
> reply makes the driver read past the ACPI allocation.
>
> Require a two-element PCCP package, keep the offsets in u64 while
> validating them against the mapping size, and only then store the u32
> values.  Also validate the PCCH package count, the two resource buffer
> lengths, the minimum PCCH mapping size, and the _OSC buffer length.

If there are no known examples of firmware with the problems mentioned
above, this should be mentioned here.

If there are such examples, pointers to them should be provided.

> Fixes: 0f1d683fb35d ("[CPUFREQ] Processor Clocking Control interface driv=
er")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
> ---
>  drivers/cpufreq/pcc-cpufreq.c | 45 ++++++++++++++++++++++++++++-------
>  1 file changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.=
c
> index 83e6f73dc9a4..c7c65104fc09 100644
> --- a/drivers/cpufreq/pcc-cpufreq.c
> +++ b/drivers/cpufreq/pcc-cpufreq.c
> @@ -92,6 +92,7 @@ struct pcc_header {
>
>  static void __iomem *pcch_virt_addr;
>  static struct pcc_header __iomem *pcch_hdr;
> +static u64 pcch_size;
>
>  static DEFINE_SPINLOCK(pcc_lock);
>
> @@ -136,6 +137,7 @@ static inline void pcc_clear_mapping(void)
>         if (pcch_virt_addr)
>                 iounmap(pcch_virt_addr);
>         pcch_virt_addr =3D NULL;
> +       pcch_size =3D 0;
>  }
>
>  static unsigned int pcc_get_freq(unsigned int cpu)
> @@ -253,6 +255,7 @@ static int pcc_get_offset(int cpu)
>         union acpi_object *pccp, *offset;
>         struct pcc_cpu *pcc_cpu_data;
>         struct acpi_processor *pr;
> +       u64 input_offset, output_offset;
>         int ret =3D 0;
>
>         pr =3D per_cpu(processors, cpu);
> @@ -266,7 +269,8 @@ static int pcc_get_offset(int cpu)
>                 return -ENODEV;
>
>         pccp =3D buffer.pointer;
> -       if (!pccp || pccp->type !=3D ACPI_TYPE_PACKAGE) {
> +       if (!pccp || pccp->type !=3D ACPI_TYPE_PACKAGE ||
> +           pccp->package.count < 2) {
>                 ret =3D -ENODEV;
>                 goto out_free;
>         }
> @@ -277,7 +281,7 @@ static int pcc_get_offset(int cpu)
>                 goto out_free;
>         }
>
> -       pcc_cpu_data->input_offset =3D offset->integer.value;
> +       input_offset =3D offset->integer.value;
>
>         offset =3D &(pccp->package.elements[1]);
>         if (!offset || offset->type !=3D ACPI_TYPE_INTEGER) {
> @@ -285,7 +289,21 @@ static int pcc_get_offset(int cpu)
>                 goto out_free;
>         }
>
> -       pcc_cpu_data->output_offset =3D offset->integer.value;
> +       output_offset =3D offset->integer.value;
> +
> +       /*
> +        * The offsets are used as byte displacements into the PCCH mappi=
ng.
> +        * Check them against its size before truncating them to u32.
> +        */
> +       if (input_offset > U32_MAX || output_offset > U32_MAX ||
> +           input_offset + BUF_SZ > pcch_size ||
> +           output_offset + BUF_SZ > pcch_size) {
> +               ret =3D -ENODEV;
> +               goto out_free;
> +       }
> +
> +       pcc_cpu_data->input_offset =3D input_offset;
> +       pcc_cpu_data->output_offset =3D output_offset;
>
>         memset_io((pcch_virt_addr + pcc_cpu_data->input_offset), 0, BUF_S=
Z);
>         memset_io((pcch_virt_addr + pcc_cpu_data->output_offset), 0, BUF_=
SZ);
> @@ -334,7 +352,8 @@ static int __init pcc_cpufreq_do_osc(acpi_handle *han=
dle)
>                 return -ENODEV;
>
>         out_obj =3D output.pointer;
> -       if (out_obj->type !=3D ACPI_TYPE_BUFFER) {
> +       if (!out_obj || out_obj->type !=3D ACPI_TYPE_BUFFER ||
> +           out_obj->buffer.length < 2 * sizeof(u32)) {
>                 ret =3D -ENODEV;
>                 goto out_free;
>         }
> @@ -365,7 +384,8 @@ static int __init pcc_cpufreq_do_osc(acpi_handle *han=
dle)
>                 return -ENODEV;
>
>         out_obj =3D output.pointer;
> -       if (out_obj->type !=3D ACPI_TYPE_BUFFER) {
> +       if (!out_obj || out_obj->type !=3D ACPI_TYPE_BUFFER ||
> +           out_obj->buffer.length < 2 * sizeof(u32)) {
>                 ret =3D -ENODEV;
>                 goto out_free;
>         }
> @@ -418,13 +438,15 @@ static int __init pcc_cpufreq_evaluate(void)
>                 return -ENODEV;
>
>         out_obj =3D output.pointer;
> -       if (out_obj->type !=3D ACPI_TYPE_PACKAGE) {
> +       if (!out_obj || out_obj->type !=3D ACPI_TYPE_PACKAGE ||
> +           out_obj->package.count < 4) {
>                 ret =3D -ENODEV;
>                 goto out_free;
>         }
>
>         member =3D &out_obj->package.elements[0];
> -       if (member->type !=3D ACPI_TYPE_BUFFER) {
> +       if (member->type !=3D ACPI_TYPE_BUFFER ||
> +           member->buffer.length < sizeof(struct pcc_memory_resource)) {
>                 ret =3D -ENODEV;
>                 goto out_free;
>         }
> @@ -448,6 +470,11 @@ static int __init pcc_cpufreq_evaluate(void)
>                 goto out_free;
>         }
>
> +       if (mem_resource->address_length < sizeof(struct pcc_header)) {
> +               ret =3D -ENODEV;
> +               goto out_free;
> +       }
> +
>         pcch_virt_addr =3D ioremap(mem_resource->minimum,
>                                         mem_resource->address_length);
>         if (pcch_virt_addr =3D=3D NULL) {
> @@ -455,6 +482,7 @@ static int __init pcc_cpufreq_evaluate(void)
>                 ret =3D -ENOMEM;
>                 goto out_free;
>         }
> +       pcch_size =3D mem_resource->address_length;
>         pcch_hdr =3D pcch_virt_addr;
>
>         pr_debug("probe: PCCH header (virtual) addr: 0x%p\n", pcch_hdr);
> @@ -480,7 +508,8 @@ static int __init pcc_cpufreq_evaluate(void)
>                 ioread32(&pcch_hdr->minimum_frequency));
>
>         member =3D &out_obj->package.elements[1];
> -       if (member->type !=3D ACPI_TYPE_BUFFER) {
> +       if (member->type !=3D ACPI_TYPE_BUFFER ||
> +           member->buffer.length < sizeof(struct pcc_register_resource))=
 {
>                 ret =3D -ENODEV;
>                 goto pcch_free;
>         }
> --
> 2.34.1
>
