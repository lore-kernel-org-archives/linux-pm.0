Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3B64DE722
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773104; cv=none; b=HnYKfHzbrKiVcQ7+GXKLLFYGoAG9jqvHLKvT6Bd4g3QvvUptKFupJclq0+iL3zKY1JOqTWSNmwG8yly5auCBpCqR7d+BDC9lq+vAZvUCXq167VsiC6s9D+GT14X5/7aR7UFDmF7pqlw9FxUcptD52jmboQqcB6MXfd4XPxBg1/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773104; c=relaxed/simple;
	bh=rZtgfYv2AO/zXiME8s9cxVQxA8YtBrtrul1J15Yqh6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTODioTxRHTDN2L/r96BsVrcz5UDYMjo6PaOGo/Z9pvHqDOrvoIbuBG16Fo5Q2QFQNNagdwhE3KI4XJDQQj0fwYmLJcdEsByrNagfCJurjHBBtsnOTwULndvo8+9hvhDToZE9vMkN+lKeWrOMNsjOArg9VwTMoDEVoLe2iII6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp5FnBXt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp5FnBXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C151F00898
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 12:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773100;
	bh=4R7QyzFU4jTnN6KZN+qcbI1ITL23TDjJrOjMQnK+HN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Sp5FnBXt/plkqGRy1LSUTeI5QP3TY75xFol2CjTifZzxgOE+Iwma2HkBoDSDipYiT
	 tGdhLACm/9pws0BKK81u08zgmk6g6C+FR7Iz/HSkkFONz9OrumVPf/3fFRtpXYwTl7
	 mlIYVcTfV+TjOtrM4l6EXT6scsemvGOxAuTlsnYxwA+FzjnO5dSkb8RsVLYVeZm5iw
	 b0Gqi0tXSAihuw5y0mvtLU1zKWY7VUhqoJYCHvTiMD+SEhIm7O1ytd4EmffYOI0Llj
	 PEnZ4iIY/mOjxLeyV/AjF/rp0rlGXO+1Uv64w1Cm0kc+1xn2esD1lKRbbohzDczswo
	 braUflZTXnmKQ==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a77da28307so3406881fa.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 05:58:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByC252g3ScqkPWRGSzrWZnj84jZx7Qt61uBmdjsH/yBeagiSXvx4PTkCT5eOHdQwlwpCDxuMd109Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYLr7ahYMh1cXiSbqgA872RhuQVoo4WeNGiA8LKhjd5b5z/NK20A
	ChZilFRo3FpIVH8Niz5B/MFdMXOO+tZdeoNznuHdIPdapWmpOHkOtlGeyU9SKNx+9ovqn2Ipe9g
	i/dHdQ8ec7Vmux+hgAbB2tUJHKjBT0TE=
X-Received: by 2002:a05:651c:3241:b0:3a6:67d9:af17 with SMTP id
 38308e7fff4ca-3a779224357mr4250621fa.12.1790773098770; Wed, 30 Sep 2026
 05:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930025044.104824-1-briannorris@chromium.org>
In-Reply-To: <20260930025044.104824-1-briannorris@chromium.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 30 Sep 2026 14:56:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i-xqbWniqWKyVbxVLVtoYDHcRfAdamGW2OkvvOm14Www@mail.gmail.com>
X-Gm-Features: AclHuK9KMt3PbkIr8TeO0dsSVJCSy3r0lAsA67o9HxEJBJtWEfvyvGCvOEsCYfs
Message-ID: <CAJZ5v0i-xqbWniqWKyVbxVLVtoYDHcRfAdamGW2OkvvOm14Www@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] PM: runtime: Overhaul kerneldoc, runtime_pm.rst docs
To: Brian Norris <briannorris@chromium.org>
Cc: Pavel Machek <pavel@kernel.org>, Doug Anderson <dianders@chromium.org>, 
	Ulf Hansson <ulfh@kernel.org>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 4:51=E2=80=AFAM Brian Norris <briannorris@chromium.=
