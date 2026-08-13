Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128673B6BE3
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613261; cv=none; b=QzqNdyak8b5mdWNzejKAHA38Uv4QG30NeR+zBZYIVeQGnwtoJoGQ8gc8GFGfSqz2UZyxBFLcUGLALSEC88KOz4fE1kUit9ecIXk4zRwkCBc/oI3yaamRl24cJdJWMpv7+E3itPdeSX/JnVpA63rTzKJHFr3sAhqO6GPDKgLXSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613261; c=relaxed/simple;
	bh=ap5TmlZjYPps+f+nxZ/Boy/5HkgNM2uC+CweCihS/lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRzkKqLocKlFYt85d1Ha/Y/1I71n8/UuNkjtHYHl1XudDgAfdIGShkDoedhaT8v4gqhZkyG8Royi2l+LMCZzNhqtJqM8Gixm4BFKHA6e1OWIDqEMS3zraOXgj24Phb+apewb2V1mBmCEVu+Vo5/liZ9j6GOk4UDa+Rd7nkM55iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhC0/SAX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhC0/SAX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACC51F00ACF
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 09:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786613257;
	bh=oBCX82m5ZSqSPdIThLcKGwKHLqMpKpSAuFVKZ/GEKSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OhC0/SAX5Q79/y0KqU33dF6pj+HlKqW52wKXAAK0mhQnt2Mcu8/FwjRAJGMhRVBTc
	 JZkOlkBucP/GbLbHPx8lCgHWQju25Tfsc+Wocms1o6dY7vfMzgtpkhaoK3XeWNmBvd
	 PN2c3t3sS+79ysl9xWoC6st5ryKfJR7pAS1ETkIFP3iB/7Zwmq9xVXBkOYm1Vpv5Fm
	 BTGJHw4W032q6fnDBTX+85dtAZ34RCBO/SjUOQFSgt8xDTJGDg5twWLk+biKxakTfm
	 +B7HItQK1nGDgxsPR7I59PVuBAW13gj0Iw0XVDLpUMaW98ib6rGsm7DMhZgUm5Cuzx
	 rdTSW+vN4dA9w==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb24c0807so1446383e87.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 02:27:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp3N347aS5OPLwX38U50f42AIHwDaW+aGbNuDj9cg157QcwQIFOZ98n6YCOzTctmWwL51RwJJ0ZVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxHywow1xpdFPhVnKRRgu5J2u9Z1NbP/3ClKcUigwtnOEK6UUC
	nD4mzygsCdCFkrTYBo1k8WTpGoo1AJF8YwkDD6OAv4WsrLoDyeDLr0BILOQUJv1LpOJdxOHy5JO
	gNaIuOgSIPkHQ+nBjwpfgL1yS+EaVxjI=
X-Received: by 2002:a05:6512:3144:b0:5b0:bc3:dc0e with SMTP id
 2adb3069b0e04-5b453f8f859mr385593e87.29.1786613256046; Thu, 13 Aug 2026
 02:27:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <91946ecf-05a2-4479-bade-3d0803bdcba2@oss.qualcomm.com>
 <cf0365de-77ee-4ae9-96bf-0652c172f425@oss.qualcomm.com> <CAJZ5v0ibXHOsa4Pp=A00cKCOiBnk9SMpSk_n9JE2qSYTRZzYrA@mail.gmail.com>
 <86ba3abc-c538-4d56-ac2c-3154b95e00b2@oss.qualcomm.com> <CAJZ5v0g2G7L0hS64Eh14927P7g+eX_3KB_qUehBoa2OUfh+ung@mail.gmail.com>
 <61e48b08-1a91-4d3a-8617-f25980038bfc@oss.qualcomm.com> <CAJZ5v0gi9n4ZAf7YZsf_dXhqYKA3DHZpR_fLmxgukogNKVbb6g@mail.gmail.com>
 <55f4589a-5146-4f46-aed1-39a1c3a15ac8@oss.qualcomm.com> <CAJZ5v0gwXQ3Y=6g=TnR5rpqAkdNCOsNa_yqGcMO5KHOOPuwQog@mail.gmail.com>
