Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB846F4BF
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785935038; cv=none; b=QLBT2d/wos19uITNBs/wojf/P2/m0iO9XzDzYOWkFo81fMRF6DUYdjG7qeUYuubNDPtEvIXlltozvkauXAf7r2t1E4Rc9nEqchF8hT/laLvIMESfbzz54TPkHdDE3ICrYYH1feLGihR/WelmeWmaFeac/Zde1IpBjrX3GhU28wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785935038; c=relaxed/simple;
	bh=uvdv92A5fUACZ6C65B3w/DvWb3SrKb4c5Kf7q0wgzk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJ+o8MzQ7/KgaNnsIQhJcIR4OotY9dH6mW196D+GoS4cwuBVQkvHHlxIfkmmkBM1+fkVfZWPvvaYmwgfhNCPLJ7SoCadjRaegODmHWYt83+aHfjZdgEZwLk4GbSwwGhN7Ta8BNn3PbRRhM/CTlTDzkKL9/lCZAc36ZN2k4tpa2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieTa0E0L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieTa0E0L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0C01F00ACA
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 13:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785935029;
	bh=Wov0tjYd2izQVvZVikeFInnSXkoR0uH+MKvUZ+/n2RQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ieTa0E0LSyjl3UwJogg1BFi19Ppv6RevZhNGaOwh/xBMQ74Vzvvh/H+DXzWaVcdkz
	 t4y6/riW+7u3MuFJfXUtHQ4rN3H2FbDeza2LpLi08/0uEdysiPMqT/6R9fIWy0Wxkk
	 4MD+pk5oCPBr6cBlkhVOdyN+V3pvrcNbFw+3CMmWNTHmms9LMBc7JyDC0cXiL1ULKK
	 bX4h0qEzMnSgkt+4J7X8svPRnxKwPtM8U1vX6OhEs8qXmNHgA7AjzTCKs3ppbvAMkV
	 gCmYSNPoOOhMYe7k4FBKY0jVNDxZePkW0Z9u2l/gcR4RBvszMX201cVsaVuS/7ZiMp
	 Onz/PQ5ipRZxw==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39c908d6cb6so11579391fa.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 06:03:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp0+EYXhqiKDMxOPQ0RCTFlkHZCiEzV6/9crXhXXyjHrghpSnlOg0xwUrm923iirbj69fXL96dbjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHpdXpmtss1yeVl/Vi8upNNxF8ZH1gvlKlsG5VKbvh807zHy2c
	YrkUilrJdDdjlIU5ioGlJf3+DyYQoLxTSnMANhZvdxkbgemVPRLqkhfHjHdHnf1w+i/9PVajiMZ
	H2If3e73ZU5oRumAyzEDQ6wOdWPaNEWw=
X-Received: by 2002:a05:651c:150b:b0:39c:6d3a:2dd7 with SMTP id
 38308e7fff4ca-39fbb2562fbmr8187751fa.17.1785935027415; Wed, 05 Aug 2026
 06:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803203531.1268651-1-christian.loehle@arm.com>
In-Reply-To: <20260803203531.1268651-1-christian.loehle@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 5 Aug 2026 15:03:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iodtV+kMcck9Yq9beMt5DUOp=d2+Ooje97WbgCUtDZ2A@mail.gmail.com>
X-Gm-Features: AUfX_myKkOivimKKxxRM5y-JlEju1okWYjIUVXrlZgMICY5eBftXpH9S85Lx_Nk
Message-ID: <CAJZ5v0iodtV+kMcck9Yq9beMt5DUOp=d2+Ooje97WbgCUtDZ2A@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: CPPC: Avoid Desired Performance reads on _CPC 4+
To: Christian Loehle <christian.loehle@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	zhongqiu.han@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 10:35=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> ACPI 6.6 introduced _CPC revision 4 which changed the attribute of
> Desired Performance from Read/Write to Write.
>
> cppc-cpufreq reads Desired Performance when feedback counters cannot
> provide a usable sample because some older platforms repurpose the
> register to report actual delivered performance. Preserve that workaround
> on systems reporting an older _CPC revision, but do not attempt the read
> on _CPC revision 4 or later, where firmware no longer promises a readable
> value and cppc-cpufreq can fall back to its cached OSPM request instead.
>
> cppc_get_perf() also reads Desired Performance while populating the
> control values used during cppc-cpufreq initialization. Its only in-tree
> caller overwrites that value with highest_perf before the controls are
> first written, so the value is never consumed.
>
> Patches 1 and 2 provide minimal, backportable fixes for the two read
> paths. Patch 3 simplifies the mainline API by no longer reading
> Desired Performance through cppc_get_perf() on any ACPI revision.
>
> Changes since v3:
> Detect on _CPC revision not ACPI version (Rafael)
>
> Christian Loehle (3):
>   ACPI: CPPC: Reject desired_perf reads on _CPC revision 4+
>   ACPI: CPPC: Skip desired_perf read in cppc_get_perf()
>   ACPI: CPPC: Stop reading desired_perf in cppc_get_perf()
>
>  drivers/acpi/cppc_acpi.c       | 36 ++++++++++++++++++++++------------
>  drivers/cpufreq/cppc_cpufreq.c |  2 +-
>  2 files changed, 24 insertions(+), 14 deletions(-)
>
> --

All applied as 7.3 material, thanks!
