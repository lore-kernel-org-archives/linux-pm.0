Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DC448D86D
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101403; cv=none; b=ejlWHMycJkaIMzRF/rVoBvQbwNPYLKp1ld4BRDoSdqqzyig8yda6pNbnPTUxDPNPO8bpzLbcH0T1bRUaWdX08Bk5AeXjBDGQKuVlC4IV0dsJP67bY2rKo4KMPkPX4fNbUcL79fxTuqHRjFT+ppdZo2vH4+Ghqf6icF1XB9dwV5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101403; c=relaxed/simple;
	bh=dq6+Nq/1U7hym7/sP6AKWx2tbdN9RbsVH9ovKkSFjwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IO8AU572GXBZLv1FkS3ntHNwFsvJG7e2RpCrgpsXHaKDdaUmyko5rqEnF4LDBysMHh/e6ooEa2bK439px19pWG9uiWIjZS+RHGpEpBd9Hk/1e0KPJbbmqpYldu45MlJR+oVnDQoew4vbtnyrNdHT5TVPKzR5VpsW9Ch7q7NEXD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvA7BNDX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvA7BNDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40C91F000FF
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 18:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101401;
	bh=7P04rFDisgI+7qAi+spYaWDTQKytFtFV/SCqA7XmRbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NvA7BNDXSVbluZjh1oN6tjfWWVlBDuj/6/yxegKxD3nQCNxb50eNEnq7D88+KeTdr
	 P1CiygGPJJ7VHnuvS0jTv+kIDr4rmTdcWXmN0p2XwPzI3ozCwSPxFQ0mSBjOC157NR
	 H/gSHtwPOIGvWyCl88J4+8zBqqhLrMNlvEBIlPbOc1PTvGLCbRtTzlTeWMDzaF1poU
	 O1+nzhbo6sxU84mlMFHI2LH3iPvv30MDridCZT91jxTuqP6N/3pJkzw9O8CFA/WJef
	 5CpFTimGU15a5327iRsVVO3VuUnKzGO4ECFtYfz9ByUx692SwyaHQYuCO6+VUlqL/g
	 G4nrZiCuPqwrQ==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a3156692c6so666931fa.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 11:23:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwWSvB/kc5ZhO59ufzS6ZttwkfEKAAoNeh0JbIighVQj/atcDRgb/uSOULZ3/mcHb2p9tK2t3RHkw==@vger.kernel.org
X-Gm-Message-State: AFuF++k7XqdGA0SIGM/Wb0NonCLjVCs7qZbMkXXweopDoeyd6iNgFBNC
	KRfM+MNZyjGAdAbYLtDx5V4DGkpiNHlAP2MXXtDsMpIQ+CueVNQ+Hw1RnjduO7zCCUF7Tq/QQmR
	WreQqAO/H6kolExvSSQgukwWlEtQodx4=
X-Received: by 2002:a05:651c:19a7:b0:3a5:abfe:e241 with SMTP id
 38308e7fff4ca-3a6305e2846mr187451fa.11.1790101400053; Tue, 22 Sep 2026
 11:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-mb-pm-wakeup-v1-1-1c91ca80c87a@vt.edu>
In-Reply-To: <20260921-mb-pm-wakeup-v1-1-1c91ca80c87a@vt.edu>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 20:21:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g1Y=RCrwBkeLtgfgQc_kTZWLc12LqbqeMgNdTK47WhSQ@mail.gmail.com>
X-Gm-Features: AcwNN1Wlq4L3-HyGzDO83DGyn0Dmh_zA7OWjewaMKL-CZRRwpkb-K6-c-jqz55c
Message-ID: <CAJZ5v0g1Y=RCrwBkeLtgfgQc_kTZWLc12LqbqeMgNdTK47WhSQ@mail.gmail.com>
Subject: Re: [PATCH] PM: wakeup: publish events_check_enabled with release semantics
To: jaidevshastri@vt.edu
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:25=E2=80=AFAM Jaidev Shastri via B4 Relay
<devnull+jaidevshastri.vt.edu@kernel.org> wrote:
>
> From: Jaidev Shastri <jaidevshastri@vt.edu>
>
> pm_save_wakeup_count() stores saved_count and then events_check_enabled
> under events_lock. wakeup_source_report_event() reads
> events_check_enabled without the lock and counts the event.
>
> Store the flag with smp_store_release() and read it with
> smp_load_acquire(), so that the stores a reader may rely on after
> observing the flag are stated by the code.

And how exactly does this help?

> Found with MBCheck, a static herd7-based memory consistency checker.
>
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
> ---
>  drivers/base/power/wakeup.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 80b497de2..afc9fafaf 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -578,8 +578,11 @@ static void wakeup_source_activate(struct wakeup_sou=
rce *ws)
>  static void wakeup_source_report_event(struct wakeup_source *ws, bool ha=
rd)
>  {
>         ws->event_count++;
> -       /* This is racy, but the counter is approximate anyway. */
> -       if (events_check_enabled)
> +       /*
> +        * This is racy, but the counter is approximate anyway. The acqui=
re
> +        * pairs with the release in pm_save_wakeup_count().
> +        */
> +       if (smp_load_acquire(&events_check_enabled))
>                 ws->wakeup_count++;
>
>         if (!ws->active)
> @@ -1003,7 +1006,8 @@ bool pm_save_wakeup_count(unsigned int count)
>         split_counters(&cnt, &inpr);
>         if (cnt =3D=3D count && inpr =3D=3D 0) {
>                 saved_count =3D count;
> -               events_check_enabled =3D true;
> +               /* Pairs with the smp_load_acquire() in wakeup_source_rep=
ort_event(). */
> +               smp_store_release(&events_check_enabled, true);
>         }
>         raw_spin_unlock_irqrestore(&events_lock, flags);
>         return events_check_enabled;
>
> ---
> base-commit: 93f51579e7df248780214094418f205253383cc5
> change-id: 20260921-mb-pm-wakeup-6bc4f1592414
>
> Best regards,
> --
> Jaidev Shastri <jaidevshastri@vt.edu>
>
>
