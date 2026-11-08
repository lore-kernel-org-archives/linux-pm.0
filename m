Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.82.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794154549;
	b=pe1Esu+iq5tcbexTCQ+SnH7mB/10b4dgIKKDQORj1hv6NKe9zsOZs3xS2lI3fjXP5ihW
	 m8gV+4VwVhKqaWXp4fAvhn5/0b++2mDYKr533CcQvDoaKyKvT88aMe2p+aRNZnnzaZeC0
	 FprkLmt8YZnGvkFngKmw/XYMtBKTW59bOdAty7DbGGKQ/baThMDvHHjbGZUIjI2cWiLdq
	 USBV9EqurdakE0qZzb+w/oij0y985+i7yajG8ff8J8+E7uKeVnJyAG8l9N5lCK9sdk9ss
	 GDsYYvsEaRhpY5GBQM924uXAgh34eaCBBP8HbxPQn7nGHCzHh1JleLT9b+ak8pR1vaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794154549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=u3cnT7HpHVl98z3Dg/6YlNkZdQb2f3LtCMLg/o0kNhA=;
	b=V5f8FQMrD+nGOuBrMD5FGNZyP2YhbFrC8sh5SQDGKi2Cdh4ykoqmCXHVRUXZuFQ8bXCz
	 cyXX4RJxw7wyfWxx8s2SG1dTbr/ipAv6Ehx7GMznSkhiN1zcTS4KwTySQzR+5+9KzPOh7
	 YzDu/+bYSqURU110NJkFyiHPjHwgg7BvaSc4dtrJeSmN6yzk7Vi6rQknPiPDfoCJbVThS
	 kKnyR3Wf9mF/URm8cYROAuShU1h3i2ouVnpPj/s5A8zjemyKkIAuFWeLMm7KKzQz8FOF8
	 yDzIoYKTKgO0lOJUY9GqED7GZu2Me86/5mhxZ4OWzcvSZ3LZfNY2jouA38JjkwCZayQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PatqLmUl;
	arc=fail smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A513D606A320
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 16:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A513D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PatqLmUl
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36f8cdd30beso380194eec.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 08:15:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794154548; cv=none;
        d=google.com; s=arc-20260327;
        b=h+b3ChYJBYJuMXWDmLeXbQf8ure8mz7Cbg4F3Cl5V7vo0ANsl+HNscftj6XYl5lOPb
         yYsVHhqGM9SKpkHUVvftHJZI3xQJ2M9n2HMHauFP80qkxyLsBqKWFGzW90e2VSaiIi3T
         OVQJgEmx4Z4b2vPpAEFJQzC+q85DVj5DdLPXXpReSg2Xv9WUaS+LCZKA+Mg9T8Mf57Ah
         krg/Aq1OnJvT/Ht+31egVSx5j307EiKKxymtuZiEr94hfRwZJeyZZJmzpfBQuLJziAb4
         7Q5zOVcCgJ1Maq/nPo2JLjlviRgJIF2B5hSnAMaEO2Qgtzj9ioHfGm3yUGN7BKh6tfZa
         aUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u3cnT7HpHVl98z3Dg/6YlNkZdQb2f3LtCMLg/o0kNhA=;
        fh=iGpJpY/WvS7KTrDBDcm/PVvX1kzZHXyTiPV2Fd9DMy0=;
        b=AWs/DvDdgGhbZsAPLoHPQ7iXQKr9Qb4uJf6qyhnIQEMj8ZLMZINqqLCnRcwGUH3sAJ
         6uoiqpHlaPsoe3hIiuki20fE/HxaCgnfFO12YyipnHRaGk3W3OKL/NH/mRYafXzAPjsT
         PXqbkv3Ej3kF3p6iOuT+IvvadQGixL+AksVIIvUEmR/dmVlVeXlivn+o2W0fqA3vuDOq
         RNdMSsDFHyixQn5Q5La9emDlkFjh+nnDi4/4eB1TCFwGIvjFrjidQg4MN+Xlcs960dh0
         jYg5n3581YhzIimFDJuuIUrTJ56r52yfu+cMeKSMO5bQkb2+c+tuIDHjTYeo0Dg+cJNZ
         NW1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794154548; x=1794759348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u3cnT7HpHVl98z3Dg/6YlNkZdQb2f3LtCMLg/o0kNhA=;
        b=PatqLmUlhcvjr6Th6h7fA+Sym1vHgKml03Doo1jlKHnHeZDTWWxnbC7h7HNiWZKpwQ
         Yad5xKEBBB4vUU4MQl6TNwLj+WL9m3VAYkihbU3kIvCSMk5+CtvUc4qXLnZ3d10I0fB7
         ijHpX1q+Ek/xXaBm5iRQSBvSahQoAJ6IbEmoMt5q3FCzVUe0DzqGyzvESBZ0cpFK9xoX
         c/KlsxgU4HR90Qy7ZGCHi1wtD92JaqSHdHp8MnEcjIx+kmAEEcLtmWcyIfjdU9qU14WG
         hFmGRrMRG+MPaCmOsaa6O9BTEVjcMJcIhCsUP9KrUtCNyhEGhXZjJEpSsRt3NiR1WkYj
         iYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794154548; x=1794759348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3cnT7HpHVl98z3Dg/6YlNkZdQb2f3LtCMLg/o0kNhA=;
        b=qCI5G1X/QmqL/QjVhsZ/B41qk8RYTGLzJzbzNx0w6szzoTIa9lCMjpWK+iACnsC+7B
         6bUQ6QowvpiaHmAHxpimrSvOrLwXYRAUb66lnaaIjAnbfy8cfUT6GjpJ5euy1JQvLIwC
         /iY27P1YPi+/ckYQ3L9bk0uHAmx8vOmNQ/lbTrp3LCQTy9zZc7+0qa61i0JPs+ehA3z3
         tY9ngwwLVsFV1oZX6GvNJCe1bmjd27AWCBZGPgVzeIKDMYfTKPhvkpr7XFVZMYnor8Vr
         M1/cIpfu9NzAdGpWeUXlSUvjo8Rp+swhM5Lf+dOt7unOCVEUaRA2JOeuP35ltlGJttQa
         1U+w==
