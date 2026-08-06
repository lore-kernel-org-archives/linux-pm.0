Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371D221739
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020453; cv=none; b=lsQLc28SRooES+elPpIXcFVjYq5NTdQzvfloau4bAY9RPvAQDml3XOTnn3IQEOvuBzcYdgt0PEdc+e+3hSyu0e9VTMQf7yjnromy60x0OgtLZY/7SSKMPHElqcFbEiQEcoesamn9wKy8fy2jlAO7ungYmoq0cq5k+VXGN7wiEe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020453; c=relaxed/simple;
	bh=gC0B1K1DEtTxVSqmMqG1zok5Vah6jo60P/KjGQYVQQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CV8ZPnOGx5S98sEcyo5jP8k8cJwQh/TfRvY1uM1kq+GxOYxyuv7tJVHFIxYgP5WmyUWD1TRVwOr7JMQ3eYvkE9wI5WsdLrxbPk852m5SHaw6yRm5zuBv3AgYVNZKAuQGW/7yeakS1PFSkxTdUdFwNqCqoJlzV2LvAhv9328sMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvQzJvB1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvQzJvB1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D911F00A3D
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 12:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020452;
	bh=7wuv5KnYemlMPmaSV5TvoZOIEsalyuyzidgXASISB0M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XvQzJvB1Qq2cThZexTX/KviqYRqDd8jlLfn6PJA6smZ/c9tTf2zWsPs0LW9iJcNcl
	 hb+77sJJuM3rdhiwEXuEOsdY74chal+RLW8FnNrcgTinW6B+4rzswHmNbQ+maRAeXe
	 13uUgyxrNE5+hBtR4ATLIF6oI5YAsSzKJFQaRr76xI4m4sM5mOMZ7X3qpvG4ZLf/Qa
	 qshg7jVPnDdjtEUvHUZMlB0VNgueiTF+OYJEFrC7a3nHQAWdKO30ZDHhvUfGne1IMe
	 DDOf89NsrD7m2M9znkLblQ7dYlUCku4EOyg6yxIGl6tZvGOUtawWsJ0CgJi7NA4Y78
	 8KNI53VtbLXWw==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso1999906e87.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 05:47:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RohbvT/P2bf2X5FyY0jZiA+tvu+K6Q0I4RATi3jWXTDwMyVpdhf0EN1DKIj+My6BRLSY+xbY7KSpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMNFZos0MaiuJZ3NlDoe9gqBPekCIpcAbpgvNF8hqkmcI0F0zV
	U0LUMscCXAuhy1Xe9dMk/qQLp8Wg+snwwz2vQ28Yd9aN6oPvAP8SGF0dVmrSXJ2hXwblWmtFens
	AMRmg/sFV0UNPVanI3r+tl48OrMVYMcc=
X-Received: by 2002:a05:6512:1326:b0:5ae:b36d:bb1 with SMTP id
 2adb3069b0e04-5b303b38394mr245236e87.4.1786020450446; Thu, 06 Aug 2026
 05:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ji5tgqbqadfypamzmr26pizz6f6mrvr75wndg5nd7exa52vm7u@eksikcoeenpj>
In-Reply-To: <ji5tgqbqadfypamzmr26pizz6f6mrvr75wndg5nd7exa52vm7u@eksikcoeenpj>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 6 Aug 2026 14:47:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hYb8QwZk7pzGntXZXK-ijmhFtBh415z+Ev+OSQ2R1F-Q@mail.gmail.com>
X-Gm-Features: AUfX_mx_TtMLDtFNcNlgRKgbHW2UJmbjfez4k3Y9mxhRKqs0XhMxJ5mXtjAi-9k
Message-ID: <CAJZ5v0hYb8QwZk7pzGntXZXK-ijmhFtBh415z+Ev+OSQ2R1F-Q@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 7.3
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 8:41=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e524917774=
82:
>
>   Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-7.3
>
> for you to fetch changes up to 8c3afcf27fa4582c1ab912503dc8a4ebb8dc0f82:
>
>   cpufreq: imx6q: fix out-of-bounds write when probed more than once (202=
6-08-06 11:54:41 +0530)
>
> ----------------------------------------------------------------
> CPUFreq arm updates for 7.3
>
> - Minor fixes / cleanups in cpufreq drivers (Dan Carpenter, Guru Das
>   Srinagesh, Haoxiang Li, Karl Mehltretter, Sasha Finkelstein, and Pan
>   Chuang).
>
> - Fix cpufreq table creation and bios_limits() callback in the Rust
>   bindings (Priya Bala Govindasamy).
>
> - Add IPQ5210 support to qcom-nvmem driver (Varadarajan Narayanan).
>
> ----------------------------------------------------------------
> Dan Carpenter (1):
>       cpufreq: spear: Fix an IS_ERR() vs NULL bug in spear1340_set_cpu_ra=
te()
>
> Guru Das Srinagesh (1):
>       rust: rcpufreq_dt: use vertical import style
>
> Haoxiang Li (1):
>       cpufreq: apple-soc: Fix OPP table cleanup
>
> Karl Mehltretter (2):
>       cpufreq: imx6q: fix devres accumulation across driver rebind
>       cpufreq: imx6q: fix out-of-bounds write when probed more than once
>
> Pan Chuang (1):
>       cpufreq: brcmstb-avs: Remove redundant dev_err()
>
> Priya Bala Govindasamy (2):
>       rust: cpufreq: Add CPUFREQ_TABLE_END as last table entry in TableBu=
ilder::to_table
>       rust: cpufreq: Fix temporary write in Registration::bios_limit_call=
back
>
> Sasha Finkelstein (1):
>       cpufreq: apple-soc: Calculate frequency as a 64-bit value
>
> Varadarajan Narayanan (1):
>       cpufreq: qcom-nvmem: Add IPQ5210 support
>
>  drivers/cpufreq/apple-soc-cpufreq.c   | 38 +++++++++++++++--------------=
---------
>  drivers/cpufreq/brcmstb-avs-cpufreq.c |  5 +----
>  drivers/cpufreq/cpufreq-dt-platdev.c  |  1 +
>  drivers/cpufreq/imx6q-cpufreq.c       |  6 ++++--
>  drivers/cpufreq/qcom-cpufreq-nvmem.c  |  8 ++++++++
>  drivers/cpufreq/rcpufreq_dt.rs        | 13 ++++++++++---
>  drivers/cpufreq/spear-cpufreq.c       |  4 ++--
>  rust/kernel/cpufreq.rs                | 24 +++++++++++++++++-------
>  8 files changed, 58 insertions(+), 41 deletions(-)
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!
