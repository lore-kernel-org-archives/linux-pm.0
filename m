Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2E2F616A
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486126; cv=none; b=d6ixZQbwwCHtUP25IEDtA+TljDycFPBtWXijzTpSugyjvoNFaVaDM+2WdA+7N7t2vs+Ybtu9uBbSE8lHaRtzRJdaD0KPlkY0QQSwk6siIn4kbFxI7gmEJon6zSbi4TUa6KHo8n8qGfDen15zfsS4K8ljF84FDqh9GowMlxpotP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486126; c=relaxed/simple;
	bh=Urb3YHwnX9sR9NLaH/BJtx2EmnSDsezpkNx7r+w/r9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YL7VdlgTyAX6CxMgVA5qIVFNKNNfeE422cD2vDewrEWHD6QtEc8LXbNgclk11YGT2olwJNavjb1QrChftB1yb9ii+0QtgXpwn0Cyu7zIfK16IWUIQAObWTtNIorpxP6qN0+LvDxliUCXrskRstx22ljn01/91b1evT5l0+O7bds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/dhpVn5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/dhpVn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10E9C2BCB0
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 14:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775486125;
	bh=Urb3YHwnX9sR9NLaH/BJtx2EmnSDsezpkNx7r+w/r9s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f/dhpVn5vCXTX0OEX4lhqzdrkWQwOQNQWxd+dhgf5DL865XiS1au017PX/h8WJBfg
	 IT4yXwEA9I/sojhaR8asLESyyCZKdthsckZmdhIZew/UavJgzCLDPV8EW3HYPWtzOj
	 LXSJW98mumiLHOw0uP5PtLi5wdhEhFamodrngFe462QCJjHoc3g2qouhUhRBThoyM/
	 wmTZVbSbRyDRkZhHDBiyibP3pauwE356nvzshJiVLCvqv2cZqNesqZ5B5ybPWhfNhW
	 1JBJdNxthX56idGjqIh3267fWG6wj8Gw+lcbSpTLsn8EBYNhAP/jT8l/r+E0Go99Jz
	 pkVpqAd+lO/DQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-42321c8b8f5so1915591fac.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 07:35:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbBRNIWCmhl7OtD/iY/V3wHjCBsqeBjUgGy5PgGLByz67mIVVqhDl/dcMQbCE2b1wRP5vJb8k7rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX0ymJzKM+wBc/NFami/N+ksRD1mfhi0Yv9mUvuuOJUd6kR9oL
	T5NSmi1dFWtmdTHBrtTUEDlOMNAoVn7kMcnSArVc50XyQ9eSIR7SxZbu10brbWBnEyjYTrYqAYB
	Reh3Gj9BPYafHkfgTYN2EiW9hhDT77+c=
X-Received: by 2002:a05:6871:7282:b0:417:23f7:6df5 with SMTP id
 586e51a60fabf-422f35aa008mr7841959fac.7.1775486124998; Mon, 06 Apr 2026
 07:35:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a4lvsuklad2ab3tynq34oiuu36rn53fkf6ert7al2tuvgyjziw@wkiqji6svbdj>
In-Reply-To: <a4lvsuklad2ab3tynq34oiuu36rn53fkf6ert7al2tuvgyjziw@wkiqji6svbdj>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 6 Apr 2026 16:35:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g58kA04UhyKw_p9BXhTxCFih53_HZq+N2CvaMcM2LSbg@mail.gmail.com>
X-Gm-Features: AQROBzCJkv6-m2IhsqdanRG5yXcnGJFtHUosr1-hsQ2a2icp30uHxYfBnamhP1Q
Message-ID: <CAJZ5v0g58kA04UhyKw_p9BXhTxCFih53_HZq+N2CvaMcM2LSbg@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 7.1
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 1:01=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f2=
7f:
>
>   Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-7.1-rc1
>
> for you to fetch changes up to 8655a4e35cda5534f93303af393eac4e71704701:
>
>   cpufreq: tegra194: remove COMPILE_TEST (2026-03-20 11:03:33 +0530)
>
> ----------------------------------------------------------------
> CPUFreq arm updates for 7.1
>
> - Update qcom-hw DT bindings to include Eliza hardware (Abel Vesa).
>
> - Update cpufreq-dt-platdev blocklist (Faruque Ansari).
>
> - Minor updates to driver and dt-bindings for Tegra (Thierry Reding and R=
osen Penev).
>
> - Add MAINTAINERS entry for CPPC driver (Viresh Kumar).
>
> ----------------------------------------------------------------
> Abel Vesa (1):
>       dt-bindings: cpufreq: qcom-hw: document Eliza cpufreq hardware
>
> Faruque Ansari (1):
>       cpufreq: Add QCS8300 to cpufreq-dt-platdev blocklist
>
> Rosen Penev (1):
>       cpufreq: tegra194: remove COMPILE_TEST
>
> Thierry Reding (2):
>       dt-bindings: arm: nvidia: Document the Tegra238 CCPLEX cluster
>       cpufreq: tegra194: Rename Tegra239 to Tegra238
>
> Viresh Kumar (1):
>       cpufreq: Add MAINTAINERS entry for CPPC driver
>
>  Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.=
yaml |  1 +
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml          =
     |  1 +
>  MAINTAINERS                                                             =
     | 23 +++++++++++++++++------
>  drivers/cpufreq/Kconfig.arm                                             =
     |  2 +-
>  drivers/cpufreq/cpufreq-dt-platdev.c                                    =
     |  1 +
>  drivers/cpufreq/tegra194-cpufreq.c                                      =
     |  4 ++--
>  6 files changed, 23 insertions(+), 9 deletions(-)
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!
