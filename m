Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195712;
	b=hbKa/PHLvgsLd/08LrwYQ2bu4O7fbG3vx0EujKBvLbRV9bU3rb/YP3JLB2iA/5EawfGe
	 mEIkb8tlgQX6dMPkBs15zTr4KwHPcd5Lr40lNpq5sWQmxruecEKZPH2XSJGGrGhWqJQJx
	 sVoPJRF1VdKsBQmBrcCHT2SXMjBZ6/xmzlbmBMRLZsDMwHXodqqMw7MUOBhBOC/SSk7W/
	 FSjPgHudA4dsazPgVxGGWIz2KZuaBfUT+qI8xlME1kJsrOXOtPkvYm8deItBu9JRksjuD
	 nYoa51YYmL6L3ODcnUS1s6JV31aqDCxKB0E3ZB0FjsTBmehF16J4YIXu5koTgdOTbRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195712;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TTjwlzw6aVAR3tSaYaZGcthnRSIUmYP2w0NYxrZBGTo=;
	b=dSwxoBJVVVcSFwyPgiBEodOC3iwI1Q6CT7so01rGhM4DKl0gHKzvoFUlogmU3psNQY7p
	 Kxkm6vbI+3o9wq+jO5/noi19Z4QMFP1qI+x3/peCdZzw0yeHZIu6l6mw/Tr4lh4X5/uPH
	 J25IB6aXeNcic/TWw2Ah/W27kATvDWJBGHjJUMsexX6QxtcIDWyPw4PrMLGgJ/YbRIRdQ
	 OLjqONO9gGRIf6hC98HLhUNQJnKX1HgjoV353CYoa8hTWOPj/rJUPNOWC7kkvEhYow+Mt
	 Wnh1NLJxHlWSCWBMFBdnDIAWDic4iakkEU0+XeH4hpISf/nyhCd8IonIW0flrfabPAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxGU6Lv+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADF0606A320
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxGU6Lv+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F116A1F000EF
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 17:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795195712;
	bh=TTjwlzw6aVAR3tSaYaZGcthnRSIUmYP2w0NYxrZBGTo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HxGU6Lv+8I6myr7Ottn18Byrzv/XjL1FNZGiMZfQxJpc40hiKtXroviW16ZdRhD04
	 b9iRN69Pw2WPoN3HIVfTlhCtsTBaSGvmL6aI5Jje+SDOMmIUnshHMFYlU5T9PoxpPe
	 pb0yzVlJcgQ6LJBzsFvrqkRmkzuXbda/7jNTmYQdXOcWJYwDsIouiWOHaolUMLZmzU
	 Cmb8h7c6+EH1J8EJovWJ7Ld3NkazEpRQ+0FGBlgwwu3WA7ulBUSuqEqlmiQWSNa4pj
	 KBqVPCeD2NwMxtTMr0qGJHj1cS77I8r3aR0DZfgO6V+uHmGxyIN1Y+ogAVFUKngOPH
	 epkXrV92a0Buw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ae854fd0f5so6570311fa.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:28:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG2gVkObj9EoxBP1u9A2Oj4qS/Hzgx7seQtZXn8DegqvTirNsn3YfrFO43XSweRgb8fP7NI1gVieQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/0Sou0Lnn6RuYyLHo5vmAxNycVBPKgcC/tpZLG0DiWy81sEdKc
	pCSy5epTooyMRAC1COwKGs1jRdJDDbad3BSV/YqOQ5yqD4d6dJpf608BLmkSVCZZWFNprZjE6XW
	OExo+oS97+O+ZLzZUM7PL+dC2ieqorjE=
X-Received: by 2002:a05:651c:2214:b0:3ab:41c8:fc15 with SMTP id
 38308e7fff4ca-3ae7f9d964fmr11430651fa.12.1795195710365; Fri, 20 Nov 2026
 09:28:30 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115172951.35889-2-thnkslprpt@gmail.com>
In-Reply-To: <20261115172951.35889-2-thnkslprpt@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 18:28:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j_a2WoMF7vcMnz-2sS_Be5Bi1XxHaK0-vHJKTq164Gcw@mail.gmail.com>
X-Gm-Features: Aa3M54obVrie8t2J9JHycOwamMXwlteXnovTfy6PHZAtEtSti6k0PE0MQyM1MrQ
Message-ID: <CAJZ5v0j_a2WoMF7vcMnz-2sS_Be5Bi1XxHaK0-vHJKTq164Gcw@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Fix partial snapshot reads
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 6:30=E2=80=AFPM Avi Weiss <thnkslprpt@gmail.com> wr=
ote:
>
> After a partial read, snapshot_read() passes the remaining page
> length to simple_read_from_buffer(). The helper interprets this
> length as the total buffer size and subtracts the offset again,
> causing premature EOF while image data remains unread.
>
> Pass PAGE_SIZE so the helper accounts for the offset only once.
>
> Fixes: d3c1b24c50e8 ("PM / Hibernate: Snapshot cleanup")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
>  kernel/power/user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 6e4f40e49319..d5e2b8d0b55b 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -154,7 +154,7 @@ static ssize_t snapshot_read(struct file *filp, char =
__user *buf,
>                 if (res <=3D 0)
>                         goto Unlock;
>         } else {
> -               res =3D PAGE_SIZE - pg_offp;
> +               res =3D PAGE_SIZE;
>         }
>
>         res =3D simple_read_from_buffer(buf, count, &pg_offp,
>

Applied as 7.5 material, thanks!
