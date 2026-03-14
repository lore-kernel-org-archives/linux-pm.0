Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B971DF987
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773487210; cv=none; b=feXdBwMuBccaRIjmilV917KNm3Pyz4B9H/yVf5FjZi1vJNf7b7PeYP+ePqqJDTZ4h4nObef2LL7R6uthjGHB2V3aP5ZzpV4ZkxWxnoAJwjijq0oKl3YVWBNcdeWOHZfnFdzEP0J/1hL6gQOaJAmepPiGifap7eJ88C7rBQSvonU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773487210; c=relaxed/simple;
	bh=cPoCVEdGUJX/2y8bIHWYgjaZORyZPTHyeL96LjZ+/MQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eur8xuDFb4dKEsRlCDeNnKNd0oniObawsF1cgA8+o4G0P7CQPYogV+uQ4xq7oWRYCuj8jrbzWxX7BsAQbegji3J1zhfiFIYs22D+EmFk13bk7Ad5i7Xsrj6RB9NiJcRd9iRr44ikn6kulvy6EmgB9KyEttfuc6Pw5n3xldGKptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YG9tWCEs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YG9tWCEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E2EC19423
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 11:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773487209;
	bh=cPoCVEdGUJX/2y8bIHWYgjaZORyZPTHyeL96LjZ+/MQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YG9tWCEsv/Y1bLJGmy1Wgi08aWMHr3ysU3ksdkMTUb6gCxeLF67rPTibx97bW2h6R
	 mVKuzZums4XZuERA6ZHsQCa1tGgbj15I1KKnCRTmmLWAoQRokYhJtVOLxN/LZeE91o
	 WK/xVB4pKpfj+kTkTigB2EGzQTmffxivE/98jWIvXe3+SB1ZpQRPnWdMb7TVOla1Ys
	 Pk35UCzmsYGqWyttrxQaZaJR+snmmJ5kczTR8FoKBjMlyHXVTs6lbQz4YjkvSEXIos
	 sIBwQTWM42iBHcGmFX/K8F4aOS035jNCv+It1rtslOatKiIk4MqW/UpukLZ8S4krp3
	 dWYxc0sXh61WA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4042fe53946so1182313fac.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 04:20:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIjFLGnerxWEcA/cgV3SCdtk7nPiRilA1ekNSqEr2JGBakNU0Ln7w3cWrmyMKKBAsmtubOVXsKkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYY8TAu7TSLP/mXf1i2uyS3kilsSpByKTE+72D2XTrBOv7xqe1
	qPJqmWGVabHABocPrAeKt8+J3gPjQb0Zs1EYzhZ7gy6rAJUEKJYxs2oX0f+LqSNtskzkfWguRqY
	FP3/4dfkznW5jU1hODdVSCYykO5DdunU=
X-Received: by 2002:a05:6870:1604:b0:417:5b15:41b0 with SMTP id
 586e51a60fabf-417b9059c0bmr3328895fac.5.1773487208959; Sat, 14 Mar 2026
 04:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312051444.685136-1-rdunlap@infradead.org>
In-Reply-To: <20260312051444.685136-1-rdunlap@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 14 Mar 2026 12:19:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gU8Ce3dj8w9iBxetY3EQ7XjsYGSLtg0znyWAR6ScTHgg@mail.gmail.com>
X-Gm-Features: AaiRm52l8DS-e1j3leboatUwW1d3HcmiLh-SUE5pekW5iKpO9Tm48S2ku5tHpBs
Message-ID: <CAJZ5v0gU8Ce3dj8w9iBxetY3EQ7XjsYGSLtg0znyWAR6ScTHgg@mail.gmail.com>
Subject: Re: [PATCH] powercap: correct kernel-doc function parameter names
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 6:14=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Use the correct function parameter names in kernel-doc comments to
> avoid these warnings:
>
> Warning: include/linux/powercap.h:254 function parameter 'name' not
>  described in 'powercap_register_control_type'
> Warning: include/linux/powercap.h:298 function parameter 'nr_constraints'
>  not described in 'powercap_register_zone'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: linux-pm@vger.kernel.org
>
>  include/linux/powercap.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --- linux-next-20260311.orig/include/linux/powercap.h
> +++ linux-next-20260311/include/linux/powercap.h
> @@ -238,7 +238,7 @@ static inline void *powercap_get_zone_da
>  *                      Advantage of this parameter is that client can em=
bed
>  *                      this data in its data structures and allocate in =
a
>  *                      single call, preventing multiple allocations.
> -* @control_type_name:  The Name of this control_type, which will be show=
n
> +* @name:               The Name of this control_type, which will be show=
n
>  *                      in the sysfs Interface.
>  * @ops:                        Callbacks for control type. This paramete=
r is optional.
>  *
> @@ -277,7 +277,7 @@ int powercap_unregister_control_type(str
>  * @name:       A name for this zone.
>  * @parent:     A pointer to the parent power zone instance if any or NUL=
L
>  * @ops:                Pointer to zone operation callback structure.
> -* @no_constraints: Number of constraints for this zone
> +* @nr_constraints: Number of constraints for this zone
>  * @const_ops:  Pointer to constraint callback structure
>  *
>  * Register a power zone under a given control type. A power zone must re=
gister

Applied as 7.1 material, thanks!
