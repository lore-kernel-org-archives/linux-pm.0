Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405102F7F1C
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788532126; cv=none; b=rVg39zXK7grSdz54dUUtucbHbFwOzbsaw0fqKEyNwC2xppp8lxsZ4V7FqIfgTpLTri2mqCXB8ioEzWX7BKnFOwGAvXDomq7Fu+/IeMYuKN+7mjYyKqcA9m7CiKR4Lj0v7W1Q3XTMiTlc0MOkoFUf0adDmdYjSCrlis+ZIy04DiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788532126; c=relaxed/simple;
	bh=TmfPz4EUMm6Z8Ox8FU0u4Az5V1Kx3kQ2bxu2Nlo/7tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mq82sxMIOHNDo3WnQJPWJ8USBT3pPIXmfLlzDYMvSeWU6d8gMceuHxx216onQ2jgCsAkuUUzvxp+7DMg7G80m7IEZVMsfsxXHfKrZb2iV1ubgIMtSKsZ6sxlIFceWFdQV0sjy56f9BxX1wmuJg4BR2yogUQsEzZN28pMp9uqsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpI68N1T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpI68N1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280231F00ADF
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788532125;
	bh=0lAgpRheQnw8NXs5uZ4P7FJxzP+cbejQwwbXm7xsKXE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BpI68N1Tv98731L+v/qCnHIH83REDyQx2WJaAKFdO8kml4N06XLie5XEdGPKvNDwy
	 nVzOwDo8tDYncWKG4Nzo8syU8geRF1S0CBzkETmwFrU4TlG/MXlovoTZH2bqIBYIH+
	 JIHnaHKQ45iLNBIpi8NWHqjVEAfYKLUPgXoxPR/8Wyn/ag+tzvteKBrmenG6Wu39OO
	 Ay+bVN1cmSJlUbcJcg/efhbiwfjk0d9EQrQpIzm+nKS/Kh75VQRHxHwE1pykSdHODi
	 Z/uwSiXd7AAQ+AtiMuj43z/lfGANiH5HULlYyDEfsrhfDxSWm9CQGumFA269Lcly+J
	 KTLV1LPD0YW6g==
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5c664b8c3f3so975870e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:28:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByc/TUHYmWpKrPd3SL+55qZDOL0UTkhRjW8XAactuAA1Ie0/beM8u6MbhqwkzF1y7YVd6BN9ogJeQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mwLbaGK6+v8mZb3y/uArk6/Jde4dlWObpvHzByfQq1ePuXEaT0
	tk3MvB3AvOgIs2QHP8G2YPJ7CD6n+IY65HjpPlURxn3i3UEnF1ftvh5QHOaoCpJC5Jp5D+1uiSk
	JGnFdV1G/vsUiONVc6AYUxOUcwRW8YZo=
X-Received: by 2002:a05:6122:da0:b0:5bd:a5e1:c7c7 with SMTP id
 71dfb90a1353d-5c7ed485cdemr2777069e0c.1.1788532124386; Fri, 04 Sep 2026
 07:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815092419.91246-2-thorsten.blum@linux.dev>
In-Reply-To: <20260815092419.91246-2-thorsten.blum@linux.dev>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 16:27:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hoJR8huKApbA5WWxqRUwra=aUis-QBOX5=feBqRzCmzw@mail.gmail.com>
X-Gm-Features: AcwNN1WvgUsThB3vWTZ5u_V2vRbMaNsyfEtQGcYqDTkzRqFDLFNEu2y3d5xdoN0
Message-ID: <CAJZ5v0hoJR8huKApbA5WWxqRUwra=aUis-QBOX5=feBqRzCmzw@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x: Drop redundant else in proc_thermal_add()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 11:24=E2=80=AFAM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> Drop the redundant else branch since ret is immediately overwritten.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  .../thermal/intel/int340x_thermal/processor_thermal_device.c  | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_devi=
ce.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index f80dbe2ca7e4..0a007a6413df 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -291,10 +291,8 @@ int proc_thermal_add(struct device *dev, struct proc=
_thermal_device *proc_priv)
>         }
>
>         proc_priv->int340x_zone =3D int340x_thermal_zone_add(adev, get_te=
mp);
> -       if (IS_ERR(proc_priv->int340x_zone)) {
> +       if (IS_ERR(proc_priv->int340x_zone))
>                 return PTR_ERR(proc_priv->int340x_zone);
> -       } else
> -               ret =3D 0;
>
>         ret =3D acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOT=
IFY,
>                                           proc_thermal_notify,

Applied as 7.4 material, thanks!
