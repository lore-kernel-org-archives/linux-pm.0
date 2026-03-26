Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4063A6B83
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551827; cv=none; b=ImlSVtxPiFmixgkz72MDDWH8h65FkcMBrV+1JIc//Co6yUGxeJT+khHc+FERV9qTbTlpFYEvL9VVg3DzXvD2EYWVttFMokvk1ItV+vBhMqq5R5dCp1G3LtdaGp4ki8DsJ6huDfstvf3bm+8ro/5qt+okRWiPkaw+LMyrGcXzaYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551827; c=relaxed/simple;
	bh=gz8nBEjqEItblgr8hqPFxg+Pu31hhDQwn7DY+WmVYKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBaFjup2vmI1ZMQic1jXikx9hp6m0Md35FiA4pPgUNeRsLxyiZanZCAmIzD86bMGP0BTKxsqE7i8SBqxJj5ucze0zpZiFr7bco+ADStYJgrhMj/Qr9G5nKPVLeE79EuIm8rw3xBUyTusRydUjo1hF6wWdmHaXJh56IGgB6/0IzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TezXqOP9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TezXqOP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E753C2BC87
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 19:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774551827;
	bh=gz8nBEjqEItblgr8hqPFxg+Pu31hhDQwn7DY+WmVYKc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TezXqOP9UWX92fMdbNdqi9JI+iCP1KFlwkYE/DtZbO6VB5BodigZJU75AwlLUjF22
	 j9/PWXgQ2OOdDE13KgJa85jlpCOrlPlV/83Ae5XU0T2aqHG/8q3V3ajdhKHsxr2WlI
	 utYJ5mFzYJNTeXS5JMdp0kpTW7y7PZ443UAq7pyMGBah0qhXC0VUeXZdWTQSd5qPsH
	 Gnu8h1gVKwBgVqyL2BUxUfd00Y79Bn5e0Wz4JlalfR5i/A7g9a571xyXNivCRXtomJ
	 3HOaaIqGfuWKFDqERcwKRN1EJkvLr5dGy+vysnjSVPbLyzSjZs6+0qzglG0u9tXOr3
	 44ZmRvUe2SyHw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4043b909ed4so849958fac.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 12:03:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVw1TSjp3i2yr2De+jUapewm78af8x4wDS3hpwUauuPfvTpyMk7Rz79M2NAHw6aQK8gGwbvskqKbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzMasjaslFGxCpJrPWBMb+o5IOsstwnkaQh2QWvUvgW7U4k/Sf
	3oZvHTul4V+rj1XcuFfxYxGH3k2Mv6r66XGrql2b2uhtsfoeqocB4Bc+pVEgkX88a63EnBpor6A
	uQf95H290apYll5x/P1q/PuTXeK3i9oA=
X-Received: by 2002:a05:6870:506a:b0:417:1165:cf2e with SMTP id
 586e51a60fabf-41ca6cf6b9cmr4823782fac.6.1774551826527; Thu, 26 Mar 2026
 12:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12876512.O9o76ZdvQC@rafael.j.wysocki> <4f1186a042ed78f06d8f2ce1eb6f3ce3@igalia.com>
In-Reply-To: <4f1186a042ed78f06d8f2ce1eb6f3ce3@igalia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Mar 2026 20:03:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hmkRsz2A0sh4PdEY9V=gLJejWH=kMJH6hR_bh=Q9ZdfA@mail.gmail.com>
X-Gm-Features: AQROBzAE2CuGnptFACR19nsLgMZ1FM3MmFlMITCRdxnkEP2kxPUuatpJ_05mcIc
Message-ID: <CAJZ5v0hmkRsz2A0sh4PdEY9V=gLJejWH=kMJH6hR_bh=Q9ZdfA@mail.gmail.com>
Subject: Re: [PATCH v1] thermal: core: Address thermal zone removal races with resume
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 7:35=E2=80=AFPM Mauricio Faria de Oliveira
<mfo@igalia.com> wrote:
>
> On 2026-03-26 08:45, Rafael J. Wysocki wrote:
> > Address the first failing scenario by ensuring that no thermal work
> > items will be running when thermal_pm_notify_complete() is called.
> > For this purpose, first move the cancel_delayed_work() call from
> > thermal_zone_pm_complete() to thermal_zone_pm_prepare() to prevent
> > new work from entering the workqueue going forward.  Next, switch
> > over to using a dedicated workqueue for thermal events and update
> > the code in thermal_pm_notify() to flush that workqueue after
> > thermal_pm_notify_prepare() has returned which will take care of
> > all leftover thermal work already on the workqueue (that leftover
> > work would do nothing useful anyway because all of the thermal zones
> > have been flagged as suspended).
>
> Thanks for coming up with this alternative. I spent some time earlier
> today thinking of corner cases in that it might fail, and it held OK.
>
> However, slightly unrelated: apparently, flushing the workqueue in
> thermal_pm_notify() reintroduces the issue addressed by the Fixes:
> commit, but moving it from PM_POST_* to PM_*_PREPARE?

Note that the work in question will be thermal_zone_device_check(),
which simply calls thermal_zone_device_update() that essentially
invokes __thermal_zone_device_update() under tz->lock.

Thus thermal_zone_device_update() can only run as a whole before or
after thermal_zone_pm_complete() for the given zone because the latter
also acquires tz->lock and releases it at the end.  If it runs before
the latter, it will be waited for because the latter will block on the
lock, but that happens without the changes in the $subject patch.  If
it runs after the latter, __thermal_zone_device_update() will see that
tz->state is not TZ_STATE_READY (because TZ_STATE_FLAG_SUSPENDED is
set) and it will bail out immediately.

So I don't see the problem here.

PM_POST_* is different because thermal_zone_device_resume() calls
__thermal_zone_device_update() when tz->state is TZ_STATE_READY and
that may take time.

> IIIUC, that issue is __thermal_zone_device_update() might take long
> thus block other thermal zones and other PM notifiers after thermal.
>
> Apparently, at least the latter also applies to PM_*_PREPARE?

Not at the point when the flush_workqueue() is called.

> Say, a currently running work item (i.e., that cancel_delayed_work()
> cannot cancel) wins the race for tz->lock and doesn't see tz->state
> TZ_STATE_FLAG_SUSPENDED set, so it runs, and say it might take long.
>
> Now, the workqueue flush blocks on it, also taking long, which thus
> blocks other PM notifiers.
>
> > The second failing scenario is addressed by adding a tz->state check
> > to thermal_zone_device_resume() to prevent it from reinitializing
> > the poll_queue delayed work if the thermal zone is going away.
>
> This also held OK in the thinking of corner cases.

Thanks for the feedback!
