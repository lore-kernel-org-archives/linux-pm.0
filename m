Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A297723E324
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787055555; cv=none; b=Hx8vF9NqVAkzri5U4kKkVxjdeaudXP2B/Xam6Nmi7Adr/nUYm93jXQA5Zivc3zK6/ExKpKXr+plyfZvAk8Z046jq4oPoXlGPQZ30P/ivTP3QAuW8LQ59C886DZnsOeTjZ2zTe+TQ2P2yQOfCSoMY0saThpBN2ED5wcXYwnHUZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787055555; c=relaxed/simple;
	bh=fdvZPmXbdEUnUjRrYEJKLAMsB4sz92yjIjOFSrTvYw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCQig+9brLSlViKeJLKS68QIN8kdihJZiPGIjIK4usjhzT/QpZLLB162AvsueuCJrTZuSpIXqYj2vC9VdJkVTAxB3VrBRrbJ1T5pEB0IBEZqChxFjm8iOwQ/v+ENoanitfDjRpXnNOruN+mJ5Ov5xXAh5YbwT5UCsFUlDJYTYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKjb9QkP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKjb9QkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5996F1F00ACF
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 12:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787055554;
	bh=AqDVcyh2RcJCpPu+F+bjajoXnUFG6ggaZVV322JZsDU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NKjb9QkP+cW56KQxMgDZuDncn9N4fQGK2L0u/sNyl8MORhXeeayMnoJWPOS0P5Wq3
	 m6xnyn02d0Cndv0rkrK8BLQ1cnnafcGoj5L2uMLMD0fjMGq1r4dvzdrLz+41xAxsje
	 yEC0AXZvf8sfzmQSTDueNt6fzE1IES6uTr8E/NIuVAP4IvPmhCO3wery+4iJJsVyd1
	 pame9gyihcGnsEyPsHohOBKxVyP1boQ+DOmFXFDqSZIg1Ll08yOo45r9Q7S+GKwc2Z
	 95+kJTTLKfvA4jSb28Q6zyJUpuX92ndvBswBKxlxb7sjtCs1HrlmknFNVL4MS/zPGP
	 EgUidHzc5xbQg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39f1ac13687so29433711fa.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 05:19:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrBNtFBDufrG7OXUCIQ3aXhJlj+KEt5zLo1AHu8Zcw7sRK8ie0mVITjul+EIVL8o7XF4/5bx40teg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzl5n9rpTUkieOrFKZEgLXVEGvH37QX5eYjRuHL7YVUjF1Umrl
	YLxWdA4FgwO0hdnVSsLRlGJOHs1FIz9+fUwIHLPb4EUoLLYZxV7hGPF9axeEgk6kFU3eU8jyn8Y
	Dk3dn2bsLr7ZabyCRIxI+cxN0F1NEX3k=
X-Received: by 2002:a05:651c:b1f:b0:394:635:70b1 with SMTP id
 38308e7fff4ca-3a1323b811bmr35454151fa.3.1787055552699; Tue, 18 Aug 2026
 05:19:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8bc7b131-891c-445e-8084-1f7e4a11d272@oss.qualcomm.com>
In-Reply-To: <8bc7b131-891c-445e-8084-1f7e4a11d272@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 18 Aug 2026 14:18:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gr_1tN4UFe6iBA3kv4bfq-AhL2XaM4r1BBWECAqiKMjA@mail.gmail.com>
X-Gm-Features: AcwNN1XMq0SVpxTdnIxla83lyM2dTrg-oHr5f1m-Q16z-VfndYhauMlQNmHacHk
Message-ID: <CAJZ5v0gr_1tN4UFe6iBA3kv4bfq-AhL2XaM4r1BBWECAqiKMjA@mail.gmail.com>
Subject: Re: [GIT PULL] [resend] thermal drivers fixes for v7.3-rc1
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <Lukasz.Luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, Aug 18, 2026 at 1:35=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> Hi Rafael,
>
> Hopefully this time everything is fine :/
>
> "Fixes" tags have been fixed.
>
> Please consider the following changes since commit
> ccda015d76736dc5ccefc70a040b9304a6c2000f:
>
>    Merge tag 'thermal-v7.3-rc1' of
> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux
> (2026-08-10 12:53:41 +0200)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v7.3-rc1-fixes
>
> for you to fetch changes up to b115930d716defc3a7daa2bc2ae2465d864b7114:
>
>    thermal/drivers/armada: Fix missing bitfields include (2026-08-18
> 13:09:22 +0200)
>
> ----------------------------------------------------------------
> - Fix missing bitfield include headers in Armada and QCom SPM BMG
>    drivers (Daniel Lezcano)
>
> - Fix missed file when manually applying a change after a conflict
>    resolution for the QCom SPMI ADC TM5 Gen3 (Daniel Lezcano)

Pulled and added to linux-pm.git/thermal and linux-pm.git/linux-next, thank=
s!

> ----------------------------------------------------------------
> Daniel Lezcano (2):
>        thermal/drivers/qcom/spm mbg tm: Fix missing bitfield header
>        thermal/drivers/armada: Fix missing bitfields include
>
> Jishnu Prakash (1):
>        thermal/drivers/qcom: Fix missing spmi adc tm5 gen3 file
>
>   drivers/thermal/armada_thermal.c              |   1 +
>   drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 434
> ++++++++++++++++++++++++++
>   drivers/thermal/qcom/qcom-spmi-mbg-tm.c       |   2 +-
>   3 files changed, 436 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
