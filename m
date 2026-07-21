Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AEA46AA69
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648067; cv=none; b=X1YRMbVgpCzh1mzVE/ahwR6Q5FL59Ia9ombKRmWRpqzV1GnTvAqkqfywFeyYtV6TnPwEHu5FYsLZNivHp+8B+P6K1wKCCJHgBgQdYXKhewRs1o7eNXs7pyDm466fyPlRx1yi8CuCePdR/M1g7HkVlTTl55ZeJXCZe/QDj2Ya+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648067; c=relaxed/simple;
	bh=rdRrZWMw6XQ0DnO09ka2+OtkvEEzz3gTsu4XlbQjHj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbkKniIpmST/Az/lwTmmee6Nn8B5VIYCD8raIpmUDOD1FZOj6nHdA/OCCna8493mNBdQ+9ZhBoVhB0d4mGcbX3FDwQj75YIgINDkx0dARRVenQbQeews26Z5YlR59d3+s2bkiiOuSwf4RtHvwX5jLKUFz39//jzlaYBWp0Lf4uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwYU7c20; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwYU7c20"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BB81F00ADB
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 15:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784648065;
	bh=rdRrZWMw6XQ0DnO09ka2+OtkvEEzz3gTsu4XlbQjHj8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YwYU7c20iyRHlUEvv19GLx0Cd2Xowt+g80i2Ddj624/G/Q8YONChEezzO2OMY6TER
	 gSOngS5Q5fzBB66dF2iSa7zoCB/cQj1Vd6g/AfLf0s72OeXuOBCjbI+BBybXwb8Fj3
	 AZtkPRM/XOMJUz9/PuwU7mXYb0F6aLMMQM5wi6oypQDySgNo/5uAtmXi9+FS8QIj7j
	 FmSSG3gpRZEM/xhI/NFd647deEHwTMHBuavLrZbW38Ib6Ipr614pyoQtVEPWHtmKfd
	 7c6BM3AZ1nKEGEu7wo+LO3VppINx/ta0qRdIWU6keCO8YnnKgwGpcxceUjdOlJdPEs
	 zRzMeBY6IM4Ng==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c7fd21b63so87387851fa.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 08:34:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rog6eZa8caeYHU7Qv/S1zw0Pi5FHLHUc1KADZi/PZ0/idwQoHBfu6P9JDB08yJfJZrt6GyGlZUqBA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm9B9lvgJkYkSffcz02Uwxp0vxg9lW47eFlqqraaWA1geGUdG8
	9QnQpmNxoXUhgCnDBO4tkWwaOgzNee/iDpCKs9xQPXpN4wki7ROZOWjhPV6iNSbR/EEQD1V0tdV
	YvWglOA42J6SQTtzcMLi/bYXVSCeiUJ0=
X-Received: by 2002:a05:6512:61d8:20b0:5b0:190a:5b6b with SMTP id
 2adb3069b0e04-5b28f9ac2a0mr2732898e87.32.1784648064148; Tue, 21 Jul 2026
 08:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716153820.2007095-1-sumitg@nvidia.com> <20260716153820.2007095-3-sumitg@nvidia.com>
 <31525db3-a7a6-48fa-bea9-5de28a4332c4@huawei.com>
In-Reply-To: <31525db3-a7a6-48fa-bea9-5de28a4332c4@huawei.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 17:34:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jGJ8HDjmnKP8HvPRqm6NKL1mzxd6=z-xDyxe6=SoNCCA@mail.gmail.com>
X-Gm-Features: AUfX_mwG9ZdYy0LRhhbEyhBL30Qkgwd4M-EOK3higeVMTPvWhi7syJpKzMc0LkY
Message-ID: <CAJZ5v0jGJ8HDjmnKP8HvPRqm6NKL1mzxd6=z-xDyxe6=SoNCCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ACPI: CPPC: Add u64 wrappers for the autonomous
 selection register
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, Sumit Gupta <sumitg@nvidia.com>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com, ionela.voinescu@arm.com, 
	zhanjie9@hisilicon.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-tegra@vger.kernel.org, treding@nvidia.com, 
	jonathanh@nvidia.com, vsethi@nvidia.com, ksitaraman@nvidia.com, 
	sanjayc@nvidia.com, mochs@nvidia.com, bbasu@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 5:47=E2=80=AFAM zhenglifeng (A) <zhenglifeng1@huawe=
i.com> wrote:
>
> On 7/16/2026 11:38 PM, Sumit Gupta wrote:
> > cppc_get_auto_sel()/cppc_set_auto_sel() use a bool, unlike the other
> > CPPC register get/set helpers which use a u64.
> >
> > The next patch in this series saves and restores the OSPM-set registers
> > across CPU hotplug using a common table of get/set helpers typed as
> > int (*)(int, u64 *) and int (*)(int, u64), which the bool autonomous
> > selection helpers do not fit.
> >
> > Add cppc_get_auto_sel_u64()/cppc_set_auto_sel_u64() wrappers with the u=
64
> > signature so the autonomous selection register fits alongside the other=
s.
> >
> > Suggested-by: Pierre Gondois <pierre.gondois@arm.com>
> > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>
> If this is necessary, I think it is better to just change the input param=
eter
> of the original cppc_get/set_auto_sel() to u64.

Agreed.

Sumit, why don't you just make cppc_get_auto_sel()/cppc_set_auto_sel()
take a u64 argument?
