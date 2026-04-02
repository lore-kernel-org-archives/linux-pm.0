Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1412E3F0774
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147816; cv=none; b=oLQAwgSBHzo62XWfVFDBij6GlFZhkcYNeDQwkt2hGkGlkkCdAWzuhY4UXF4h9xYOqDlkxXcr6xAcobr2cC2FTPdY9uHISC/ZB05E4U71IdMFA41qCKA3FOfnxSwQdmepNkh92EDoP8CEooF1O1G21rLmuzc1zSDPmq5n4SEpWfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147816; c=relaxed/simple;
	bh=lrlq/HbxmnC5PpR7YmxiMp9ckRpkYpfubG7qvmOaqdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwtjMGqiepXa0FxHR4CnPg4js/caBNS5uSdmc2ZRcxd30kUjzxzWPcDpTvlW+Y7v+KST8WdGWoZLwmBJ0xzwYWiH1qStBrRafv6S+Hji2SMf5L60KawieQT8mzcbrmqlBUh34p5J+sTVFTCHdrGYSGLALxjEFH+g8zCblevoKCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzhYonar; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzhYonar"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA822C19423
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 16:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775147815;
	bh=lrlq/HbxmnC5PpR7YmxiMp9ckRpkYpfubG7qvmOaqdQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GzhYonarEmZfZEf3DAtE/8ZF+bkG0SRDlVVQrUm0XGL5erqr3S039ZNNKlboMHtWf
	 w6A/BiJoWiv4zu3lFr/JeHQQ2v5iBVEI/69LRW8fAAS2jJbodeLAPD9tkBUx0Ep6s1
	 C4SMjzNiCfnEH2CjGqwGVa6MjoapN9mIlVQ9eHEirvISBLrLqAQQv2WB1UQ9l/iQcP
	 uJiJSM5UToZ4VD98fjLIVBQ5VN+Q7AvVyXDxGxy4zkoM7gmQygNx3DDZp/zK92MJ1F
	 X9LiHcV9b1rCZdpdepsrarCxoMaBhKxrBcDaG1hb7jP6dbI8Atx4x7quwEHB3Ji98G
	 hgVRi/oybPA8Q==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38bd60d7a2cso9909011fa.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 09:36:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+JVYb/54Ilznv1gCAdbbG37RI6dTHTAQzGe1ytGl6C9RjgyzO5FYhFCz/qZkRyj+8/s9tVoRvBQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXkbkyUwtK5iyUVxBz0X6rWL79s7ZFBgfZJYJiDSZuHq3F9Pmg
	OYaHDbEsGXcOo8MruxIVuaNmySIs9nonnOLHYMb1fmSBCAz7dxUbtnCJzyVa/JJxd2t9efW1yY1
	4KKqVeBT6dZFrHZISywzyOPgfCN+CLPpwMKBx6jpwWQ==
X-Received: by 2002:a2e:be86:0:b0:38a:4152:e91b with SMTP id
 38308e7fff4ca-38cc2f38436mr30270941fa.4.1775147814523; Thu, 02 Apr 2026
 09:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401191030.948046-1-arnd@kernel.org> <CAMRc=Meu4DjZ0=r1FRnBGXGN67VxK74x3AjO_T0J7NcA6koCRQ@mail.gmail.com>
 <f402c8e8-cc71-4263-a51a-368a8a0e018f@app.fastmail.com>
In-Reply-To: <f402c8e8-cc71-4263-a51a-368a8a0e018f@app.fastmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 2 Apr 2026 18:36:41 +0200
X-Gmail-Original-Message-ID: <CAMRc=MfHsKk7zb6E7MC2WT-dANQrnC7B2eX1dJb=__2=NnEGRg@mail.gmail.com>
X-Gm-Features: AQROBzDNRUX7-gfs1OGfqB1PhlSd-vPFXwPGFatAH2vTiTqMWjw1SL6y4VwK7-s
Message-ID: <CAMRc=MfHsKk7zb6E7MC2WT-dANQrnC7B2eX1dJb=__2=NnEGRg@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: pcie-m2: add SERIAL_DEV_BUS dependency
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 5:42=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Apr 2, 2026, at 17:38, Bartosz Golaszewski wrote:
> > On Wed, Apr 1, 2026 at 9:10=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> =
wrote:
> >> diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequenci=
ng/Kconfig
> >> index 77c6d9227251..1c5f5820f5b7 100644
> >> --- a/drivers/power/sequencing/Kconfig
> >> +++ b/drivers/power/sequencing/Kconfig
> >> @@ -39,6 +39,7 @@ config POWER_SEQUENCING_PCIE_M2
> >>         tristate "PCIe M.2 connector power sequencing driver"
> >>         depends on OF
> >>         depends on PCI
> >> +       depends on SERIAL_DEV_BUS
> >>         select OF_DYNAMIC
> >>         help
> >>           Say Y here to enable the power sequencing driver for PCIe M.=
2
> >> --
> >> 2.39.5
> >>
> >
> > I assume with this patch[1] from Mani, we no longer need this one?
> >
> > [1]
> > https://lore.kernel.org/all/20260401070735.107162-2-manivannan.sadhasiv=
am@oss.qualcomm.com/
>
> Depends on which one you mean with 'this one'.
>
> My patch is needed with or without Mani's, while
> his patch is harmless but does not fix the issue.
>
>      Arnd

Mani's patch adds stubs for the symbols that the linker couldn't find
in the build error you posted above. I thought this would fix the
issue?

Bart
