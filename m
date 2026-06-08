Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D6E36BCE8
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926035; cv=none; b=EaYjdr2gcVnNL0quxW0vwCGz8/YP2P+p1+8vZxdDgEXNyG+WMkOi44M6R3CI6++rEZgX8I/dIFa9y6Jq9zYX2SNXbxNPfRmS3ARynRyqrbG1U3DbUXZyl4qSBcJfa2aMiDElZlrPRxgS09FXgsR9XIZEcPJiynG/Gpbul7f/RGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926035; c=relaxed/simple;
	bh=J3skKjUhVZQdkhFczdJLw+lzdjiFgrMcr4PuUe/jcmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmoOCUH/4SmMUo/y6fwWExsEWDcd6QiIe1x7lBYhwoE0OWz3FXppfhYAD/cmvLsDsSP9z3nACmW709uPNBdYjN9wWm/sj357HMn7IHpApkbfcoTnRO/WRZAkAYZ671CjhyD384CfrL2s1jbGFD5W72t9zgjA1Tl516jtKNwT/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/bsXI4A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/bsXI4A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8FA1F0089A
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780926034;
	bh=0AALMhmVWXiMrIwmPe3r0oYyCMwasHK3q176uAXFHAk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=I/bsXI4AKDhkvzchYjLlaV7l6Cl8yTJFU+XcjYqu6jLhFYa7oKKU8hqy36SxVV8zK
	 Ol40Dmaookbujbi+7PW4WsUEHtbTRG6PG+es6ydgFiGqtWAicGdE7JYcpBPl/l0lvf
	 S9ehobpTCS1FMVxL4qWfRfo4K8xv+VGMHOwWRzlNCAa374BsZaYE/x7uh64Fxpb5Qt
	 EkIFCUnMkeyxd4zENXzJL7TPoYzMbrG7IrrWin2LDu0dK9jZYvmocukH3L2v9s9y68
	 0tC+qZzPBPEhsO4asIBWKGDRpq7AqK0aNRCjLomMPa9POCZvtStpcVCJLDnW1vrFsf
	 i8Il544bKRo6A==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa4bb157c6so3917935e87.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:40:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/PFC+NmJj2xxThSsyzztbAJ3v2cikCrSQIyLRqPEXuc8F1xntD9B9aT1GXC6ktACZkLWB+MAMeIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyB5/HyopgcylGkIfkaeHkSuTRcWpQgBn2EP0GwSRVgeeRPsWZ4
	480MxN7lAEln4tq1ypnqumEynzQD86FhlsPO/LrC/KfTIjE0NsGdb1Ys6JXNbOKoo/DdegvBx1l
	oZ7tDLgRrWMask9XMYG8H06MCHs/D61k=
X-Received: by 2002:ac2:5282:0:b0:5aa:62d3:3833 with SMTP id
 2adb3069b0e04-5aa87bd9523mr2953350e87.5.1780926032763; Mon, 08 Jun 2026
 06:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605173054.2050476-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20260605173054.2050476-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 15:40:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jUND1cF3QEA=6zCwsoFe2Q0PqgX9OinO1VWDWCLEBGCw@mail.gmail.com>
X-Gm-Features: AVVi8CdY69tl95W9np7aRWO3c1O-EBQOGLPi-7p-IuVqah1R5yBy8Pv6IYOOENk
Message-ID: <CAJZ5v0jUND1cF3QEA=6zCwsoFe2Q0PqgX9OinO1VWDWCLEBGCw@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: intel_tcc_cooling: Add Arrow Lake CPU models
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 7:31=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Add Arrow Lake CPU models in the support list.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/thermal/intel/intel_tcc_cooling.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/=
intel/intel_tcc_cooling.c
> index 6c2ba0ba3178..52ea4f7fc9f9 100644
> --- a/drivers/thermal/intel/intel_tcc_cooling.c
> +++ b/drivers/thermal/intel/intel_tcc_cooling.c
> @@ -65,6 +65,9 @@ static const struct x86_cpu_id tcc_ids[] __initconst =
=3D {
>         X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
>         X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
>         X86_MATCH_VFM(INTEL_RAPTORLAKE_S, NULL),
> +       X86_MATCH_VFM(INTEL_ARROWLAKE, NULL),
> +       X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
> +       X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
>         X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
>         X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
>         X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
> --

Applied as 7.2 material, thanks!
