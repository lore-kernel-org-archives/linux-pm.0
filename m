Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588F1296BCF
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923957; cv=none; b=pbFQZdOSCQ/R4/PydpgGmCrwfBTDt+6Th8uRV40NUoIbh+hrt+T8wyL6HVAWHD6qonCOSDV1f5pML56vxzwpvmrKe5d8O1IE6tQl7YtDWrXPEuQ58cvTk6TPfTPNee7y8DA7su/JlQ6su/cZ6cF4qEUrO1aIfpl9NXevn6/VJ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923957; c=relaxed/simple;
	bh=4fjaJr0ZeldOQf4B6Fd427ppyCOtVg1bv0/wHF8SuxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBLU+0vhzL7GRJFQKGLRsrOY7vKSsjwVPqXG5GdwS0cndX3z6xo45fiXR9AVEoAhlrh1XSNy4cu/NCWlEYHfP122F21JvwhWsb3uAhexiVsRpCPLBtWCbymjcOrko38IOCxhr1WBmAbY8vlT9A/jjug+x9PArPPSJvmTs0/MTZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq7jyF3h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq7jyF3h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04751F00893
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780923956;
	bh=j4Rfq/+pIS/+jiYpkehJ8iqAfj0ezZEeWSmtSY7h6pA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lq7jyF3hH4YMkDbsn5iNYWjF3C3Nlj5/u9TUkk6uRF15GE1KlInzTmH/ndux/gzoe
	 tv8mKL3BGnRxT6eMNgwNHkZotUDr23YaLy1BfyFIgtIOceQvMjR/bItyIUNEYTKeha
	 FncuxdeQV8AmBIkRReyps+RXn7N4bXO6NFek/mfIPev7jTqStCYQ13iaU5m2+IgAkt
	 6ygaFanM8BmSHg+heE9J6BqxG2HcVZsLFkz3h3ivr4+s+kKbIyqbJkmijvDRWT9fUJ
	 JO6/BvBjAwPGnVDtIAPu+5CKVs1pMfju+MRniIorwFSATgmOKeRnBseILl5BYK1+3u
	 cr8OTHmjmreTA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa7a7ad4d3so3458721e87.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:05:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+AvBDJvtOaPYfD876mj4ZDliQ5sPLIaYJ2jd5zNBv7MHf+xc6xE+cbohl6iFFH9FTXCXIIiONcsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVZctgXAlju85LlTOndKKDpyq0nPGs4QC4N44F0+T7cWZyidjo
	qhno8yO4KgvjhNlbzsugPXp2BjVS5sdStxgmgMtx1/8ICME7O0s2832VnTBuVDgyAuGCmi+UhZM
	B/+JOtSCACog/IXO7OPLInPgmM93mZbk=
X-Received: by 2002:a05:6512:66c5:b0:5aa:6603:5256 with SMTP id
 2adb3069b0e04-5aa87b80e6emr2827360e87.28.1780923954314; Mon, 08 Jun 2026
 06:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <if5efe4wlmbgls5ylj67jdfgqjwzpfmk536lar2v3djo5o7gux@6sbnyfo2c3kq>
In-Reply-To: <if5efe4wlmbgls5ylj67jdfgqjwzpfmk536lar2v3djo5o7gux@6sbnyfo2c3kq>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 15:05:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iCpg+sCNJnjPuRcM5QjdhKi4ejB4H=ARV56V21N6SrtQ@mail.gmail.com>
X-Gm-Features: AVVi8CdQdIzugxSUlZ5O5-IzG7ekxu4u4mrnHBGDzKDV56oyhzdHbY8jcxJNCIA
Message-ID: <CAJZ5v0iCpg+sCNJnjPuRcM5QjdhKi4ejB4H=ARV56V21N6SrtQ@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates 7.2
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 8:05=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e7=
31:
>
>   Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-u=
pdates-7.2
>
> for you to fetch changes up to b59020834b2d8718fe37a4e77367f554cbf95982:
>
>   opp: rust: mark OPP methods as inline (2026-05-25 09:40:52 +0530)
>
> ----------------------------------------------------------------
> OPP updates for 7.2
>
> - Fix memory leak and a potential race in the OPP core (Abdun Nihaal,
>   and Di Shen).
>
> - Mark Rust OPP methods as inline (Nicol=C3=A1s Antinori)
>
> ----------------------------------------------------------------
> Abdun Nihaal (1):
>       OPP: of: Fix potential memory leak in opp_parse_supplies()
>
> Di Shen (1):
>       OPP: Fix race between OPP addition and lookup
>
> Nicol=C3=A1s Antinori (1):
>       opp: rust: mark OPP methods as inline
>
>  drivers/opp/core.c | 5 ++---
>  drivers/opp/of.c   | 3 ++-
>  rust/kernel/opp.rs | 3 +++
>  3 files changed, 7 insertions(+), 4 deletions(-)

Pulled and added to linux-pm.git/linux-next, thanks!
