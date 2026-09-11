Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A33546E1
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136547; cv=none; b=bV/WpRPDgIZM7/cnato+osXfBQX7nwAqqjZHiA1KEWF8UWlkhbwvVf0J5ZhHavfzkmd1cROG7mJlRqfk0BnS0+5YEeQv9c+jAktRlReoOaqHQQwfwQQ3+lYP47qnc7seM5ROOdNAw7/cHXdNnMRgOsKG70FmsRDyLSsNoEtKqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136547; c=relaxed/simple;
	bh=CKEQ5986CV/kzwyn5wRQ5Od0ZfAMuzoy3/vGXU7ndXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak7HIGhU4L8n0WPOilZQfbFhlQonx8iWflX8wwMjArpiiXUqyU21dote7Ef8e9RAC6wBAtWm8HTPUnyzjHi+yLGSxgfWZKDsh7Y/t5RP6vcucaX5F1S3gn9Rx7+HB80bbeMxmuOjelYpbUnfTHCF7FraB41fF3a7YJatPDoySvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7tOSJfx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7tOSJfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FF41F00893
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 14:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136545;
	bh=TxAn6ueekm44HEOWY30thTo349hdrLwTtPKtsmgWunA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Y7tOSJfxrk5G6npv+DhJi1lYpeo6/FikZNipxLmIw3AKHllZVyFuBr0Wm0sHPgr8+
	 RN2ChT+R95Rs4+T6xp5dAQ4Tl2nsvfVXDKHJUqmB6GbSrV4X+oClILQXedWmwvR3PU
	 T61+LGgkaUuj+7yBvjlYTdh4AaPu9ZoPe/c9BQwXlv5lCzRueC9j+XIjaDCnNZSIOt
	 0iWNQwPYHkzF2XVigsesYNOl/GVeJapFpcKZFeBv9xj3r3c1rP1mO6fMAoNKTW7gVU
	 wDGjaH79SsbFuw4vkvtXfDiUOO9qbe06gXSs2hMgxyGw0BwiP2/Ncn/FIUlbg8Bc04
	 GZDjJdMW4AJaw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a4fc78b556so8920761fa.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 07:22:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxKN2uflIFQhZn1vB+yF19/0q6mC4e0l4BeI0JX6x32vhncSYvy7u9LIsNxPoOP8rVkz6DbsNfKTQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ltYNP0oqhJu5497koKNb/qM083M8oZNRLT576F/2c/P2E8gw8S
	Bz/4E/PhxfqeOyMkG69YoH1eyAWKejqWNE3MqMCN8cqT0hDjUzWlqZA71pUR1RQah2LzXcIonXM
	uyjweNbE7qQTeiTp/iW8tAeWdoPtVrqg=
X-Received: by 2002:a05:651c:211c:b0:3a3:42cf:c035 with SMTP id
 38308e7fff4ca-3a5a505d60amr4839001fa.2.1789136543723; Fri, 11 Sep 2026
 07:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827094820.3900062-1-luoxueqin@kylinos.cn>
In-Reply-To: <20260827094820.3900062-1-luoxueqin@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 11 Sep 2026 16:21:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ihYqbucMQeJE_ZtbUbhBERmvN=YrvqAtT_fG+9k0F5Lg@mail.gmail.com>
X-Gm-Features: AcwNN1Wb1x4Wa89YnnzehnAvHYl21bHVksfC4doTtVVYnu6JAUsT7uHn6sZzk2I
Message-ID: <CAJZ5v0ihYqbucMQeJE_ZtbUbhBERmvN=YrvqAtT_fG+9k0F5Lg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: menu: Do not return a disabled idle state
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, daniel.lezcano@kernel.org, christian.loehle@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 11:48=E2=80=AFAM Xueqin Luo <luoxueqin@kylinos.cn> =
wrote:
>
> When idle state 0 is disabled and the PM QoS latency constraint is
> zero (latency_req =3D=3D 0), the first branch of the || in the early-retu=
rn
> condition of menu_select() is taken immediately, so state 0 is returned
> regardless of its disable flag.
>
> Address this by making the !disable check a prerequisite for the entire
> early-return condition, so that when state 0 is disabled the normal
> state selection loop is used instead, which already skips disabled
> states.
>
> Fixes: 53812cdc9100 ("cpuidle: menu: Move the latency_req =3D=3D 0 specia=
l case check")
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  drivers/cpuidle/governors/menu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors=
/menu.c
> index 544a5d593007..eb529d73d4b7 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -284,10 +284,10 @@ static int menu_select(struct cpuidle_driver *drv, =
struct cpuidle_device *dev,
>                 data->bucket =3D BUCKETS - 1;
>         }
>
> -       if (latency_req =3D=3D 0 ||
> -           ((data->next_timer_ns < drv->states[1].target_residency_ns ||
> -             latency_req < drv->states[1].exit_latency_ns) &&
> -            !dev->states_usage[0].disable)) {
> +       if (!dev->states_usage[0].disable &&
> +           (latency_req =3D=3D 0 ||
> +            data->next_timer_ns < drv->states[1].target_residency_ns ||
> +            latency_req < drv->states[1].exit_latency_ns)) {
>                 /*
>                  * In this case state[0] will be used no matter what, so =
return
>                  * it right away and keep the tick running if state[0] is=
 a
> --

Applied as 7.4 material, thanks!
