Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001203F3294
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567583; cv=none; b=tBzeEKtWm2CpcpIivpYn/f89Sq5jNeVmVImhanHYdU0bSwGkRkNy6d/YyXxgBEOdTlylGF3uHQhlL3Ois4vnTonvo0BkJ6UJWvla/14/r7AUQjnUaH/pYjplomYZ7TQSTLEBi6upqvZ20UrcWixN7fdUpvB4j9CrYD1V8gw7yu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567583; c=relaxed/simple;
	bh=weNxL9twIrm/RsFpoaE3cbLeAHaBLxjPZ57ywio1sKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNxlf4otjl6phaWdztjfzv+sGewJaDkG36otOwvzo33NNFLt3SnrcIp55IeAZmh3xTiAKJ/FtvTRsSxOYXVFhCGgoHYZOh9bR8EtMbue4OhhLATzosOS53pbueEYW3ecffc29EXi142mSSJYB/e3xU4+z3EZbWOCrWz5o5B8UJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1flZ+nI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1flZ+nI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABEE1F00A3E
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 10:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787567581;
	bh=weNxL9twIrm/RsFpoaE3cbLeAHaBLxjPZ57ywio1sKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=j1flZ+nIH3ncX+zJK8XmSQCCjt41icF2l+wPlBRmtO/lkvD7ad6q+ab+hPMompeLP
	 mCAzMncPCPOJtBLQAB0a8tgtCNx7YZv0rd1X1BZ2AiHT9MAqsxLSNizJUaW4/jcGPj
	 vcZ2d6Jnnr7gjacEJlzJi3mkJmzVDZ3vnOwZ/aYwjyG7fG52QiFOjsst2KuTnT4RJB
	 LnbR5FFSqkcXB+N0aY0AGtHQeXvBndq2Gp0v1QftMq3O13YVYyL+coBp4Z1z52R1wk
	 X1PuUxef7ordWFxK5jvROWB8lQWqtRVDnqNhS/RTMfAslMxr0rZhEYXPp2u7fowiBq
	 CAgT2asXYntiQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39fa5e3a428so22205661fa.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 03:33:01 -0700 (PDT)
X-Gm-Message-State: AFuF++k66PpXmWMMhzXzXdOQx5OB0ZgYYeMrvJjpd+ukcgXmNB2UQ4P6
	ITrHaoJb/u3BF/ysLSuQlKA/uPyLWTYBYpVr2/lwVmZdZV203kg7Q7cdMyJCfv0CWkcuqzanWBm
	7+eFF+rVws60tKfhecmlUFGxkQAlfiOw=
X-Received: by 2002:a05:651c:c91:b0:39f:6001:824a with SMTP id
 38308e7fff4ca-3a19697e16cmr74890591fa.6.1787567580109; Mon, 24 Aug 2026
 03:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822094657.12489-1-sumeet4linux@gmail.com> <bytk4rnkmttixn5y23fhgg64hvgtg3qkurk364h5swf4ufyul6@dd4k3suk67w7>
In-Reply-To: <bytk4rnkmttixn5y23fhgg64hvgtg3qkurk364h5swf4ufyul6@dd4k3suk67w7>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 24 Aug 2026 12:32:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hpaccbRZLJ+Y5Xo-3c9ynagPfwuJ2UvMcKARZv-AGYXA@mail.gmail.com>
X-Gm-Features: AcwNN1Wfe1e3VMVqn9-rrfuI9JLgeLAGcbLjJP4KJqZRr852yRyH-u5pRZBihSI
Message-ID: <CAJZ5v0hpaccbRZLJ+Y5Xo-3c9ynagPfwuJ2UvMcKARZv-AGYXA@mail.gmail.com>
Subject: Re: [PATCH RESEND] powercap: intel_rapl: Fix kernel panic during PMU unbind
To: Abel Vesa <abel.vesa@oss.qualcomm.com>, Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 9:35=E2=80=AFAM Abel Vesa <abel.vesa@oss.qualcomm.c=
om> wrote:
>
> On 26-08-22 15:16:57, Sumeet Pawnikar wrote:
> > From: Sumeet Pawnikar <sumeet4linux@gmail.com>
> >
> > rapl_package_add_pmu() fails internally at perf_pmu_register(),
> > and rapl_pmu_update() leaves the global rapl_pmu.pmu structure
> > zero-initialized via memset and returns an error. But any
> > previously probed packages retain has_pmu =3D true.
> >
> > When the driver is subsequently unbound or removed,
> > rapl_package_remove_pmu_locked() sees has_pmu =3D=3D true and
> > unconditionally calls perf_pmu_unregister(&rapl_pmu.pmu) on the
> > zeroed-out structure. This attempts a list_del_rcu() on a NULL
> > list head, immediately causing a kernel panic.
> >
> > Fix this by checking if the PMU is actually registered before
> > attempting to unregister it.
> >
> > Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
>
> Looks OK to me, so:
>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Applied as 7.3-rc material, thanks!
