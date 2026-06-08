Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A372DF719
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924008; cv=none; b=eFO7MjbIkKeRGbXjOwTSP+7por7YyW1zssAax3buf7AMkHch2DbWDqkyuhxLs5lxatyupObQcFKKqk8D4kqEzmVBEbXI2cLZiM9mPom3VskwsnGL8HylltiWLOOta8ib9c63Kw0pRpN0hdSOA42WWI90UKKsdPaZRUhxJlAuuos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924008; c=relaxed/simple;
	bh=rISzRwdhuOp8LkRfHxZZ81PDKV8gwW6WJTidoJvIoCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VM0K6L3BXIKMcgfKkpbKScCDLSYKmnWkbqew2VWqxTaGovZIOvBcXsorqo7REHKYI8vLJDr0NSha8jvss/u3EmZkLbynvbJDikVjsyErxOs9VTCt3liKsXXLUVeOXQcJc62JY7fVEtB66j3cX6PHK7KcQ7TnkQBF2irQB6ROuAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zti2KLGV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zti2KLGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEE21F00898
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780924006;
	bh=TfZC+ezIZKbyGLVars9C7RGvL2BO+FmYxMv61waLUrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Zti2KLGVK+xfuUvIP3c3llrw/WQO6D173f4FA9B6qnx0ft1c3sfAdp8tKPK2EtR4S
	 HPxd1xo5/InrrLxjy7hJ7u6sd5Hc9aAJboiO53s5shStuMGorT/CJ/3abbtBZE/pcX
	 cIzWvlg0bRdMJg2lQw8NxnJ+CToTmg2j2kwzyHNzyMvsgM4DLkV2qDrNH9vONb7DKN
	 /GWL13ilpoxQAduGCwriMAWGJyQCSAwx/5oteRDyRbZErtBdOJmrWd/wtMd88gx675
	 wSJ0Lz/Ul23lmFcEfIG6KEDtRcJBHDi9GqZ/Xnw9iaN9SZsC+6QJBYfVHHZJxTylJ3
	 nOUXzEYIsTjYQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-396775c26e0so39232631fa.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:06:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8zmDjQJAYxeAwXQWSGR4WUJ8IWoaiMEymutho6QAu1mxBiAszPQrblJAmI1sJRO69+/vAhio683g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ct6OoCboyMR5oYTr0XU6xnZThF41ajoOhWEXynWJs7F6xPX4
	l+e9kLx7mSku4gTRERs2QIBjx/4H5TPKRHTERdETaHiLSXXLBfnqxh/T6lmwrRpsiSQIKXl/CFr
	J7jqg48WDXZzoPtcxU4V+g0x7YjB3em8=
X-Received: by 2002:a05:6512:2241:b0:5a8:6f4a:6a62 with SMTP id
 2adb3069b0e04-5aa87c1e5demr4922681e87.41.1780924005140; Mon, 08 Jun 2026
 06:06:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bzbh6b62uekudzc6zqyiezhbeke4g6b5hde35yr5hsgyhsn33u@k6t254axv6l3>
In-Reply-To: <bzbh6b62uekudzc6zqyiezhbeke4g6b5hde35yr5hsgyhsn33u@k6t254axv6l3>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 15:06:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hA6iu_zFTzdr3VApjiAK5DLQ0B+uDTrVwf+P0wPJdzow@mail.gmail.com>
X-Gm-Features: AVVi8CdLmdjaIgtUsHbGIxhOHEU3lzZtlHZHnXoxdY33LgoICKSQkvSrz2Rd4Lw
Message-ID: <CAJZ5v0hA6iu_zFTzdr3VApjiAK5DLQ0B+uDTrVwf+P0wPJdzow@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 7.2
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 7:58=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> Hi,

Hello,

> The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e7=
31:
>
>   Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufr=
eq-arm-updates-7.2
>
> for you to fetch changes up to b7a76f38ef3500d53ec87489c445fec8100c7a6b:
>
>   cpufreq: ti: Add EPROBE_DEFER for K3 SoCs (2026-06-08 11:16:42 +0530)
>
> ----------------------------------------------------------------
> CPUFreq arm updates for 7.2
>
> - Add cpufreq scaling support for Qualcomm Shikra SoC (Taniya Das, and
>   Imran Shaik).
>
> - Minor fixes for cpufreq drivers (Krzysztof Kozlowski, Akashdeep Kaur,
>   Hans Zhang, Guangshuo Li, and Xueqin Luo).
>
> ----------------------------------------------------------------
> Akashdeep Kaur (1):
>       cpufreq: ti: Add EPROBE_DEFER for K3 SoCs
>
> Guangshuo Li (1):
>       cpufreq: qcom-cpufreq-hw: Fix possible double free
>
> Hans Zhang (2):
>       cpufreq/amd-pstate: Use FIELD_MODIFY()
>       cpufreq: apple-soc: Use FIELD_MODIFY()
>
> Imran Shaik (1):
>       dt-bindings: cpufreq: Document Qualcomm Shikra SoC EPSS
>
> Krzysztof Kozlowski (1):
>       cpufreq: qcom: Unify user-visible "Qualcomm" name
>
> Taniya Das (1):
>       cpufreq: qcom: Add cpufreq scaling support for Qualcomm Shikra SoC
>
> Xueqin Luo (1):
>       cpufreq: cppc: mask Desired_Excursion when autonomous selection is =
enabled
>
>  Documentation/devicetree/bindings/cpufreq/qcom,shikra-epss.yaml | 96 +++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++
>  drivers/cpufreq/Kconfig.arm                                     |  2 +-
>  drivers/cpufreq/amd-pstate.c                                    | 26 +++=
+++++++----------------
>  drivers/cpufreq/apple-soc-cpufreq.c                             |  6 ++-=
---
>  drivers/cpufreq/cppc_cpufreq.c                                  | 29 +++=
+++++++++++++++++++++++++-
>  drivers/cpufreq/qcom-cpufreq-hw.c                               | 24 +++=
+++++++++++++++++----
>  drivers/cpufreq/ti-cpufreq.c                                    | 10 +++=
+++++++
>  7 files changed, 167 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/qcom,shikra=
-epss.yaml

Pulled and added to linux-pm.git/linux-next, thanks!