X-Forwarded-Encrypted: i=1; AL+hErGHOAgahqlp0690Ck29glwF1moe26QshgHzrnzxcu8eKzTVetCUwjGrhFy6bBpsTFx23MA00Iu7rQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+a955ONJ6+ZI8TWTGngeKiuSihz2MBMJ7KIghEYNtVVPkJ5Kaf
	wJk128v7lF1kUVq8PTmkyqB5u+euNxHQVd9YZyjd3030dadBBMhxkCGY8OgzFzzmsp3hDFYyVnR
	iq6sB8U+SR1jS4ZrIRs9DikwBjPHm9h0=
X-Gm-Gg: AYBFou0bTV0Xg7hmWvzh33JfVSWtjZ34nDCu6BJwL7zyZdv4AHhmlbwjv3RZEiEPJ6x
	QO7ibtgEL/VxAGcUlJWLKfLx9d7ai1vMz1c42Yqp+WrJ0GRfMPXqLU2NC4MdeFx3Tq2rddVY51E
	6IA1ADNDZJAQpk/c+r26fTRoLm98TNvle2sHvMmgXRYNpBWQoGHjPCkD2cFaQw7ZfC/JBd7lEhb
	vrMwZH8PskLRbaMz5K5RElDvaDVZDlIijMoSmAo/iHsRliqm/ADwaSEkkFqbqO7KvV3Rx73Af3e
	ZACkGSB0ZwYw5JOVGB/Zas2ZmPn4TCHlYqA5Nc7KA++LB/6we+Ju6l6I9bZGhhad8jylw8v1o/j
	Pt2cZHWGnNWin3LKlGI5c5J0pjVkhzcdYpPhoGwy9H9PRci+51x2rUTBE0thyQ40f9vthUTPUB6
	gqxeOZFewba5B45hRA8cc5Y0dMDGbX5g==
X-Received: by 2002:a05:7300:87:b0:361:7ab9:479d with SMTP id
 5a478bee46e88-3725e34086amr3043054eec.27.1794154547628; Sun, 08 Nov 2026
 08:15:47 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108154241.198160-1-huggek@klattorp.se> <20261108154241.198160-2-huggek@klattorp.se>
In-Reply-To: <20261108154241.198160-2-huggek@klattorp.se>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 8 Nov 2026 18:15:36 +0200
X-Gm-Features: AclHuK9_E5rFWHmjd6VJiQbI5thChlB3L-K94emAWszn3iblcbzKAB-4qYiSIQY
Message-ID: <CAPVz0n1mr22nZkHuYSe1pzwv-iQqAKC2Cuhx9W8nibf=-BXU-Q@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/3] power: supply: max17040: pass the device
 fwnode to the power supply core
To: Hugo Karlsson <huggek@klattorp.se>
Cc: sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	matheus@castello.eng.br, me@iskren.info, krzk@kernel.org, 
	m.szyprowski@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BD=D0=B4, 8 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 17:43=
 Hugo Karlsson <huggek@klattorp.se> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Since commit f4b782af61ae ("power: max17040: pass status property from
> supplier") the driver forwards POWER_SUPPLY_PROP_STATUS to its supplier,
> and the DT binding documents a power-supplies property for naming that
> supplier. The driver never passes its device node to
> devm_power_supply_register(), however, so the power supply core cannot
> parse power-supplies and the battery never gets a supplier from
> firmware. The status lookup then always returns -ENODEV and userspace
> sees POWER_SUPPLY_STATUS_UNKNOWN.
>
> Set psy_cfg.fwnode the way max17042_battery and cw2015_battery already
> do.
>
> Fixes: f4b782af61ae ("power: max17040: pass status property from supplier=
")
> Assisted-by: Claude:claude-opus-5-5 [Claude Code]
> Signed-off-by: Hugo Karlsson <huggek@klattorp.se>
> ---
>  drivers/power/supply/max17040_battery.c | 1 +
>  1 file changed, 1 insertion(+)
>

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # LG P895
Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
