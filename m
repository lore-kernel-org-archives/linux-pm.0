Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D52394493
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532683; cv=none; b=OXgffFEj8EjV0Znz3TICn+GLuhhneBcyZotWd6ryr7AEF7FSJYgTmzvR/UY8L6SratFL8x4JkS58uVN5H6Yty2IZCI7kFgQ2DlFcZnP7sA9wlWoNX8jkgaDp/MdWzKysZtRh70UoWdMw1t3O+UHHGiMf65rKFpSRgj4rGcvx8yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532683; c=relaxed/simple;
	bh=VIKMGOABbmGORlaALDqzUfvqMWhZh9adDdBOyKk2I7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcXeXuZkcf4k0PjvaMFGzyCSJANM7OHgwu09xqWmgq5ff3/wtWbHoefULBiMziRxpbY6ARUql+VhNj1yJXv+LxxYmQFr0swWBOCNzgLJp7QCsy24n/yEQh+Vjiu01nx+8UNK0sl7CXVKqOWAilnLx8Z2Gbc6b8GEyLovWZXfJOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAwiMM5I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAwiMM5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54631F00A3E
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532681;
	bh=Q7BGRg8LCxGXSnhUr8e0NA7RBh6XartT5oLwBHQ7kS4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lAwiMM5IbfBP08DwN48sEK0I7KevdBuGovui4opqMMJTBNNyz+UQ5sV/Fcatvg2Nd
	 5rnKHapuuuNv9PWPIfA6wlIukCpMznBZhoRUpj2XCGUrt10hZ+gQucHSOTwVSDqVjE
	 +zE1a/8b6lzfTcwRe/a2fB2QbH6octvHLE8E+wUdyAm7/2VG8wwXgcT7Lr468uKRXd
	 fH2tCuVeZmanshaGXm6aypbmjk2vRdV2LDkuggaULgFXrPUMG0bqQu6FIO03w7oaVA
	 t5hiBT0XG5VTEfhbtJnWwBiuELiuvseLUFSxvgHMCyitR0qrkjMSknxHyeSm8g7+GP
	 5yqNz+WvdSweg==
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5c681c2a6a7so456081e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:38:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBypZ4Ht25bU/SdtlSHw5jsP0MHJ6JG3sVXXAMtYdVayl9aht2o1EnuTgWYMVXZfU/BvMmbz6I2jUA==@vger.kernel.org
X-Gm-Message-State: AFuF++leGn3XcIJWa5YleDxDW54fQa5j+4IBQfcpQfkODe0Au83YHc78
	OFsk/JivVI7Hg+NGT9i0Oq9LcjyJszPsq+Y+NcSqQHWb4pPkUBov2Jo4GakiNI8MrZPMMaL4/Mm
	UV0dHrKkExRR28r1rHK3COyriFQ79QEE=
X-Received: by 2002:a05:6122:e189:b0:5c7:a9ee:dcfb with SMTP id
 71dfb90a1353d-5c7ed3d6e40mr2833424e0c.5.1788532681171; Fri, 04 Sep 2026
 07:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819174122.1184364-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260819174122.1184364-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 16:36:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gdO41izSghgyCY_-kfMPWz0MyZxzA-Y_F8DMypBc26qQ@mail.gmail.com>
X-Gm-Features: AcwNN1UKLpohgs8WM7lD-jdP4W-3Phfu0YSWy464nrPfyEpJuOf_2vntJEnnCN0
Message-ID: <CAJZ5v0gdO41izSghgyCY_-kfMPWz0MyZxzA-Y_F8DMypBc26qQ@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: intel: intel_tcc_cooling: Add rugged Panther
 Lake support
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 7:41=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>
> Add TCC cooling support to rugged Panther Lake.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/thermal/intel/intel_tcc_cooling.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/=
intel/intel_tcc_cooling.c
> index 52ea4f7fc9f9..75f6fbec2530 100644
> --- a/drivers/thermal/intel/intel_tcc_cooling.c
> +++ b/drivers/thermal/intel/intel_tcc_cooling.c
> @@ -69,6 +69,7 @@ static const struct x86_cpu_id tcc_ids[] __initconst =
=3D {
>         X86_MATCH_VFM(INTEL_ARROWLAKE_U, NULL),
>         X86_MATCH_VFM(INTEL_ARROWLAKE_H, NULL),
>         X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
> +       X86_MATCH_VFM(INTEL_PANTHERLAKE_R, NULL),
>         X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
>         X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
>         X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
> --

Applied as 7.4 material, thanks!
