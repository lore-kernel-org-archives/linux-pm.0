Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795193588;
	b=n/RJUPkYcjbLue2IaO3U2+epQPi1T5axDTmKgWCxU7AKKzV8aCIWp9Os+2cIUQd3vy8v
	 hYljzPz5u3z8+xclf7ypE++6EEB230+Ihdbjx6RWD45JqdjIQwWLID5RHkl3QA5cP+vTr
	 6wAlGS0RfhQ9OKb8/DzM7SIcMbb6Iom/SukaIilxBv9mDu7PDEl/QhW7jitFK/T/JC7Nd
	 Wo+WdO7A07xejBzNFK4+obXI8cGWsvnSNFAzsb2wtRqJnpWWQjO9HezER4n9FLhGDtt/s
	 10o914j0RSLd77QYQYioYbXp1ztCk2iN4hp8v92SteFW1wbhqnjpNz6mEUn+qyFnCzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193588;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=A2nLq6am/T/zNwphpbaOffHi5KxUqXtUM9OeXv+xYRE=;
	b=XWs5Y9RgUSFx4Tl8/9dIdmVYRMfCZX0cYU3fF9BwcGUi0B0bjsZR0zZwfBEZdSz1tg+u
	 ayBv3gwMCYLm1Z8JNWTlKpEQOXPgXkM8IYWyH1gGgNJOQO8503n70ZexGqBddpMA3lytm
	 U8iWMLsS6DTqy8ZSce8ey9nkg/FmbUsyiVJWzt/D4A36cxPDeELK9TgTWL2w1p0DxD/Kg
	 bKi1t55jLIkpklGBQYZ4Xg80KenHewLiI1DqSx4AvteVmNtwyrUwQrn8DFILvzwoPjMN0
	 QjTuJvTm9+fAxyHdreYdHD4BNsLEOprfqm4ICi7G514TYCww50AkFvGjPHyRzpwiiKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcJS42KG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E358606A325
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YcJS42KG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631951F000D3
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 16:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795193587;
	bh=A2nLq6am/T/zNwphpbaOffHi5KxUqXtUM9OeXv+xYRE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YcJS42KGCGCOoF6/uHN1RQidhqQwiBy145eBAxwxierpntbvxSX3vdpviAtOOQpAV
	 qEwFjik/t9YX6YG8BIxCFqzwwxWmkHUtJ6eSh0WxSAJCE6n/+fhsdMYtDv8W2EdqsX
	 M+QU40GGN/oZnfQhm3qOHEAeW3quqh2DS8PSxWibXOEebfsSqy/x5z0oZd/Dh5Iyib
	 yrAJgVXFNoK2OwTepuf+ODS+mURbIeJPggijiY+L8WHcO1GXFa7e+y2JtG7b7lP5/q
	 GO29Emhv+8z5oTooi8fxUPp/IJY4uGF2ex7gxhz9/yPtnLoHpDbvvX7uVJ5bOq0CWG
	 AbMqkCSuJizzg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso1380974e87.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 08:53:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHrOpb/et/DR+seB5Aekhoz9TaasdhkW20+UsDFrmQkxWdXjTWM0gbKxkdt+975EGzZKEuAwK7VXg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8v6Ku7oo0DNSop2WVWny1Ln2dfI6DXRjyIbjH8zBsa0RkbCcRN
	PVPYqsXM3as3HpCm9F57s5sTdCNNMgKpqwZgXIaNAuA0pq0bdhQKNuOlvzVyd8nZAKIgoqFfmWd
	g4vop3b+R9Cr6nYo477aeY1d7muK6EoM=
X-Received: by 2002:ac2:4c4e:0:b0:5bf:d063:608 with SMTP id
 2adb3069b0e04-5c1bc7bd46emr1186381e87.17.1795193585853; Fri, 20 Nov 2026
 08:53:05 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113072621.2285-1-gubin@cmss.chinamobile.com>
In-Reply-To: <20261113072621.2285-1-gubin@cmss.chinamobile.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 17:52:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jqzVYLck6ujV4jc2=Mkf-BFeCy=7dUX-FaZfZ8wMJyJg@mail.gmail.com>
X-Gm-Features: Aa3M54oXMmrxOpu8xOdOOB6acVvkJkOq-L8oVEyl4twYOeTba7QaRyxboJG3ic4
Message-ID: <CAJZ5v0jqzVYLck6ujV4jc2=Mkf-BFeCy=7dUX-FaZfZ8wMJyJg@mail.gmail.com>
Subject: Re: [PATCH] tools/thermal/tmon: propagate fscanf failure in sysfs_get_ulong()
To: Gu Bin <gubin@cmss.chinamobile.com>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, rdunlap@infradead.org, hemanth.selam@gmail.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 8:26=E2=80=AFAM Gu Bin <gubin@cmss.chinamobile.com>=
 wrote:
>
> sysfs_get_ulong() always returns 0, masking a fscanf() failure, so
> find_tzone_tp() cannot detect a malformed trip point temperature file
> and reads the uninitialized temp_ulong. The sibling sysfs_get_string()
> returns its ret.
>
> Return the fscanf() result from sysfs_get_ulong() and have
> find_tzone_tp() skip the entry when the read fails. This also makes
> the check honor the "ignore 0/invalid trip points" comment above it:
> previously a failed read left the caller-dependent stack value to the
> temp_ulong < MAX_TEMP_KC comparison, so a garbage or zero temperature
> could be counted as a valid trip point and later drawn as a bogus
> marker in the TUI thermal data window.
>
> Return 0 rather than -1 from find_tzone_tp() on the skipped entry so
> the scan_tzones() loop keeps running, avoiding the early break that
> would leak the remaining scandir() namelist entries.
>
> Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal s=
ubsystem")
> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>

Sashiko has feedback on this one:

https://sashiko.dev/#/patchset/20261113072621.2285-1-gubin%40cmss.chinamobi=
le.com

Please let me know what you think about it.

> ---
>  tools/thermal/tmon/sysfs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/thermal/tmon/sysfs.c b/tools/thermal/tmon/sysfs.c
> index 5d64aff12a86..7f1e38276254 100644
> --- a/tools/thermal/tmon/sysfs.c
> +++ b/tools/thermal/tmon/sysfs.c
> @@ -70,7 +70,7 @@ static int sysfs_get_ulong(char *path, char *filename, =
unsigned long *p_ulong)
>         ret =3D fscanf(fd, "%lu", p_ulong);
>         fclose(fd);
>
> -       return 0;
> +       return ret;
>  }
>
>  static int sysfs_get_string(char *path, char *filename, char *str)
> @@ -167,14 +167,15 @@ static int find_tzone_tp(char *tz_name, char *d_nam=
e, struct tz_info *tzi,
>                         int tz_id)
>  {
>         int tp_id;
> -       unsigned long temp_ulong;
> +       unsigned long temp_ulong =3D 0;
>
>         if (strstr(d_name, "trip_point") &&
>                 strstr(d_name, "temp")) {
>                 /* check if trip point temp is non-zero
>                  * ignore 0/invalid trip points
>                  */
> -               sysfs_get_ulong(tz_name, d_name, &temp_ulong);
> +               if (sysfs_get_ulong(tz_name, d_name, &temp_ulong) !=3D 1)
> +                       return 0;
>                 if (temp_ulong < MAX_TEMP_KC) {
>                         tzi->nr_trip_pts++;
>                         /* found a valid trip point */
> --
> 2.55.0.windows.3
>
>
>
>
