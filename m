Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688835;
	b=fUp1vu7gjeMWTvYv2zUkbtMUJvasFXe3JoPx/sm0kP8Fm4Y6gJxYLHXCWvfkBOcc5jNb
	 iuzq1KILhzezznCH2I3U4gPaBTPRmTOjE1Zwb+BuGJvnCCwWHCJLKzPPVb5Ji2V2OygAY
	 tEaNtXLofdHETPosSBqzlXrUR7cLjUxm8OHIUBMWHfX+nlbqVHZdj+jE7qQdAVJbKIPuf
	 woAP87gI1IgvKVPNuQqwfB+zW6WS7smQuWVUNSM5+82NF3iOoPrjoCdJMM/ukx8MQOuO+
	 F4F4W0W5NpjDoE1peJRB/Aexd7qwxPaanfd4kryPoq8zlOw+f0pQZymfJTk0Y2f9prQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=hyUTUpsSAlQcCsDB6lwU6/zmOD65Zpl/jNjaMxbFRhE=;
	b=E/AANQQm27mWWzVF+8hv7VNjibROjBay29zkUoCtXi8/uB7jxL/0KscDHZG6xctTZ1Ru
	 guar98OtSrThxRIY0YNZnOCn1c2s6Yhb8MpyPHTznXF6eyDyxpj1kyC/IxvWq1WL17U94
	 7J7o1RfHkMXlDnSdz0pSivXcEmb+eU4u/sBos2450OQORxcWi/IPdooClMnrk9vFnuTq1
	 hQnDO+a6QlgD05DlwAlLd9DQW0PDfso+1BUpqYSXxMq3y5+UqvhBc0dCMr8l6zOqR8o+E
	 vfNbHt7mqmljP9atUikeXRYnquXo+wb5/yAcdpHOSYgEkzWCEq910M1CsqqP+G70n8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tqhDiL2Z;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE287606A31E
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 10:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE287606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tqhDiL2Z
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so46578445e9.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 02:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795688833; x=1796293633; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hyUTUpsSAlQcCsDB6lwU6/zmOD65Zpl/jNjaMxbFRhE=;
        b=tqhDiL2ZCxkie0sVNn34wqp/FemsKe7D7Fxyd6nZD/8KKxjW+gtdqa3gMbO+DiBrEL
         tce9+3y0NedN8iMlWcQUd9ZrDixQf0mddvwE+YhwEaqWTFoDjLa9HagQ0UJaBztMl6Hb
         fnTQuFZUVxURn+5nVQTCtVOeraBztVlxWWpupR125KK83vmXpzak4OMRZM8DbdqiG90c
         U207vhlAzv1DnhC9ChY5IdtbeXAdk0qKyGpPBTqQbke99EYPTz472RJqhqWnaRHKbt/t
         I1qPvWexbisMJAANUmhpb3eOccH/1Gkhj/Fmlo35gtHBApX0PAOdsfyDcjl36iaz4X5e
         lLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795688833; x=1796293633;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hyUTUpsSAlQcCsDB6lwU6/zmOD65Zpl/jNjaMxbFRhE=;
        b=NErNNIGGHLbCRjb0wYWGYr2RyJT05VruSbIGK76Nr3useGF19HvYtmDgXMIIjLUBkg
         lPArxEZMOZQR57BfR0hHCe0zVbX2Y+RId06NjvL27ZqyQq6QryZ6D7pFH/n6kF++tn7b
         2PWEe1HPnEnxejRFQQ0Dx+8S8CPB2pjZFyCwub2cfgjbaposKhKBVMDeyyeQY2+GTA4P
         lJPfyxoDjlu1LHgXC9bBYef21e246fDfWk7YC4tI0EokXQfXKXoWoXAArxwIi6TRab2+
         QdWchzBapyMf8cZHS7AyTsZrAAWJTjHFPtl3kT74sPuBGj3gjpLcXGKXmUi4u6QP2IGA
         vkXQ==
X-Gm-Message-State: APuU4Z8tPVZklq5i/SFo6OePkeIHt0MI5of4N4SMvnbE47dTy+tQeupD
	cYpWXX2URBcThkKhKKDbWS9+kGERN5CkeKWiWBoWsBSBxJESMH+dPS9H8QdKBT0tp5M=
X-Gm-Gg: AZFdTZfIhzB9vZp8uKTAAd+cdNbgHk+Wx/zQjtFvVVFPnHzPUDIvzm40WOWyhd6m8hM
	rnjYhbXxdxrZyWgil400btJqmAchAzcjheW1npOerMzTN7S4FI16mHavJEifuGnBcRE6/x3S+Mr
	VmP590MaT+Wv18VJ/VTJ6rEGEosOPdVeNLVBPx5SMhodbZYbwdoVexDf0NOWdQxvcap1zlLn/wG
	rv54AG1q/uea8hcYgQD2t/6ESaKs48bwKk6VvIdRZ1cv6vdJGMfxcQmh6kGHmlV88xJiQJZt+Lk
	FvvX5+cTrdx4Ln6lPdaul97vpXOIf1DI/Ble1WgFecmcX/ylIqx3gwD29pSLTBXreFkchzaIBlu
	wG6dJ0KHEQ1O5yvKa81teO5YXiJXt6BKLYl+jJhzoHnIuT/afYwt9atEHKPAIf4W2XF0fkGGHYH
	s624MHo2QrfzIxs0MNOCdBuBNBrqpWCJJXhEVKlLEMHjwMRkXI/bi5Ix26B1MwO8xp1y7OlFM/S
	njGYD1zIdgEuH79u96JNY18PVFNZeNbrAaG0XjjwhuOkf3Qi8WVWaLGvvG3WMTvcc1Xk6GGO3u0
	Zzjti3aT8CCNOsMRQWw3ES4TERKG4PcKvF0=
