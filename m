Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793307158;
	b=J2CjCdV4W58ZAmfwa1+mmF0T4Xg+jNtLbmwLRglDUaRijoHMcUzaXLQoVrvTQYkiprD/
	 04JcZbpCKV8zsSHBSi4wOu8l9Ns5JRwAmh7MjJeGxErPjOBV2AnH/FFu4r6lrYzzNQBKu
	 4hllGLeUsBCktJ+WOVIdrftfjMqXLcgqNHnKgki8IW62nCIwSJB/NNHf/nfzNhGfqFEOh
	 5fz/l/teVg0UxtdTW5HwE0lS7Ni/PIIgsW895rIZG2UBslkX45Ps23UDLD9Ss6xpj5ruE
	 pterlBhg8t5ZK1w2emG+JBJFdhWHUOIGD9DB5TBck7usFmtSbtRjWDhvPl17vzFLZ9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307158;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=g0oiqv1BCNymG/AnH2ybaPqlkDtRSeW/PCn0KPdcdu0=;
	b=QEU8bA7kxtEgcTgNeooL1WA6YDSVhwn6/3Kmxj9PkqQeupiTEO0l9L+OQN6CiftrEazV
	 4T/FyL/tlhsyF/WkpOtXdlPo96WCXmgfaGFoF4Qgw3Lv7DnKgy15P4ww7kPLHUmOwPlJ2
	 FDBJ3CJBdLNrL9D72EkSkhLgxFZpf3Qvwn8G4z0qCEbbh6wuvw89649ONWoNxJb/BO1mz
	 ijqzNb8iSyeMxyzVjkcqGVCQlwH879qc+CUbPxLWfZiE3HD/KMd7UP32KH+BnlBzEw4Uz
	 LexsuSSMISoSysy8LffazfDy93oUhCigBPTJp/0uQl4AbWqIsCYDIPSnqLpn3LE81ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEhtR2kg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6474F606A322
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEhtR2kg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DE31F01828
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 20:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307157;
	bh=g0oiqv1BCNymG/AnH2ybaPqlkDtRSeW/PCn0KPdcdu0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nEhtR2kgt1sgTImuHeJZ9gHY2k8evDf8pFZ+dw4gU7Ay50EWHg1eHowt5+Zcibl2z
	 DtFD8F7FreSCWtw5a9NnEOMstzD6zt8y3EN3RkrEfdBMYqVTHR7A9vcKi0p5IKQPaa
	 QbfpRodtcO3aEMBpg17YKE0G/An2fEkOQ378UOOysIzGOpf+R/QfDoj43/S6Njrnma
	 5Noq4rYzPr+Y9rTPTlizpLtukARP5l11JIw916Yqjoqgz4MuTs0Z2o2pbO+99K1SJJ
	 VYekTJCp5Sw7mYutyGbIpJaifVhjrOAjxYGnYQKNaaiEPohEdKvE7b2xcU98hYcTSS
	 qX/vUeTq2dFpg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bcb4f23ddeso85480e87.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 13:52:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBziMb/zte/T1ZItyiW8N0tc+zwomKenSknpGc+/Y8KoWs0ckn92KSYqlpUIoUMPsaZVS+z0lgjTUA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIDCupiW2s/QntMiQYfdFC592affPcbDVkfo+qGIkffLH0Q/TaA
	GS1mzYPBo3f6S/7OybdHFd69lCFPJHViKa2xS6Xemf8sYuCiqmXB/Dm+CDMhOgZmFuMXPMqfupk
	LSW5tLYT1pOPobXWR/x2tiZVPf6DulkQ=
X-Received: by 2002:a05:6512:3c8e:b0:5bf:9fc1:393f with SMTP id
 2adb3069b0e04-5bfd957cee8mr30155e87.52.1793307155366; Thu, 29 Oct 2026
 13:52:35 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027143725.3763827-1-zakbrightonknight@gmail.com>
 <001101dd6631$6167dbd0$24379370$@telus.net> <CAJZ5v0gVkYuZAh7H8KFakN+vHkJTjzvmZsLrUVP0MXkaKLVoCA@mail.gmail.com>
 <004401dd665c$97eda060$c7c8e120$@telus.net> <CAJZ5v0gvruWF7VhVuLrn4AgV9_n6Ayektrh+jB=eLY79ufw4UA@mail.gmail.com>
 <006601dd672b$a7d67f90$f7837eb0$@telus.net>
In-Reply-To: <006601dd672b$a7d67f90$f7837eb0$@telus.net>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 29 Oct 2026 21:52:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jAG7wxxsuynPL3fyo8Kr3sLCC75fpm91JADuDpm10QZA@mail.gmail.com>
X-Gm-Features: AclHuK-i6rAgr4hWoQWOq8Is9fFHqRRfrwy6lPQ_Ehh6dGw3c5bzTzaaaQyOVTw
Message-ID: <CAJZ5v0jAG7wxxsuynPL3fyo8Kr3sLCC75fpm91JADuDpm10QZA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Restore P-state request on resume
 without HWP
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Zak <zakbrightonknight@gmail.com>, 
	linux-pm@vger.kernel.org, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 11:28=E2=80=AFPM Doug Smythies <dsmythies@telus.net=
> wrote:
>
> On 2026.10.28 08:54 Rafael wrote:
> > On Tue, Oct 27, 2026 at 10:46=E2=80=AFPM Doug Smythies <dsmythies@telus=
.net> wrote:
> >> On 2026.10.27 Rafael wrote:
> >>> On Tue, Oct 27, 2026 at 5:36=E2=80=AFPM Doug Smythies <dsmythies@telu=
s.net> wrote:>
> >>>> On 2026.10.27 07:37 Zak Brighton Knight wrote:
> >>
> >> ...
> >>
> >>>> I confirm your findings and tested your proposed patch. It all worke=
d fine.
> >>>> I had not seen Rafaels's reply about a possible race condition until=
 now.
> >>>>
> >>>> Test computer: i5-10600K, 6 cores, 12 CPUs, HWP disabled.
> >>>
> >>> Passive or active mode?
> >>
> >> Apologies for the incomplete report.
> >
> > No worries.
> >
> >> Passive mode has the issue. Active mode was fine without the need for =
the patch.
> >
> > Thanks for the update.
> >
> > Please check the patch I've just posted if poss.
>
> Because I had already done so before this email, I tested Zak's V2 patch,=
 and it worked fine.
>
> I tested your (Rafael's) patch and it worked fine.
>
> Tested-by: Doug Smythies <dsmythies@telus.net>

Thanks!

> I have not reviewed the code and will not have time to for a few days.

That patch had problems found by AI and it cannot be done exactly the
way I wanted to do it because at least the userspace governor depends
on preserving policy->cur across suspend-resume.  However, there is a
way to force driver callback invocation in __cpufreq_driver_targer()
even if policy->cur is equal to the new target frequency which can be
done during resume.

I'll split the patch and submit a proper series when the AI is happy with i=
t.
