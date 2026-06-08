Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171CF3AC0CD
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926413; cv=none; b=ZJOnLzkxDc+g2gwO1vCg6U1syGfLS1Zt4HefVZqlRqOnKIeWpjK2/br/gEuvf+uBGPLHd3/q/wqJuExAsN4C8EM84oKGuDBC3ke/+OCiGTbFY4MPMYsQ+PyirL3h5VmOTRAtMX1Y/1udu19w7AdDz9g6HPN6V1LEm1qLCDuPjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926413; c=relaxed/simple;
	bh=P/8Khx7dACp7YT+Da6YFXaqMZIiqDEyv6CrRmIawq1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5bAOzt4h/iArzauMLZ4E/lPXZ3RaAz9LVpbNGH1b5j/ooKNGO2h6qM/Zn0sqVsG086H4lv0HD7ByfZ1KyLXTwihWtp77QYvx3owrJblWr12O0T4v4ebwE9WxWK2WBuJ/+JgyKWrnd23Rs+muGBsgGRjqmpCHckGRq/JZYasHD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jl0sDoBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jl0sDoBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41051F0089A
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780926411;
	bh=T9Qqh8GZIF6Q6VRMI7WzHyxkyZicu6b8pVE06L/+fpw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jl0sDoBgOJB091pO1xzArod3DRLM0YROHZ1EDpxbRIMLx0LpacNRxWp+PFW0e5nNW
	 CPxZVZfHRx3wrBw7j3uS8HLschWux742nf1zhYG96H7Td5boxshNT8hC9xzQKH6Oq3
	 EbyYhbXtUN9KrPJB5YqcvPXuJW5qhWZ1EqCzNgggT2H+cvZhQkb+hQloNRS/Xq+pEK
	 GgMB75VDMxw5czQ8Kq5TnKk5563r0sOFGv4VNPdVftjnP1ay6RfF6sh6KWkbq1AlxX
	 p0nLtavnnKCuffH3f4OcnvMNrCGznstJXcOiQ/o9R70AOY1PmV3JYsVdx1mezbNWlw
	 77i4co2NOsUrQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa68d7d757so4672584e87.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:46:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8YJ6524bjrcGMyxZB9ToMbnmAUyvMS9M2Fk8i76TZtZ8FamKjDQyuWyAl1Cs+b+FGXgkfxPneKWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnWY9gdpkRISZ64FnXtWoDVCRS/zGfNIAodBjcpia1m27SBBYW
	gNkBp6Y6MjMTQ+/AlMsSB/OD10pSsnIyVzhQ7TSBZB+NcLsb6LjUY8/ce8kS8nLTkzsnX2f7fGQ
	5KAgRmMrw4ntYEki3dsEz4fZ/Z4ONWAA=
X-Received: by 2002:a05:6512:ba5:b0:5aa:63a8:c78e with SMTP id
 2adb3069b0e04-5aa87ba43b0mr4203405e87.15.1780926410081; Mon, 08 Jun 2026
 06:46:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605185212.2491144-1-sam.moelius@trailofbits.com>
In-Reply-To: <20260605185212.2491144-1-sam.moelius@trailofbits.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 15:46:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hai93VgBcT5M3Z9XLkW5CFA9M2+App=tSHrCxK0_pOiA@mail.gmail.com>
X-Gm-Features: AVVi8Cfjya8x8gvms4I4_hqdDGXlRo1N5P_tI8wKlAlpo2sMdouAfOHxd0YSAQ4
Message-ID: <CAJZ5v0hai93VgBcT5M3Z9XLkW5CFA9M2+App=tSHrCxK0_pOiA@mail.gmail.com>
Subject: Re: [PATCH] thermal: testing: reject missing command arguments
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 8:52=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> The thermal testing debugfs command parser splits commands at ':' and
> passes the right-hand side to the command implementation. Commands such
> as deltz, tzaddtrip, tzreg, and tzunreg require a zone id, but writing
> one of those command names without ':' leaves the argument pointer NULL.
>
> The command implementations parse the id with sscanf(arg, "%d", ...), so
> the missing-argument form dereferences a NULL pointer from the debugfs
> write path.
>
> Reject missing arguments in tt_command_exec() before calling handlers
> that require an id.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---
>  drivers/thermal/testing/command.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/thermal/testing/command.c b/drivers/thermal/testing/=
command.c
> index 1159ecea57e7..fbf7ab9729b5 100644
> --- a/drivers/thermal/testing/command.c
> +++ b/drivers/thermal/testing/command.c
> @@ -116,18 +116,30 @@ static int tt_command_exec(int index, const char *a=
rg)
>                 break;
>
>         case TT_CMD_DELTZ:
> +               if (!arg || !*arg)
> +                       return -EINVAL;
> +
>                 ret =3D tt_del_tz(arg);
>                 break;
>
>         case TT_CMD_TZADDTRIP:
> +               if (!arg || !*arg)
> +                       return -EINVAL;
> +
>                 ret =3D tt_zone_add_trip(arg);
>                 break;
>
>         case TT_CMD_TZREG:
> +               if (!arg || !*arg)
> +                       return -EINVAL;
> +
>                 ret =3D tt_zone_reg(arg);
>                 break;
>
>         case TT_CMD_TZUNREG:
> +               if (!arg || !*arg)
> +                       return -EINVAL;
> +
>                 ret =3D tt_zone_unreg(arg);
>                 break;
>
> --

Applied as 7.2 material, thanks!
