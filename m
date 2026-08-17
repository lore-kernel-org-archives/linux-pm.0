Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2690D3F23DF
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 23:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787009125; cv=none; b=J1TphOMolMCh9aPp+M23dGkmpCJizVve8384DURHYP9+3ugjtyrPI/yqESgy7WkE8Pfe/5RYUzPnOL6yo1oU/+B0wI3meWfiBsARDQbUd/WU45RoULTQblDkGG43eKLUR3U4tLF3cD1SyRkuqfCX38PM+mQNAOsG3Ypu4XxduPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787009125; c=relaxed/simple;
	bh=Fx7brQgcIeakkb1m+MbAbK/FKd7Bp8bU1a2vfFqHV00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1DOu5z3HoH4LP5anc5x650rOSztDjj2R0U12Qj/3OWQbWNsUMSglpyepUq+lGVs6LquLXibIH4gKmIpXN+iI6yyyHoSYUdPinJ+26E5+DZdG/bQ/d28SDicHoGue3ju8ILbFtGVpBBQxhNyuM3v8PszChRdOQqU6stTVeJqICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrUEQM/A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrUEQM/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EB91F000E9
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 23:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787009123;
	bh=mwAQ3jRzSAca4KNvR/m/1+BHFxtSKk0t5Qbu87ee45E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RrUEQM/AW19Cc4oPkHK03SP496egojbT1EiCPdkKhSfk66toGQ90seRbJad1+5+nF
	 8LYtEyneDjBj8QcX8vvjTQouHwr90t4XatBBpqhr0bLu8vRThY7Srmi4MZzAfXhZIO
	 Mles3G18wyDGag4zs9Exymk9g/ZgcWZNoDJlfFSQV49J1Celw806YcwXp2qW57vnok
	 S1CTOy3RDJgwP8oKfkRTU51I9hTPO2JMsjqPFR3GRNctU+gxOG/yWdWXOPDVDCiOt1
	 kVz7KhB/4sP1Y8Uy4M+0x1uIcHQgUsnjlmTVzPohaVsgc8W6kH4FRr790dsvPBgSdh
	 Qyqkv0KTSMw4g==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c197e7e4e94so684877666b.2
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 16:25:23 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzjc0Nl9WNSgXoYyGokvo6JxtH2kpppu3/QJLg3hrsKipfVGnfu
	iicv0gJ3bBloctNj2bnfLaFpjUAOMVbh6iHR4blFtXemDrumej8OkRollZPQ+K33RCebth4G2aI
	cu2WTXmqfpnUfJnLO+VOVl3PFuLaIcg==
X-Received: by 2002:a17:907:3ea0:b0:c20:af9d:454a with SMTP id
 a640c23a62f3a-c216bbc2660mr615832066b.16.1787009122362; Mon, 17 Aug 2026
 16:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612215009.1884665-1-robh@kernel.org>
In-Reply-To: <20260612215009.1884665-1-robh@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Mon, 17 Aug 2026 18:25:11 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+zBQrAf0oRrJ178X9UDum1gsbpUKgMsyiPsPZZyXZDBA@mail.gmail.com>
X-Gm-Features: AcwNN1XrBgA8iTvbeGX4GXX0GXBwkjtHopHYnWXKuPHJBTHWjN_qgQfi4rBPvB0
Message-ID: <CAL_Jsq+zBQrAf0oRrJ178X9UDum1gsbpUKgMsyiPsPZZyXZDBA@mail.gmail.com>
Subject: Re: [PATCH] thermal: of: Match trip property helper types
To: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 4:50=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
> The thermal-zone binding defines "temperature" as a signed int32
> value and "hysteresis" as an unsigned int32 value. Using helpers with
> matching types avoids dt_property_check mismatches and preserves the
> signed interpretation needed for trips below zero.
>
> Read "temperature" with the signed helper and keep "hysteresis" on the
> unsigned helper using separate typed temporaries before storing them in
> the trip structure.
>
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/thermal/thermal_of.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Ping

>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 99085c806a1f..196cb29afae9 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -63,22 +63,23 @@ static int thermal_of_get_trip_type(struct device_nod=
e *np,
>  static int thermal_of_populate_trip(struct device_node *np,
>                                     struct thermal_trip *trip)
>  {
> -       int prop;
> +       u32 hysteresis;
> +       s32 temperature;
>         int ret;
>
> -       ret =3D of_property_read_u32(np, "temperature", &prop);
> +       ret =3D of_property_read_s32(np, "temperature", &temperature);
>         if (ret < 0) {
>                 pr_err("missing temperature property\n");
>                 return ret;
>         }
> -       trip->temperature =3D prop;
> +       trip->temperature =3D temperature;
>
> -       ret =3D of_property_read_u32(np, "hysteresis", &prop);
> +       ret =3D of_property_read_u32(np, "hysteresis", &hysteresis);
>         if (ret < 0) {
>                 pr_err("missing hysteresis property\n");
>                 return ret;
>         }
> -       trip->hysteresis =3D prop;
> +       trip->hysteresis =3D hysteresis;
>
>         ret =3D thermal_of_get_trip_type(np, &trip->type);
>         if (ret < 0) {
> --
> 2.53.0
>
