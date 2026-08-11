Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE442C50F
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442773; cv=none; b=WLTbcYeQ/0vdgx4950uTuC3S765QtMGLjV/kvbFhREe6k9/EmEidLD61GS0cvNpSstWKbKytGxNe7khIYz6mLWBxola60N3cYZ8p7Jfr24vaYnmee5jXsLO/U25EuM525nu+Ib1XeQW94XEzfcNvZECB4Td0r4rc0PP+xMEer1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442773; c=relaxed/simple;
	bh=90S/r6mQImTAg3aZLqt1gFeM/uUAYtWppVsAv12Encc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AoJ+H+qs5he1jVCZUi0IZIJz9splGnGC9z+edDzXPy0RjJZrw37g9o69+obxaZD/kB9fbdl1xjO2y9WbCT38UDXuF0YqK6EestkFDPpq1oLCASNhGXIqr2Vvly0+QpdS1PyzpTb1NyNxGmy1rXusYSnGTLJug5NFxoQsEzKZHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxtZsZ3S; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxtZsZ3S"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f703a9d05so2109858f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 03:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786442763; x=1787047563; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/AjFQLOe5BBgwaHswZ4SoRx+qcmxOMalicWoeykewJU=;
        b=KxtZsZ3SyutyiZxrelYVuVAq5KEn+Qd3Cwe194kOGGmEkKEu59wwnHyymMymJa15G9
         WgVOb0SFD4Xd3y5NThq0Id5BctulpR1QBUdOemhF0/+qDWn/MYPwgyRBAZMpAWxxz3bN
         nl0J04aIu+R1MbxNZn0dLm8ECaD6gU7t2XaorFRG29/q7NqlcQjQ9G9kYwvR/WbICXEi
         0BOOwzEhHKd46DTVqEyitSEhoGFgbdYYICLUXJ4EAbfXKEDdNca6UWO9ZEcs93vVGgko
         7gvGDvJALYboxmQ+LNWxQIzIu9CFtDOd3YGcECaHytVw3m+apc+0Bu7hbj8RyHhwFzcB
         xZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786442763; x=1787047563;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/AjFQLOe5BBgwaHswZ4SoRx+qcmxOMalicWoeykewJU=;
        b=U9VoWdC3z0dUDWN/ZUwdG59ukbMMogC22P83p1XrpXeczo1baOfDEeZkeS5wtiGOso
         cw+6ZwyQe1e75RU90PT5X2jfPG6uy63a8+fZsbsgJbccrjemClmpMvorttV0mx2aezZq
         4TdEDqwgWGitSTnPQxqBJauxKp3V8+QmGj612G3CHhZTEkh2wK5rsFb3r3ole/GYH97g
         gtmftf0K/Q2S5SviB3dAcCmxzCh1w+4jHI1BlgL+fW73PAH4l6qkPHTUQ/tu3rfoAuAM
         KGv0nGR7zLTYR5STv2/3+lvoZZI9bza5N6E4783hTDYOkb0jekegyHkEFXhq2ZBFkxaR
         pJcg==
X-Gm-Message-State: AOJu0YwNOqaYmFUU4lxcr1fJtWik1Lkmo5H86ZSTom/itoJqwQTKJ26D
	oWgdYTE3ngxjRlTuhjEzkBDoJsC9O0UN4/g8QIGMklnIjq3e/UbTdeyy
X-Gm-Gg: AR+sD13/3KfGwLcYZ3mQXolEJ+QckNJJlcD53qw1QuCeW6P8TVjLrYP1oP/eeSsIMdd
	TJPj8eT0zofiiAGYk9NOAnAhAKZA5xyV6hFgO82PxBDqNtmZSCLrwrWg3OA+MbmW8OH+x/Xz8Fr
	ctTQ4mU9lb3quL20qClkhS7ctW3ph5DVcyVLvr/gC32ih7tQixJQsPUV0lqfnX6/oL7RWFqM9Ne
	N6TE6L0iYP22gn28J+H/b4KiIdQQuWT3HgcaA55SuGoGAda9Aj8Z2AmVLXZ2MhAh3S0fM0JKwOq
	OQU7hA9Gn4H2887nb+ivX1Ajefu1fQ+O+m73GjTmF8Xm2BxJ0bRfy6/whoPuUq2GG6ketuT8qOO
	CIMnglyEknwen3OTdr0UUIhEYdNKmENuSKx0cfKJK6wP1j0qA82rVdDGZwBqZCHhWL64QBypuL2
	3Q8WPNj9jNUFWD27YerJdZe1Cc2A08nfHZGW89yVqOUefsimoGuOq21geyeyD6h/Q=
X-Received: by 2002:a05:600c:3112:b0:496:c2fd:1731 with SMTP id 5b1f17b1804b1-4997842a1e2mr31350875e9.1.1786442762789;
        Tue, 11 Aug 2026 03:06:02 -0700 (PDT)
Received: from [10.245.245.29] ([134.191.227.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499788fd908sm33538205e9.13.2026.08.11.03.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 03:06:02 -0700 (PDT)
Message-ID: <9f75245a24905368dade4d172727933c4e1a74af.camel@gmail.com>
Subject: Re: [PATCH] intel_idle: Fix C6S and C10 latency values for
 Pantherlake
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, rafael@kernel.org, 
	lenb@kernel.org
Cc: linux-pm@vger.kernel.org
Date: Tue, 11 Aug 2026 13:06:00 +0300
In-Reply-To: <20260811081729.186571-1-kaushlendra.kumar@intel.com>
References: <20260811081729.186571-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

The current value are based on what I measured using wult/pbe tool.

I think it will be better to explain the problem and how this patch
fixes it, give some details about workload. And ideally, also provided
turbostat output when it runs in parallel with the workload before and
after this patch. Then we have can see CPU frequency and idle profile
of your workload with and without this patch.

Thanks!

On Tue, 2026-08-11 at 13:47 +0530, Kaushlendra Kumar wrote:
> Correct the values using BIOS ACPI _CST characterization data read from
> a Pantherlake device via
> /sys/devices/system/cpu/cpu0/cpuidle/stateN/{latency,residency}:
>=20
>   C6S: exit_latency 300->127, target_residency 300->381
>   C10: exit_latency 370->1048, target_residency 2500->3144
>=20
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>  drivers/idle/intel_idle.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> index 651408df9c24..0b5c94c7cd3a 100644
> --- a/drivers/idle/intel_idle.c
> +++ b/drivers/idle/intel_idle.c
> @@ -1010,16 +1010,16 @@ static struct cpuidle_state ptl_cstates[] __initd=
ata =3D {
>  		.name =3D "C6S",
>  		.desc =3D "MWAIT 0x21",
>  		.flags =3D MWAIT2flg(0x21) | CPUIDLE_FLAG_TLB_FLUSHED,
> -		.exit_latency =3D 300,
> -		.target_residency =3D 300,
> +		.exit_latency =3D 127,
> +		.target_residency =3D 381,
>  		.enter =3D &intel_idle,
>  		.enter_s2idle =3D intel_idle_s2idle, },
>  	{
>  		.name =3D "C10",
>  		.desc =3D "MWAIT 0x60",
>  		.flags =3D MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHED,
> -		.exit_latency =3D 370,
> -		.target_residency =3D 2500,
> +		.exit_latency =3D 1048,
> +		.target_residency =3D 3144,
>  		.enter =3D &intel_idle,
>  		.enter_s2idle =3D intel_idle_s2idle, },
>  	{
