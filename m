Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960D33806DA
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486101; cv=none; b=adFsUpjCPpZD2peQzblpOFGYfeYZuBzI27cAjTYljCEW/OzqLfNPAplrfdc9pLiGsEAhMsx61Omok/LKddMy3JIRLxlXQO/tRfl/l1ZSWBE37qd7Tm5fQsbGujvWNu/+vBA0KwghqTyKU7xH/XtM+zblakRUCOTKjZ/yQ2S/55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486101; c=relaxed/simple;
	bh=Ed1O0V24YKthIkCikhjWcfEOCZzLWHltJG4R6WL1/aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMPqU0rvhkQuvi+yQU3TN7y7GOfxN9RKZArh912X8cSL+PIt/Qz5kdUPcma28piyf69HBUC5qzsjzGlP3+hatP39EURPzS0ewqUoWC8xI/S79Q5mqFwUBikGiNQqUozXNxr7rjtvRCIxxd+BByKJW1X/tZgQUAZV9NTkNLFPfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tO93thFh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tO93thFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C80C2BCAF
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 14:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775486101;
	bh=Ed1O0V24YKthIkCikhjWcfEOCZzLWHltJG4R6WL1/aU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tO93thFhACZuWehl0/1FSyWPJNKaMJWym8LHKrA3vPf+kQo3poIif1zI1/LsFhHHQ
	 XFcxwWxSivLplTGRblbgby4DJC7aaGVrOXDWTdBMOrXpjWfaItyll61LzTJC4vd+dm
	 AQTxQuLQvzqDbcyoN187E9a/33K4HlwaxzGJ0RIwfp6Hn7re+kiFwqhLBULRLw/bLn
	 M4ULejbX+LTPDVT+HxGi7fORhbYv2DxkIx58GywLWfDqQplMk02oaa1EynJhKRsnEj
	 4/HUphE57TLoAKen88eD9tjhP8ch4lZKbIUqZ5uWufDRuV2cf84Bf2r3rx0jM3er0G
	 KaM8xlL3MqU5w==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-662f30d3f1fso2667806eaf.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 07:35:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZ7qqfzxQS4RqV3geKFkD3hqqucpQ6IwgKyGGOEEnY4t5tZYrn2BpfSXbcp3Ken9n6Vi09l75oEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl8iFCQXSEGBRqyNVz/3Tn1FCkYQNRZJutxEyH5fXHziQxJ5kw
	YfHr4GbGRof11GdzLvBMG2n5BoyNEwcdNM6ukt29ROL4pHAQJlkk1846Iz8Uc3dHUBWtz/KXW3W
	qe5/QSCXNycMh7OOuT8IbDsbauOpaFnM=
X-Received: by 2002:a05:6820:81c4:b0:67d:e11f:5e90 with SMTP id
 006d021491bc7-6822024ed55mr6529811eaf.16.1775486100449; Mon, 06 Apr 2026
 07:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <qgpnmh6sh5abdgrgxv2so6xo3ktn43vhvykv3sn6z3224iioks@qukoxvvz6cis>
In-Reply-To: <qgpnmh6sh5abdgrgxv2so6xo3ktn43vhvykv3sn6z3224iioks@qukoxvvz6cis>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Apr 2026 16:34:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jOpox0DOTYngfZuYZx=KpXomxLmmkBJnZoBTn413XF0Q@mail.gmail.com>
X-Gm-Features: AQROBzCzLpm1G8r02HUyKxHt7FbamR1NgWc_MKnIzw77S_mkdXyFfoERW6r1lws
Message-ID: <CAJZ5v0jOpox0DOTYngfZuYZx=KpXomxLmmkBJnZoBTn413XF0Q@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates 7.1
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 1:00=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f2=
7f:
>
>   Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-u=
pdates-7.1-rc1
>
> for you to fetch changes up to 3d2398f44a2d48fb1c575a6e0bc6b38f3e689e22:
>
>   OPP: Move break out of scoped_guard in dev_pm_opp_xlate_required_opp() =
(2026-02-23 11:05:59 +0530)
>
> ----------------------------------------------------------------
> OPP updates for 7.1
>
> - Use performance level if available to distinguish between rates in
>   debugfs (Manivannan Sadhasivam).
>
> - Fix scoped_guard in dev_pm_opp_xlate_required_opp() (Viresh Kumar).
>
> ----------------------------------------------------------------
> Manivannan Sadhasivam (1):
>       OPP: debugfs: Use performance level if available to distinguish bet=
ween rates
>
> Viresh Kumar (1):
>       OPP: Move break out of scoped_guard in dev_pm_opp_xlate_required_op=
p()
>
>  drivers/opp/core.c    |  2 +-
>  drivers/opp/debugfs.c | 20 +++++++++++---------
>  2 files changed, 12 insertions(+), 10 deletions(-)
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!
