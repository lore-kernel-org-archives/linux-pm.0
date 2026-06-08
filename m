Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572E037F00D
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925364; cv=none; b=IJWTO6sMq8lPiEnSQqb5Pacon+3dL3yCwtv/MkC0nueaQuey+1YlKnnCWB0a07YKXCSVE7PSIJ6zx/bumxKyr5kGI7rIVppyGHq8rTG6YnRGwZk5wKKMn+P1iuN77F4YIJQNZdslrFD8svNkJrn01OHoKxzW9Pi4KerIeovjCbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925364; c=relaxed/simple;
	bh=kO9nmfW+cyKpL93bquF9+xLapbVgZScxZT2gMHhaZEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAw6PmFOdfzEXrZcx9DAEI6PsDo3N7eMWoMX4c0ikW6dJlWLLCYWSimym6OipiPtEuua0dtrGnCK0X+cL3aXD9+f2feVPVa+8evZjSuZ3ew6kEjmlvx2Aevs8gkaPqLLWbCQ3aHhVqtd3kEa4Tzj0v/KL1CNwxPF5eh+4bk9kO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlrzaMAt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlrzaMAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AD51F00899
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780925361;
	bh=PWXMTqxQMWAlY8m8MLF0UJtkX03WJvcaUDHodhDys64=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UlrzaMAt1oq/rTPBN1yBkWUqGLD0KOSbhEQmtFL19UK/mkkd0SsAcrGaCeRwyZF4W
	 JobijO81ef97/P0cr4/UboG2DgvOys8NASeyzcWEeHuHrn63xRf4TTtAaCBB1nKUfx
	 pa+YmiP8s4acBP93wMwLNm+Sw+5QsEdHCTAjwOMGrRyL3j3Y6L+A3/b7T5B9VbYy7B
	 IX8C1rV8w1V/Cu91rLBMIikHfPVUe2KgHKp4keV826JwjhQcod2GV8tp+RjIxWRJQ0
	 xCfjl907KG+EBbn3XIC+FCCdVyb2u9Hw9phcmrVSfCYo+HxK5GUa/smtld8c+IF/qR
	 euR8g5537L7rg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa68d9d4a3so4642181e87.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:29:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8mfRm39QW2OC1splbZIS8LlD9YrndNSRAJkzmJ3iC3Z4tFOubOWivIH1idGDGLpq5DZSXHmd4Z/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEPPw7kOkUmmK5uhZSy4PWS1E8AEm+BfAMxnXY5Uva7ypMMvEo
	Hszf9+aa8rnqsWcTVQxuyPQSHtalHCfhV9cRCL55KCcTKP5CoLsunSjEE812vkf8W4zXnfvqrm4
	FFv3RULOZ+es2dXrhf+6GAGGIvhVDgiA=
X-Received: by 2002:a05:6512:1153:b0:5aa:61ef:2bd8 with SMTP id
 2adb3069b0e04-5aa87b406e4mr5548680e87.4.1780925359982; Mon, 08 Jun 2026
 06:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603032255.2126508-1-lijun01@kylinos.cn>
In-Reply-To: <20260603032255.2126508-1-lijun01@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 15:29:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hUYObm8QAB1DJ6wFb0wum+sFmR7VG-5YBnJ1eAMYyJsA@mail.gmail.com>
X-Gm-Features: AVVi8CcSei3H2mkNcHUeOJr2dkiz1OmmxdvSqmibhutG--V1Mtig8HbJLlb1aKg
Message-ID: <CAJZ5v0hUYObm8QAB1DJ6wFb0wum+sFmR7VG-5YBnJ1eAMYyJsA@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Add unlikely annotations to saveable_page()
To: Li Jun <lijun01@kylinos.cn>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 5:23=E2=80=AFAM Li Jun <lijun01@kylinos.cn> wrote:
>
> Add unlikely() branch prediction hints to conditions in saveable_page()
> that are expected to be false in the common case:
>
> - !page || page_zone(page) !=3D zone: PFN valid implies page exists
> - PageOffline(page): offline pages are rare
> - PageReserved(page) && (...): reserved pages are relatively uncommon
> - page_is_guard(page): guard pages are debug-only and rare
>
> This helps the compiler optimize code layout for the hot path (valid
> saveable pages), improving performance during hibernation image creation
> when scanning large amounts of memory.
>
> Signed-off-by: Li Jun <lijun01@kylinos.cn>

Are you actually able to measure the difference?

If so, how much of a difference is there?

> ---
>  kernel/power/snapshot.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index d933b5b2c05d..182f27eb573a 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1380,7 +1380,7 @@ static struct page *saveable_page(struct zone *zone=
, unsigned long pfn)
>                 return NULL;
>
>         page =3D pfn_to_online_page(pfn);
> -       if (!page || page_zone(page) !=3D zone)
> +       if (unlikely(!page || page_zone(page) !=3D zone))
>                 return NULL;
>
>         BUG_ON(PageHighMem(page));
> @@ -1388,14 +1388,14 @@ static struct page *saveable_page(struct zone *zo=
ne, unsigned long pfn)
>         if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
>                 return NULL;
>
> -       if (PageOffline(page))
> +       if (unlikely(PageOffline(page)))
>                 return NULL;
>
> -       if (PageReserved(page)
> -           && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
> +       if (unlikely(PageReserved(page)
> +           && (!kernel_page_present(page) || pfn_is_nosave(pfn))))
>                 return NULL;
>
> -       if (page_is_guard(page))
> +       if (unlikely(page_is_guard(page)))
>                 return NULL;
>
>         return page;
> --
> 2.25.1
>
>