X-Received: by 2002:a05:600c:4585:b0:4a1:83f0:7c91 with SMTP id 5b1f17b1804b1-4bb8882948dmr422256135e9.18.1795688833275;
        Thu, 26 Nov 2026 02:27:13 -0800 (PST)
Received: from [10.1.1.59] ([109.255.181.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067846esm399651265e9.4.2026.11.26.02.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:27:12 -0800 (PST)
Message-ID: <f203e85c22e97363a220fc09b45ff6ba33c3f59d.camel@linaro.org>
Subject: Re: [PATCH RESEND] power: supply: core: give each supply's epc_sem
 its own lockdep class
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Ryan Brue <ryanbrue.dev@gmail.com>, Sebastian Reichel <sre@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, Hang Nan
 <2122295973@qq.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 26 Nov 2026 10:27:29 +0000
In-Reply-To: <20261125-power-supply-epc-lockdep-key-v1-1-c8a41b8a4470@gmail.com>
References: 
	<20261125-power-supply-epc-lockdep-key-v1-1-c8a41b8a4470@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9+build1 
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Ryan,

On Wed, 2026-11-25 at 17:23 -0600, Ryan Brue wrote:
> Since commit 9f7f7a859451 ("power_supply: serialize property access with
> unregister"), power_supply_get_property() takes the target supply's
> epc_sem for read. Every supply's epc_sem is initialised at the same site,
> so they all share one lockdep class.
>=20
> A driver that reads another supply while holding a lock that its
> get_property() callback also takes is then reported as a circular
> dependency, even though the two semaphores belong to different supplies.
> sc27xx_fgu_get_property() does this with data->lock and the charger, and
> a fuel gauge driver in preparation did the same with its charger:
>=20
> =C2=A0 WARNING: possible circular locking dependency detected
> =C2=A0 kworker/2:1/60 is trying to acquire lock:
> =C2=A0=C2=A0 (mutex_#2){+.+.}-{4:4}, at: mt6397_battery_get_property+0x50=
/0x23c
> =C2=A0 but task is already holding lock:
> =C2=A0=C2=A0 (&psy->epc_sem){.+.+}-{4:4}, at: power_supply_get_property+0=
x34/0x80
>=20
> Lockdep then turns itself off for the rest of the boot.
>=20
> Register a lockdep key for each supply, so that only a supply's own epc_s=
em
> is ordered against its own locks.
>=20
> Fixes: 9f7f7a859451 ("power_supply: serialize property access with unregi=
ster")
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

Thanks for the patch =E2=80=94 I hit the same shared-class issue on Pixel 6=
 (Oriole)
with max77759-charger reading properties from its TCPM supplier via
power_supply_get_property_from_supplier(), which triggers a "possible
recursive locking detected" splat.

Two minor suggestions:

1. It would be helpful to also mention the "possible recursive locking
   detected" case in the commit message (e.g. consumer callbacks calling
   power_supply_get_property_from_supplier() or power_supply_get_property()
   on another supply), so people hitting that variant can easily find this
   fix.


> [...]
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index de15314ef954..76bbe8772143 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1662,6 +1662,7 @@ static void power_supply_dev_release(struct device =
*dev)
> =C2=A0	struct power_supply *psy =3D to_power_supply(dev);
> =C2=A0
> =C2=A0	dev_dbg(dev, "%s\n", __func__);
> +	lockdep_unregister_key(&psy->epc_key);
> =C2=A0	kfree(psy);
> =C2=A0}
> =C2=A0
> @@ -1765,6 +1766,7 @@ __power_supply_register(struct device *parent,
> =C2=A0	if (!psy)
> =C2=A0		return ERR_PTR(-ENOMEM);
> =C2=A0
> +	lockdep_register_key(&psy->epc_key);
> =C2=A0	dev =3D &psy->dev;
> =C2=A0
> =C2=A0	device_initialize(dev);
> @@ -1810,6 +1812,7 @@ __power_supply_register(struct device *parent,
> =C2=A0
> =C2=A0	spin_lock_init(&psy->changed_lock);
> =C2=A0	init_rwsem(&psy->epc_sem);
> +	lockdep_set_class(&psy->epc_sem, &psy->epc_key);

2. Because lockdep_set_class() stringifies the key argument, the lock shows
   up in /proc/lockdep (and any future splats) as "&psy->epc_key" instead o=
f
   "&psy->epc_sem":

     ffff0008068e26e0 FD:  167 BD:   13 .+.+: &psy->epc_key#2
      -> [ffff000816c3eee0] &psy->epc_key

   Replacing init_rwsem() + lockdep_set_class() with:

     __init_rwsem(&psy->epc_sem, "&psy->epc_sem", &psy->epc_key);

   like block/blk-crypto-profile.c does, preserves the lock name while
   using the per-supply key.

Tested-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Cheers,
Andre'
