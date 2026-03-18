Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3BE243376
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 03:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773805132; cv=none; b=b4JtrpRba28ktao8QBgW+SLOaIzpcaU8niCAdxtgCfBX+WywS59S7XYi5qiEs98V/WSTYYBcjNAAIqKmtUiHWPm4uA3hHn/ugvLD5xtUH9qcPxaVDsPfAtp6/qpj9o3PYJSRYdJBuzSdNvrjLC5DRE64J42evmkQKqDTA9kVen0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773805132; c=relaxed/simple;
	bh=uqmFJenA7NvCwu2QwaHJEmPdclY5/2SsSJ0L2gnM1PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRe/ZIppbzHNoMxAlntxw1zERlB5Owrhy+0q7w8Yx+ROteZ62EMwPQ/hlBTCMcShXpvF4Z6XHAG5wEV0eNBrFXLQGh84YI0NjKZCuUC7A5CluEno+x/+A0hapBNvHmtNO5vPVKAiRxZdN4ZH7ITx6urzf566Es7AHr5SE6Yj2ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HERIrviz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HERIrviz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F61AC2BC86
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 03:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773805132;
	bh=uqmFJenA7NvCwu2QwaHJEmPdclY5/2SsSJ0L2gnM1PQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HERIrvizPeQsyZ8AA/QrPU6GQvCs9RlkmMfpAkHHGJWR+HTiyB9LwLSEty7hsoTDJ
	 tingcy0fuJap7mlH4wfFoLqiEje68rQJGuuPM+czIkV77jARmf6XsiU3pAmBBD9La0
	 rG7QuMM8X+iNlzMwDUzDMFK4LIPSFmN6DgK+xJ1TBR5uzD44FACKh/6B3u/ogJXU17
	 rcofaiUn39IgIStQTKtj+8tdz3mNqcLq1ZwGXQ8rAdD7Q14g2GZsaDLbKfugkojdfg
	 u+vFKz5+X7jKxdHwa5l/q3JJdXo3gFKMKdrnGKl7Ld0TKGBG7Cno3LT+yBsOLPRf4E
	 hIifQlsqg+e4A==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so11392164a12.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 20:38:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YxrWO5p8lg8bN33SrqNkFHDUTR9H4k7rIryovRLXcve2js0XI1k
	1yiLJdL1LZ1vy7WfOvrzOCWvTDfeD3SxLDEzzFdB8Pbw8gDDVFHXeCojT04RHOLCdwn0V6N71v1
	FIVafv4/lxRrGFVtxFzWr/HDm+tR9/50=
X-Received: by 2002:a05:6402:5c9:b0:667:83af:b623 with SMTP id
 4fb4d7f45d1cf-667b214dcddmr1286959a12.4.1773805131312; Tue, 17 Mar 2026
 20:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311090035.169539-1-dedekind1@gmail.com> <20260311090035.169539-4-dedekind1@gmail.com>
In-Reply-To: <20260311090035.169539-4-dedekind1@gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 17 Mar 2026 23:38:40 -0400
X-Gmail-Original-Message-ID: <CAJvTdK=DAmRpGYx6xwSghpEOh3z+Y8vAqFJr3kogT9NsJwN9LQ@mail.gmail.com>
X-Gm-Features: AaiRm50ogNQ-BRDBX_kOETci35TJfdGPGwfj-fI0Pr7rUuvGLsdZwJSm2XJif7s
Message-ID: <CAJvTdK=DAmRpGYx6xwSghpEOh3z+Y8vAqFJr3kogT9NsJwN9LQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] tools/power turbostat: fix --show/--hide for
 individual cpuidle counters
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Applied, thanks!

Len Brown, Intel Open Source Technology Center
