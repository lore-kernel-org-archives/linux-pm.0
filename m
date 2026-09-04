Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4FE4A6CC2
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533477; cv=none; b=mi0X8AbUrteB+SwTcAdQLgLdJF9QVhJhQwDAo5ZBOYsuPhzrzCzxBvy6nXBvTPH/u90f/AD9jX6GNej65v1FiEAIe1HqtLQ1v4ecxMp2t86dWf0mYlUGuxPjL+8z8K9ygOBtgupr6d4g4vEzQ9YaQAud7FKrk5TosUPzbWJYiKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533477; c=relaxed/simple;
	bh=3cIr898l4+xlDFJy4acxoBlvCIAqLYxsTwS5DJAho14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REMgzJR59PlDGoqiLyGhac9pALRhRoddZIJ1tEFpo9HHwnOhPK5ZYfOCIAEsbOWuELendO0HqG8lMdopSuf/6qVhA0lRtxwEGdJweiR/gaV5Qlfs2V8hqekD6R/QXuHMjOZvV5ZCWdnHtutGVw/JKAftvywYbU4LpUZKPJFytfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvZFljBx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvZFljBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6241F00ADE
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788533475;
	bh=4vkuD3na4i2ySN/2/bVtt2a87x8yRk+LYFtnbh/Z4MA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PvZFljBx3P91vyHrS5GLB3FRvrjzRgf1KhG1fF4jC3pkyjih8zrpdi5g+oqvLvP7L
	 oKqkdoYeC4SmHJSMjg0xn18nLtXP/uB/nuc6eilYuIyX6l3GP29x4eH2Lf+VOtqNyM
	 ThtQkE2O1gOyZZCpz11AVY9QKO/gffc4EiI873MfuEUuef3OY+ktsMwkEp4ifIpj9J
	 J4ZoRCTg0P5tNu03KmHxyyM0+ebPjSq2bFud0x6WwJLeOMyPq7WZ89HUJ9sY+pRDtA
	 RQlXUVo6BIlsdRGiE1S/Bm0vjgG1DyiCxpNlnDDPQclnc/Wk3NR5eIfk9V4CTKme3J
	 8VNBPxzkKMisQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a20f56876eso10930491fa.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:51:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy1BdxnuZevdN7O8uEWjl9PtaL6OyvsimokEpU5leBucZcYwn+GeknYUkO6wzcbniYSksfXnc8CIw==@vger.kernel.org
X-Gm-Message-State: AFuF++lidWadzK2mcGlf8rt4zR+anBFt8a6oq85hFMK8x9pzRe8JQjET
	95bnIuZ53YrhnkTdehe9TNpVl0AulyiDC+ng9kq4s5kNemoKDs8ORo6zTLOFlJGk4SLBPwTBdkh
	YD8KnpfdVi8/TNg74+KniP49m9Bq/gD0=
X-Received: by 2002:a2e:ab0b:0:b0:3a3:7681:6d73 with SMTP id
 38308e7fff4ca-3a376817563mr4904721fa.28.1788533474198; Fri, 04 Sep 2026
 07:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828194530.43370-2-blum@kernel.org>
In-Reply-To: <20260828194530.43370-2-blum@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 16:50:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g6FGL4xO9xNEuhfLOrZ_=JjG-NFtJMc4VkYjQ5Yfeo_A@mail.gmail.com>
X-Gm-Features: AcwNN1UZJtkUcpZeitwn44unYn6noiHoZmnVIT_VyDqYAK5ywz0YbBBypF4BPtQ
Message-ID: <CAJZ5v0g6FGL4xO9xNEuhfLOrZ_=JjG-NFtJMc4VkYjQ5Yfeo_A@mail.gmail.com>
Subject: Re: [PATCH v2] thermal: intel: powerclamp: Simplify idle_inject_update()
To: Thorsten Blum <blum@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Yury Norov <ynorov@nvidia.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 9:45=E2=80=AFPM Thorsten Blum <blum@kernel.org> wro=
te:
>
> Drop the local update variable and call idle_inject_set_duration()
> directly instead. Also return !should_skip directly.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
> Changes in v2:
> - Call get_run_time() after powerclamp_adjust_controls() as before and
>   as suggested by Sashiko [1]
> - v1: https://lore.kernel.org/r/20260828184354.39423-2-blum@kernel.org/
>
> [1] https://sashiko.dev/#/patchset/20260828184354.39423-2-blum%40kernel.o=
rg
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/i=
ntel/intel_powerclamp.c
> index bd7fd98dc310..da10b02bc028 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -536,23 +536,17 @@ static struct idle_inject_device *ii_dev;
>   */
>  static bool idle_inject_update(void)
>  {
> -       bool update =3D false;
> -
>         /* We can't sleep in this callback */
>         if (!mutex_trylock(&powerclamp_lock))
>                 return true;
>
>         if (!(powerclamp_data.count % powerclamp_data.window_size_now)) {
> +               unsigned int runtime;
>
>                 should_skip =3D powerclamp_adjust_controls(powerclamp_dat=
a.target_ratio,
>                                                          powerclamp_data.=
guard,
>                                                          powerclamp_data.=
window_size_now);
> -               update =3D true;
> -       }
> -
> -       if (update) {
> -               unsigned int runtime =3D get_run_time();
> -
> +               runtime =3D get_run_time();
>                 idle_inject_set_duration(ii_dev, runtime, duration);
>         }
>
> @@ -560,10 +554,7 @@ static bool idle_inject_update(void)
>
>         mutex_unlock(&powerclamp_lock);
>
> -       if (should_skip)
> -               return false;
> -
> -       return true;
> +       return !should_skip;
>  }
>
>  /* This function starts idle injection by calling idle_inject_start() */

Applied as 7.4 material, thanks!
