Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF51148B38F
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788801900; cv=pass; b=BwSCu2zSj1/yk9QZp1L/9KS8axL71kRKYXRReV5P8s8xGafOn7jhjmbDBnvSm9J9i2omYyFdNWSAF2sHTeFTDZ7imJHT4foElVsBgDKOPLf4gSM086mquOcd7Y1a60EKthVmkp4vP1MpdyQL2U7lJOG2Z94NE6Ir1TsSkpsYnzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788801900; c=relaxed/simple;
	bh=oSNTQCPnILUw/68+gMk9HV9c3gowZFlOqukTFVtyVLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBAH5V+FJGsRfv6+ZLrKB5iCN/mnEigirS3OBgdUXypujoXueydrB7o/KCjoES+8rIggnh46NjHHwSU8teM+DhQ+ehxt22XLNVGjDevpkQGw+0+MM5cPt7FD0rJ3OvFRNf7oKyYmEAiXFWmuuISpuEwf7z2JcWuUBdOsVPL4WgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=A1QG/Nev; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="A1QG/Nev"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c250c6a6a6eso490956866b.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 10:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788801897; cv=none;
        d=google.com; s=arc-20260327;
        b=DqgHeATIcopA32l0vKGvkRUWnRTucv7TX7r81j7TwaS3Dj1qaI/bksjDOqZyVNKH4x
         2pBzk0cmKfdg7Rk3KgXggHBjl0suo09okhZhwqCqKlCPTKvJkq24otXS/4SlPMs3Rebv
         NN51dqqG+A6VHPT8VBoUAmc1TTNghWVZUf1iy9uxgEFh+wZ1SxDei1TioRL9TWQk94SO
         KcwTRZdmYkra6X4k78Px5/kz4enCgGxUkgPVk7/sxZd0OKauCb2IzmpUnRKVNAWpQH1V
         yYO380GSvBrR9gQzKPuoD2+MilJ8yddXvRxpjCSEDrA9md9GaYrp50fQlOs0Gw4U7+Ez
         l29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3tIvk9tN/HCp65ng31snFe+b+/Er/ZIovEHg1XgPvOI=;
        fh=BO7eUINeRuy9oGJzl/nBQzcMWNi/0STTY2M66plqFHI=;
        b=TglzUljcZuvzDu8Ds3a4XuYygsBU/qpd6/CV9BgDKqdE+hOjvEnpDVkzDe01OuU1if
         8QYD3FlqXBny8fELehw7hBVH59ccKl/++qAwbC9dVeyJUUcvo/5M90GdfMfy1vEpNT9l
         k1bYCaJ2fPdwBwqZpB7jJMmMh+vxuJa6tcWrTeKYPGdKxnvPvbn2ncFMmB5IZrIG7RWu
         gaqqiYLY1e2Rrbi4fQj0Gu3gGWFN1K7hy0gc+natxzXxCGXqFNEu3377mFVyjcqqs1dn
         Pp9wGcKCgAlYd+cXIutWkzm7EpWXah9mMqwpyVMMdk1+gl8P1HyrzHtQe/vBEvgrejmT
         +Sjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788801897; x=1789406697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3tIvk9tN/HCp65ng31snFe+b+/Er/ZIovEHg1XgPvOI=;
        b=A1QG/NevHCnH6e8hv793ehDowSCePrIRi3pjhZy2atwXMBTcADEZ3uSHItpYb+9orn
         xKuhuM62b6QlFRVNBYG6cMzxgF3Ye71Jqg7LuuRBVrBSeo4KCUnHTVUnPeAFY7On2EZ3
         NtsdRatMjjtTAfDBxrS2J8qQaCFIXFNflIYfKYmx1MmJpy3u8EuRHE9lamcO7NlqDxFp
         7J2lXJ4H8hJVSmyUYc0BH6hNp7dsq1HypmhqWB++UHF3dfDngR+qUm/XOivo54dXzUPq
         64Rmp6fAt0ATMidt6eGn04xef5x/CTwlooJVW4vFfqVwBoJiqxgXHFHjNOX/C71yXNbF
         ZKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788801897; x=1789406697;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3tIvk9tN/HCp65ng31snFe+b+/Er/ZIovEHg1XgPvOI=;
        b=PynYzZ6a3oFopyzJR/1BeyM1LphdgNLVs09jIeroejJ9iSXTEqqWgZDWV5nBUF91+S
         WPV0CN1zCooG+6YnjLp4klVWU5HMV92EQWmSczyZaFfqW/Hr6V/AXwGHFRC5HulOX0bt
         HJfAFe/rRbWr9aaIYVNPAX7y5uu9dTzRiCqEDrf9FksnA+F+I+QZ9um1mAQM6gEXF00X
         Df3mBmluyelMJcn9UsMEc6S/g1HjyL+XQe2Uo7O/7cTulUwJmxXuacZGfMEmBOMnYxRk
         0/EHB4C7FF+OkOdvDbUPbBAHgKz0NJdU9VGfys+DACsNDH0qxoxsjAPRYRfajohqbWw1
         RiQA==
