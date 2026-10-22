Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696476;
	b=iJC+endBfeb/XrpMr9iRmKHXoiMQUCTm5vKNcmSPdJv3+o0ELKdg5n5OhbpVv60gz+pl
	 5ibAQ70hAH1P+5IBjfIBj8Sz/PFQSlYbR8tMQn4NVbv8QIiW+scW536gKZhdDNt7BiF99
	 KCrFBOslc5m8Kw79j83VllDp6kpiZ5w7BOn407rWNpXr9Y0j91f2ing5cIp00FpKcLDPH
	 KdDqJ8OpTO08efveZTwhNisdDuS9Se2fZ0Jd/pthQVdhn5JFGc4pA35dyMGBthxnpi2YC
	 QuqmoSRTmVWewTrroDd1suWJpTRtW/qz/uGDQE3ztM/iT1dKXivbbWLlO9kHFlHvVNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696476;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=T/yfsex+iXT2y+mnUpnV6G/RlAESLattCq2u7FMOcqo=;
	b=ACDzzclR5lB621Ts/290zPzKQzaxCK1cLe2tpZ++ikyjJIxQPb/1SCx4L+27n2P+BYob
	 +bQZmtJ7AYRVfdLJnzkh7SJ6mqqE0EC3yk7d/+0WGCKPyF+xbdS3XitlzXRJ0qBo6Lomy
	 4YOYykTY/nGbsI7TabqBD/v1vxatUU8ItHBVBOdfShn8/F8my+gbBINxcp+6/9OVQvCHG
	 rWRUHqNpdHBD0/l/ct3HI1EjsguBE0N5Okiu872HrnVpEMkuMZT/+XFVdd6j4YQOXJclt
	 IpByz1IBvJEo0O+5C7q8UF6lpWSdhOEJ7EWh1pc8wMquzSLCJfvZ6NwONSPdGlKx8Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbNcKzrs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E433A606A31A
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WbNcKzrs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87ECD1F01825
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 19:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792696475;
	bh=T/yfsex+iXT2y+mnUpnV6G/RlAESLattCq2u7FMOcqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WbNcKzrs4jlat3qo19SV3vGqrVC/sjs6k92qlo/tyDrRcRGtDqEOQGCL+//UiNdya
	 fU23l2YaBkwLby/GaQN8NAuFcyavTO6Mmnjq+nRuuyzcgzInnrzUNjhGusvuvcdgSC
	 bUKleioMEsiPqL35LVrsRomt4pzoKnST9J7S2LYLVDfAvTnhj1Dadb67ZH+W772GoQ
	 IVc6pu6+a+4eVj6DhdjQXrtgBqWkSClSAytPRIAaSXfTsEO/K7FhcOzo81+wNZTqVW
	 JbZju2RUTdQEPn3wnKLitSw4oWbY2wlFZf+BoGqn6VWu5PwTS22alZwI8iKtZsvJ88
	 QVeZSV53c6n6g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5bcb6faf862so31186e87.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 12:14:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwn8OJVzHxwnvwNBpyu+MBf4tyevKW8PVbkWqU2RhE8ObCEC3Jz70rQ9J04uIaVp+6n6+n4uB/msw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLgf4EoHi/1x2rU8vuIrtrUunh8gLzRWJirDI/ydbNEDrzEaW6M
	hRjIq0v77+FF8GoNRHKQoLVz1+yi0wrmOKePEHKKoM1s1AUURBRltlT8f9EF/kCmmq/k9hWD6ld
	bWXg7jTSSUTw7uuobbMXQj2/heCfb5tk=
X-Received: by 2002:a05:6512:1108:b0:5b6:95e:87ee with SMTP id
 2adb3069b0e04-5bfa1be5a8cmr2554398e87.13.1792696473945; Thu, 22 Oct 2026
 12:14:33 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260910205234.5392-1-kmehltretter@gmail.com> <117bc415-6bbb-4739-81b9-d2bf718056ba@arm.com>
In-Reply-To: <117bc415-6bbb-4739-81b9-d2bf718056ba@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 22 Oct 2026 21:12:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gg1uEy4pagxkPFMqvy__KWJU-_k3S6Ovx6BRzCnuD87A@mail.gmail.com>
X-Gm-Features: AclHuK8EhEVVmKJNgxR3ezPnbggzziCRHv9w2do46n90Ob62xaTp3ojSpOD12RE
Message-ID: <CAJZ5v0gg1uEy4pagxkPFMqvy__KWJU-_k3S6Ovx6BRzCnuD87A@mail.gmail.com>
Subject: Re: [PATCH] PM: EM: allocate the cpumask for every perf domain
To: Lukasz Luba <lukasz.luba@arm.com>, Karl Mehltretter <kmehltretter@gmail.com>
Cc: Changwoo Min <changwoo@igalia.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 9:57=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi Karl,
>
> On 9/10/26 21:52, Karl Mehltretter wrote:
> > em_create_pd() allocates space for the trailing cpus[] flexible array
> > only for CPU devices.  A performance domain registered for another
> > device therefore has no storage for its cpumask.
> >
> > All performance domains are added to em_pd_list.  The netlink interface
> > does not distinguish CPU and non-CPU domains when it calls
> > cpumask_weight() or iterates over pd->cpus.  A request for a non-CPU
> > domain reads cpumask_size() bytes beyond the allocation and can report
> > bits from the following memory as CPU attributes.
> >
> > KASAN reports slab-out-of-bounds reads for both dump and by-ID requests
> > against a synthetic non-CPU performance domain.
> >
> > GET_PERF_DOMAINS does not require GENL_ADMIN_PERM, so an unprivileged
> > request can reach this path when a GPU or another devfreq device has
> > registered an energy model.
> >
> > Allocate the cpumask for non-CPU domains too.  The zeroed mask remains
> > empty, as required for the documented unused field.
> >
> > Fixes: d8eef0453132 ("PM: EM: Implement em_nl_get_pds_doit()")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> > ---
> >   kernel/power/energy_model.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> > index e610cf8e9a06..fd07c564c201 100644
> > --- a/kernel/power/energy_model.c
> > +++ b/kernel/power/energy_model.c
> > @@ -439,7 +439,9 @@ static int em_create_pd(struct device *dev, int nr_=
states,
> >
> >               cpumask_copy(em_span_cpus(pd), cpus);
> >       } else {
> > -             pd =3D kzalloc_obj(*pd);
> > +             /* Readers expect pd->cpus to exist and remain empty. */
> > +             pd =3D kzalloc_flex(*pd, cpus,
> > +                               BITS_TO_LONGS(large_cpumask_bits));
> >               if (!pd)
> >                       return -ENOMEM;
> >       }
>
> my apologies for the delay.
> The patch looks good, thanks for catching this!
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied as 7.4-rc material, thanks!
