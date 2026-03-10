Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BE93C5DDF
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 19:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773169482; cv=none; b=A9oA0ZeFPVs6qYflA64FL/7vHNvtBjaUxwP2LKT8YeenWS+Rf8Cl9XfYHbeTTZ34J5lkCxyyPPB46zAM1SlsRTNFCqCg7mGZN2beBr8xX2/VP0/h7/oAQKCV9yNQ1JpRO9tA67nzPABim63+eMA95EUDrNr+UsBSp5fWbr0ukfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773169482; c=relaxed/simple;
	bh=fEREXXjnNb2sMQt0Aj8BZHdNShDU/QKWZFs/4RKxB70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P75+f3g6fNPB65IxkFX+DMYkPrkQ1+saq4V9/nEf8d77HeAV/BRsmRfZHvBaB5vRqd3uO0XE4P71n4A4CoQyp04n5Npm4NdGpx0UfuA2ot1ubJ0+nsQyQrUI8NL7y0hHckhPb/0/olYAHc9an8ybz5qnXWRe1rXxqAocMEJPfng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYJWbnV5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYJWbnV5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB138C2BC87
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 19:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773169481;
	bh=fEREXXjnNb2sMQt0Aj8BZHdNShDU/QKWZFs/4RKxB70=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JYJWbnV5ejN9v9yuTaTQJ3YvYwKqZxXf50+Wl/chOAAC2JpmPyA/u1TK0EsHWt9/i
	 Lv6zEAeVJLS4J4xXVDhoi4uZVtfdrb4irmsEFnNbs/eHin3mUw2yhndEC8oHoDZxL+
	 n3XprLKw5lI6KFDophLsbFwHkVnARlR35gZHGRrAvMjiE7dADgVBuMYWJ91FRkkGP5
	 PXAy+JZ3E0P7EPKdkG4NMc8LIolTyc3NqnxA7uN5733YHUlmokzrC+IhZ0dUczjN+E
	 ETjVY6Cn8FbaFfrnBVM42ATtiUuHWGXmejViVNHfRY70ftg4X/N6Imc2AcppvnfZgO
	 n5hx5l7gWDFtw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6618bc129acso7757427a12.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 12:04:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUb9DKv+Vswqqt5pVHK8tsONlKxsejzrjYwlWT8Y0ovJ6ezotxkBvINfRA7jzAP83wmUyn5M1Sr5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ6QQcwPIRAwVnczbp1xA219X9BLooBfggUQZ8yVcdgW5Ty57X
	pDlm+7Hlp3bYfzCEBnxjll+AK8L2o+5XtVqz9Ofa66IQfBrnPOlIZQEFFY5ausXphYG/T5kCqOt
	3UaVSpQWPULZGAgoGJDImJyqZYJ85GlE=
X-Received: by 2002:a05:6402:26c9:b0:662:cf32:a58a with SMTP id
 4fb4d7f45d1cf-662cf32a82amr1832049a12.31.1773169480490; Tue, 10 Mar 2026
 12:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310060201.660773-1-rui.zhang@intel.com> <20260310060201.660773-2-rui.zhang@intel.com>
In-Reply-To: <20260310060201.660773-2-rui.zhang@intel.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 10 Mar 2026 15:04:28 -0400
X-Gmail-Original-Message-ID: <CAJvTdKn3txgnNGD_ybC_sc9UMgoJE_3PME-YRsBv0QBcGo2oCA@mail.gmail.com>
X-Gm-Features: AaiRm52FFsJYX8KFrPuiHpHeCHMqYD3bXZdYP8pG6JViIbRWQ6KEU2N61A9VkBo
Message-ID: <CAJvTdKn3txgnNGD_ybC_sc9UMgoJE_3PME-YRsBv0QBcGo2oCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tools/power turbostat: Optimize core count
 calculation and fix naming inconsistency
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks!

(I simplified the commit message a bit):

    tools/power turbostat: Eliminate unnecessary data structure allocation

    Linux core_id's are a per-package namespace, not a per-node namespace.

    Rename topo.cores_per_node to topo.cores_per_pkg to reflect this.

    Eliminate topo.nodes_per_pkg from the sizing for core data structures,
    since it has no role except to unnecessarily bloat the allocation.

    Validated on multiple Intel platforms (ICX/SPR/SRF/EMR/GNR/CWF) with
    various CPU online/offline configurations and SMT enabled/disabled
    scenarios.

    No functional changes.

    [lenb: commit message]
    Signed-off-by: Zhang Rui <rui.zhang@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

On Tue, Mar 10, 2026 at 2:04=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> wro=
te:
>
> The current core counting logic has both naming and efficiency issues.
> The variable topo.cores_per_node is misleadingly named since it actually
> represents the maximum number of cores per package, not per node. And
> the core count calculation is suboptimal and wastes memory.
>
> Rename topo.cores_per_node to topo.cores_per_pkg and improve the system
> core count calculation algorithm to avoid memory over-allocation.
>
> Validated on multiple Intel platforms (ICX/SPR/SRF/EMR/GNR/CWF) with
> various CPU online/offline configurations and SMT enabled/disabled
> scenarios. No functional changes found.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index ae827485950d..ef3059ba07cd 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -2409,7 +2409,7 @@ struct topo_params {
>         int max_l3_id;
>         int max_node_num;
>         int nodes_per_pkg;
> -       int cores_per_node;
> +       int cores_per_pkg;
>         int threads_per_core;
>  } topo;
>
> @@ -9634,9 +9634,9 @@ void topology_probe(bool startup)
>         topo.max_core_id =3D max_core_id; /* within a package */
>         topo.max_package_id =3D max_package_id;
>
> -       topo.cores_per_node =3D max_core_id + 1;
> +       topo.cores_per_pkg =3D max_core_id + 1;
>         if (debug > 1)
> -               fprintf(outf, "max_core_id %d, sizing for %d cores per pa=
ckage\n", max_core_id, topo.cores_per_node);
> +               fprintf(outf, "max_core_id %d, sizing for %d cores per pa=
ckage\n", max_core_id, topo.cores_per_pkg);
>         if (!summary_only)
>                 BIC_PRESENT(BIC_Core);
>
> @@ -9701,7 +9701,7 @@ void allocate_counters_1(struct counters *counters)
>  void allocate_counters(struct counters *counters)
>  {
>         int i;
> -       int num_cores =3D topo.cores_per_node * topo.nodes_per_pkg * topo=
.num_packages;
> +       int num_cores =3D topo.cores_per_pkg * topo.num_packages;
>
>         counters->threads =3D calloc(topo.max_cpu_num + 1, sizeof(struct =
thread_data));
>         if (counters->threads =3D=3D NULL)
> --
> 2.43.0
>
>


--=20
Len Brown, Intel Open Source Technology Center
