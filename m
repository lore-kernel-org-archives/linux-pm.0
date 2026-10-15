Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA0549C4A1
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057469; cv=none; b=pEsXD3ljF7vyN/zJfHoJts/gXQaZ4CjgYNOhyDdNvn+UWG+MTOe3lkWT8C2lVgImw3IZ3cCfvd7qZtzeYI/MAUcuzP+ZyuH/Laa13+KxnfSMZ36HvZeDiVi/omnJ264nmgaHigfWRC6it7Aoxr/6t5VZPYvH8bHyGQJqoqZYMIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057469; c=relaxed/simple;
	bh=s0uJPaoNZXruwe8UvAwUvg4brG4/KXCJSIm8alIC9hE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l/hn0TVUbF2mZMXWOoemKIlwgMbHJmTo8cdN7GnmvqmKMTyczpItFSv/T4VZSMLpG05Onf9zW743i6CBv7GpirvphcITwxxdHm+oqFj/UyxPKX8dzS69mvwRsiTxjxa590w+/r+lIM7opZ+9hkx60Diuawawi9rl1gq/S40yc/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue1Hf+fR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue1Hf+fR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8451F000CA
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 09:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792057468;
	bh=s0uJPaoNZXruwe8UvAwUvg4brG4/KXCJSIm8alIC9hE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Ue1Hf+fRJ+nJYzrx4zC7XQ7x1vzTrddk6samDmmtdne8ln1u/dIm0UxMQYx45MCgt
	 yTWp3AFyNyYwvv+o0HxlS8xRHqzayxr9LzbxgXCwPaDWjflplaKIq1GYBKyt/dHrGz
	 v2vRPPtM1zxpWlGu+wlvZZe3r48DSq+WfYbE2c9G8tV1RKSNMx5y44r1P0cciceHXA
	 ZyWPZOV+jJEO8nmHSrzDcpKgvnWiu8w3LwHd+6PNwWq81ysv+f+/A4jLsEfRNvGJLl
	 rKDlPVSEneGaPavUJkBoplbbfTM9fpmc/N/q4I5nVZi0Qh69PYhentjzYzHfD/8iLZ
	 qyuRVf6imr+mA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a65ed9c7cfso38117541fa.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 02:44:28 -0700 (PDT)
X-Gm-Message-State: AFq9FYJP6EgRjK93HV5xSXF5OWbreHi4O/+eWOrWhE2k/AG4PUaQpMbc
	VXvwOd5OSAymjf3LHVRjcepYc5TYjEnIfWBr4v5rO7V19uavR64TxolgWveH7XZWY7+W6YiYzBg
	9pP6afwifqKlnveMWrhBq2XRbz4vkFKkV6c4C96/cEg==
X-Received: by 2002:a05:651c:198f:b0:3a7:812b:d1c with SMTP id
 38308e7fff4ca-3a9c4844a20mr42740571fa.0.1792057467102; Thu, 15 Oct 2026
 02:44:27 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 09:44:25 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 09:44:25 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261009165710.1320233-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009165710.1320233-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20261009165710.1320233-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Date: Thu, 15 Oct 2026 09:44:25 +0000
X-Gmail-Original-Message-ID: <CAMRc=MeMd8vNLWVABaAexMSrX7-j04uGSXs7D1BeZEvTjOTtQQ@mail.gmail.com>
X-Gm-Features: AclHuK9yzjt7WYvSkzfxcys-Xm1b2aqlzq1epr7KhnIksa-ua0uUkI-ESHuzw3k
Message-ID: <CAMRc=MeMd8vNLWVABaAexMSrX7-j04uGSXs7D1BeZEvTjOTtQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] soc: renesas: rz-sysc: Make power sequencer
 auxiliary device name SoC specific
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Oct 2026 18:57:06 +0200, Prabhakar <prabhakar.csengg@gmail.com> said:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The SYS driver currently creates the power sequencer auxiliary device with
> a hard-coded name, which prevents SoCs with different power sequencer
> configurations from selecting their own targets and consumer match
> callback.
>
> Make the auxiliary device name part of the SoC-specific initialization
> data and use it when creating the auxiliary device. Set the existing
> RZ/G3L configuration to "pwrseq-pwrrdy".
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
