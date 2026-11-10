Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340297;
	b=S9W/rttiV5GH3BRbxirM8Twkqy3/0juQl8NVAREBJa7EeggN6POd+Ir9VfHAxvXix9YG
	 SnX0weyDGf/bQxdta5hUSFKmIS5IHuPLDp7Mb5XN3CuIN3md+SWpEmn8HTIsG5qPsuXwC
	 zOFhxeLL1wwv6iXMB0djDF5hAQnsLD5A+sffyxccieCddxzngGpcpaeygtkACOkQKtDNs
	 FA1KFUnx7yVx1Ul4WQjfJdLoY8SAO/u/MeC63e3RN4D5KeTtbcRkm+E+FoJ0mfidg0ui8
	 2yiEYRga+YYqBdj/t30Cpkf0a/y0W1yEm/MiNYABCdIil+5K+dYuyzSUt+Q7qQQMQiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340297;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EoaJJOwcscDH8OHCgu1SVsadAtlXJ+GnM9q74gYtlK8=;
	b=Tqz0zDAlTVs5Rx7uaF/bRo/bLMfNbq1RKKcMsAO2BsTKVsJUYGRC0Z/twEtIAWD4l5Gh
	 bsHEZyGjTj80FpatlUs9BcdzVfBlj5nu7H12+6r18iMzXNGa+Z3pWiXN+8bSdveTHizYv
	 qSQiomZbZoe9J4sgR2ZC1hOa0ec/CT3aaHmjgVSspH+6u4cfj78c0YCa2+i3hm9DjeczT
	 eqhnoB88tU73Oq/sWNLId4IHoz2Zj5qBDoOedVid+zO2cxx/ru5IgtFwU2YJaXi2ru8ZL
	 HkniJLbxYSN9J1N1i0WrDlfFOCFv/z4NSfVybu5LXcLvXmAYflgrLAAHCewaJdnDeqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StB6Q5O7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAB3606A325
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StB6Q5O7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837E41F008A1
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 19:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794340296;
	bh=EoaJJOwcscDH8OHCgu1SVsadAtlXJ+GnM9q74gYtlK8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=StB6Q5O7kL5kQ7NgUI8glfKXASFWgBGQuRo6xfElTw+QxsoiDQvcQr7lXroMSOklj
	 diQoZ/dlsrQhHqYuaWAE5tf3m5K9iJgckiOa8OIU/G4CoO/t5GLGU0HxXzM+wLOi3/
	 9g4iOlJrgmM3CBuGquZeBx3wi2q3uxSX2YBA/wM41ZqoDI3i9S9drH2OgscGdLzxzw
	 ZDYqcn9+UVnKlENH4SgbFlwmWDFN4mGtWqpKVnSK8/mAUboxVKIvw/TAs9CA9J9HW0
	 CGhL5BGo+TLxb8NRFUD2PCbop0SfhlVLWlRBmmNNRZHT8ZYcnUhBLq++juLZwpP8lT
	 55I8B1aChCNBA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ab46699a09so22991421fa.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 11:51:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFMcmhG6MNaRrIjZ5RFGK+PMhRzsYLQZXG0eJalGhk1naF4IRWYJ0gPofarlBoJaD70WXhL95XobQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/GKQM2Yy2owU9J4NoJxfi2MDmATUlDjDfFjPSZQIarGN2UF15w
	xZgEy7n4jPatNQbPPGtH4dyxtVnzUpsnKUH+zuGl/bYfHhwrsadWb4Kn8eaxVlWQJDX1PD7/B7X
	SqLIg0iYf2HYtiZGIAc4McXUlvXg8IP0=
X-Received: by 2002:a05:6512:402a:b0:5c1:5814:4b94 with SMTP id
 2adb3069b0e04-5c15d54b364mr43799e87.9.1794340294836; Tue, 10 Nov 2026
 11:51:34 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103114103.74195-1-k.chen@smail.nju.edu.cn>
In-Reply-To: <20261103114103.74195-1-k.chen@smail.nju.edu.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 20:51:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g31VPxrF6FwggLx-JwXJjex5iLxnxcn7ogo8LJm2Fs1Q@mail.gmail.com>
X-Gm-Features: AclHuK_fagscXlzoJ_i7Uy_dNtaqqPEBsCJFz8QyWBK3J7tNU5Iq82wkdOaUPWA
Message-ID: <CAJZ5v0g31VPxrF6FwggLx-JwXJjex5iLxnxcn7ogo8LJm2Fs1Q@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x: bound the PATC trip count
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 12:41=E2=80=AFPM Kang Chen <k.chen@smail.nju.edu.cn>=
 wrote:
>
> int340x_thermal_zone_add() adds the value returned by PATC to
> INT340X_THERMAL_MAX_TRIP_COUNT without checking for overflow, and then
> uses the same 64-bit value as the allocation size, as the loop bound,
> and as an int argument to int340x_thermal_read_trips().  A PATC value
> of U64_MAX makes the allocation count wrap to 12, while the fill loop
> still runs for U64_MAX iterations and writes far beyond the allocated
> array.  Values above INT_MAX are also truncated when passed to
> int340x_thermal_read_trips() and stored in aux_trip_nr.
>
> Also add parentheses to INT340X_THERMAL_MAX_TRIP_COUNT so that the
> macro can be used in expressions safely.
>
> Ignore values that cannot be represented as an int after adding room
> for the fixed trip points, so the zone still registers with its fixed
> trip points.

If this is a theoretical issue, that should be made clear in the changelog.

> Fixes: f4118dbe61bb3 ("thermal: intel: int340x: Use generic trip points t=
able")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
> ---
>  .../thermal/intel/int340x_thermal/int340x_thermal_zone.c | 9 ++++++++-
>  .../thermal/intel/int340x_thermal/int340x_thermal_zone.h | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c=
 b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> index 965700ee6962..6eda7823a7e2 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -130,8 +130,15 @@ struct int34x_thermal_zone *int340x_thermal_zone_add=
(struct acpi_device *adev,
>         int34x_zone->adev =3D adev;
>
>         status =3D acpi_evaluate_integer(adev->handle, "PATC", NULL, &tri=
p_cnt);
> -       if (ACPI_SUCCESS(status))
> +       if (ACPI_SUCCESS(status)) {
> +               if (trip_cnt > INT_MAX - INT340X_THERMAL_MAX_TRIP_COUNT) =
{
> +                       acpi_handle_warn(adev->handle,

This should be at most acpi_handle_info() and please use FW_BUG in this mes=
sage.

> +                                        "Invalid PATC value %llu, ignori=
ng\n",
> +                                        trip_cnt);
> +                       trip_cnt =3D 0;
> +               }
>                 int34x_zone->aux_trip_nr =3D trip_cnt;
> +       }
>
>         zone_trips =3D kzalloc_objs(*zone_trips,
>                                   trip_cnt + INT340X_THERMAL_MAX_TRIP_COU=
NT);
> diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h=
 b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> index d504e271009a..b1da47cc5402 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> @@ -10,7 +10,7 @@
>  #include <acpi/acpi_lpat.h>
>
>  #define INT340X_THERMAL_MAX_ACT_TRIP_COUNT     10
> -#define INT340X_THERMAL_MAX_TRIP_COUNT INT340X_THERMAL_MAX_ACT_TRIP_COUN=
T + 3
> +#define INT340X_THERMAL_MAX_TRIP_COUNT (INT340X_THERMAL_MAX_ACT_TRIP_COU=
NT + 3)
>
>  struct active_trip {
>         int temp;
> --
> 2.34.1
>
