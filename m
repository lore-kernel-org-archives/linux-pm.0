Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FFF47255F
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057478; cv=none; b=ID+va56q9aKP8PZrg/LFb6FsCYFUrk7cOmLxOTYBJrGLYBUZ+KiIdhzGTZNZT7p0GsAGnCD8CyJ451uapkobsYBUDuhG1sIobDQ9UU6u8c+xxpMw16h2gvSiRmIMN8oSx5jsx/pCLs7HDf2+niZbbvoq4HeNzejBlQ/YieedQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057478; c=relaxed/simple;
	bh=2F47dI8k+UhGiSMgBi0MK24JYHeZpDnvQeL8ZN2yE9E=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqaiwI9hP+YAnMd1dkmbybTf4EVmA6vawyWNPX9fzlekzODXcA/1Ael601dF6gX07Y3aU6l/B9m0M5oKWh+AcTvkBl4ZxZSJDfDuPgr9e5NmHTLef8A4wJxso8HhgPfuEbow+SgORgPD3pxykn898Uc9cLfrL4ltMAr4ohoiKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1PAMCvV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1PAMCvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8FC1F000C4
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 09:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792057476;
	bh=2F47dI8k+UhGiSMgBi0MK24JYHeZpDnvQeL8ZN2yE9E=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=D1PAMCvVpLUZDIXF88rZxF3CfbrKx70cj+VA1aay+B1mHlVSQSl/C6yuCTS+yFFAv
	 PsyU3udJhewuO9qTzNre1zglrugX2CHZmWUIKb0jpkn3dDDjWlVilqIcyf1tToVzga
	 Hos7C8FhUkhCCwU2JeQmo3K7b/MnXQDvFfEisqWh9MKwG33xV67k1bywfCDNMGVDu5
	 slhPswq/nr/iWixGiuXkFMqDj30L6LQMhyuhoJ9TYU/Iq1jKW0xHJDXQNsCylFnb54
	 PsELuJpIFlPP6dgOAygEx0xEmeUpl6KRYtRs4t5m+ToWmWcj5bb/wLQNjIXBEvgpLs
	 nBrnEE6nIViDw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a75f960be4so38885841fa.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 02:44:36 -0700 (PDT)
X-Gm-Message-State: AFq9FYIwPF1hzOdsKYEjC//flQ5LZiY3Q4Uikcynuv+4ly+uOFgoIuNW
	rCZFLS+piOxBeak3uhWMP4iRnYP3ihMdCc9MiRBURj3pr6SmqUvz2w+fLEhM/oxaZspBgAVy8av
	BBzCS0kSVirD10bSlxtrZZLg5nVfH/TkDMKVf2nbfwg==
X-Received: by 2002:a2e:a9a1:0:b0:3ab:10e7:e079 with SMTP id
 38308e7fff4ca-3ab10e7eef2mr1123031fa.5.1792057475597; Thu, 15 Oct 2026
 02:44:35 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 09:44:34 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 09:44:34 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261009165710.1320233-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009165710.1320233-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20261009165710.1320233-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Date: Thu, 15 Oct 2026 09:44:34 +0000
X-Gmail-Original-Message-ID: <CAMRc=MfwvuEWia05s-z+uG3d1Dj_xGxc1tuthLftnYRfVBeaqw@mail.gmail.com>
X-Gm-Features: AclHuK8Csalkoi2sCghBQEIYUJAZpQ7G744EQK5iP5bsTBYvpW7V2v22DW2kXd4
Message-ID: <CAMRc=MfwvuEWia05s-z+uG3d1Dj_xGxc1tuthLftnYRfVBeaqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] soc: renesas: r9a09g05[67]-sys: Instantiate power
 sequencer auxiliary device
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Oct 2026 18:57:07 +0200, Prabhakar <prabhakar.csengg@gmail.com> said:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> On RZ/V2H(P) and RZ/V2N, the SYS_ADC_CFG.SY_MSTP_ADA bit controls the
> power state of the A/D converter. RZ/V2H(P) has a single A/D converter
> unit, while RZ/V2N has three units sharing the same bit.
>
> Instantiate the power sequencer auxiliary device for both SoCs and
> provide SoC-specific auxiliary device names so the power sequencer
> driver can manage the shared power state across the ADC instances.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
