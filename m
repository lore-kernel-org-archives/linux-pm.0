Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340882;
	b=NZtrLCA9utkDlK+0AKN7ZpRlYXPdu7VmnIx2cSgw5a2T30HVXmuZLI8RNhYiY5XCO5jY
	 Dcd9qbM4k1xe7nRlXbxKiDn1jkcd3l9uniHxoBb+tDnstFr9UdGzpw2XN1XiIE0zX199G
	 RVkRAggcgucyzeTUVhxq1DM+1PVPYoGYBHHlcS0wuLtBF1WgD3No3nG0qvNT/0ifXqYnu
	 nolxtX5dKisEE7HqB9+9P04GJG6UEpFla3jfhszsKkwalbYr8sR0Owla1yPvSjnVQBVwT
	 SfyBUSoKRPK/EfCWP89lynWT3dw7Szra5EeE/CCOLe/FDa0YXGL5gVO0W7gqUjdyduw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340882;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=D9z0hUJMabcU8YBNpOYZdchyxPfKbVjxxRlkMtSmlg0=;
	b=cDckygsv3R5dXDnR69ExmjfIhWSTJHFCV/RxwPJ+ocePh46hqtAnAmZOTykXrdQUAG8E
	 md3Yc8ayrSLX1+OaEee9Thlg5G3MLd4C5NCOUJxOJ+E7RkvAmz0x9vNtTS+3XcfVWqrjD
	 FDw5fJyLzVauos7gJzcnEO+3HkEI0F2UZ2cj/T6qcOkAW4x0NnEBVE7eLgiIi9jHlK+DA
	 5jGGpJ30/wM4Wy32TTb42IdsdOFIEftt8TRdAMAms1ZSJmsJroZhOrCmipCHxacMNIdia
	 yvMAPDjez1OQ7KNTnGyA3vyy+uFsp9GrkqOLe3AfNKBZUoFEKER3+/BUhxG3HUYDUMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzKn+XqP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59CC606A320
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OzKn+XqP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C691F008A5
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 20:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794340881;
	bh=D9z0hUJMabcU8YBNpOYZdchyxPfKbVjxxRlkMtSmlg0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OzKn+XqPRV92FvSgh7X5useqpv/drr9LaxR30eVR951fjBgEdDLvJAWk9ugstA2WC
	 O72uRQE43XNW9wtsRHxjR6Z4pIM3WAKJxF1z7ZnCQMd1GO6HP1oyUZCdeuj4j3Ua/I
	 7iKC+jfrEUQWD2vY4wuLZJ7UzIe/alwNvE/NreUEQoGN8oX3zplJl2dJQRfE69zv9e
	 n0DYdZYrMHbPTIwTCdqkik3bFHpt4Qs64Klj/Yc+UjBHbtdmMtmnm9ByyGUkLqRrwG
	 rTx8D7M6KrF4j0M2r0BoZpDb4FW86GRhWOw8LbrzV6Hb+X7ZRxN6n1XhVW8OSFyGlJ
	 EASdQyix8Uz6g==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bfa65c8617so1447016e87.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 12:01:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErERfQ/zioeGHMN/N3iz2rgnTQDyQRaU5MrLBBVaqMOCZb5soKZFV3x6GxkR2mcSCdYhSdKtuq3P5g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+IH3wcBe3G2J2LRsNWxZe6ATeghIptkFtg1owyNSqOL/UqfatO
	tSrkoHc9usw9saRbmJBrO/pFHLl5vcdXCCyWQnKFs+P80Jwn3FcsgmGLBal8QNHqfoNvb+bjuUW
	gt6h56kjUS/F8H0SI9SbLmvxw1kQDXF0=
X-Received: by 2002:ac2:5686:0:b0:5bf:b994:5f91 with SMTP id
 2adb3069b0e04-5c15d643ba1mr49174e87.15.1794340879856; Tue, 10 Nov 2026
 12:01:19 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106184008.1728-1-lirongqing@baidu.com>
In-Reply-To: <20261106184008.1728-1-lirongqing@baidu.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 21:01:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gHXCKvvHPXevx4U5WSVsS91Z3WuiMCwiYSQzQBEB5jNw@mail.gmail.com>
X-Gm-Features: AclHuK8yAa0We67mGYcCmtxqAz4cYCS5W1KgeKUgqW5tPPUQLUeK9Og0fALrKm4
Message-ID: <CAJZ5v0gHXCKvvHPXevx4U5WSVsS91Z3WuiMCwiYSQzQBEB5jNw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] cpufreq: acpi-cpufreq: fix P-state index mismatch
 between perf->states[] and freq_table[]
To: lirongqing <lirongqing@baidu.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 7:40=E2=80=AFPM lirongqing <lirongqing@baidu.com> wr=
ote:
>
> From: Li RongQing <lirongqing@baidu.com>
>
> policy->freq_table is built by filtering out _PSS entries that are not
> lower in frequency than the previous one, and the original ACPI P-state
> index of each remaining entry is kept in freq_table[].driver_data.  The
> index spaces of perf->states[] and freq_table[] therefore differ, and
> mixing them up leads to the frequency of one P-state being attributed to
> another.
>
> Patch 1/2 is unchanged from v4 and fixes the cached frequency used by
> get_cur_freq_on_cpu() to detect a firmware frequency change behind the
> OS's back.
>
> Patch 2/2 is new in v5.  As Rafael pointed out, Sashiko observed that
> the extract_msr() fallback interferes with 1/2 and can render it
> ineffective: when the status read from the hardware matches no
> freq_table entry, extract_msr() returns freq_table[0].frequency instead
> of reporting the status as unknown.  If the OS is already at the P-state
> corresponding to freq_table[0], a firmware switch to a filtered-out
> P-state then compares equal to the cached frequency, data->resume is
> left clear and the next ->target() call does not rewrite the control
> register.  So 1/2 alone does not make the detection work in that case,
> and the two patches are posted together rather than separately as I had
> suggested earlier.
>
> v4: https://lkml.iu.edu/2609.1/07369.html
>
> Changes since v4:
>  - Drop "cpufreq: acpi-cpufreq: fix P-state index mismatch in
>    extract_io()", which has been applied.  This series is based on top
>    of it.
>  - Add 2/2 to stop extract_msr() from masking firmware P-state changes,
>    as reported by Sashiko, and note the dependency in 1/2's changelog.

So Sashiko has feedback on this one now:

https://sashiko.dev/#/message/20261106184008.1728-2-lirongqing%40baidu.com

>  - 1/2: no functional change; changelog extended to say that it fixes
>    only the cached side of the comparison, and a duplicate
>    Signed-off-by was removed.
>
> Li RongQing (2):
>   cpufreq: acpi-cpufreq: fix P-state index mismatch in
>     get_cur_freq_on_cpu()
>   cpufreq: acpi-cpufreq: don't mask firmware P-state changes
>
>  drivers/cpufreq/acpi-cpufreq.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> --
> 2.9.4
>
