Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794393865;
	b=YAUkyA5sfICslmyDU5wwXXlURR5pNZRRTUpnupvIqjjUgiVaZ8Kv7FBr54BtpCq6C6LW
	 l0xc2Vtiz5OBCk26ywiNaG7ZutkTBKGZ5cl9X43xu3oHij5R5I/NvJAvCpHAEDpe7v0xG
	 BkeKAI1JLN8sG+WTCauYrbmQwx5I8gfOHX7n4HKz3ijSCRs3oShdOF1bdoU0OKpDzDZ0H
	 Ig7CpVU3TQXjvkeokyN6luJV+vH/c85LUogCUPzY6RSDQaT4q+r23H52IKiAhqqqyL7WL
	 PfeE5rTkGXwkinVk26avlzML24kl1ToO65LadjqnWeEd8VzwlOPpjWv1LpIW2CUyxRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XDltiKjGMBTBW0kCAum/jL7npP4ychg3vu8xCXEIE5Y=;
	b=1/mcvuaR4XUpbVaxak0LuyRCl1lNB6D58ecGjrsfrsfM1JX2d4S+TEwlEFVHYxovs1LV
	 Pzok9LyGGy6c+l9ClNXHRvf9zmo7kOqWvgoBaWzEsYQqTo16jzABMf0lmNNFNBpSdFhmg
	 kyQOmDUk+mQvytW/sQPljqXtPZYRhT0M5Lov2bPg0e3+8pDZa+QFws78klmlUcE+A1ePV
	 8fR5jh6x4I5EEPpDdOYn4Ypln0LY9ZUJSSwMG2eXk7j3rHk92+VfjPHf+YKxD8ULzDJPM
	 IizkmVf1AXBl3yIKlN39cNkKmJoKQ1uWz0oLW2gEH7Anu0F0VmsHYkQib1nGTPyFyaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fs8YFliw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF041606A326
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 10:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF041606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fs8YFliw
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so38349385e9.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 02:44:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794393863; cv=none;
        d=google.com; s=arc-20260327;
        b=fchM3kYIoMbVu8YmmMCVZtvwNFdDRUQMn9abHWG7gtEYeDkVWjcG9F0wRmgljO7tgb
         Aked04jv1mhuKMdziTwJ2mePCqU5LhRDFHbaH+3BI8SlngUiKii9eInZxt2IxMTVyTMJ
         PSAfHTrlmRXcLPMxX7yq3DPr/xReRBKQcnfwYo6/N94rnhk9iB3f4A7XUjsFqTZhFaDm
         KPEjaN5TdcgZPzyrmH3teeyD8vRrmW5R121LI7liwdNcUaXrEs4dQp2iEpGASCR8rCsl
         LimfmlKMG35P/U0az2X4+fBxvXoXyMLScUtPU+RdgXTbz+rMgf7UEeEVIHgqe++YnRJ0
         txhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XDltiKjGMBTBW0kCAum/jL7npP4ychg3vu8xCXEIE5Y=;
        fh=e84Ei2GGfEjZeUDOwx3J08gm3x2gs6jsx1+4aT9d9+I=;
        b=BMmeB08dQ4YsXHTdtozboi67WgcAiBkxihLYVbwD+bs/MDjtoISLP2wzK3PMTHTb6q
         xgpA8PTmY/CjiaKijZ5PoNu1ao3px14AXg3D4/BIm1WDONF6j+uhk45bm4JBf6eUQGBk
         DXBE7qDUpARspVnAVF991TtUnLP8lT5oBbmd9jBkysIKItVS+0HkRngtJdvpoMY+jRml
         BydefGvjZtIpdLe1rITazfWofi9fdYgT0EuD1cimzvbWyJumiWCbjBCFybq5xivnqpyo
         FJy0n14MTjPr8gwr9wnagJ3CFgJqlDmUzur8WHe3hzsVSS7uydbLZZ5r+9JAlCBeSC3Z
         b0IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794393863; x=1794998663; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XDltiKjGMBTBW0kCAum/jL7npP4ychg3vu8xCXEIE5Y=;
        b=Fs8YFliwR0dE34yAPVXf0YnsrVCXForfvJ5syM6fGnqXF0TTrrD5zLHNLZoIj967Wn
         RkAiWlwsQ+st7JAel/3WbkKBe3YGM5XueyFFIrdx2dWshV1w16XKa0uRdcaYj0ENjexd
         RyOynvqSjSfduPmadS6ldC1bPwlAaUW56tFRBvyyJ6zx+maDOCLVHqCZHRotfKppcOvW
         GVtKM1+P/6pCmQOeLmBtcl+lbgnKIWaIjmgPB622r7IrZGKxMfaoTw17fX2o9ZO1ABgp
         /rEM5vemp+9VtVNA75SbpJMAbgJVCWY6lK53nhEfMpprCN1m2ArawIwFpZRa9e5hXbKE
         V29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794393863; x=1794998663;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XDltiKjGMBTBW0kCAum/jL7npP4ychg3vu8xCXEIE5Y=;
        b=LF8N++I0gml/BEh59Xg4d7cpY3lYio5y71WDpsKT2MzSbqma9A1MIf4H65VMro/lTS
         37M/yUQvCMIzHsrpIZRghAEledLe0cDsBWbMEhpx1iljXsC2x1K3eqWj/6kSIqffhZPT
         fC/LEiyTzrD/HD9wrZP7zlP8wJ/KN4hD9Dmm4rUVmJSeYMXBjBxWplAerulnrVS2VNNI
         WpvFkNrn0mpOHb8n6TZhB3KyaiK8vN9LRWl5IV0BK6YEK1mOr0jF4AAHuCmhbr8oQdHn
         0k/zHaAotBfJFmCpvmvB/bE3OlEQr1CeGPnQlPE+kv+pfugD+i41Vihf/YTddH/srZ9D
         hmlg==
