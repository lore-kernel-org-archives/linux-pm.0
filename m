Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB68237EFE4
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647726; cv=none; b=oDDN9K2QRh1ZGFdDBAHzb+StCynHt3EjSV7F1Y1kT2D8mKKem0ZY/doNa1sJsTVONOcqmX4DEufdf7pYFdGr07vPU7zKji9ieYySC9iu5AjIDrizhnlsFJX6iIdhewoS94Hch9tBKnC+XO/7kokdhw9J0z1sl0aFbbWEkyKPdLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647726; c=relaxed/simple;
	bh=WpTsmZPh+xA4CuSe3W5eF4OeOihCnTNllNHkyE4t/rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uf8p+6zGaobJn/N0TnEv4OJdPHcMHCfzKpEmZsAIdQad7ESoZZ3x72y6pqLZerM6jWbtwibjBUQq237L0kFMNiylQ7ivhngMfgbyVEEUe4uMTLW1svyJHrUu2Tq8EvFbqh3NlQkk867LV+i0cpEkFOOWIBEXQyChIfy3wkfs6Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6d2ODWY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6d2ODWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948F41F00ADB
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 19:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786647725;
	bh=7XtP+yf/djpFxQy4oMz+DWQ7ozEeQd8CQGDADFYcLr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=A6d2ODWYlAeZDvN275UgSVQVaDWoBqyLGqmo2OOKJnZbTPCyQLfrJXQhgX/tjoXsF
	 cKDsKEiawGIBbhn5o1jIwQWhKkhelpQLM28cuLmJF65nM1wNh7B8qYf+y/ZiX9iwsF
	 +5Y/sCVwnYBPZFwnZSANJyz/iJMHArQcs7781JIWYbYz5uc+Gshx7HtV73OQuxDu2C
	 rP2cGizRFwlMko/YGInIKBHNgJUzw1Op6aPjh4HcwqOTwQZlUCjheiG15ElueR0UQo
	 U772ZwTi51sdmO9mgZOlv0+BMDxKPTmbJvur+nI7P4M2o+T3eQB2sWQl32PHsZ7NXx
	 83In+qy7dOE6Q==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a115c08b0bso1784771fa.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 12:02:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoQGVVMVaD/UCEG3aWzC933Y+rjjqw8haAWQOCXI03ybL7Y1xGCNFc3STwkcbR03wkdWiSIyBXQmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv8zoCS63v16tty/PYpxVg1GT2ou+NlePMZAA7j3XW0/DjMqvF
	j1TOlklKgHR2TFvYRszLOUTrb6CKyjW7NmLX4C/y3J7/iJKmprvHahiYNCuPotSsOzfPGmD4FGd
	II7zz3VJwpAVI+kJE/HO6SqYN4R256Go=
X-Received: by 2002:ac2:51c8:0:b0:5b2:a5e9:3a9e with SMTP id
 2adb3069b0e04-5b45919edb9mr2462e87.48.1786647724009; Thu, 13 Aug 2026
 12:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <468d3bf3-fbdb-4548-bde8-1c94ad6f15da@oss.qualcomm.com>
In-Reply-To: <468d3bf3-fbdb-4548-bde8-1c94ad6f15da@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 13 Aug 2026 21:01:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jwVVedFiw0NcL8pNN1CsxvVfRNOn17L_oW5aQbC04XVQ@mail.gmail.com>
X-Gm-Features: AUfX_mwnWUDfJyFCPY-ZW3rA5o_XZsXOXtM31NZ0n-VMUlWSv7WHaHEEb7aYvj4
Message-ID: <CAJZ5v0jwVVedFiw0NcL8pNN1CsxvVfRNOn17L_oW5aQbC04XVQ@mail.gmail.com>
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

On Thu, Aug 13, 2026 at 5:53=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> Hi Rafael,
>
> please consider the following changes since commit
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
> for you to fetch changes up to 61faa946db1a9c94a3f48e587235d9b41bd8b07d:
>
>    thermal/drivers/armada: Fix missing bitfields include (2026-08-13
> 17:12:42 +0200)

Pulled and added to linux-pm.git/thermal and it will be merged into my
linux-next branch tomorrow.

Thanks!


> ----------------------------------------------------------------
> - Fix missing bitfield include headers in Armada and QCom SPM BMG
>    drivers (Daniel Lezcano)
>
> - Fix missed file when manually applying a change after a conflict
>    resolution for the QCom SPMI ADC TM5 Gen3 (Daniel Lezcano)
>
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
