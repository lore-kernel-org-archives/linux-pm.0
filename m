Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B275932B114
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066747; cv=pass; b=l5xS9PQyr+jc4U4VhAdVSaWFNwTfCVcMC7qitwXP+Jn9mwPbVMMSRdz5W24MBsHmbO2lgdIlrfuShCjEFueEFCQw+x4DX07mnQvOxSpqHPsWkUh6ySeS1Cr5foRD95xtJGceQktT0DoIiZ2rTNsoqeez9rg3iUfUX67/c7R73LM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066747; c=relaxed/simple;
	bh=nQCpACxM/NNDWLD8aG1f9Y5eQyxFb13mKb3dIoAiQz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKhe+PTFAVGtJNlNphmx2h+uvUuHNtgJ3RP1lqmEOCDI33ZkXKhGf2X/a2FyZ8hsm1lRB4XfPoyKDPbcRjxubPgl4swAh5Uwenw6lcpgFSnaYRygl5Mfo0pPt+BRmR0+GL7JhFcAjrlBDVIYHNiLbWlsK8iHcbhxCZF8wfggFJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNMwL1Yb; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNMwL1Yb"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304b8ced372so4660960eec.0
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 07:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780066745; cv=none;
        d=google.com; s=arc-20240605;
        b=BZRrOjxNEB6L+/CyPxvwcLpfGCe+HPXp+aKVsGjPT2U01IyJ23DsYPxR1gfXy6VXxz
         G8OH4Py7fiapit7Ir+vaP9JzBWbY556lcLjKWDlbbmnnjmg4yr0V1HOh/K2Dpo/jIfeU
         BeDqXnLx69Jb0NkI8P/rgs9HHoFwG0A8OuzgFGuEZnTWq5VFhm3aRtpyBx5PfTJxu5VI
         mEKbPXCuzLfkzJm0aP4/9zH+ETFUGZTG7IDAl3+yMqaI9V7aDXXKLSsyznctZGqd+UYm
         Aqq1uBqMH9jOJGx0Pciu07W8HJfe5YN+yqkSwvRv0zWMoD9i31G3KM6dRP3uG6QXd6Fg
         sFHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PgXHcM39V5zvAXFHcyS55ak/JoLwnSwxluSWMdfV+ZQ=;
        fh=HPTWEWq29fIl7M3ZWSJTEKICRdHKTsOC5PSpQ3XuWvo=;
        b=MX3LoYGbLlNZetjSkG/V8B6S64H4Lvtc0MsT/HRr5G7GK0mtYNlaFqyOuJ8R63weRE
         j9AQEQdh0eQwiJxqpvz6btV20EfW5itNDixc5yMiLU3wS1ysfabelSw6IUUiAYWkw4SH
         LWYXt4SKsjQ8YMVQ4dwdVmKfIWU23HYHPEGv82IypGNOLQrRDTZ+py7Gl8ImdkFSvPoo
         TNXbym9+lyiEbuVt763nW2/0dySOFQ8rRfgtINCdrioa/9VKXkYVMNLkZINz5tMdGqbO
         KDRKrolCDJrZ20PzVaXINiRTVwCi959xgrsJU6Gopf9Ik0ivkvn7/1tkBMSkrEF8+oUi
         oG/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780066745; x=1780671545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgXHcM39V5zvAXFHcyS55ak/JoLwnSwxluSWMdfV+ZQ=;
        b=gNMwL1YbBRZTB7NSZ4KCgt6SbCk7Nhp0rcGLAn43t4CF0eLO1A3IWnkWm/CTuhlCdZ
         JzRwmtVYUdrS9YjadYk7X8Abc3sIH93tG1cfCprE/YmBLJwIcLLuGl9D4yECP64cD2gX
         pXFNiRLIJhztez1AihysMIusiyY0KU9zuVXRv4DuQeix8mcdUHx4Q07Lhd2i2nkhY2GV
         cBYzN7QPh2hXyEuy7TNXjgYfk/T/vIdZwTe75PLkGcZjNgFTRLf716UBbZ95a9Gyxpy8
         h5r5wr88j6Ys0twBVoj5QQkRQdCpgejw4OrsYOlNAaJWCEjieQHiXZ5zFauyeKFT5uyg
         NECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066745; x=1780671545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PgXHcM39V5zvAXFHcyS55ak/JoLwnSwxluSWMdfV+ZQ=;
        b=s5K+VqWw0UZBMYn+VnCO7xb0C2LHyfo8YnHn+dkl+8UUSXxL/Ndx29OH+XAMmkymNC
         y4a7+HNldtaagHeGg0PnStjveQYrpWO/D246n6Qpl/w5XdvTWGR143oFbZmw4VTMMniG
         QVoy3M8ZWJccPnk1JQj9hCL2r49cWQ3wV/CZREVIRqMrR/NjKLjHX3jn7+rlOqm4FfDw
         Qipo7jDJjaKOAoCyXOaG5acQBPIzCaEb7vq555s3Kqc3mVHEA9gWL2NAdQ5elWGMyfpU
         t+OaTfngWIeZ68OSI5Ky4H8VBMqQVe61aRGKzyhYZn/r1yvVLhHO3bAyrgDgPot+piz7
         LBIg==
