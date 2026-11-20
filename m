Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193088;
	b=J38FKohAsTEXTEj12DM0d0K+yb7Nmou2RWVhgQfguROfPtuZTwTj0menLrA4jzXSgJ0n
	 6uZL0uzwwhKaGLMaz+sGcXQBrgnNnTNUypRaTINs0UvUCvHVMhsTfPTAybl0MXwnqnorW
	 pH00qr1Zt6jCSaPYzfG4c3Impa8mmeUSi7tASGbrCemVmPxqzKioFJhgck6yO5wRkNp94
	 9YcRSDf0X/er2qZxi8BWRWXWE3o6/wTws4aYbFpJLRw79BsQv1ay3+jzWOLhN7+bkE2NC
	 d6crpo2z9ForwDqEsB0etlTAHgiUyKPELNKQF1H1Zi09N40KoF/iNjbh1PdLS5FdMCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193088;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bafyYJg+TfrhvIeUtow4ao92Xon6lM47/WExRgR2qlw=;
	b=LV6kT/k1WMvyYCCWGAsIKIk7EppuEVYDT4tnAWz6wX9B5H2xdERTaEAe1zwueFE4Ce2W
	 qmx/V4iFL4K3GQczL0yqON4d4SbSo0QiZhVSg+rxdjEE1YHBqTku6AEkteTHZqZ8Cm+Nv
	 AFqnef0QIm6MX3gq9R4Bv3+6ysnvZ5xaBRtHLXA1cbHYpiJyZlh9U2nJbzAnBnU2OKrAa
	 J67scR3NTXqsnaj89gfldHu3NaToYfok7BQNFu/gsaQ70oSiRpnkaw7wzfv2VYwYfUN5Q
	 nrERp4U3mFxvObzhz2VZs1xXmdc5gma2g/v/Gdh3aGVsV0vfqgDRBS/frSeyiogSx0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SaymmpP+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400C0606A604
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SaymmpP+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95BB1F000C0
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795193087;
	bh=bafyYJg+TfrhvIeUtow4ao92Xon6lM47/WExRgR2qlw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SaymmpP+64MLpypXK0f5ayXGfEnI85rJnJRj4XXMg3duqXEMVWurQnDMM4FU8Oa94
	 dS1QzfU+pcxC8tFRfr4HNGhaqBEcxvXFCjFgMljTpPGFaYp4Yy8WuJQq+cr/Xsh84D
	 BLj1Wpn1gojHuyCdjm6pF3QHscLjBmeXr7kOeIsFbCR+YQopvpJAlYsXEhTDFIN6XK
	 SObXU/dLS/KpuNH6w6MTVSK9oNLrVEOCFX01dMC9R/3aTnm1BcGowm5U0l9OnaaL6X
	 KVcWP4zJa+H9ChRosTdrnVa5gBDqhxlq3B0XV3YHv+/dda6pyfEDCutq/0d00VtBrJ
	 6PKQeZWZGGb9A==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3acc7a0b558so10146821fa.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 08:44:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF/GtU761udCI/B/dAzYp4IYCF7JYf7x8th4B78yQwCjFPfYBMEeSUe+D1SwKtv22A6Uqt1asIDQg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8eZlyo19dQNPk9UUbgSLKVOixFKuVjK6jGtWApyZqvmSBb19ix
	hglTnBHBO+ULakeAOqp0k/XTriWYZvS2I7VQVlWiTg7ksOgCYKiUTJjlNMxWnL5moK2en2d8OFL
	YMOem5jshqf91pT1NTnutCD0MGh6VuVI=
X-Received: by 2002:a2e:bea2:0:b0:3ab:d488:2f9a with SMTP id
 38308e7fff4ca-3ae7f9b0e15mr14195911fa.9.1795193086375; Fri, 20 Nov 2026
 08:44:46 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113042214.2155381-1-lcy8047@gmail.com>
In-Reply-To: <20261113042214.2155381-1-lcy8047@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 17:44:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jteS6xpV6H_6Sjg35XCRAKT+DK=fFE=af70Rb_royCgQ@mail.gmail.com>
X-Gm-Features: Aa3M54r_dSoOmEzcNwZenNPF0vyTT-s22AX7Vp7r9gXRv5QDkfKbJWeKcJD5Eg0
Message-ID: <CAJZ5v0jteS6xpV6H_6Sjg35XCRAKT+DK=fFE=af70Rb_royCgQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: Hold control_type->lock when removing a zone ID
To: Changyul Lee <lcy8047@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 5:22=E2=80=AFAM Changyul Lee <lcy8047@gmail.com> wr=
ote:
>
> powercap_register_zone() allocates the zone ID from the parent IDR
> under control_type->lock, but powercap_release() removes it without
> that lock. powercap_unregister_zone() calls device_unregister() after
> dropping the lock, so removing one zone can change the IDR at the same
> time as registering another zone of the same control type. The IDR can
> then hand out an ID that is still in use, so device_register() fails
> with -EEXIST, or keep an ID that was removed. intel_rapl_tpmi can do
> this, as all packages share one control type and each package device
> is bound and unbound on its own.
>
> Take control_type->lock in powercap_release(). The device_register()
> error path of powercap_register_zone() drops the last reference with
> the lock held, so drop the lock before put_device() there.
>
> Fixes: 75d2364ea0ca ("PowerCap: Add class driver")
> Signed-off-by: Changyul Lee <lcy8047@gmail.com>
> ---
> Found with a static analysis tool we are developing.
>
> This is on top of commit 3d1c2693d809 ("powercap: Do not release the
> zone when device_register() fails") in linux-pm.
>
> Reproduced in QEMU (x86_64, KASAN, lockdep) with a test module that
> runs four kthreads for 20 seconds. Each kthread registers and
> unregisters a top-level zone of one control type in a loop. Without
> this patch, powercap_register_zone() failed with -EEXIST 7 to 12 times
> per run in three runs, the highest zone ID was 4 to 8 although at most
> four zones existed at a time, and up to four IDs were left in the IDR
> at the end. With it, there was no failure, the highest ID was 3 and the
> IDR was empty at the end, in all three runs. The module also makes one
> device_register() fail on purpose, and with this patch that error path
> ran without a lockdep report.
> Not tested on Intel RAPL hardware.
>
>  drivers/powercap/powercap_sys.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_=
sys.c
> index eacbc3c96db1..e9aa1feb5e3c 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -388,11 +388,15 @@ static void powercap_release(struct device *dev)
>
>         if (dev->parent) {
>                 struct powercap_zone *power_zone =3D to_powercap_zone(dev=
);
> +               struct powercap_control_type *control_type =3D
> +                                               power_zone->control_type_=
inst;
>
>                 /* Store flag as the release() may free memory */
>                 allocated =3D power_zone->allocated;
>                 /* Remove id from parent idr struct */
> +               mutex_lock(&control_type->lock);
>                 idr_remove(power_zone->parent_idr, power_zone->id);
> +               mutex_unlock(&control_type->lock);
>                 /* Destroy idrs allocated for this zone */
>                 idr_destroy(&power_zone->idr);
>                 kfree(power_zone->name);
> @@ -561,8 +565,8 @@ struct powercap_zone *powercap_register_zone(
>                  * ->release(), which may free the zone.
>                  */
>                 power_zone->ops =3D NULL;
> -               put_device(&power_zone->dev);
>                 mutex_unlock(&control_type->lock);
> +               put_device(&power_zone->dev);
>
>                 return ERR_PTR(result);
>         }
>

Applied as 7.5 material, thanks!
