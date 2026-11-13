Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582635;
	b=uP+ydav/GgV1+PUIPU4Oypyzj6yH/yzwU28kCzOZNlPPTN15x6CmF2TiVnMj4uN4qD4Y
	 Z1L+6GhcN3FqfXjINz5C4H0/p5cdC0F9i0mP1xbltCPcPbkS2HN7aTM8uSRDRi3mN9RaA
	 uI3kCrzBKB62WFCilEvoY4eDgYn4m0xLLZeb5DXpMMDjHFdCDPrFkDrBNpKWWNLoZ/fRK
	 tyakmhyEfd7Nq9bxqE+SEhs9eDM+N1l9G6EHWhg+/xMSFDzlIpz23ZYXoCsWiueXdYx9l
	 liVGC6Z1dNS0UrtiVrkBGHWHBN4rTP0kBer5ukl5PNf55xCf2oARL2tsmSS9IiPMy5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582635;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TkG/mXd3xxyfE1YMucELf8ChMbHN6hjbr127YP2DmWg=;
	b=oGZ5XAlteJ7BBulDJD2mlWy7F1eH19Gema8INEgeOj6TKdqkb4PytLgCkCo7kNfZE3sY
	 RVsH0y7ZGKoUvxYL1ZOzloov2bBYepuZpwPbEoIAgHTQ9CgNtaGpO0ihvKrOK5c4iAzmy
	 CqqYf/3YHLihngD8PSZdDCTO/hdmgMyjzFcGEEw0vi6RscL3MFmyF6TybpRzAaYjVjAd+
	 2qD5jACV4NPGoZWH4CF6zUdjP6ZiR9NwLq+ALMHnhAe9L8reGFVGJmgkXE8srUxV5xLFb
	 FlpgEiCs6Rj7wJSls1+qdOXKCRyGVkcxA74IuX6UUJxs2fPW9CzhSNXqN9yHCNFvGLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIxB9nP7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BD8606A332
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIxB9nP7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1ED1F000C8
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582635;
	bh=TkG/mXd3xxyfE1YMucELf8ChMbHN6hjbr127YP2DmWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dIxB9nP7TAmwSOEHqrIyK0Nn/LJv7CPry7ddbW5hvteR/ShKiX11mEjvW4d60k1Fx
	 a1veJFFTTy+jYJVVwV+gymkhwA3aGT9vvrHijpxjFpUdl8zoQDEeGHHbZkFSp7zl+3
	 Yw6cX07Ban/8W2/7Yl2W2N1Tv8EPpxIxO8e14XDFKWAb2FXUWILjE/9N1AUq6bIS1g
	 uKO4x6OhTbtTnAcnXe/2yt4hgYqccDI8IJJV9mELyTkZygzZNDW0IiLR+QzLBKxnCV
	 UZ34r8Hi3mUwfTFRycANtNj6jZeIpgsTBUlDMxlFeERN5ccOOUHqMiJhsYZcXPwxgV
	 mc1sJfEwIgK7A==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c15ccd7fb5so1341140e87.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 07:10:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHByzsNFVS2liP+YUccATf38rxQqHSnL8X2LAM05c9sIcc7cz7zkKD9K3o+gidkvincwz5KezKe+A==@vger.kernel.org
X-Gm-Message-State: APuU4Z+wvpefRYFIS++ZX8isHeqhy62Aon5CByHdjpHUiWMxngXDg5PO
	F0bTvssF1c+j2v8SOy+82fTJKAoIhxDZIuWWAO7+S+Ki91ti7NnkjEVValx+t+6M3/x6jl8YJiy
	pSXVuiY1VPctUYCFtQt+Qg7UIEfwmIlE=
X-Received: by 2002:a05:6512:2348:b0:5c1:57c9:fd34 with SMTP id
 2adb3069b0e04-5c170999212mr1412865e87.16.1794582633771; Fri, 13 Nov 2026
 07:10:33 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111121225.70218-3-blum@kernel.org>
In-Reply-To: <20261111121225.70218-3-blum@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 16:10:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jPkX1ZQNBoPCXdsUZPApqXU+DKAYb7GLxBtaDBKR4VnA@mail.gmail.com>
X-Gm-Features: AclHuK92fvqHP3aXXz_SUix1-XpeyJW9Q5XHaisUt4mXgBwTJdjKeYRqUd7fD9k
Message-ID: <CAJZ5v0jPkX1ZQNBoPCXdsUZPApqXU+DKAYb7GLxBtaDBKR4VnA@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: powerclamp: Return -ENOMEM on allocation failure
To: Thorsten Blum <blum@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Yury Norov <ynorov@nvidia.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 1:12=E2=80=AFPM Thorsten Blum <blum@kernel.org> wro=
te:
>
> cpumask_set() returns success (0) if alloc_cpumask_var() fails. Return
> -ENOMEM instead.
>
> Fixes: ebf519710218 ("thermal: intel: powerclamp: Add two module paramete=
rs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/i=
ntel/intel_powerclamp.c
> index 1ffcb0a699e5..df898fc3f3e6 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -157,9 +157,10 @@ static int cpumask_set(const char *arg, const struct=
 kernel_param *kp)
>                 goto skip_cpumask_set;
>         }
>
> -       ret =3D alloc_cpumask_var(&new_mask, GFP_KERNEL);
> -       if (!ret)
> +       if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
> +               ret =3D -ENOMEM;
>                 goto skip_cpumask_set;
> +       }
>
>         ret =3D bitmap_parse(arg, strlen(arg), cpumask_bits(new_mask),
>                            nr_cpumask_bits);

Applied as 7.5 material, thanks!