X-Forwarded-Encrypted: i=1; AKwUvBxEIYRYGJNs6CarvBcnMVniblBiFoRhCepf5vbLoArDju2ueBYy6af9+hlzAfcb7FX6k1gXQlL97w==@vger.kernel.org
X-Gm-Message-State: AFuF++k3je2I5mGHnkqTQvQnRIJUIAnTH5wfzB71yZE6Szo+xUyuD6Ax
	QKQ606uZ8kj1JdWjxCDh4nQ4pHBMfCN5gJA30UJhy7D0PxP9Ru50VQzohIMDNgmsEt6KqKa8Qov
	IVz7xVyf4ZcmIezq8pd+SWEU8QC+wby65guzmonbCiA==
X-Gm-Gg: AYBFou0DCA7wjfSXhv1bmMw6TF28oZrTugrQAVR8YoAah/WNQDn+f8Kgs6pLXcuvAUw
	RUz7MPk8wteQakXTOe7LBS3Xy76TvbPPmN2YA4ZgWqGFkdWGT4d9AXD6EZBVKnsF3ULaDTyJSYD
	zw/l5pjfRnRl7qnL/lp5dVS0c0041jHuE1A/aWOJpPRhdfARpSe712DSELLVUXaEFaqkBnNBBE2
	2ZiZm7CufCDs7Gx8mKAS87x4thYrv7nHHRANqwUzcDnYQM3h5UGDV6HzBVt18RZBC1Gjh5gRLw2
	UDH5oA3cIuYhgATTLoZrgCO8OYm8sROZQfeOcLHqxR+f4dw8Ql71c5ZemgduQ/r3/FGNQqFR68Y
	pdA==
X-Received: by 2002:a17:907:1c17:b0:c26:19de:9ae4 with SMTP id
 a640c23a62f3a-c2619dea7ddmr757639966b.35.1788801896232; Mon, 07 Sep 2026
 10:24:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-bq257xx-init-v1-0-1a08b29e1a68@flipper.net>
In-Reply-To: <20260907-bq257xx-init-v1-0-1a08b29e1a68@flipper.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 7 Sep 2026 21:24:45 +0400
X-Gm-Features: AcwNN1VZBW-1Mt7kTfGFh2RSUKZM_MHn3RKjTl1xYyYe5M3UAavFebV38etJD5c
Message-ID: <CAKTNdwH47P9K935fGgnq0qaaNTbCuBNo+-ibVf-=vRcA01GJMw@mail.gmail.com>
Subject: Re: [PATCH 0/5] power: supply: Fix probe time race against driver
 teardown and battery parsing
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Pavel Machek <pavel@ucw.cz>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 7:01=E2=80=AFPM Alexey Charkov <alchark@flipper.net>=
 wrote:
>
> If a bus holding the battery-equipped power supply goes down right after
> it registered, it leads to massive fireworks as the driver starts to tear
> down its resources while callers from other contexts are already eager to
> process events using this driver's callbacks (and their private data).
>
> In current power supply core it's further aggravated by the fact that the
> battery parsing code expects a psy struct from the caller, which is only
> available once the device has been registered, so the device gets
> registered with its hardware constraints (e.g. charging current) not yet
> fully filled in.
>
> Fix the former by preventing the unregistration of the psy device before
> its callbacks complete, and the latter by providing a battery parsing
> helper which doesn't require a psy struct from the caller (as it doesn't
> strictly need one).
>
> While here, fix up these and other adjacent issues in bq257xx where all o=
f
> it was discovered.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
> Alexey Charkov (5):
>       power: supply: core: prevent unregistering a power supply while a c=
allback runs
>       power: supply: core: Allow getting battery info before psy is regis=
tered
>       power: supply: bq257xx: Don't ignore errors from bq257xx_get_state(=
)
>       power: supply: bq257xx: Use psy directly instead of driver data
>       power: supply: bq257xx: Parse battery info before registering power=
 supply

Sashiko gave valuable feedback on this series [1], which I'll address
in v2 - except for the part where it thought up a non-USB supply for
bq257xx, which the driver explicitly doesn't support.

[1] https://sashiko.dev/#/patchset/20260907-bq257xx-init-v1-0-1a08b29e1a68%=
40flipper.net

Best regards,
Alexey
