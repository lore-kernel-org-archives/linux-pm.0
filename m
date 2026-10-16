Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E6D47ECF9
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792152370; cv=none; b=BnllGZh2nhZlA9wQQZsr2aZ6eJ7zXCxcJiBg4ruNBvQwjZmPf21b28YLr7l8bmYA2jYH41SWnHYyHy1Aj9HJqIl4Zt7YSxag4fXhrZLSuWm56cnNoJVBn/wu+5YFotBCeb3nvQFo7HikkuHQhWLj6pO6VdD/FUEWCIX4yEyrw0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792152370; c=relaxed/simple;
	bh=xNEVlMkXFFl56beLu9OwRlFYPhqZ/tX+fw7U4mwLuFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTiW/+LtzlzML3cmEegUd0vofdRybnbclCFrAgkJcsM+9W0CX++zpG5dV84YJ6WumMOg6B5o6B4wLq7s3Aa9CdIs23ldny4BWi+dyJk4zLAFJHgXp9c6VKQnD0Py3N5ZdlJ5HYlmIbIcGTcVIBeL7EADzHz2lTuje1Uo99uQmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qjfebli0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qjfebli0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83CF1F000C5
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 12:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792152368;
	bh=z615JxEuk4WvMRb3fgdn1010HhazyHWcvydII0xt/vw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Qjfebli0iNKmNpBW2u39kTocpP326muebfW4qCpijtnIyIUHd0AkNMTHie6UDTqoA
	 iY6vOLDE3C+uNZ4C+TPJCaX9b1ZG2KFTUOPeYOehKIBr+1Agt/tBh5kNJPYfBmN2+V
	 xvJa+unTYOTRXcKES8bDIvFLPiDcwVUaaGv/2fU+bmHGOSjZyxLYNj1Oo3m3UQoaB/
	 96sst0agPvx/67zq760KI2NZ7fRgkmydcIGUZs2TGm66zaR3FsjkkZ8+LpPczj2oiG
	 fA9ud2vcZNNzDJbz48xo4jT4vpPW0dIdHQ+QrKuxpAS0BJfQ1aX41lLeqUMIcKfiVz
	 p/21AUFr/nKvQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5be4b61fd3dso570858e87.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 05:06:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxPSkcdRW+hZ7WcnTG/6aIg8iMaeg3x/se6nesj89UFBqTk4XxaU4ej7AAfszj7bRY0kOIK2cdFnQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJO9NHQSz4wjaO/wx0PaeCTSVH9AiENvexN3dt6qkjZu0RpqDwZ
	+Cafgcr3hBQIF013TZWUIKxNWV3bsfBHwfAdU/24cJIDAuAU0pRT9YL2EIcvM+G0waVaCxT/uWJ
	HP5UKeiLp3dzcEATH4OJSSD8F235V9AQ=
X-Received: by 2002:a05:6512:3189:b0:5b8:c05d:2ab6 with SMTP id
 2adb3069b0e04-5bcde3b0b87mr7509182e87.30.1792152367255; Fri, 16 Oct 2026
 05:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <atHBKtyNwXb8jK25@vireshk-B250M-D3H>
In-Reply-To: <atHBKtyNwXb8jK25@vireshk-B250M-D3H>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 16 Oct 2026 14:03:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g+OWSdmjPQB0EEi5tNXY99gCWQpgiHsaa+y2eZqFqRpA@mail.gmail.com>
X-Gm-Features: AclHuK8msS1Yo7x-wEOeZ4_GDB2b4-RgpCMAtAvDRT8huMZ1asYHcW7vtsiCyik
Message-ID: <CAJZ5v0g+OWSdmjPQB0EEi5tNXY99gCWQpgiHsaa+y2eZqFqRpA@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates 7.4
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 8:16=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> The following changes since commit 1f6de65e3314519ce462bfd3a1d29e918f97e4=
e5:
>
>   opp: fix use after free in _update_opp_table_clk() (2026-09-09 10:23:05=
 +0530)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-u=
pdates-7.4
>
> for you to fetch changes up to 706081c6b9327dd611dd72b20130a77f0f059b6e:
>
>   OPP: Fix the return value in dev_pm_opp_get_of_node() kernel-doc (2026-=
10-01 11:40:49 +0530)
>
> ----------------------------------------------------------------
> OPP updates for 7.4
>
> - Fix the return value in dev_pm_opp_get_of_node() kernel-doc (Karl Mehlt=
retter).
>
> ----------------------------------------------------------------
> Karl Mehltretter (1):
>       OPP: Fix the return value in dev_pm_opp_get_of_node() kernel-doc
>
>  drivers/opp/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!