X-Forwarded-Encrypted: i=1; AL+hErHbC11Q/Dk5sAzdluG7kaYYwyVsKbw5jHbEheCOqeN9bvUTXsWRprN+xxq5l1tFzmKCUrXLDIbv3g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8M/kPrEBW59G9NDIpGlRhskw9DhlV4ZKlLl3EuMbxYVqyMx41I
	9NUrFWIN50ZQR5Bq+zc2VknJMP91edzl65WT9RdonoNiFoJtJNUz2IstfkOWaCQ+iKtcPUjwxpB
	PBjtagK1BJ67JXMEi0OQ60C18XhypDaI=
X-Gm-Gg: AYBFou3qAUgq7/gf3lJNDCWH1b5cenezma/gA2dBmCwhfrxenJAPUIGOnjaSMxX9WSn
	6devfQskGq6LEeKo+Y4jRSlgtbBMqor1I0100l8KWoMd5pU3c4qsZdAER9n5W6jnUbdzZAxEOkJ
	YeXM5k0xPw96L9gOLBpblIZ6dCpbNJucshiyHry4HMp5rdySMGsIECZgcletEy9+TA4rVX3QFnr
	FZWlidQRY0kGJ1E4v20TwZo0tVSGmFmiyWiIH7mQBngH4krR+ixtm38Cw25HpTxE/zTNBb7rxWf
	zsYn4l+ujPckHwZFVW8yBND6T/9gQtHp3cJDwNWbLjk7WIGVgj/4HeEBTagYHmls1C97PdwxY7z
	sBneF9hrVr5xzA7XQ2HpRt0Z9zP1sx13zrFiC3Fp7ArM0sz4fjIBzZvoxwdxnWmTN4U6+CZvAnu
	8fZ3nbQpEp1Y2/254ihVHxRyi6xeTdMQ2zq2a4H06PABMIGYhy1xDZkJKoPLa3kf7ZOQg7xykd7
	BjKIVw=
X-Received: by 2002:a05:600c:a00d:b0:4a2:1a:a129 with SMTP id
 5b1f17b1804b1-4ba093b7ffcmr37431285e9.35.1794393863111; Wed, 11 Nov 2026
 02:44:23 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009165710.1320233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMRc=MdcWS0c9E0V3cJj9B9WMAe0vSs9e2s2EauRH5zFkOng+w@mail.gmail.com>
 <CA+V-a8uVxwP+AFbRYb-weN+EHQ5rFxo7gXPus4muSrMri1QAAA@mail.gmail.com> <CAMRc=McjH1CE9wZpqWVWOa23oQn-Zxsq64akB4FgW=dA28vGTA@mail.gmail.com>
In-Reply-To: <CAMRc=McjH1CE9wZpqWVWOa23oQn-Zxsq64akB4FgW=dA28vGTA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 11 Nov 2026 10:43:56 +0000
X-Gm-Features: AclHuK_vtK80w1Fs6m3xd960NvDg0_oPO4I0vQEHXEfEWlJLombO_D83MeFpWaU
Message-ID: <CA+V-a8uERLULKgthkRu87eqCjNPexNi9sUKz_6SKx-y6WNq-OQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add ADC power sequencing support for RZ/V2H(P) and
 RZ/V2N SoCs
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

On Thu, Oct 15, 2026 at 1:08=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Thu, 15 Oct 2026 13:05:10 +0200, "Lad, Prabhakar"
> <prabhakar.csengg@gmail.com> said:
> > Hi Bartosz,
> >
> > On Thu, Oct 15, 2026 at 10:43=E2=80=AFAM Bartosz Golaszewski <brgl@kern=
el.org> wrote:
> >>
> >> On Fri, 9 Oct 2026 18:57:05 +0200, Prabhakar <prabhakar.csengg@gmail.c=
om> said:
> >> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >> >
> >> > Hi all,
> >> >
> >> > This patch series adds support for ADC power sequencing on the RZ/V2=
H(P)
> >> > and RZ/V2N SoCs. It introduces per-SoC probe functions for the
> >> > renesas-pwrrdy power sequencer driver and ensures that the necessary
> >> > Kconfig options are selected for these SoCs.
> >> >
> >> > Note, the ADC driver and binding patches have been posted separately=
.
> >> >
> >> > Merge strategy:
> >> > option #1:
> >> >  - Once the pwrseq-renesas-pwrrdy driver is merged in only then
> >> >    the sysc driver can be merged via renesas tree.
> >> > option #2:
> >> >  - Merge all the patches via renesas tree.
> >> >
> >>
> >> IIUC there are no build-time dependencies, so the pwrseq and soc parts=
 can be
> >> queued separately?
> >>
> > Yes there are no build-time dependencies, and since renesas-soc is
> > closed for v7.4, the pwrseq patches can go via your tree.
> >
>
> It's rc7 so I prefer to leave it for the next cycle too.
>
Gentle ping (the patches apply cleanly on top of next-20261110)

Cheers,
Prabhakar
