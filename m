Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193468;
	b=UN2zniyaR5jyyKB125aTBpBOkr0j7zarova9O+G/XiB3z53Uc8ficGjqZ03SbO1EaQIP
	 aa2lw4c60A6puCvQLWd08m/8exJdf6F2sh3JzVu1as78An4z3OuLm0Rz9c7cLQWrPIPAP
	 ZxIiweLLZXwTEvMWmkI3Yj41YhwBx965Ymup9cIQpiF8w0MXS7VwLUcz4PJLm7JUDKJ5X
	 qPHdGKOYvXykvPiwvvSMdqi7CTVy137rmePzhWMD1e+/AYrb4zGZRDb89vpucM4boMcs/
	 cLZvteqi7Q9M8WV+MYUdVe1XcOaGvWsEn+IWBkyRP39sYIPtkqsYVNNloLU2vEgeuig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193468;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=v9u6Il645wwqwPsIhsxeY14aJqFQtWTjPLxOKEgbEEw=;
	b=wkTBS0866JQCnVA5Tx0vSLKtHgMsHNND7ShqyploC4xUQ9denXN+aGNuaMfpk/c37LwH
	 EO/r5yP99c2qnLWUf+ETYE/jQiGHcY9bpUZc640HH1z+Y+WiJHYPPN+do0uYQDDA8W192
	 9khhaIR8UEqjexSChkTPsVIX6mn0A91+wFOnfg5C+edFCK72h7mbuFhoUEINHmpZpw5L0
	 aWXoqRRBBqrjz5W/UCpFo01MzhGJXNB4NIC8PzBOiG2NVkOKdFlAGYeGndlUFDz3gjJxh
	 Tyh56C3sJDr8TK4osLvq1k++5rsos0Oqori5y84GBDgWJ2SiZfI4q866WmTaYQfFwMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4XFjb1Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2393260A2601
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e4XFjb1Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632BA1F000E6
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795193467;
	bh=v9u6Il645wwqwPsIhsxeY14aJqFQtWTjPLxOKEgbEEw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=e4XFjb1QUl+W/h3IkvvVOzp3emObeLDLbCfyF8DkzwaaaFAnsadwSLlKaB1v1T7p7
	 QW9Y4NlliI56DoM6KyPPbHoZWRfcBzKLWnhiTi5c5LhHaLKHY2sWMvnDz5oZ5BS+ln
	 q4eXmRWuZssZPnNuwQDEADNlAuOPhe03sSMcZayjfcJ2IWRwl93fOqlfD4ISGRZNZ9
	 xH3/RC2dVKXqwWDxmIYuBEbic2qQyjacQadWmGijEB82k9dHqy92na7LXS7JqIylqc
	 DlZoHoJ3+pqF5///bIKfWFccZ+K1Y6VPT4ERjXLRaGiujinJ5+steGn7lUH9DiugYx
	 ndPWGuSzGtyPQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c126f80426so1000684e87.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 08:51:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGDwzqf5W28SbEsSnN6rAZ5U6cXlktzzsS6g4tmzY1lcJPGuLUWvRIFMAEQ1XfpkLi8NqP6+zbZjA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8NbrFbNFLLAwT1wuqPnHuFArxCbu1XPaz3MWcZbFu8FBjeJOzw
	MtV6JsDKwIAihpx5I+gIRqJKpDalJS51xBIcG7/mIoSe6Q+H7xubBZJ/t3Gdyaoqt+7DjGGIPtL
	vSZHxG+lxeo6hOs8WLWpg7/zUUs/N6lo=
X-Received: by 2002:a05:6512:1086:b0:5c0:53e:6662 with SMTP id
 2adb3069b0e04-5c1bc80756fmr1199028e87.12.1795193465789; Fri, 20 Nov 2026
 08:51:05 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113045502.68053-1-yuz08559@gmail.com>
