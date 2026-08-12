Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4036E364042
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550682; cv=none; b=eoKwV+xVNNcCrmQ9cLEdQqO93Ld4xX+pSqUob5N8lngSvmG6RfEBKffsncOAU3xDr2p6HQOlHbd/+J9M/05NLPUXjI6iRPuVAThmU6B5P4JZkfJMhcFaxb+sHfOZHDBKRvVRsH23dX3X/QBwE5nvTmCy9dR+tIp3Se0DYCC2Ni0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550682; c=relaxed/simple;
	bh=PWVVFah3pXXWxhk4pMGUEW7qRmitAA9c3z3/XA4bD9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxHXgOpW6M6AvYH2mEdaV2QrA2wmZAPZALvPaNSiN6pJSTYG8VaQEE04jjz9gtSn+iCEKIH6mci48DJYDTL8id+qxW7n8ss7fcLkstWII7BCdpSM6DcGDqjVK1ppGB2u8Vmo8NixrW/e7HcPkR0ucNmYR6Y1vQAv/GN/nbS88ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dbz9TBYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dbz9TBYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74E71F000E9
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550680;
	bh=PWVVFah3pXXWxhk4pMGUEW7qRmitAA9c3z3/XA4bD9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Dbz9TBYivykmd9mfMwC0l/91AtRbD2/kt5I3Bb0E/p4zI4gbsUw6MGer+XTmQp6pf
	 HNJMx2dfeRhBQ5bGr2FLWTnrYrQZMd2dZMjFN9Cvc+c6DbXm4BjmAxmvLlbbzOSbdC
	 trxbyhRIpqQf9JaxjFLjF29eI6qBFP8DfFzjjaAdtFSAIe+4RsvpXWLec/CSBVZgs1
	 fYaLNaIfh0qbjipgeiygJ2mPvLNR+YbdByrZy2b4+zbplYGQU7ePR6ZOBNzyFaINas
	 rcG6CVLOXflYU1+zaPLhq5C1qvP2PW4Lja2NYe9ZqCcttekxWNiHCAEI2+mcm0r7VA
	 r0nMv63RrpBKQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39dbe684115so274831fa.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 09:04:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrpqDP2o7QTdb9xIXKT/b16oql3NjBwL8wOoHWSA9A4R/6xJyFT7OZGETclc1iNHv4olxeY1ZCXDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwBl8cwuX1wsRc0J8kdsw7B4lptSgYgYcYmNe1uiwKfN0ktr+DS
	psjfzmQS7B5ZJ+RkE9brc+jKQTSlsSf3HcW6DqQxzP+Aw/31ddrFcrYb3gslVLX86N+vbNVDZ42
	mg/8+JHBUK22TwsoSwIvLXF2b/8sVZI8=
X-Received: by 2002:a05:6512:8050:b0:5b3:f8b:b714 with SMTP id
 2adb3069b0e04-5b4531c7bafmr32965e87.21.1786550679400; Wed, 12 Aug 2026
 09:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <91946ecf-05a2-4479-bade-3d0803bdcba2@oss.qualcomm.com>
 <cf0365de-77ee-4ae9-96bf-0652c172f425@oss.qualcomm.com> <CAJZ5v0ibXHOsa4Pp=A00cKCOiBnk9SMpSk_n9JE2qSYTRZzYrA@mail.gmail.com>
 <86ba3abc-c538-4d56-ac2c-3154b95e00b2@oss.qualcomm.com> <CAJZ5v0g2G7L0hS64Eh14927P7g+eX_3KB_qUehBoa2OUfh+ung@mail.gmail.com>
 <61e48b08-1a91-4d3a-8617-f25980038bfc@oss.qualcomm.com>
In-Reply-To: <61e48b08-1a91-4d3a-8617-f25980038bfc@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 12 Aug 2026 18:04:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gi9n4ZAf7YZsf_dXhqYKA3DHZpR_fLmxgukogNKVbb6g@mail.gmail.com>
X-Gm-Features: AUfX_mwp8tpg7SWwZlrH8Q98yuZQdFjCgk18lsYxoq-37n7eoohNBi0tD-2aFbo
Message-ID: <CAJZ5v0gi9n4ZAf7YZsf_dXhqYKA3DHZpR_fLmxgukogNKVbb6g@mail.gmail.com>
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

On Wed, Aug 12, 2026 at 5:16=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 8/12/26 14:50, Rafael J. Wysocki (Intel) wrote:
> > On Wed, Aug 12, 2026 at 2:43=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@oss.qualcomm.com> wrote:
> >>
> >> On 8/12/26 13:28, Rafael J. Wysocki (Intel) wrote:
> >>> Hi Daniel,
> >>>
> >>> On Tue, Aug 11, 2026 at 4:48=E2=80=AFPM Daniel Lezcano
> >>> <daniel.lezcano@oss.qualcomm.com> wrote:
> >>>>
> >>>>
> >>>> Hi Rafael,
> >>>>
> >>>> please ignore this PR because there is a missing SoB.
> >>>>
> >>>> I'll fix it and meanwhile update the linux-next branch so it will fi=
x
> >>>> the build issue.
> >>>
> >>> Well, the build issue is still there in my thermal branch though.
> >>>
> >>> I've now remerged my linux-next branch to avoid exposing the thermal
> >>> drivers merge I did previously and I'll wait for another PR from you.
> >>> Worst-case I'll skip the thermal drivers material in my first 7.3-rc1
> >>> thermal PR.
> >> There are 3 fixes on top of the PR.
> >>
> >> One is obviously to be folded with the existing series as it is my fau=
lt
> >> I forgot to add the file after fixing a conflict [1] which led to the
> >> linux-next build failure.
> >>
> >> But two were reported by lkp [2][3]. May I take the opportunity to fol=
d
> >> them with the patches they fix and shall I keep them as is ?
> >>
> >> [1]
> >> https://lore.kernel.org/all/20260811145427.3089426-1-daniel.lezcano@ke=
rnel.org/
> >>
> >> [2]
> >> https://lore.kernel.org/all/20260811094935.2941313-1-daniel.lezcano@ke=
rnel.org/
> >>
> >> [3]
> >> https://lore.kernel.org/all/20260811094747.2940616-1-daniel.lezcano@ke=
rnel.org/
> >
> > At this point it's better to do additional fix commits on top of the
> > previous material as it has all been exposed in my thermal branch for
> > which there are no history rewrites.
> >
> > Please send me a PR with all of the fixes on top of the current HEAD
> > of my thermal branch.
>
> Do you mean linux-pm/thermal ?

Yes, that one.
