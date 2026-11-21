Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795261965;
	b=GsXK7sAIpgLj0RVGN3DTNso2joeEOlg5iCIHUKTK4L6nKZiBZH1seLm4HSJouXVZj1yR
	 vrWRLNaC1tE1Dy/2M31a0nvM0zwOQl1KuQ8VkeFb3DDDk7ZqQSjMMsYJI93Fnecb2Eml7
	 UHNG+M4VEU65pNE1VlmruMr89zN/fS7lF/meJTbmBNKVbQNtPuTvICy7DJ+CE52mq7z/g
	 tLNC4SCVyDi/kPao3l4yMFSolRyVNhJ2JxHayaCGPlyrTUAkcuLjl3xAxmgrolubKosd/
	 UIumntCm4GTxj0ryKoJH7VSTXhUvyee0y/7vjeMhnPtbzhqs121uFdX38hf37aa3XFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795261965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=N0f/oc4w+1288sm9q4rBvBHgWSxv2jCSc3LHHH66Lc0=;
	b=V74DvLy1zqivIBo6JvusoRFw+X88ynmMOULWTI8r6bR66hCr7rU6Bohg8TexQjJsqgVj
	 Nhf7avtbZg3CnQgpQg7M0ZNczyGaBW9C/bRjY+2kyB5og4xT7mAjTDNnqmSLdMKOwwxOe
	 9jz6Pd5mtksbvcIxeCTofFLbXXPbXVX3GPNNiE8kc95GOnRDZ284tPFbUv6Ph+orOSZai
	 dSgqQvnp543CrXP8WNhRNTu0eFAdCsjwG5QGBP9LzU3Q8kwiW5VknHdeGdoFS7bvAVqIk
	 oq+h/O4/NcQ05WP0Jj6plWsZwHSsf24PIsjO+dTzjkA0LSb6fGSrjYMtYI4pinB5lfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qb5bJfVt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBCE606A325
	for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 11:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DBCE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qb5bJfVt
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67583c777abso1817115d50.1
        for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 03:52:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795261964; cv=none;
        d=google.com; s=arc-20260327;
        b=WCUdD/t3qyg+cCHy54DHEzgckqSKwGaPGvZBq5ZZykRiqQ6Nto3SljhioTB8gb0vmO
         OV+yrtYJylW3U/Lx9hoCeo32wm9gaZzncH2UKYRZqOS+OcococzsE8YDmPu+pzUIRoY0
         qDPNygMpRCztItHIDmIyIEZEGaB/Y25bZoPyxXvXzKbJJp50Bo7CkXoIjUGxxZPrFNKg
         1SWDPsqsFB8TaGTTYX6PBRZnZaK3OkDAgIVdpe1mj2SkyRiWJH8aCR8dPROr1l70QFrg
         c9ws8BavMD4+b9vJPyHSNBYk8MdKLPf506BrUX0teocOyW45+5+kVHikUyajGfxI0pUy
         jOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N0f/oc4w+1288sm9q4rBvBHgWSxv2jCSc3LHHH66Lc0=;
        fh=ccsjRWN+IakTT+n8hN/vhr+cSWarQhPsHJQbImicqA0=;
        b=l5834EfvTsKfT7icbSz4Iz5c0XcKWjOYs3wZUmyVzvqD/xpZRESncOIzdaPnnM8h0A
         WY8xE0q/gQnJjWlJ98/+GRFpYvyD9GAfb91OXMs6ONwY0CiEckSt6xCW8KyzLR6mgJc0
         A6DRgermzRFi3GPaLy/fj/RxSn74dJqCiz5mne4z2HSFm9E3DvHHw0tE7181wpSkVs5M
         ZqbngBGDh67+g9vgv4V5iKgW2p/rtxKFMVNQPZ1aBCOwt0Ftb/84nNNjER6bSMAqschA
         Bqgw4JZTmhqC3Eh0TB9+LeekuKPr7hFWdxISKPqQ4ntQ2d0wnA3VYiQzByIY0a1bQ3Kv
         LSSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795261964; x=1795866764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N0f/oc4w+1288sm9q4rBvBHgWSxv2jCSc3LHHH66Lc0=;
        b=qb5bJfVtA/D80+4zx2m05pDWxT9nPxP/bWOJ/woKNsUNyhX/SLgh4QGGFI/dC+6aR0
         yIuNj9xlMvR7m1/Pj1wh10ZAtTUPfPyWhAR1DL8jLDw8QwhbYyj/3UkubkcO1Pur6I0X
         Nwh6NYFE7b6vXh26kw7VbAEQfFeQYV6hy9aAXxJF7eC6kcjuIU9mpPH679E7+d6qzl4w
         dV6C1ALIEp7yxxu20gP2IGzFT5UFInrqavS90e2AhUALFUFISR7I9+qMhW5EFb5pRyQC
         jX5B6HvLy8BlN5/FSIQT5GY7OYUicvqb9HKnzeMhZ5J7zzTS/+rNz6BWV3gvSmx+vXhN
         Dl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795261964; x=1795866764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N0f/oc4w+1288sm9q4rBvBHgWSxv2jCSc3LHHH66Lc0=;
        b=13Cyj7KY9UTRG2IYgAJnChxKKqg/lIBbNzdRAHdkCfvi6rIkrMhMrli764dX/V8fiN
         g7CPpCrQ4E14b+6MZ+XMUi1yPDFgLrIqnOEoaqZh6jhZPzRJMarMm1BMyuXOTt9uf9xs
         shP9rAQSjbRTjZ/OzvmaTNNlJPkekallotpYZhGV3otEz35U7OFlljdxENn5Hv3IamFP
         vcGoDeu8qAkITWW66paOqSNppYuFabe+lC5qTiVRGbGK5AyqtY3axXX3Flus96zdkmB3
         a4lGM+xzA83RfrAhejLEMGg+z2UeTHy3elo12ymSVADvna6qKyeHPg8x2EqyDyVgJ/vl
         4vLQ==