X-Forwarded-Encrypted: i=1; AFNElJ/m5aF/ktnPcTvXyAUClcGwwMaTPHl3RHuE7BbfAes+7FM27ow1zoWf942NOZVuGB+Pmiq4xc3miA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCkbiFJ9NBUj71Ced/rzTrFA3qdDeP2o//M/1Mm+uykThnsxhN
	t1trGpPPtFztwWuyjSKXKcmQt9C1UQRiKi9igAO913BUc2Xaah8GoEdAW2fubs7MDsWj6J6KfmE
	mirETTuC2UcJOraOhho1naTfl7cvetdlkN9lB
X-Gm-Gg: Acq92OEPRloTSRVa3TO11caVpRydoUOT9HML7voxK3tWXEBmMt89GeboYjGzADNrPp2
	tQ6Ay70bxaDZdV81eNRI9SHZqLXPkDvVfCrS8n0CIt0FpSUdbF6uU0zvNy0VmOTWpnC9qejcg+2
	nms3KddgA2h2KLVQs2MpOFuMOsweGocSaEE3UI9I+8+EI7Jm40JbrrUh4a1HQUT2ZPseCZq/A1/
	ukqAEBHIWjAHGSXEEw1kq97inUTnfD30K2lUcOIxna9BBxtNWe47CRVDQ38MxDwPf3oEOKLEC17
	O5WUh7E4gjy1OfxvnE0=
X-Received: by 2002:a05:7300:e683:b0:304:de26:3cb6 with SMTP id
 5a478bee46e88-304fa61b98cmr74574eec.23.1780066744852; Fri, 29 May 2026
 07:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523085102.51000-1-clamor95@gmail.com>
In-Reply-To: <20260523085102.51000-1-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 29 May 2026 17:58:53 +0300
X-Gm-Features: AVHnY4I-sQrdOAdbDInY5d2djINIvTW6pdn0Pji3ZBEmd0xb_C9GzSfWWHFkO2w
Message-ID: <CAPVz0n0+FEpfnuoH9STZoRtLOA2YxD_FvvyVn+WdyahxmEA-Qg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] power: sequencing: Add support for Nvidia Tegra
 modem pwrseq
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 23 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 11:5=
1 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Patchset implements support for the Tegra-specific modem powerseqence,
> which handles the registration and unregistration of the USB controller.
>
> This patchset is a part of larger series aiming to bring XMM6260 modem
> support for Tegra devices:
> https://lore.kernel.org/lkml/20260511135703.62470-1-clamor95@gmail.com/
>
> ---
> Changes in v2:
> - previous phy driver reshaped into pwrseq driver
> ---
>
> Svyatoslav Ryhel (2):
>   dt-bindings: soc: tegra: Document Nvidia Tegra modem pwrseq
>   power: sequencing: Add support for Nvidia Tegra modem pwrseq
>
>  .../soc/tegra/nvidia,tegra-modem-pwrseq.yaml  |  49 ++++
>  drivers/power/sequencing/Kconfig              |  12 +
>  drivers/power/sequencing/Makefile             |   1 +
>  drivers/power/sequencing/pwrseq-tegra-modem.c | 209 ++++++++++++++++++
>  4 files changed, 271 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/tegra/nvidia,te=
gra-modem-pwrseq.yaml
>  create mode 100644 drivers/power/sequencing/pwrseq-tegra-modem.c
>
> --
> 2.51.0
>

Hello there! There will be no v3. Sorry for disturbing LKML with 15
year old obsolete tech. My mistake.
