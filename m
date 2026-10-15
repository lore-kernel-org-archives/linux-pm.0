Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482964E4C22
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066126; cv=none; b=f8uTyTYpp0OU+CqxIjsTe4OupSNFG1zLgbwONg2Cu+Im14FaGpW3UlBD04z/sWFrdh3v1o6N646j745xqJjBswVE5LYd/0D6+KROQ4RJZZsMU/9B0YHFgA0uKWYhT8xrhtE3VL26JDDGAPSmg1/kDyAkfX7ZCkdTUAmkNXcguR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066126; c=relaxed/simple;
	bh=rwve/lrMelILXHO8EI1RG1qfxEqofbz4qV/vULi2MVs=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndl5sabz3nFqPf2t4hrneUfJN4eE9QPczxsZBis2qrkU5vyu44rtyk8/hNT8N6ydBifGApYsYNT4dkheyj8/nkRE98lIJy5PGiF+nr1V2bvYVY/5kWCtXlATSQIP+o49WMnY3Uz31t5v9xSmRQH8yBqK8ZEadQ7oTYlVjjmt9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3/KyA7k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3/KyA7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DA31F000C7
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792066125;
	bh=NKeQ1khZ10IWq/8SFcICGZaXJTG9uvUp0paqGQCwHMs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=m3/KyA7k3Q+mDBsFfee0dNGtPvTPVgJ5m45kRDVxjBd+q94ZSc1egaKLnETZclZx6
	 kTwo7OyqcFdFJUvw8V3OnSZaFOvwdiKE5L2rxMx6hMsnqKQUMI7wQSQy1cWf37v/cV
	 NUF4vS60tH/2g+3JUFOHl/a2M0v7kysemgXxRAQs84YB0FUMfj3TM4HCvKmwGl+4H7
	 FNHr1FyFQT3pWK+pSqKDanorxP4AzqcjveEczSHOMS0kNTQWAinx2C9mDmRqDQb2nF
	 IEbJyw0/fDbq0AlShGeYEsVgO4qyy/8foeocW+mWcmfN28UaS9uFTQwY7R7NhGCph8
	 CBSuBLHO0Idkg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b8b3c8c4bbso2300591e87.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 05:08:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxQd2ki1Rb9fOsdmjvZuwV36xcg5MKsaoGEFFKyOJOasnZQrQbQ+uTmdT08SmpV4S8PPDJIjsJYsw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJM2iPZzzDNYnz5OnTUjKSYO7CkiskbxyKFLfcdWltPii6FKeCX
	DNExw0pP1SStMwkXiNbmWO/B8/LcaMbCzSuorp+W3XT9xla/s8EVSEm0X7OU9lTbotoPyyRB2Qk
	6bRpj59V8Vr18fF27wgMu5Xds6OkOUGFl8U47QsskeQ==
X-Received: by 2002:a05:6512:318a:b0:5ba:430e:f627 with SMTP id
 2adb3069b0e04-5bcdd1c318amr5442326e87.1.1792066123844; Thu, 15 Oct 2026
 05:08:43 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 12:08:42 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 12:08:42 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CA+V-a8uVxwP+AFbRYb-weN+EHQ5rFxo7gXPus4muSrMri1QAAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009165710.1320233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMRc=MdcWS0c9E0V3cJj9B9WMAe0vSs9e2s2EauRH5zFkOng+w@mail.gmail.com> <CA+V-a8uVxwP+AFbRYb-weN+EHQ5rFxo7gXPus4muSrMri1QAAA@mail.gmail.com>
Date: Thu, 15 Oct 2026 12:08:42 +0000
X-Gmail-Original-Message-ID: <CAMRc=McjH1CE9wZpqWVWOa23oQn-Zxsq64akB4FgW=dA28vGTA@mail.gmail.com>
X-Gm-Features: AclHuK8HS_70o7anX2R8BK89-XyAWV79pV1PxwdAxZDse4-3BBRpa5S1S2t4q0M
Message-ID: <CAMRc=McjH1CE9wZpqWVWOa23oQn-Zxsq64akB4FgW=dA28vGTA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add ADC power sequencing support for RZ/V2H(P) and
 RZ/V2N SoCs
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Oct 2026 13:05:10 +0200, "Lad, Prabhakar"
<prabhakar.csengg@gmail.com> said:
> Hi Bartosz,
>
> On Thu, Oct 15, 2026 at 10:43=E2=80=AFAM Bartosz Golaszewski <brgl@kernel=
.org> wrote:
>>
>> On Fri, 9 Oct 2026 18:57:05 +0200, Prabhakar <prabhakar.csengg@gmail.com=
> said:
>> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> >
>> > Hi all,
>> >
>> > This patch series adds support for ADC power sequencing on the RZ/V2H(=
P)
>> > and RZ/V2N SoCs. It introduces per-SoC probe functions for the
>> > renesas-pwrrdy power sequencer driver and ensures that the necessary
>> > Kconfig options are selected for these SoCs.
>> >
>> > Note, the ADC driver and binding patches have been posted separately.
>> >
>> > Merge strategy:
>> > option #1:
>> >  - Once the pwrseq-renesas-pwrrdy driver is merged in only then
>> >    the sysc driver can be merged via renesas tree.
>> > option #2:
>> >  - Merge all the patches via renesas tree.
>> >
>>
>> IIUC there are no build-time dependencies, so the pwrseq and soc parts c=
an be
>> queued separately?
>>
> Yes there are no build-time dependencies, and since renesas-soc is
> closed for v7.4, the pwrseq patches can go via your tree.
>

It's rc7 so I prefer to leave it for the next cycle too.

Bart
