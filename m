Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD5503BE0
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865913; cv=none; b=meFyaK31lkqH9R7z0eS4bM42uYYEXSf0hzOyJ+eBW95sh5OXvSm6p665MfUpNdjm9fO6MXeRelsLOWrkyYURcFmSPBfsH4n5sdzkSjpXc7K5HkLdl4RoE0s7E9ST79/PgL8bOaILJ1BeIvALQguLenaCZ7KtxF2oiolS1fz2MfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865913; c=relaxed/simple;
	bh=9L6CH3BNsiAwS+p+KZKfthcFKV4pNXIkhNBnMWLc38U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGsVemT1nkJIkHZ7ZS8u34xoNi/+WIdJTDM6jU7xKyknAUHCD1Zh+kacRrC9TiI67bf1ebPRH47Kpy+/JA3CzPOuMNAA9zIQfmEcIbmnZtTdZjGEo7xNgh8NUrwbpj0Qz85bvl9nEBb3PFITB6EKOi9BAt0tzq6sm39ZI9P+qKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R40y2+z0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R40y2+z0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82681F000FF
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2026 14:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865911;
	bh=9uZ3mVJtvx6p++HOh3FyeX5LdpfEqkU81Hfu+v2ES8Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=R40y2+z0yPoQVl1o5lFeZEka6UC42wpMJflYdk5nvWP5N8Yr2KciXqbqma5DFmRuE
	 jI6CaMKitg5Z7a37E3MgfBM7C5Q3zsS5/+LVSXyOHhOaa9/LAcDjHpiVS6+LdIIjvK
	 cgQGPwXteFUyyNGWRMym5rsxPzq3Ip+or//8M3m34jWR8P9N03zhf9zRxbp7FWmALD
	 hx3HBnyuE5Uk9LTtVagCPr9yLFE+XL788gdkh6QEC3JCWf4Ny0yZvaVMNB76nEGBfT
	 CJVqUtnREkl91LqqeT+rALZXvRwCjMHj5gNFN5r94qh/aCJKouHRwjxq/XgDyXWqy4
	 /w3DsCh3b5PrQ==
Received: by mail-qk2-f40.google.com with SMTP id d75a77b69052e-53396950528so3084821cf.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Oct 2026 07:45:11 -0700 (PDT)
X-Gm-Message-State: AFuF++nSD000NPen+gdH32zzVzTrpS3StihHhSDOrtisG0Mc28veJD8V
	xOWq5KTgt8RvsNMASC7KukyYlYXKb+AaVuSgs4+th/BSAP7Kr/SRNXaPmDWCyYpiIbeB/h+Q0C1
	SjbSKSw8yQAVEGx/gf3kdye4QTuhIMhA=
X-Received: by 2002:a05:622a:e398:20b0:533:8ae0:3a4c with SMTP id
 d75a77b69052e-5338ae048e0mr29517051cf.47.1790865911012; Thu, 01 Oct 2026
 07:45:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902065922.1408-1-yanlonglong@kylinos.cn>
In-Reply-To: <20260902065922.1408-1-yanlonglong@kylinos.cn>
From: Len Brown <lenb@kernel.org>
Date: Thu, 1 Oct 2026 10:44:58 -0400
X-Gmail-Original-Message-ID: <CAJvTdKn3--_KCvGiqJAOySscw+vpT1OnvdVfi3uMUVjJ6L3LiQ@mail.gmail.com>
X-Gm-Features: AclHuK9iD_6H4G1l1yw-Z14P0ZZrV7zTwx2IT9mIW7X9lkLTzjdgHB29E7kOdQ0
Message-ID: <CAJvTdKn3--_KCvGiqJAOySscw+vpT1OnvdVfi3uMUVjJ6L3LiQ@mail.gmail.com>
Subject: Re: [PATCH] tools/power/x86/turbostat: add NULL check after calloc()
To: longlong yan <yanlonglong@kylinos.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied -- thanks!

Len Brown
Intel Open Source Technology Center

On Wed, Sep 2, 2026 at 2:59=E2=80=AFAM longlong yan <yanlonglong@kylinos.cn=
> wrote:
>
> Three calloc() calls in turbostat lack NULL return checks, leading to
> potential NULL pointer dereferences on allocation failure:
>
> 1. rapl_perf_init(): the allocated `domain_visited` is used later via
>    memset(domain_visited, 0, ...) without checking for NULL.
>
> 2. added_perf_counters_init_(): the allocated `domain_visited` is used
>    later via memset() and domain_visited[next_domain] without checking
>    for NULL.
>
> 3. pmt_add_counter(): the allocated `pcounter` is dereferenced
>    immediately via strncpy(pcounter->name, ...) without checking for
>    NULL.
>
> Add NULL checks after each calloc(), using the same error handling
> style already present in each function: err(-1, ...) for rapl_perf_init()=
,
> errx(1, ...) for added_perf_counters_init_(), and return 1 for
> pmt_add_counter().
>
> Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
> ---
>  tools/power/x86/turbostat/turbostat.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 4ad7cb1df5c5..926dd1422fbe 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -8578,6 +8578,8 @@ void rapl_perf_init(void)
>  {
>         const unsigned int num_domains =3D get_rapl_num_domains();
>         bool *domain_visited =3D calloc(num_domains, sizeof(bool));
> +       if (!domain_visited)
> +               err(-1, "calloc domain_visited");
>
>         rapl_counter_info_perdomain =3D calloc(num_domains, sizeof(*rapl_=
counter_info_perdomain));
>         if (rapl_counter_info_perdomain =3D=3D NULL)
> @@ -9942,6 +9944,8 @@ int added_perf_counters_init_(struct perf_counter_i=
nfo *pinfo)
>         const size_t max_num_domains =3D MAX(topo.max_cpu_num + 1, MAX(to=
po.max_core_id + 1, topo.max_package_id + 1));
>
>         domain_visited =3D calloc(max_num_domains, sizeof(*domain_visited=
));
> +       if (!domain_visited)
> +               errx(1, "%s: alloc %s", __func__, "domain_visited");
>
>         while (pinfo) {
>                 switch (pinfo->scope) {
> @@ -10333,6 +10337,8 @@ int pmt_add_counter(unsigned int guid, unsigned i=
nt seq, const char *name, enum
>         pcounter =3D pmt_find_counter(*pmt_root, name);
>         if (!pcounter) {
>                 pcounter =3D calloc(1, sizeof(*pcounter));
> +               if (!pcounter)
> +                       return 1;
>                 new_counter =3D true;
>         }
>
> --
> 2.43.0
>


--=20
Len Brown, Intel Open Source Technology Center
