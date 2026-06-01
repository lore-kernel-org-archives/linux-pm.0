Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A193E5EF8
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337498; cv=none; b=KxR+p1Qyvjo/ZrpIswhYTPQIQcjad2p1CalSyJyKMjGIe1lFtnJqR23Z5HR4iazPfN3/R+Xgn8JvEeHsTKR5zHdOKe4WZj60x6e2H0R7daZBVJfypMZq+npFAzdCGSYWteSMHlNsR5teEnGWUYq0FNT2iZ+aEM2Pyemf/gksYZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337498; c=relaxed/simple;
	bh=SiP84wSBjXvzGl4obQJqUGO7f/9RzMYlkUj+O98EVEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=un6sUJxG3+j6GPMIoJTISv6CJJgBoZljBGtNbrET1Axq+deUj6fUG1PAcx/qddSw+pjU6IN+5KqYwiPuRQENGUhByflWwfUJFo7BRqV6HYCLRdu8PUom36hHXx5cNK+56aXHgDWKgmsTsCktUfc0CD5Ka6rf+R1EjJGqTURZEac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ81aLlS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ81aLlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D701F008A5
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 18:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780337493;
	bh=V/Uei0EDeq8dZpWHZiyt4nu5qJ+sNFdglTPQyXTHsig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bJ81aLlSmSXQ/l2uzVdRuEKkzPrCQeoKtHhY4u8YNeRC91DZ4/x3wvejUNoVXtrZb
	 T8xFDY9v4w2wITwIjp0S8cWqZ5S3vrJYM4tHK9ENkfUjZHT9KSoUgWLRWSg3qz/bbG
	 SZQ9tb+F/vBhghWICpJDWRfBEY771I8mrJMDwDLDvkgEzaIRB7aM6oQTukH3Z6ePbV
	 ZvZU0i+bN0dCNdxwJEpIqJU8rHtJUri1MhPQSihXk5QiWfxLAxi7w//fiT9ah7UnuF
	 QyXW5K4Jh0Gh8b6A4iDDt1bJEDRqzHSjZ8qYDMWljBmmIwLu73zpkVuUClFIXwNcue
	 MseUa4FSYvD9w==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa66893e9fso1840905e87.1
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 11:11:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/I3vRJH7guDkuU+mbfK4GL9YT/0+Z3ODa1W3Exnsdeg6BC75Ub+goWIS7SzLtAboEl3y4+L6N8ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUSrPkxCT5sLgmIjKnMwESzq93TmoCJMUOdYMhvD5SpA4sVhU/
	tXYpASJG2/nJJwpinkdtu9Rr5U9DEgnJzC0y6p3A6FQX25g8QYSvNpgvak/xe/DsLKrXRfD3o5f
	0IkusECp+RaCEORs3wx3o4sN77tqBedo=
X-Received: by 2002:a05:6512:b9a:b0:5aa:5c69:42f6 with SMTP id
 2adb3069b0e04-5aa73edbef9mr358098e87.42.1780337492226; Mon, 01 Jun 2026
 11:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527194626.185286-1-sumitg@nvidia.com> <20260527194626.185286-2-sumitg@nvidia.com>
 <CAJZ5v0jFpTeX0Vxt+Ut5nkmgueJFxHjoP-mdjdDd6jkCokn-VA@mail.gmail.com> <88932964-4148-4846-a872-8dbeb845c967@nvidia.com>
In-Reply-To: <88932964-4148-4846-a872-8dbeb845c967@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jun 2026 20:11:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hRLnBBc-abqCCpcNAVyo1Nh=Yf3rdD7DkAP7ucDmr1Bg@mail.gmail.com>
X-Gm-Features: AVHnY4JVgpvvjCQW9LZsZhv2gOoFpzTMXJ0eNKJa1CmE6zGdkxXsH9dS_UmkaPY
Message-ID: <CAJZ5v0hRLnBBc-abqCCpcNAVyo1Nh=Yf3rdD7DkAP7ucDmr1Bg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] ACPI: CPPC: Add support for CPPC v4
To: Sumit Gupta <sumitg@nvidia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, pierre.gondois@arm.com, 
	zhenglifeng1@huawei.com, zhanjie9@hisilicon.com, mario.limonciello@amd.com, 
	saket.dumbre@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	acpica-devel@lists.linux.dev, treding@nvidia.com, jonathanh@nvidia.com, 
	vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com, 
	mochs@nvidia.com, bbasu@nvidia.com, Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 8:02=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com> wrot=
e:
>
> Hi Rafael,
>
>
> On 01/06/26 23:05, Rafael J. Wysocki wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Wed, May 27, 2026 at 9:47=E2=80=AFPM Sumit Gupta <sumitg@nvidia.com>=
 wrote:
> >> CPPC v4 (ACPI 6.6, Section 8.4.6) adds two optional entries to the
> >> _CPC package:
> >>
> >> 1. OSPM Nominal Performance (8.4.6.1.2.6): A write-only register that
> >>     lets OSPM inform the platform what it considers nominal performanc=
e.
> >>     The platform classifies performance above this level as boost and
> >>     below as throttle for its power/thermal decisions.
> >>
> >> 2. Resource Priority (8.4.6.1.2.7): A Package of Resource Priority
> >>     Register Descriptor sub-packages that allow OSPM to set relative
> >>     priority among processors for shared resources (boost, throttle,
> >>     L2/L3 cache, memory bandwidth). Parsing the full structure is not
> >>     yet supported; such entries are marked as unsupported.
> >>
> >> Add v4 _CPC table parsing (25 entries) and update REG_OPTIONAL to
> >> mark the two new registers as optional.
> >>
> >> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> >> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> >> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
> > This patch is good to go AFAICS, while there are still comments on the
> > second one in the series.
> >
> > Do you want me to apply this one separately?
>
> Yes please. Patch 1 is independent of patch 2.
> I will send patch 2 separately as a v5 after addressing the
> review comments.

Applied as 7.2 material, thanks!