In-Reply-To: <CAJZ5v0gwXQ3Y=6g=TnR5rpqAkdNCOsNa_yqGcMO5KHOOPuwQog@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 13 Aug 2026 11:27:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gD_48j--P_auMSG=s8M7SzVmnU+e2=sxpn5CQsFp=ZFg@mail.gmail.com>
X-Gm-Features: AUfX_mwXlFT8Af9RwkQZWJVdDyZT4SlXH9RlfovIScwib5DN1hPFWXX89uVOE7w
Message-ID: <CAJZ5v0gD_48j--P_auMSG=s8M7SzVmnU+e2=sxpn5CQsFp=ZFg@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers fixes for v7.3-rc1
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>, "Bryan B. Lima" <bblima@usp.br>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 11:17=E2=80=AFAM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Wed, Aug 12, 2026 at 11:33=E2=80=AFPM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
> >
> > On 8/12/26 18:04, Rafael J. Wysocki (Intel) wrote:
> > > On Wed, Aug 12, 2026 at 5:16=E2=80=AFPM Daniel Lezcano
> > > <daniel.lezcano@oss.qualcomm.com> wrote:
> > >>
> > >> On 8/12/26 14:50, Rafael J. Wysocki (Intel) wrote:
> > >>> On Wed, Aug 12, 2026 at 2:43=E2=80=AFPM Daniel Lezcano
> > >>> <daniel.lezcano@oss.qualcomm.com> wrote:
> > >>>>
> > >>>> On 8/12/26 13:28, Rafael J. Wysocki (Intel) wrote:
> > >>>>> Hi Daniel,
> > >>>>>
> > >>>>> On Tue, Aug 11, 2026 at 4:48=E2=80=AFPM Daniel Lezcano
> > >>>>> <daniel.lezcano@oss.qualcomm.com> wrote:
> > >>>>>>
> > >>>>>>
> > >>>>>> Hi Rafael,
> > >>>>>>
> > >>>>>> please ignore this PR because there is a missing SoB.
> > >>>>>>
> > >>>>>> I'll fix it and meanwhile update the linux-next branch so it wil=
l fix
> > >>>>>> the build issue.
> > >>>>>
> > >>>>> Well, the build issue is still there in my thermal branch though.
> > >>>>>
> > >>>>> I've now remerged my linux-next branch to avoid exposing the ther=
mal
> > >>>>> drivers merge I did previously and I'll wait for another PR from =
you.
> > >>>>> Worst-case I'll skip the thermal drivers material in my first 7.3=
-rc1
> > >>>>> thermal PR.
> > >>>> There are 3 fixes on top of the PR.
> > >>>>
> > >>>> One is obviously to be folded with the existing series as it is my=
 fault
> > >>>> I forgot to add the file after fixing a conflict [1] which led to =
the
> > >>>> linux-next build failure.
> > >>>>
> > >>>> But two were reported by lkp [2][3]. May I take the opportunity to=
 fold
> > >>>> them with the patches they fix and shall I keep them as is ?
> > >>>>
> > >>>> [1]
> > >>>> https://lore.kernel.org/all/20260811145427.3089426-1-daniel.lezcan=
o@kernel.org/
> > >>>>
> > >>>> [2]
> > >>>> https://lore.kernel.org/all/20260811094935.2941313-1-daniel.lezcan=
o@kernel.org/
> > >>>>
> > >>>> [3]
> > >>>> https://lore.kernel.org/all/20260811094747.2940616-1-daniel.lezcan=
o@kernel.org/
> > >>>
> > >>> At this point it's better to do additional fix commits on top of th=
e
> > >>> previous material as it has all been exposed in my thermal branch f=
or
> > >>> which there are no history rewrites.
> > >>>
> > >>> Please send me a PR with all of the fixes on top of the current HEA=
D
> > >>> of my thermal branch.
> > >>
> > >> Do you mean linux-pm/thermal ?
> > >
> > > Yes, that one.
> >
> > It has my PR in it, should it be reset ?
>
> No, it shouldn't.  Please send another fix PR on top of this one.

To be more precise, please just make this new PR only contain fixes on
top of the previous one.
