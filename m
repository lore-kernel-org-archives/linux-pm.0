Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195213;
	b=nj8fXVR65ah6xUOS3mVr85F3cohG7NiteJR7hCESO+4vVutjo9gaab+2KyOIJzKIy7ao
	 UksVVzRKrLKcJxzFupW1O01ikgqCm6599sYw79jWE7+O4rqIdGXf9UPeVsrTJBVAKR9MZ
	 G9FMFXuwTfaVLUCjYTgXCUKEYLt9O8L3PsDrsSwLJA07wZdJxXYErL8YmJ+zD3DztJF74
	 uy2w+vQclXowWFtIb0zPDO8uuj5Se0XVbz0qTlKTiKUmKdP7kbVtcddvNQJLhjZ7RaY35
	 s6U9nd/oG6hnA8iiF0UhJwL00njl6dqgmdqsRpmApiMdpzFksHwg9/TM9d+/rVjysuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195213;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Y4Bc+0yC5Sbi8yUIWH+dJ6WtjRKsFLPVm8zb7sCcrd4=;
	b=e8UB5iWYr/DQdUlzZ7P4spRHWPveW2Yj0CGg2K63YSJTwNYC94fKsexQvHIrGjmM9Mtd
	 OqMezs8S97qkY/iKzbi2MVjssDgkPNKsT1DVnB7nj9tdDXFFSZVTva6Ye/YXt3fpozQ45
	 m19EwTH4bj0xyP/L6ZOM8FnxLRShODeqKQJxa0QbyJE8Rpi7bjYwmwhJVcF0GRibSq3op
	 6DFgkWSb+IBDbGYphSm+rlfTxi1h+FsGPR8v56Kdt6Q7IFTc0+ML6tm45czrCzoKszYs+
	 1XyOXsUfLJepaOSxtKX0VEI+YBZsNXPRJB4W1fsiqjzKCeRms6T9luwGNQLC44Bg57A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJMfIqQw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCF660A2611
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJMfIqQw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041581F000D4
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795195213;
	bh=Y4Bc+0yC5Sbi8yUIWH+dJ6WtjRKsFLPVm8zb7sCcrd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XJMfIqQwEJhIT9Cq6IKKt7/UsgoOyz/TWG6zgL3lm67TWn9DZjj8gqWAFmXAk+yGl
	 Rpx9dWSU2yPyLXK3Y3kkq/UhW8R1yrXHaH/UQwVpAeRDt5hoeN8lN9Wghbxzh6Rpza
	 /QabQYIhoNLsJMbL+K04aVkEzAn/LpHXe1DMNhM42fDSrAoIU1dMMiv5wkPbbAEWC+
	 Bxm4i3tufokA03pk6FqKcpLW8ztDyaIqdGjNvjInzseDlwqLmq4gXGAtYmynHJ0wRB
	 0TmZ3jwnR+Cxk7P6kXsbMzKgmx3W8AB3bgie9dvdRYyiUz6CwdHIPkPLUdGJA5WkYM
	 IYCa7b2n603Xw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5be416e603cso835476e87.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 09:20:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFrFWlhFnYgAxFKVSai5FBM+ecX1VGF+lD+gWnqHdVgFPIACCLtgZ+0O8WLNHfc1TuTaQAGXQ/yIw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/2yiA+3a+ZILkrfJ94ePxw1fgsaihMVeLePwonDwVNyGjPS21m
	GRCEyK+PZtvQtBOpAcTzgiHwND5re32FUzrkGbe/15bEvfKEa3SXtI0TohdZmlqIZMniI2aBmGo
	rz28W/37kxvm/zRwRPuenKOyJ6eafqxA=
X-Received: by 2002:a05:6512:104f:b0:5bf:f5a3:9a1d with SMTP id
 2adb3069b0e04-5c1bc67e7ddmr1191762e87.7.1795195211476; Fri, 20 Nov 2026
 09:20:11 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116121723.342798-2-blum@kernel.org>
In-Reply-To: <20261116121723.342798-2-blum@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 18:19:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gMAcGTg7RAF00S7mzrkYXa116OYEbbn8RE1-F_CnO-zA@mail.gmail.com>
X-Gm-Features: Aa3M54qYyVMRg2sTMOWnU96DamHzfYjmEqlDjIxhHjg-kgHRQQhzEV84PJo3tiM
Message-ID: <CAJZ5v0gMAcGTg7RAF00S7mzrkYXa116OYEbbn8RE1-F_CnO-zA@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: Use clamp() in pkg_temp_thermal_device_add()
To: Thorsten Blum <blum@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "Ahmed S. Darwish" <darwi@linutronix.de>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 1:17=E2=80=AFPM Thorsten Blum <blum@kernel.org> wro=
te:
>
> Use the simpler clamp() macro since the values are compatible.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  drivers/thermal/intel/x86_pkg_temp_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/therm=
al/intel/x86_pkg_temp_thermal.c
> index 43fd5bdf1d8d..2b6265b80fe1 100644
> --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> @@ -327,7 +327,7 @@ static int pkg_temp_thermal_device_add(unsigned int c=
pu)
>         if (!thres_count)
>                 return -ENODEV;
>
> -       thres_count =3D clamp_val(thres_count, 0, MAX_NUMBER_OF_TRIPS);
> +       thres_count =3D clamp(thres_count, 0, MAX_NUMBER_OF_TRIPS);
>
>         tj_max =3D intel_tcc_get_tjmax(cpu);
>         if (tj_max < 0)

Applied as 7.5 material, thanks!
