Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB8437118
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786539029; cv=none; b=X0sNpcehR8XJCsFj9p+ChYK7wUQcee933B6dayIe2+cbXzOfVCnXlCwiWCPI1btrmfp4YZpyY9DVZdwIBrNZqfUc5fgmLzIq0qLRK/CTt7MCLC3cgtcI+6+SYwBhjUP51gLrxx5TpUrnKy/VvRvEqd2EwGGxE1E3nFCaXeUnOGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786539029; c=relaxed/simple;
	bh=W3xeRc919Z+Q7xzdSiV8sqtMh9UHpzb6myu6PztEbT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zgi70nT1c7qjvKRtp6Z8i0iyWfNtwXCACdc0zUTGKvFh1BNd/zG0U7kBrKozriLogtBkeo/Hr2BVOFmyDzL9oqPoLmXBmS1ACDNuAUtJ/VYbOqPNeSWTWZI4oTYo2dYQxfzpSiAccuArZbKyAKKYcHAp1Hn5q0lC+YF+c6UQNM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHnGsBZi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHnGsBZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A054C1F00ADB
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786539027;
	bh=W3xeRc919Z+Q7xzdSiV8sqtMh9UHpzb6myu6PztEbT0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZHnGsBZi19kedmCoYIqndzPT0xfIJkIKMu/4av9epglvpFKYdhB7qCBK/JIvoMPdq
	 rhN3fXmAZcKY5Vt/aJd9aIJV8fuMEQ+v039ogqWZAioTAXffHaJ0ZmF6+2omQrUgDB
	 rL/xPQ4bppcp+d/Hre65EWPcRVZz3DBkERVGrD6wbRhWmc970M0c1ag4xG69l2+/eh
	 Ubi8F2Mkv2EX2wLHXwufAuiPZarswJPt4xEGdLcb+dTSujtTy+si66hrzvhlCWrQCN
	 9IEfbzBGM5xzFY1hNI3yMvM1c07eWT/y5uM9W4Yt/lAjvYDBYU1M7QGoPzYvQGRjxM
	 w0DnAPe/ppjUQ==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b015532f7bso997083e87.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 05:50:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrnnoE6N7VpNbH7SIhxKO6k9W51julc0SxdZGOlvwHBMpF3UhkmYc7s2aK+Lpl/X86RJ7AatAD/2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHfmBhE0/J3tOepk+AC9zHjulA58w1F4pChkUM2GEPGz6+Uut4
	Z8XdZ+2ADsHU7z0ftHYrskBJiL/o67+gokErRrJJC/R9XS5PkjgPQC/2o84K5oreaIlXkZk8cZl
	/HZ8IoQsQWOx0fxwxs0AayDqG4nEUBUs=
X-Received: by 2002:a05:6512:2306:b0:5b2:f426:9c67 with SMTP id
 2adb3069b0e04-5b44e2e1a07mr759527e87.19.1786539026029; Wed, 12 Aug 2026
 05:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <91946ecf-05a2-4479-bade-3d0803bdcba2@oss.qualcomm.com>
 <cf0365de-77ee-4ae9-96bf-0652c172f425@oss.qualcomm.com> <CAJZ5v0ibXHOsa4Pp=A00cKCOiBnk9SMpSk_n9JE2qSYTRZzYrA@mail.gmail.com>
 <86ba3abc-c538-4d56-ac2c-3154b95e00b2@oss.qualcomm.com>
In-Reply-To: <86ba3abc-c538-4d56-ac2c-3154b95e00b2@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 12 Aug 2026 14:50:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g2G7L0hS64Eh14927P7g+eX_3KB_qUehBoa2OUfh+ung@mail.gmail.com>
X-Gm-Features: AUfX_mw2cNdf090onpOyglc5AwIz5FFJHXnnmag1WS1Gb3Bn6I6op33rvy2W7Xs
Message-ID: <CAJZ5v0g2G7L0hS64Eh14927P7g+eX_3KB_qUehBoa2OUfh+ung@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers fixes for v7.3-rc1
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>, "Bryan B. Lima" <bblima@usp.br>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 2:43=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 8/12/26 13:28, Rafael J. Wysocki (Intel) wrote:
> > Hi Daniel,
> >
> > On Tue, Aug 11, 2026 at 4:48=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@oss.qualcomm.com> wrote:
> >>
> >>
> >> Hi Rafael,
> >>
> >> please ignore this PR because there is a missing SoB.
> >>
> >> I'll fix it and meanwhile update the linux-next branch so it will fix
> >> the build issue.
> >
> > Well, the build issue is still there in my thermal branch though.
> >
> > I've now remerged my linux-next branch to avoid exposing the thermal
> > drivers merge I did previously and I'll wait for another PR from you.
> > Worst-case I'll skip the thermal drivers material in my first 7.3-rc1
> > thermal PR.
> There are 3 fixes on top of the PR.
>
> One is obviously to be folded with the existing series as it is my fault
> I forgot to add the file after fixing a conflict [1] which led to the
> linux-next build failure.
>
> But two were reported by lkp [2][3]. May I take the opportunity to fold
> them with the patches they fix and shall I keep them as is ?
>
> [1]
> https://lore.kernel.org/all/20260811145427.3089426-1-daniel.lezcano@kerne=
l.org/
>
> [2]
> https://lore.kernel.org/all/20260811094935.2941313-1-daniel.lezcano@kerne=
l.org/
>
> [3]
> https://lore.kernel.org/all/20260811094747.2940616-1-daniel.lezcano@kerne=
l.org/

At this point it's better to do additional fix commits on top of the
previous material as it has all been exposed in my thermal branch for
which there are no history rewrites.

Please send me a PR with all of the fixes on top of the current HEAD
of my thermal branch.
