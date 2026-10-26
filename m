Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042798;
	b=1Slt/RnaEdTuHICUyrft1Ud5Yen2l/0zBedVEbmnGM5KF4C8MH6z0GCU/HIfiYoLDhuK
	 s8yjYxWefpvdGSo1M3+XwJaO/RscSYv0DdAyvyKO9sVlgfQdyGIZ2WBBson0rJkgSq9kV
	 ExjHBvQFbycI8gu1cQ1QcgKSM/M4zpXR7S69C5npEBhspNAyhyxRHjjixp0bjfqKwPtf7
	 0hDb/mMY1b8oqp1s8gEpk7heb/3fOmZMVJIa33Jk4pIjnuqgOWIP5Ab5KhYAqBLOHMQVx
	 er5f7UXpSb8q7fKduUYxdV8swOahDGqxvMZNqiEZHcgdg1Z3EpR5x/FXo1c1rlSJNLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042798;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8Kc1cohtal7Z6JWXOOnKtAzlP3ZNhZ94KfGnkpnEI7c=;
	b=Z3hN+CwrcpDtonMW3wevZN35HKE0RoijS97gtSJuJTrTtyYxRb38pksDV0/vdCL//tk0
	 AHOUSgRYzsNDVVggc+m75HHZpmVXGxHxMfWsg+o9xf/2PMr7Jwm2h7j7ER8m72gxBxrJO
	 q7QdwEU61ZKML2H2w71BR260j9KxG6tkxUmyCJhUf/LAwU6c+XssI+tggNwWnlw+vn2+t
	 EfZuC3eMwHszRJiOAZ9zkBpbmVLV62KpKx6iUn/HL3kp+Fq8tH1It+RFSSzyvrpgnpicQ
	 yjG/zuoTrG6hUe12i4mzrM0Hc/sFN1Se0HMCH0+ulG+aze2zWGqWr1up+wquxuLwmag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCAtdriz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6969C606A31A
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCAtdriz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005261F01828
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 19:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793042797;
	bh=8Kc1cohtal7Z6JWXOOnKtAzlP3ZNhZ94KfGnkpnEI7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MCAtdrizNe43F0olqIRRZn4iuFqaFMWg+zXPlJdEc63+HMl1SqUYbK0TVVICYGhEV
	 xc7oUgzwL+Qv142zTXJk3FJ2+rahZfKG2KtxO71ZjmEcvyvWTQS2cQvpp/QychbwQx
	 bRNzeE7ALvjW9zYM6oWVSBwqvpPorVd1Bw61FCnQffZwupLj+15lSJRgkWbSHdTtn8
	 ZlpCQ9/BtvUu9NWFnVEb/v7nFsF8NL9eviIuwNyOFHLlowjNBECkMYs4zyxv+xAhbZ
	 skvpgi5HsglzeCBKsNjzqctYhWHul1h8UbfO7PESBYtSfC3BhVtAWQmv/VKo0Y/2NS
	 D6bB/eeeGt7Lw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso2856106e87.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 12:26:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzfVhK3GHosLttiGWI9T1tbteIB5cV2NwU77ul6DwLhFHVGaKnWcEmUSS0xeFqxQJa0P0aNzoXcHg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJdk38VRZqYmchgNWRn796lU4V/64gzwaxiUN2O7s+Wu+7qRb5V
	Z/qeAHNnw1/wVuWMqinjmIPg7E5R7KeIh0HKGi65Xjo8+561lGkdv9km49l0d3P2vYTOvWK2IbS
	LBr0pXCNvZZtTQMl2eqO8c7fxQmo+Snk=
X-Received: by 2002:a05:6512:694:b0:5be:513b:a44f with SMTP id
 2adb3069b0e04-5bfb71e3d25mr2337199e87.49.1793042795490; Mon, 26 Oct 2026
 12:26:35 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261003000011.58045-3-blum@kernel.org>
In-Reply-To: <20261003000011.58045-3-blum@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 26 Oct 2026 20:26:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iBX3tL2mx10g_4abRO_G3U96z5bgF49zaR-SvszbuOjg@mail.gmail.com>
X-Gm-Features: AclHuK-RzJ2SwTkeK5-H7Bk42trBPZSMQT2JY6seIFQATTFT6YeYQQ-1dwFRvaI
Message-ID: <CAJZ5v0iBX3tL2mx10g_4abRO_G3U96z5bgF49zaR-SvszbuOjg@mail.gmail.com>
Subject: Re: [PATCH] thermal: sysfs: Fix indentation in create_s32_tzp_attr()
To: Thorsten Blum <blum@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 3, 2026 at 2:01=E2=80=AFAM Thorsten Blum <blum@kernel.org> wrot=
e:
>
> Indent the show callback consistently with the store callback and use an
> early return if the thermal zone parameters are not available.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  drivers/thermal/thermal_sysfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sy=
sfs.c
> index 96fe5d591a0a..47daba943a76 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -287,12 +287,12 @@ sustainable_power_store(struct device *dev, struct =
device_attribute *devattr,
>         name##_show(struct device *dev, struct device_attribute *devattr,=
 \
>                 char *buf)                                              \
>         {                                                               \
> -       struct thermal_zone_device *tz =3D to_thermal_zone(dev);         =
 \
> +               struct thermal_zone_device *tz =3D to_thermal_zone(dev); =
 \
> +                                                                       \
> +               if (!tz->tzp)                                           \
> +                       return -EIO;                                    \
>                                                                         \
> -       if (tz->tzp)                                                    \
>                 return sysfs_emit(buf, "%d\n", tz->tzp->name);          \
> -       else                                                            \
> -               return -EIO;                                            \
>         }                                                               \
>                                                                         \
>         static ssize_t                                                  \

Applied as 7.4-rc material, thanks!
