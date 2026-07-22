Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C923E559C
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750312; cv=none; b=h0HrzAvhseQDfnRHiyOf6mxtffqTmXifY2sH79QCuBP677PGqInDaYGj53imb1Xv6XEqe20n9iMTsvcxgvtdi+oFIEa7lbZ5bp9xUeq3FbecD6w5xjxsL3BiR1JWaHYMcxar20F0yeSeSsfuZ/xIJc/RlXJMpj+BZ0ZK+l9OzPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750312; c=relaxed/simple;
	bh=A7AitE/XDd3LqWQmorPTs2ptcRNDrTYGhZT8AjRw8EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUXAn+8oBlXG/EvHSyE74CNLYOOexgjEGXy/54DVabxUjeWklwLgON6QhqmFyoS2rATbngIvOL1I2jgSeZ4Fs/OEKZ5Fr/rLxOrFMhBHF7EBytkvO5/Z/tFiujO3O08PeiLQkHy6cL4CPgajqAcGJjTCM2uaP8RCqp8uqIuV0oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebyQcg/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebyQcg/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4561F00A3E
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 19:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784750310;
	bh=nR4O5DANIva3goaebxkg4Sh/ghkWjyLukyGQAqgAAvs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ebyQcg/T7sRabO/k8ourFCDiSdv5/HNN9pAaufxQej+k8+avaxcJCChUrElEVEvLg
	 USobHRHReRO8Cy3qYgYaw4MtHK8m1viaLunmOuMbfcQknx8tTCvtIs6eAY4ODzCzVd
	 J18lP1c0BuX/EyAL6ZCwsKbi756l+emh4m2APL/FRHwxpX3mU0/Whz0AEKvC91Nqk/
	 bspvL765PfG/srxKHaBxP+uzpNUqREX08IEwe1dQrVXV0n/CfyvypMT4pKEtqF8n9T
	 FnWprs3L5mAX15mdfDrmTr3sgA1lOlulunn7ypjtqkJF6sB4x/qtsPVDSg1n5aC1w9
	 dp9Zp9VfDjF0w==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b01cb18515so12382080e87.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 12:58:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpjtLu6whQ7xeCfn9ZWDx7ITXxwHrAKOwQNeuL0gyfZTz9QBa0N19aPw0QUBSPsBQhHi+ZVMbDirA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUK3oiAA646n+xdPRhy6ZxcspR/qXYFbKaFTJtzm4/dJOWRR27
	KwbdGSIang+m12VJF+eMrn7VJoqrzEcPiWGYXtT0S8oIdrMHZFgk83r5XjblutMY1oJ4CAQqf9A
	l9oBqQMORPm2wf176YXNEm3lpLdkvgXE=
X-Received: by 2002:a05:6512:2388:b0:5b2:95b3:b90d with SMTP id
 2adb3069b0e04-5b295b3ba31mr4050255e87.43.1784750308651; Wed, 22 Jul 2026
 12:58:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707163647.6646-1-s921975628@gmail.com> <wh5m5ymcadonlywszmepriuxagc3jf4mictlvf3id6hezdpj7l@y25j7iqdg6qd>
In-Reply-To: <wh5m5ymcadonlywszmepriuxagc3jf4mictlvf3id6hezdpj7l@y25j7iqdg6qd>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 21:58:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0haO-CwdtSCX15NSiUwRWzpgWtgN3APHhJbJB7gB7LL2A@mail.gmail.com>
X-Gm-Features: AUfX_mzVjbo9JANfzPLm2bqDe7CTq6XvSe0qSAr1Gyyq5OqdzjpBLf9s6TzwpKE
Message-ID: <CAJZ5v0haO-CwdtSCX15NSiUwRWzpgWtgN3APHhJbJB7gB7LL2A@mail.gmail.com>
Subject: Re: [PATCH v2] kselftest: cpufreq: Backup and restore governor for sptests
To: Viresh Kumar <viresh.kumar@linaro.org>, Yiwei Lin <s921975628@gmail.com>
Cc: shuah@kernel.org, linux-pm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 5:44=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 08-07-26, 00:36, Yiwei Lin wrote:
> > After executing cpufreq sptest, the system governor
> > will be overwritten with the governor switched
> > during the test. Restore this setting to maintain
> > consistency before and after the test.
> >
> > Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> >
> > ---
> > Change-Logs in V2:
> > - Wait for all background processes to finish before restoring governor=
s
> >   in sptest4
> >
> > ---
> >  tools/testing/selftests/cpufreq/governor.sh   | 21 +++++++++++++++++++
> >  .../selftests/cpufreq/special-tests.sh        | 14 +++++++++++++
> >  2 files changed, 35 insertions(+)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 7.3 material, thanks!