X-Forwarded-Encrypted: i=1; AL+hErG1ONpOOjRdl9jl31S9MDxSLNgWhDAFSqYEu5m8/rMMPsqY+xg87X0mNxH75P47UK+DxxapEJDSbg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/zC+XhCpMOX4Vurnqbpivf7bpzSOTq2bFfYj0xDQw21Wwe6aqR
	C4e55q2oOEY16QMsPSVtX+MzDTl8NY1tXkCggd+/VCjfJaX4Ifz44EZnzHfZv16/ffD7vfQoI22
	zS3yVEOHDXPiQbblvpORDiZNu5dwgYb0rSHxNJxs=
X-Gm-Gg: AZFdTZeQY+nwC+DFuFv8ONKcB5VUzSAHWi48i63CrUMjkf58Xzs81kHVFjZAd3R6I+A
	C4Cg/slBfwFCWYCdgku435Vmfxqk4M3Ww/JRyvAIYBuJDQLIyVklNe8FmoRbqe+aYD2h5Gj2mnM
	wPj3PplGMLhOydJLCBbWDz0mcTMLr8gLiBFPa2C0NN4kWcwaEVfocFputaLVy+QTnLB+pCIZGhO
	R7mIFIPhIR0leK+qGV65FOT4J9dq78KXNJ4uUt4JhFs6+CkVrQfeb0fR+UuBrlXPeyKL2BwAuNh
	1JFUQvEKDcJyoF13eF8Xy7vROYuPqARXZJvJspVWBZgRnpaYjQNKl4Tz2fOTy/9uRdUYswLRjN7
	OKDlV6vQJ8bCdL8HUe0a+Tr8eMwNwttHegqJAVx7bEbyUdVzLXunZeh2JDBg0USSx/jMyiu1hhM
	KiGXXQ6mla35L9zM6niUrFE7TjJI0=
X-Received: by 2002:a05:690e:4850:b0:67d:ab84:3bc9 with SMTP id
 956f58d0204a3-67df42c4011mr1425040d50.5.1795261964144; Sat, 21 Nov 2026
 03:52:44 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-m3-cpufreq-opp-v1-0-42a0c07c48a4@gmail.com> <20261121-m3-cpufreq-opp-v1-4-42a0c07c48a4@gmail.com>
In-Reply-To: <20261121-m3-cpufreq-opp-v1-4-42a0c07c48a4@gmail.com>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Sat, 21 Nov 2026 22:52:33 +1100
X-Gm-Features: Aa3M54rZGK9MVhmV7coDk48If11yJyzjN2A4aBmkg_LQalyda1z1hSvlbjbiJKY
Message-ID: <CANpmGNvd3Bnv58BQX3UcX5eOip5Q0DfmPhvPp_9DGRQQUWOqQg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: apple: t6031: Add CPU frequency scaling
 and OPPs
To: michael.reeves077@gmail.com
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yureka Lilian <yureka@cyberchaos.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
On Sat, Nov 21, 2026 at 10:44=E2=80=AFPM Michael Reeves via B4 Relay
<devnull+michael.reeves077.gmail.com@kernel.org> wrote:
>                 cpu_p14: cpu@10204 {
> @@ -272,6 +314,8 @@ cpu_p14: cpu@10204 {
>                         d-cache-size =3D <0x20000>;
>                         i-cache-size =3D <0x30000>;
>                         next-level-cache =3D <&l2_cache_2>;
> +                       operating-points-v2 =3D <&everest_opp>;
> +                       performance-domains =3D <&cpufreq_p1>;
>                 };
>
>                 cpu_p15: cpu@10205 {
> @@ -284,6 +328,8 @@ cpu_p15: cpu@10205 {
>                         d-cache-size =3D <0x20000>;
>                         i-cache-size =3D <0x30000>;
>                         next-level-cache =3D <&l2_cache_2>;
> +                       operating-points-v2 =3D <&everest_opp>;
> +                       performance-domains =3D <&cpufreq_p1>;
>                 };

Oops, I accidentally forgot the capacity-dmips-mhz for these ones.
It's just 1024 like all the others. Can you apply that when picking
this up, or would you prefer I send v2?

Thanks,
Michael
