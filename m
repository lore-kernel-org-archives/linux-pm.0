Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FCE28C2DD
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769199170; cv=none; b=eMob9HOTvi9RskGhAVuPcqpJU7rkA5tVF5vc9TqzMS4/QammabyOh3w46Q8I4GvciMy9E0vtlxCfFe4Tu2F5NenyG+tmKL7cWDNJ1Q89XoRU2QMYvcygDht+ugkZRwiuwlKNDvfTz8DYoHjJZlN8fz2aFuqFh+fgrRdkNQjKKnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769199170; c=relaxed/simple;
	bh=AjjjPu8CmS0oDDrwloS6qEMnH7cwPTd4sU1u4Kp13A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nChQYulDRfo+VQTzq48N/ufB2D5vULoQ2B5A8DBKAyFeRA/1oM7JyHvgonV026WpiMDIEt2BuaSsWb20e1CLLcAYPqXsWF/Y17HbRUHUir8oo8Fk/Rgk7f9eMHI18PI/yusRlCqtjQcqkPrNUH2RuR2uc/QK3XGwBpGZeu7ip5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEYmwPPV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEYmwPPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0F8C2BC9E
	for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 20:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769199169;
	bh=AjjjPu8CmS0oDDrwloS6qEMnH7cwPTd4sU1u4Kp13A0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TEYmwPPV/efIgwe6kQwi0Q/TbPsRT1SUxE4ofSFz4zfEkPRRvKihXivlKSmvleRZJ
	 mw5pCS28p2gMXCsuePLL8B9vu6tQk5dKj4CXQqMPEpffxwgGgz6S2tXMt5bhCcVtkQ
	 JY3VxDtnQ6qLBOUrjaKmy2xtmaTExvZiPct9DnGr81oPiNSquqHRdBDM3snUZt37I3
	 zKbdP7RPRyY51G+yQzEhFPvBRbIYQLwFLdXq53dY5Un1EQFaUw19WgISUqOomhewNQ
	 K7s8ANdrZv/fJ2GL1LY/gUl0CN0GILCrGh9jtt1DBxwfH2ioMLH5JUwR01oI33Z0hR
	 xg7Ouf+J08zMA==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45c8e85deffso827894b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Jan 2026 12:12:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZJOeHM0cBY1SQgkw9hsdEgJ9pzSTlcmuUdx/i+0epAMnBuC1bzbxtNjuvgVTmxCbXVu1Ni4Unkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxechLQRvDDAJ9uOuKnbZ9ljVJVxMzUPDZ0cLKHR1n7sPkV3Go
	eSAabSW8Is529klWT376kqBSUuGaTGNa0UjKHY3gCE3UmrV9/N6eGYlqyuSBm0/0ktB8bXpu4cW
	bix0CjB3F+yXwuwZJ3ewlUpk8qLhWg/I=
X-Received: by 2002:a05:6820:4c03:b0:65f:5b63:2bd with SMTP id
 006d021491bc7-662caadebf1mr1658764eaf.16.1769199168968; Fri, 23 Jan 2026
 12:12:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119074118.835922-1-tianyaxiong@kylinos.cn>
 <20260122155549.GA18021@ranerica-svr.sc.intel.com> <7cc76b59-964d-4ce2-b3c4-e1337dbe0c67@kylinos.cn>
In-Reply-To: <7cc76b59-964d-4ce2-b3c4-e1337dbe0c67@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 Jan 2026 21:12:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ipPwmBe0bxKBJc203ug6ENzT6OEaOruyL=vUw6NWMZfQ@mail.gmail.com>
X-Gm-Features: AZwV_QiCRXMpcVxWoJpA1_oclpBw40Ions-cjYk7n8FzgU7mL76_S_5FDdv_ccY
Message-ID: <CAJZ5v0ipPwmBe0bxKBJc203ug6ENzT6OEaOruyL=vUw6NWMZfQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Disable SMT when hybrid systems
 are enabled
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 2:20=E2=80=AFAM Yaxiong Tian <tianyaxiong@kylinos.c=
n> wrote:
>
>
> =E5=9C=A8 2026/1/22 23:55, Ricardo Neri =E5=86=99=E9=81=93:
> > On Mon, Jan 19, 2026 at 03:41:18PM +0800, Yaxiong Tian wrote:
> >> When hwp_is_hybrid && !sched_smt_active(), the driver enables
> >> hybrid_capacity_scale and disables ITMT. According to the original cod=
e
> >> logic, these related actions are one-time operations; therefore, I
> >> believe the original design intent did not support dynamic runtime
> >> switching.
> >>
> >> However, SMT can be toggled via related interfaces in /sys. When SMT i=
s
> >> enabled, the system is no longer hybrid, and the original settings bec=
ome
> >> incorrect.
> > Indeed I was able to enable SMT siblings:
> >
> >       $ echo on > /sys/devices/system/cpu/smt
> >       $ echo 1 > /sys/devices/system/cpu/cpu1/online
> >
> >> To resolve this confusion, permanently disable SMT by calling
> >> cpuhp_smt_disable().
> > IMHO, the user should be able to enable SMT back if she or he chooses t=
o. Instead,
> > the sched domains should be rebuilt with asym packing and without asymm=
etric
> > capacity.
> Yes, I also agree with this viewpoint.

I don't agree though.

> I think a better solution is to
> place it within cpufreq online for heterogeneous judgment and to clearly
> address sched domain rebuilt and asymmetry issues.

Maybe in theory, but in practice the EAS-related code in intel_pstate
really only targets systems with no SMT.

While it is possible to use it on SMT systems with SMT disabled, I
really wouldn't recommend doing that beyond debug/diagnostics and no,
it is not sufficient to disable stuff when SMT is re-enabled, you'd
basically need to unregister the driver and register it from scratch
in that case.

> I ran some tests the
> day before yesterday and encountered a few locking problems. I will
> publish the patch a bit later.

Given the complexity involved, I don't think it is worth the effort.

I can apply this patch though.