org> wrote:
>
> The runtime PM documentation could use some improvements and additions,
> to help guide people less familiar with the main runtime PM concepts and
> its internal implementation details.
>
> v1 is here:
> https://lore.kernel.org/all/20260904212000.4167880-1-briannorris@chromium=
.org/
>
> v2 is here:
> https://lore.kernel.org/all/20260923174711.1283986-1-briannorris@chromium=
.org/
>
> The first part of the v1 series has already been applied. For the
> remaining work:
>
>  - Formatting and clarity improvements.
>
>  - Clarifying core concepts in the Introduction. (Pretty much all new
>    readers I encounter have a hard time with the difference between
>    "enabled", "allowed", and "active".)
>
>  - Adding Example driver patterns -- because the API is so large and
>    complicated, it can help to try to walk people through standard
>    practices, and what everything means in context.
>
> I tried to keep some of the larger changes toward the end, to hopefully
> make it easier to rework or reject them while cherry-picking some of the
> easier stuff from the first part of the series.
>
> Feel free to add suggestions! Within reason, I'm open to tackling more
> here, as I think many people have many valid perspectives on exactly why
> and how the docs do or don't serve people well today. Or I can tackle
> less, if you think some of my choices are not improvements.
>
> Some possible follow-ups I'm toying with:
>
>  * Slimming down the API might be better than heavily documenting it. A
>    smaller API is a more digestible API.
>
>    My only concrete next step: drop __pm_runtime_put_autosuspend(). Its
>    last user is nearly gone:
>    https://lore.kernel.org/all/20260806-smmu-rpm-v4-1-8183d007331c@oss.qu=
alcomm.com/
>
>    I could also see deprecating one of
>    pm_runtime_put_sync{,_suspend,_autosuspend}(). They all do slightly
>    different things, but I'm not sure every difference is actually fully
>    intentional (or at least, not necessary).
>
>  * Tweaking some of the behavior on pm_runtime_barrier(). Today, it's
>    very asymmetric, as it prefers resume. But I believe there may be
>    value in making it flush (not just cancel) pending suspend too. That
>    may be in a future proposal; for now, I just try to make its
>    asymmetry more clear in the docs.
>
>  * Sand down some more rough edges on return codes. For example, it's
>    very difficult to get any useful meaning out of pm_runtime_put_sync()
>    return codes. There's a high chance that anyone trying to treat
>    return codes as errors is inviting bugs. (Is -EAGAIN a failure?)
>
>    Of course, the answer there is not "document it better" -- we can
>    make it easier to use.
>
>  * Adjust the way devm_pm_runtime_enable() works, specifically for
>    remove()/teardown. Currently, this is very hard to use correctly --
>    some common driver patterns may assume that a device will tear down
>    while RPM_SUSPENDED; but that's not actually guaranteed. Notably,
>    this makes some of the "Examples" section fairly tricky/subtle.
>
> Regards,
> Brian
>
> Changes in v3:
>  * Misc formatting improvements
>  * Rewrite Examples to avoid devm_* at first, to highlight correct
>    approaches
>  * Include error-handling and remove() in any probe() Examples
>  * Advise more caution when using devm_*, as ordering issues are subtle
>
> Changes in v2:
>  * Major rework on Introduction section, especially regarding "enabled"
>    and "active"
>  * Add appropriate teardown to "Probe with Hardware Powered Off"
>    Example, as the remove() + power-off behavior is subtle here, and
>    easy to get wrong
>  * Drop changes that are already applied
>  * Add a few new fix patches, noticed while reviewing the rest
>  * Move Introduction patch near the end of the series, as it is a likely
>    target for further discussion and modification.
>  * Correct Ulf's email address
>  * CC linux-doc
>
> Brian Norris (8):
>   PM: runtime: Correct pm_runtime_autosuspend_expiration() doc
>   PM: runtime: More kerneldoc formatting
>   PM: runtime: Misc improvements to runtime_pm.rst
>   PM: runtime: Add "Section" hyperlinks
>   PM: runtime: Clarify ->runtime_idle() callback return value handling
>   PM: runtime: Clarify driver callback expectations and structure
>     Section 2
>   PM: runtime: Expand introduction with core concepts and structure
>   PM: runtime: Add Example Driver Patterns section

Patches [1-6/8] are fine with me now, so applied (as 7.4 material).

I will send comments on patch [7/8] separately and the last one is
still under review.

Thanks!
