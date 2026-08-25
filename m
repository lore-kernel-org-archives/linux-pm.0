Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F1C3B5301
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684382; cv=none; b=LFpOaspcEzqQQY0BmahBwbd73G8fSbmhpNotOEx4Je56nndBm/SoK6tj1O9MPA8ogFD1Sx/L9/mpicnCm8+Tvii4I+c6TZINXEY7Lwim7J5rxVjQSh7g3sqctN37DNY9yJpv3uB2J0dKUiVRf3Tjj7hyW+U9cI4CyUAuxkVN3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684382; c=relaxed/simple;
	bh=5plKsS+uASIQTYQh34Fh2nX4JFfVtwB6LE/z3YWdG5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzJLfN3tEF5pdceOC99Z24ZwndJOXa5Crvl9gSfWtDUpq1siQCuaKJJEkPH1DU1vjM25qde+uZ+t9K9hT6uBpQN3Gf2D0AjhbzQED6MwM4Fpbeq7advT4GBpSbrLHH8MxOz4wbMju5sddZAVyqfMgTKNa3Pue/C23QNClk+WCrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7dsB30x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7dsB30x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9870C1F00ADE
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 18:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787684380;
	bh=kWidqxLeQBllMhAA1iM7Mqn8zXuNune5V1hwmAATg08=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=l7dsB30xdbKqaBlqTEW1raA26FCfGn7PRAbDqe1JQaaj7aDbALB/shqwB0TEaAbbm
	 d4wkABbKU64pPmXToGPbpNE2dVuij2zd9Xueuijs3uFN1GK1IswnSRzbfnk1E19mZ1
	 nLNrH8dhEHsIuB1oAbZRf+A7ZCRSsnSFWAbfwxGHvsfICEbBab0uMbfCyHstFOOW9V
	 8XI8DBRbrKodkpOoG//quMNWhYk/3NpOMqHKIZV/8mvWreQm2I/CNfBE8W9tCuzitt
	 dZy3QThdxA5TQ5fiYkH82mU3YLlQ0f+YCaD5dlNQHN24A3Se5o9Sfoea/2vexvrU2r
	 mGq7cFkfBZEhQ==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a1f628b1d1so721281fa.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 11:59:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpLF3LgtkhHc+PmJPTnyLSznhiOCxjcmXD1kp3ydzbdO8hXZUJ0pITR2h3quRUK5wnAFe6n2S2QhQ==@vger.kernel.org
X-Gm-Message-State: AFuF++llmLM9W/VuDO71i6EN4mFoElphFG4UhgrsdRU92MKbHcqIWD8s
	RaEzcjfCH39IBlQI6EGE0rYcw/2p1W3vUBLvhBJXUjpKVAQnAB4Uyh5lgCXdfjOARv+DWc//SWI
	FWPqFRBjes6+PtDKnRb8x758ZCowdbpY=
X-Received: by 2002:a2e:bc05:0:b0:3a1:1d3b:67f1 with SMTP id
 38308e7fff4ca-3a1fd6188bfmr1473361fa.7.1787684378885; Tue, 25 Aug 2026
 11:59:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aohvcP8ch-Zn6tV-@sirena.org.uk> <580f9129-de4a-472e-bebb-d08d9cabad7f@infradead.org>
 <6027571.DvuYhMxLoT@rafael.j.wysocki> <20260825184825.GA1276817@ax162>
In-Reply-To: <20260825184825.GA1276817@ax162>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 25 Aug 2026 20:58:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gDQAbyo+KTgQ8CzUfJ6cv4xg6-rHbH-HcbfXCWX9Wc7g@mail.gmail.com>
X-Gm-Features: AcwNN1VLCAgpQgZ5gnFi1h3xxTxb9gpzZyNBAdh2QJR2jPjdOdRMq_hwtYolxl0
Message-ID: <CAJZ5v0gDQAbyo+KTgQ8CzUfJ6cv4xg6-rHbH-HcbfXCWX9Wc7g@mail.gmail.com>
Subject: Re: linux-next: Tree for Aug 21 (drivers/thermal/qcom/qcom-spmi-mbg-tm.ko)
To: Nathan Chancellor <nathan@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Mark Brown <broonie@kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux ARM MSM <linux-arm-msm@vger.kernel.org>, amitk@kernel.org, 
	Thara Gopinath <thara.gopinath@gmail.com>, Linux PM <linux-pm@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 8:48=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Tue, Aug 25, 2026 at 03:27:32PM +0200, Rafael J. Wysocki wrote:
> > On Monday, August 24, 2026 9:15:16 PM CEST Randy Dunlap wrote:
> > >
> > > On 8/21/26 8:32 AM, Mark Brown wrote:
> > > > Hi all,
> > > >
> > > > Changes since 20260820:
> > > >
> > > > None.
> > > >
> > > > Non-merge commits (relative to Linus' tree): 7073
> > > >  5989 files changed, 509370 insertions(+), 156446 deletions(-)
> > >
> > > on x86_64 allmodconfig:
> > >
> > > WARNING: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module us=
es symbol 'devm_iio_channel_get' from namespace 'IIO_CONSUMER', but does no=
t import it.
> > > WARNING: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module us=
es symbol 'iio_read_channel_processed' from namespace 'IIO_CONSUMER', but d=
oes not import it.
> >
> > Does the appended patch address it?
> >
> > Interestingly enough, it doesn't complain for me when I build the
> > thermal tree merged on top of the current mainline.
>
> FWIW, I sent a fix for this two weeks ago that explains the semantic
> conflict:
>
>   https://lore.kernel.org/20260812-qcom-spmi-mbg-tm-ns-modpost-error-v1-1=
-d849390d2714@kernel.org/
>
> You will only see it when the IIO tree is merged against the thermal
> tree.

I missed that one, thanks for the pointer!
