Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4399439B976
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900011; cv=none; b=u690ZZbaHb5BweOPi2TnbxhXsvFhGBZ9ldLHrrtaG7AjgSZurauFIjcu5HUjSn6S0u0MRvG28WrOch72Tg0isYJJ+7sCwEXws0HiWnR4AokP9rPlXTW1S2ohDjykBCHvUlekqR1uqV8OIVagYlNQpUZ6N/kx4GScBmmw5x8cW84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900011; c=relaxed/simple;
	bh=gEjmJtrD7vuSYZLRM5tauXihVF7NoHm+GngemMbDLc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXI4sS/7us+5TnDFkk1rXQ8C8Dw/6Qqna0EFPh+wWnzHXhxSWDy6c8RGONSzYcgE6Ba9ZkoQlzyy4LXQBvAXVP/FgN0vpOYjfkZTjBC2x7qgA5fCL598VTTcL3omYznjD4UQlVvL9A6Jggmz5prIlEspfq5oCysZh7NpA/yGXg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQtXr6EH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQtXr6EH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA57C2BCB2
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774900011;
	bh=gEjmJtrD7vuSYZLRM5tauXihVF7NoHm+GngemMbDLc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eQtXr6EHun6QSDewcByzjSOFIBOsF1WbVIamDCetZ1pBgQRgGpeyx0cKytqbBd3xg
	 k15ASlnWVGSswxC4recCO1oAQg7WopoOLo5jgtXFLf22lqDAuP36WXJYRnI/cooW6P
	 qjOa58MYEXPkO3UIEQeve0SgUfXDGLcwo+4/ibHDzQURijftWcl7lCvnjJrnfRRsRC
	 vXWJkUGXcim476jNyXJBNmrzrX5pRtG7rMIeqEN2tVqkAH59KvITY93QJqHGuth8ZH
	 2oep4fNUoUYMj1uxnBacbgZUJAdLGICE4sRNQq6l4+qENu5oAc6TWLBJAnYHzSinbj
	 ezCArvvFQLwmQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-404254ffe8aso2966079fac.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 12:46:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/RRYJ8CFANnddK4BU+txn2WNRc4eI9J680wlBNOHGThlvG79/haVaDPg28+JWSzQyzNjQEOAHzw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/P3MvQ5ccHT17Wfqf9HwhPECG4pge2LW2+kB7pfjjpFv68TON
	HYXZTvTr+OgQl2CRlD2jRpKhRq1Xu54Aoo4IPIND+vW4jlbho+Bk7lCoTuiZYvV79uFVO2aRdSj
	+/eQy7o89YD1/W7h/fqz/DP7PRuobDxQ=
X-Received: by 2002:a05:6870:240e:b0:417:14d3:399f with SMTP id
 586e51a60fabf-422a3b60bc6mr512517fac.2.1774900009892; Mon, 30 Mar 2026
 12:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260329073615.649976-1-changwoo@igalia.com>
In-Reply-To: <20260329073615.649976-1-changwoo@igalia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Mar 2026 21:46:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i6kEWjo=EFUOtRxwWWgXXmwq8Zco9FSpf5dVa4wtAm7w@mail.gmail.com>
X-Gm-Features: AQROBzCeET41haBhyhSnYEFL8W09UTH9KXL6qKsSxLxmMXzP0Y3LgAP4nDW__34
Message-ID: <CAJZ5v0i6kEWjo=EFUOtRxwWWgXXmwq8Zco9FSpf5dVa4wtAm7w@mail.gmail.com>
Subject: Re: [PATCH] PM: EM: Fix null-ptr-deref in get-perf-domains when ID is
 not found
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com, rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, 
	donald.hunter@gmail.com, kernel-dev@igalia.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yi Lai <yi1.lai@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 9:36=E2=80=AFAM Changwoo Min <changwoo@igalia.com> =
wrote:
>
> dev_energymodel_nl_get_perf_domains_doit() calls
> em_perf_domain_get_by_id() but does not check the return value before
> passing it to __em_nl_get_pd_size(). When a caller supplies a
> non-existent perf domain ID, em_perf_domain_get_by_id() returns NULL,
> and __em_nl_get_pd_size() immediately dereferences pd->cpus
> (struct offset 0x30), causing a null-pointer dereference.
>
> The sister handler dev_energymodel_nl_get_perf_table_doit() already
> handles this correctly via __em_nl_get_pd_table_id(), which returns
> NULL and causes the caller to return -EINVAL. Add the same NULL check
> in the get-perf-domains do handler.
>
> Fixes: 380ff27af25e ("PM: EM: Add dump to get-perf-domains in the EM YNL =
spec")
> Reported-by: Yi Lai <yi1.lai@linux.intel.com>
> Closes: https://lore.kernel.org/lkml/aXiySM79UYfk+ytd@ly-workstation/
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  kernel/power/em_netlink.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
> index 5a611d3950fd..4d4fd29bd2be 100644
> --- a/kernel/power/em_netlink.c
> +++ b/kernel/power/em_netlink.c
> @@ -109,6 +109,8 @@ int dev_energymodel_nl_get_perf_domains_doit(struct s=
k_buff *skb,
>
>         id =3D nla_get_u32(info->attrs[DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF=
_DOMAIN_ID]);
>         pd =3D em_perf_domain_get_by_id(id);
> +       if (!pd)
> +               return -EINVAL;
>
>         __em_nl_get_pd_size(pd, &msg_sz);
>         msg =3D genlmsg_new(msg_sz, GFP_KERNEL);
> --

Applied as 7.0-rc material, thanks!