In-Reply-To: <20261113045502.68053-1-yuz08559@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 17:50:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hNrr_+CBkOLpbfs7nrCCSfGT0_CPo=G3LB_dpetcKuZQ@mail.gmail.com>
X-Gm-Features: Aa3M54phyBWRr-oW0bMbLB1lpYMkfBaYd3wcroDjrMDD1838N0GeOrSuvTqDZ6A
Message-ID: <CAJZ5v0hNrr_+CBkOLpbfs7nrCCSfGT0_CPo=G3LB_dpetcKuZQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: sysfs: take the zone lock in the tzp attribute handlers
To: Yu Zhang <yuz08559@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 5:55=E2=80=AFAM Yu Zhang <yuz08559@gmail.com> wrote=
:
>
> The thermal zone parameter (tz->tzp) sysfs attributes - sustainable_power=
,
> k_po, k_pu, k_i, k_d, integral_cutoff, slope and offset - dereference
> tz->tzp without holding the zone lock:
>
>         if (!tz->tzp)
>                 return -EIO;
>         ...
>         tz->tzp->name =3D value;
>
> For a zone registered without thermal zone parameters (tzp =3D=3D NULL at
> registration - the thermal testing zones, ACPI thermal and every driver
> using thermal_zone_device_register_with_trips(..., NULL, ...)),
> power_allocator_bind() allocates tz->tzp and power_allocator_unbind()
> frees it and sets it back to NULL, both under the zone lock:
>
>         tz->tzp =3D kzalloc(sizeof(*tz->tzp), GFP_KERNEL);
>         ...
>         params->allocated_tzp =3D true;
>         /* unbind */
>         if (params->allocated_tzp) {
>                 kfree(tz->tzp);
>                 tz->tzp =3D NULL;
>         }
>
> bind/unbind run from policy_store() -> thermal_zone_device_set_policy()
> under the zone lock when the governor is switched to or away from
> power_allocator.  The tzp attribute handlers take no lock, so a read or
> write of one of these files racing a governor switch dereferences a
> freed tz->tzp or a NULL pointer.  The read side (0644) is reachable by
> an unprivileged user.
>
> KASAN, one test thermal zone, one loop switching the policy between
> power_allocator and step_wise and one loop writing k_pu, panics in
> seconds:
>
>   BUG: KASAN: slab-use-after-free in k_pu_store+0xd7/0x130
>   Write of size 4 at addr ffff8880064e5c94 by task init
>    k_pu_store+0xd7/0x130
>    dev_attr_store+0x46/0x70
>    sysfs_kf_write+0xed/0x110
>    kernfs_fop_write_iter+0x29f/0x380
>    vfs_write+0x5df/0x950
>    ksys_write+0xfd/0x1e0
>   Allocated by task:
>    power_allocator_bind+0x51a/0x600
>    thermal_set_governor+0x86/0x170
>    thermal_zone_device_set_policy+0x58/0xb0
>   Freed by task:
>    power_allocator_unbind+0xad/0xd0
>    thermal_set_governor+0x57/0x170
>    thermal_zone_device_set_policy+0x58/0xb0
>
> Take the zone lock in the tzp attribute handlers, as mode_show() and
> weight_store() already do ("Don't race with governors using the
> 'weight' value").  The governor already reads these fields under the
> zone lock, so this also serialises the PID constant updates against a
> running power_allocator.
>
> Fixes: f5cbb182586e ("thermal: power_allocator: don't require tzp to be p=
resent for the thermal zone")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yu Zhang <yuz08559@gmail.com>
> ---
>  drivers/thermal/thermal_sysfs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sy=
sfs.c
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -258,6 +258,8 @@ sustainable_power_show(struct device *de
>  {
>         struct thermal_zone_device *tz =3D to_thermal_zone(dev);
>
> +       guard(thermal_zone)(tz);
> +
>         if (tz->tzp)
>                 return sysfs_emit(buf, "%u\n", tz->tzp->sustainable_power=
);
>         else
> @@ -271,6 +273,8 @@ sustainable_power_store(struct device *d
>         struct thermal_zone_device *tz =3D to_thermal_zone(dev);
>         u32 sustainable_power;
>
> +       guard(thermal_zone)(tz);
> +
>         if (!tz->tzp)
>                 return -EIO;
>
> @@ -289,6 +293,8 @@ sustainable_power_store(struct device *d
>         {                                                               \
>                 struct thermal_zone_device *tz =3D to_thermal_zone(dev); =
 \
>                                                                         \
> +               guard(thermal_zone)(tz);                                \
> +                                                                       \
>                 if (!tz->tzp)                                           \
>                         return -EIO;                                    \
>                                                                         \
> @@ -302,6 +308,8 @@ sustainable_power_store(struct device *d
>                 struct thermal_zone_device *tz =3D to_thermal_zone(dev); =
 \
>                 s32 value;                                              \
>                                                                         \
> +               guard(thermal_zone)(tz);                                \
> +                                                                       \
>                 if (!tz->tzp)                                           \
>                         return -EIO;                                    \
>                                                                         \

Applied as 7.5 material, thanks!
