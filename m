Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107D73A1A54
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790366452; cv=none; b=R+kLzh5++7KCxB4lbDEI5DuW5AoagkQBd7Yt2HWCRc/ppsp4A0FQFxmbiSCoiLHAVbBHZeMWXMOzQlV+55BCeWVuToAwN18rbkBFImSUCfGZVxoxSAYhRsthvnq1g4a/LK94gApq1DoxQ1RlwGm5joCDF1nzOPnorF6r5BANspQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790366452; c=relaxed/simple;
	bh=TuA8mJp6WIiFejbqcxOx8qfFnbYu+NcKFML1Bnvjv1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okeuUcULCb36raI6/b6ggmim/jAQvFBf2YzYXq9bVEZGQU6yZp/TCax+n3ABEOnZjhMTz9Fw+VmrokMErZt/ZqLCRIcat8pL+9cEb8yD7s2uBcdv+AHRPyuw9arMAHyULcjuTtb4HKoAdGvWei4IGo9cdweKLnnHlatqlmpvcHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aInWkDLv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aInWkDLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E937B1F0089E
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 20:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790366450;
	bh=mdthU5pFhoPpRCYtUZtakptdc+N2Ccs26ug23E7MbGo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aInWkDLvDoq/R50BzyZ7sMOtrOyu94SkBZ+GJcyGiOXXLvPFZFdSlwrgcEn68PcZx
	 tM8Paq6eg3VOs1NrgGOPLDC3fYlbUi68WxVa4f38yTuLJN0hQ7sMu/mtunTIHj16Sd
	 UNdQBxKdCSnKEJhTgWWJLmHseaT++Fd7kecoRwbsPavz373PN7L5VN5eMhToZ0ugd7
	 nHPsXk8SqOrbwuhVBcHXncCVwSMXW5y/5QA4PTIRZ6n3LhHpkNoJxJBncoxHlzjpd2
	 SwjqZPQ834k2FMRMm5ms8l9ItBP4u8m9VLeGXIsHHfwyiTC8YyiUnmg4kTTDa7+Qfd
	 z3PpnTltvvhsw==
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a651f928d9so6276211fa.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 13:00:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzz7/TXRZAeCPJTI2dT5LB0tGF0ZaEe87jy9VbBBaEPpTuUd3uLImigNc8GfZR83C7eQTyQsfvaRA==@vger.kernel.org
X-Gm-Message-State: AFuF++m6oEU2YGDkMkRRBP4QFKAFL4hfKKurL055YS9HQbFvniAvVOPD
	ItUrC2v9HvnhMX6lW5klPBFUE4fhkyylTQph7txDUPRh52tAbpcjfGxXzRYWoZsoi+xQe9NIZGZ
	u7GVenOmqBNM561AvL72ufaAPztkNhUo=
X-Received: by 2002:a2e:be1e:0:b0:3a5:ba1e:8b08 with SMTP id
 38308e7fff4ca-3a63dd61a6emr15047821fa.3.1790366449302; Fri, 25 Sep 2026
 13:00:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921143644.69381-2-blum@kernel.org>
In-Reply-To: <20260921143644.69381-2-blum@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 21:59:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hdPbFXYa9KRfFskgt5kjQCZL1abbuxHCaPLozn0-Gh1A@mail.gmail.com>
X-Gm-Features: AclHuK8bo65Dg1I1tpo0GAtZ0VUZYaam0tmEl15Y2Ce1LxoPxHCrH1jXO9rxCmM
Message-ID: <CAJZ5v0hdPbFXYa9KRfFskgt5kjQCZL1abbuxHCaPLozn0-Gh1A@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x: soc_slider: Simplify slider_def_*_set()
To: Thorsten Blum <blum@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 4:39=E2=80=AFPM Thorsten Blum <blum@kernel.org> wro=
te:
>
> Return errors directly to simplify slider_def_balance_set() and
> slider_def_offset_set().
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  .../processor_thermal_soc_slider.c            | 28 ++++++++++---------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_=
slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slid=
er.c
> index 91f291627132..e161b95828e8 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> @@ -66,15 +66,16 @@ static int slider_def_balance_set(const char *arg, co=
nst struct kernel_param *kp
>         guard(mutex)(&slider_param_lock);
>
>         ret =3D kstrtou8(arg, 16, &slider_val);
> -       if (!ret) {
> -               if (slider_val <=3D slider_values[SOC_POWER_SLIDER_PERFOR=
MANCE] ||
> -                   slider_val >=3D slider_values[SOC_POWER_SLIDER_POWERS=
AVE])
> -                       return -EINVAL;
> +       if (ret)
> +               return ret;
>
> -               slider_balanced_param =3D slider_val;
> -       }
> +       if (slider_val <=3D slider_values[SOC_POWER_SLIDER_PERFORMANCE] |=
|
> +           slider_val >=3D slider_values[SOC_POWER_SLIDER_POWERSAVE])
> +               return -EINVAL;
>
> -       return ret;
> +       slider_balanced_param =3D slider_val;
> +
> +       return 0;
>  }
>
>  static int slider_def_balance_get(char *buf, const struct kernel_param *=
kp)
> @@ -101,14 +102,15 @@ static int slider_def_offset_set(const char *arg, c=
onst struct kernel_param *kp)
>         guard(mutex)(&slider_param_lock);
>
>         ret =3D kstrtou8(arg, 16, &offset);
> -       if (!ret) {
> -               if (offset > SOC_SLIDER_VALUE_MAXIMUM)
> -                       return -EINVAL;
> +       if (ret)
> +               return ret;
>
> -               slider_offset =3D offset;
> -       }
> +       if (offset > SOC_SLIDER_VALUE_MAXIMUM)
> +               return -EINVAL;
>
> -       return ret;
> +       slider_offset =3D offset;
> +
> +       return 0;
>  }
>
>  static int slider_def_offset_get(char *buf, const struct kernel_param *k=
p)

Applied as 7.4 material, thanks!
