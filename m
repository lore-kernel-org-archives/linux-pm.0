Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995F12F9984
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786985232; cv=none; b=pWx6LPje2yUTWkQ6y2NMJxbZwKnvom1ynrjjeNVn0kC5nBNAbzPTW1uqRXnz0zuZdppBh4upcOvYvfn7N7VsGjHUFsf8YqUJlejEV+tqEuwzh9eZ5q2EfT9Jmuof/zSpadk1AWsjsl5pnh20iA2U43S08BEBjPHeVEm4aLuErWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786985232; c=relaxed/simple;
	bh=BkidxGyW0rCHvUxWzOVYAqUFa3mGwE0gsaS5ckmrWnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbqprOBuWjeR7sSa7yQdgyYEHc3Tk6HQ7Q+6gomK/TYyYka7Hintwdp0yJbjoU5X5NmV3xF8vN2e5imcNcnyEYkyWhTBjJt0JYvzdPXZp9Nft24EK1SpzogmeXEFTIs5lfPr/qt9h4USdAg6zrzTLyAr5I3ZO31J6k3Xabg388Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkicoXk+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkicoXk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD511F00ACF
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 16:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786985230;
	bh=QW91ay+R4Nj2LbLFHcZTQhVNEo1rWsdYpIDr7Fhs168=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FkicoXk+8qIhMs3zEw1SoxdnSDrf2+kfvg2Me37PNLOyfYzCa7bbYtWRJBKRVsYfK
	 yBtQlsOf4lneAGVBQCverLVBicJRuJAmpd7tLUlrieT4BvxoBKSV0UhY1RbQlEHNT9
	 rbtYxP63YL8HufJmMtrQ0PV6WxF1MlVRnuh+rdRlnBTF6tsz46oMYrm0hjmfVdKK63
	 LDnJzlObWORVtwrvy9Fer6JFbZ5bI+nFQxGjzcGZSxJEw1W2GY4J+FklpZ2U3Ilnyb
	 JHlwLt/Q5EebB+gFC33AGMjE9BfjRWXiFh9pPiUsluPzZ4+5m7d8/lvIquQmq9038o
	 PhrLPqV4PxY/Q==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39ca300db70so30615011fa.2
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 09:47:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpXxBKTq4wv3KS4o3y5Y5pfg10jiFGQSGLjmpJpyOE8A6u1zLFEG0u4DcG0dQRqLqVCe6EpQ5AIng==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsadi8ZZvZUDA35dvZM7/xw9GjubnZY2x/sY3sFRWNMDu0HzV1
	k+ccUrmL7uZZmZ+8jlc6anKrNhOo92nWjngZk94ypVxy/bcGyVj793BL9F8oWk/8/4p2tNmeEbc
	J18cw6mdoa7nS6dnlgioXhf+vtcJsDYU=
X-Received: by 2002:a05:651c:1a0b:b0:3a1:6af9:9e57 with SMTP id
 38308e7fff4ca-3a16af99fb6mr6236041fa.29.1786985228278; Mon, 17 Aug 2026
 09:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <468d3bf3-fbdb-4548-bde8-1c94ad6f15da@oss.qualcomm.com> <CAJZ5v0jwVVedFiw0NcL8pNN1CsxvVfRNOn17L_oW5aQbC04XVQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jwVVedFiw0NcL8pNN1CsxvVfRNOn17L_oW5aQbC04XVQ@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 17 Aug 2026 18:46:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gcWp_zxuETVgHatBGeUhiXZrNHKAZAKcZwrfiVSgOmJQ@mail.gmail.com>
X-Gm-Features: AcwNN1Vkje80t1XQLYSd5IojEZTlPCO4a7MwV3dJUWHT3-a51ksE0aZsNZzETlc
Message-ID: <CAJZ5v0gcWp_zxuETVgHatBGeUhiXZrNHKAZAKcZwrfiVSgOmJQ@mail.gmail.com>
Subject: Re: [GIT PULL] [resend] thermal drivers fixes for v7.3-rc1
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, Lukasz Luba <Lukasz.Luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 9:01=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> Hi Daniel,
>
> On Thu, Aug 13, 2026 at 5:53=E2=80=AFPM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
> >
> > Hi Rafael,
> >
> > please consider the following changes since commit
> > ccda015d76736dc5ccefc70a040b9304a6c2000f:
> >
> >    Merge tag 'thermal-v7.3-rc1' of
> > ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux
> > (2026-08-10 12:53:41 +0200)
> >
> > are available in the Git repository at:
> >
> >
> > ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.gi=
t
> > tags/thermal-v7.3-rc1-fixes
> >
> > for you to fetch changes up to 61faa946db1a9c94a3f48e587235d9b41bd8b07d=
:
> >
> >    thermal/drivers/armada: Fix missing bitfields include (2026-08-13
> > 17:12:42 +0200)
>
> Pulled and added to linux-pm.git/thermal and it will be merged into my
> linux-next branch tomorrow.

And it turns out that there are two broken Fixes: tags in it, so it is
still not ready.

Please address this as requested here:

https://lore.kernel.org/linux-pm/CAJZ5v0gvxu6dzToOhh-xsP539Mjtczz7oTLiMXFeM=
vA+U=3D3Zgw@mail.gmail.com/

> > ----------------------------------------------------------------
> > - Fix missing bitfield include headers in Armada and QCom SPM BMG
> >    drivers (Daniel Lezcano)
> >
> > - Fix missed file when manually applying a change after a conflict
> >    resolution for the QCom SPMI ADC TM5 Gen3 (Daniel Lezcano)
> >
> > ----------------------------------------------------------------
> > Daniel Lezcano (2):
> >        thermal/drivers/qcom/spm mbg tm: Fix missing bitfield header
> >        thermal/drivers/armada: Fix missing bitfields include
> >
> > Jishnu Prakash (1):
> >        thermal/drivers/qcom: Fix missing spmi adc tm5 gen3 file
> >
> >   drivers/thermal/armada_thermal.c              |   1 +
> >   drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 434
> > ++++++++++++++++++++++++++
> >   drivers/thermal/qcom/qcom-spmi-mbg-tm.c       |   2 +-
> >   3 files changed, 436 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
