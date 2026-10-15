Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035A4485515
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057439; cv=none; b=bhvr6rs9cykpWL0mPYoh+Ct1UCvzXj+fX9HudxEZmTvbJRUzqrjsv2JI0t3QB1AimX0KCTpdUs/XRWQqeMEaNCVBZ2BRIeb0/aTCRqNh6ek/XXCOKKwSFV/2yH4dYiJkg1Ie3EyJl3hLTwTdRCSa7+k5nF0gmOVw1c1JAZpMRYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057439; c=relaxed/simple;
	bh=IdTLXtaS8JGwsIzRneQe0HDvzxq7JmUXtY6tJMk6YE4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ua4c7GjKef43RDD7+tRLedaar7Smpn71+Wp50g7A710hekMqFI9bntMxVnh2dJjN+xlfJVHjG9roiwBCuD/RDwcBlTqjj4oqn46XLDuGqypJUDyAquXDve5iCEGvN/aniOI14IXY9fBVkGQqZUNRMCLnCyaZk9FxBra7/BZPgs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKH1DDsR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKH1DDsR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA491F000CB
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 09:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792057437;
	bh=3iBMEPhKj5baiqEigGr0RhAJCrk7rKocDmxjVgO2LpY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=jKH1DDsRfZ9YlXeszwHery7+Pz/wfSomf+kutIh9OGfNvAdM5KVw97FEHogbELyIp
	 LN+cRKLYXuvcpoFQC8swnF3MEx26Y04C1Mkee/7Leik0FcUxuM/3xvm3FC/eQUTD0a
	 M604IC0GtCM+a6mL9EaYnIZoM+zd9yR0B7CspH/9Agbi+DLLxISxAWSihmgFsWxzCG
	 orR5PK8IclSL1cL2ZAQrMl1sIlVzp9Pv4Cj7zOaHpnr+yeI2/EUUN1T9dLBLvJYmwa
	 Vo2c5nZFEQplAizKd4MjIMCQOXndpTbISKe/NDYy7fOGGuDBCYrCFsk5U6Rf197DGl
	 gBj5rvLLoHGug==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a65ed9c7cfso38113281fa.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 02:43:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByLEqI60QkHHu9Epr2SPtnxaLzOTaOgIG7rlgBjPnzakwIBnult7SH1qpVSynEwlE9Y7I79bS7Lig==@vger.kernel.org
X-Gm-Message-State: AFq9FYKYS2omrN+3I0gyntWhwz+SXlrlSy0ISioTJ6uVEx1C1mDduJXo
	NpTQj+i6/F3usPC397/mlAw2ij2/Wegikmb3Al7LRyuaQhQmksjbwhSAJv261Nlq0Irah1lqW8j
	RkvgpO7lwwgpybSUSLAbgjhccVSVqhL7rg0euJGHeQg==
X-Received: by 2002:a05:6512:2349:b0:5bc:f6b6:411f with SMTP id
 2adb3069b0e04-5bcf6b6426emr4260070e87.63.1792057436594; Thu, 15 Oct 2026
 02:43:56 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 02:43:55 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 02:43:55 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261009165710.1320233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009165710.1320233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Date: Thu, 15 Oct 2026 02:43:55 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdcWS0c9E0V3cJj9B9WMAe0vSs9e2s2EauRH5zFkOng+w@mail.gmail.com>
X-Gm-Features: AclHuK80UgUaXqAi5KtyhBEZG6VWkSJHiIja0RK6M1XWB1s1gfV49oCVpHPaz04
Message-ID: <CAMRc=MdcWS0c9E0V3cJj9B9WMAe0vSs9e2s2EauRH5zFkOng+w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add ADC power sequencing support for RZ/V2H(P) and
 RZ/V2N SoCs
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Oct 2026 18:57:05 +0200, Prabhakar <prabhakar.csengg@gmail.com> said:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Hi all,
>
> This patch series adds support for ADC power sequencing on the RZ/V2H(P)
> and RZ/V2N SoCs. It introduces per-SoC probe functions for the
> renesas-pwrrdy power sequencer driver and ensures that the necessary
> Kconfig options are selected for these SoCs.
>
> Note, the ADC driver and binding patches have been posted separately.
>
> Merge strategy:
> option #1:
>  - Once the pwrseq-renesas-pwrrdy driver is merged in only then
>    the sysc driver can be merged via renesas tree.
> option #2:
>  - Merge all the patches via renesas tree.
>

IIUC there are no build-time dependencies, so the pwrseq and soc parts can be
queued separately?

Bart
