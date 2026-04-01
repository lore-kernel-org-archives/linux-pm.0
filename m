Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939D543C055
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051982; cv=none; b=WMLRR8PTka/ob0I+LPnbR2EgsTp2xfEmimjCYFowcZ27CE52S++mFSxu+TpIsGsnTauMBZoqSvMPNO0h/adRVNh0tBDG7gQCr887/BSQBgclOmpCzaDUfw4uinZLpfIb2hlzmmzIIOCA6xMCsDSZK4wqAKHdsiNDJSvOejG2kD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051982; c=relaxed/simple;
	bh=Yi6dLH2rXlULaJDrQtJkxdN+BWAKEuvMgPWbLPk3Koc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NaiOid3P4gTxV7xaGTz0W0urGj1SLoMIgsw9SbbrV8ZAeHLyDBIP324XCkJP5vLsK6K8gkKACCl/+DQEoIpxJckIuaUI064oA/4d6fatC7kRgPeHFb0b6al5JwfBgaRPSUwtdeC4OATqjjV58/laSlhmNyUwnlKWTFpcDloX9TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+x/HIPS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+x/HIPS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42474C19421
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 13:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775051982;
	bh=Yi6dLH2rXlULaJDrQtJkxdN+BWAKEuvMgPWbLPk3Koc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n+x/HIPSAdZkhANIEqfLswOjUH92ishaVoH8GmoiL+DhtRozgKes0sEie59TFsH6A
	 pGED8pRSgAY4/q2rpQW7DLumeoC9etzFwJ8zNBB+JKQatU0/8+gWcGEroZgP4AdZjq
	 bcyFKa7gKBwIImFbQqrg/f9OEsAuYD21uI+n59un6JsEmmHFkaqZXnUi1G2oPjaph2
	 wmVtQN5pVj7P6H4PjFNkak8Jpo/Hua3aQl+sPdifUdSzkeAdBX3vBO+vzwiQAXiSGu
	 xoepSIDzXrJHh5twD5J/oUnsE1Kvce/Ld45EVr61pfvsjeLG27WG63HwLdXVd1H9D9
	 r5fWaaxC6/oYQ==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d743cd9e5bso4562440a34.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 06:59:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YxIywgvLOODmmlg2ogijT4rlRiUxmoRCxDjBK1gMLWC2a74oamb
	uinivi3LQc4Vox3kBV+AXHIXgaFowo6gAmPCQrUcG/i7u3WKhi21WpFJ+tVRs9idk3cPKsobIS3
	qpnw6MzNMdgPPXe5Xsrc0ZLQyH7gKScM=
X-Received: by 2002:a05:6870:638d:b0:409:6ce6:a371 with SMTP id
 586e51a60fabf-422cfc51358mr2078916fac.14.1775051981393; Wed, 01 Apr 2026
 06:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331074242.39986-1-julianbraha@gmail.com> <4qxfqgj7jbjywmkzblf762oamxvb2s6m5b2w3ftq2i72abhmcl@cgtgslih7ric>
In-Reply-To: <4qxfqgj7jbjywmkzblf762oamxvb2s6m5b2w3ftq2i72abhmcl@cgtgslih7ric>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 1 Apr 2026 15:59:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g28-xizOm=qY6Y=16uKYWw6MB_Pux0U6ypo=q1y=KhqQ@mail.gmail.com>
X-Gm-Features: AQROBzANhr3bDdTYcg1n-BH2dMxE3T9nQjD8o4-hnhw59879Ho4h-isjWLmrCvU
Message-ID: <CAJZ5v0g28-xizOm=qY6Y=16uKYWw6MB_Pux0U6ypo=q1y=KhqQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: cleanup dead code in Kconfig
To: Viresh Kumar <viresh.kumar@linaro.org>, Julian Braha <julianbraha@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 9:55=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 31-03-26, 08:42, Julian Braha wrote:
> > There is already an 'if CPU_FREQ' condition wrapping these config
> > options, making the 'depends on' statement for each a duplicate
> > dependency (dead code).
> >
> > I propose leaving the outer 'if CPU_FREQ...endif' and
> > removing the individual 'depends on' statement from each option.
> >
> > This dead code was found by kconfirm, a static analysis tool for Kconfi=
g.
> >
> > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> > ---
> >  drivers/cpufreq/Kconfig | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index 78702a08364f..db83f3365698 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -163,7 +163,6 @@ config CPU_FREQ_GOV_ONDEMAND
> >
> >  config CPU_FREQ_GOV_CONSERVATIVE
> >       tristate "'conservative' cpufreq governor"
> > -     depends on CPU_FREQ
> >       select CPU_FREQ_GOV_COMMON
> >       help
> >         'conservative' - this driver is rather similar to the 'ondemand=
'
> > @@ -188,7 +187,7 @@ config CPU_FREQ_GOV_CONSERVATIVE
> >
> >  config CPU_FREQ_GOV_SCHEDUTIL
> >       bool "'schedutil' cpufreq policy governor"
> > -     depends on CPU_FREQ && SMP
> > +     depends on SMP
> >       select CPU_FREQ_GOV_ATTR_SET
> >       select IRQ_WORK
> >       help
> > @@ -365,6 +364,6 @@ config ACPI_CPPC_CPUFREQ_FIE
> >
> >         If in doubt, say N.
> >
> > -endif
> > +endif # CPU_FREQ
> >
> >  endmenu
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 7.1 material, thanks!
