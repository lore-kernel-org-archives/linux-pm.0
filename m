Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340575;
	b=izbsXJZzy6vK3wmOrwCTAP7Rv5U4Q0u1ZIo6XBpX1ZTqEtEeU8TlJPbCnXFUTORsRoJT
	 JxYicWUapHbd8YJphHHFrVkyhdu8lyLmSvE//LJKZwBvMB8WXA2cyJA7Y/IyyzR4BAA/H
	 TthZ5gxnFU0EAGkLpxVVQAl7Xe43m/VMrExpvJiWQVYAUwPnVMBqGI9nTtn39umayIgVx
	 lAMKPtFsYQtDdYljyQGUoFA4Jxs4WAmiMDyHo5qgUlfwti/ZSWpvta78tQjhroT9QvUNe
	 Hioiewu9Vqr3xpPd/rjoJwV8tBZXaTcAfO31rF71wjLSL9+wTIig9W3dPDbbSkslg4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340575;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4e9zTEEepAH07YcZ7jQL8z3Ph2Jplxj/qCJ27ebIFzk=;
	b=sTjdohPemk4jzh+/XOEOUN8pfjWKUyBi6UmN+0hldSXJRgC9h6Hy4eFoITuOCOzrWItx
	 sZHYR7UsfSVQnypMI7fS9Mao70+DgBJ9jfJ7W00pw059PsWjMTlUKz7AvjFXOH1duuUH2
	 xz4VU7qePxS1pSklhzhmSFCJfArC3LNt28PgbOag1vO1iMDOL59w8QhzA2cvT85nHuvcT
	 DlABkmZL+DjRgyv7zA+HqxcQgTfIhRYygBdMrrXbjlupRY+yW2cdtEcgVkWHQfbQDM7Pl
	 JHJpRJ0Mbe/Ifa2J7q0XGL4kQZrEnXuppDUfvlZ6XYveX8kJnpf/42NQcfgsjalUXxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cg5Faxr9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9787A60A2609
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cg5Faxr9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AE91F008A4
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 19:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794340574;
	bh=4e9zTEEepAH07YcZ7jQL8z3Ph2Jplxj/qCJ27ebIFzk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Cg5Faxr9v+zaSU1I7eWru+ybfPtVRmrNfap/AxS1DesuT1U3ymnw3FbJBp0/Y4PF0
	 Vpwaabish9VkJVp4qp9kqbJTNM48JC7Lob+NV73I3VmpFr0lVS4U51WePY8svJ/q/0
	 BnF6AfVCJB/c5LGl+rgFGGH7apLWY56LmjtWyk0uxIJ1/Q+PyQEADiiYqdcEKpidPv
	 H1DkVOT2g6swHoq5YJ3ec5OCJfmabgQnp0uTi1836mRBKR+371sq89cHtJVddn+giK
	 lHnzlRFL2PCbRHVXngUtsgvDKBv2oMK9ALhH39kIHL4v6SP1cwq+Vdf0aGe+SI0FDs
	 MSO7iY7LZBepg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be4a2d94adso2215502e87.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 11:56:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEdaAUD47Fk/F1DTdBcSu6B9nZgoQK6PFMX6+QGuwZPkIcFcJFwaKCJXhNhImNR42f0jlZjTEIUow==@vger.kernel.org
X-Gm-Message-State: APuU4Z/FMATGl3vH+a4rtXHfgN40mNNOJXerevSW9T1mwNdJ/6ODs46K
	m+stw9aOGYByd3XBRyvtrBm3QmwSnaNLVoH1CExxftHi51tRXFsjTd82K5JfwqwYXwYiZh5DazA
	Ji8/tuXMVNKisrVgDWFwSAsCD9xKUpW8=
X-Received: by 2002:a05:6512:4023:b0:5c0:46a:af07 with SMTP id
 2adb3069b0e04-5c15d633aa6mr41569e87.24.1794340572514; Tue, 10 Nov 2026
 11:56:12 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106151947.3991524-1-vincent.guittot@linaro.org> <20261106151947.3991524-17-vincent.guittot@linaro.org>
In-Reply-To: <20261106151947.3991524-17-vincent.guittot@linaro.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 20:55:56 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j9MvRWz276XfR+FK+jZTyj88CEpV9i-Vtb-crhXLswvg@mail.gmail.com>
X-Gm-Features: AclHuK_hRY2h3ib4gYJGswYHP1kc8kMT9CG7yVECgP2MQJGZ6hr3Nt_oO0vb9a4
Message-ID: <CAJZ5v0j9MvRWz276XfR+FK+jZTyj88CEpV9i-Vtb-crhXLswvg@mail.gmail.com>
Subject: Re: [PATCH 16/20 v3] energy model: Add a get previous state function
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, kayracizmeci@gmail.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 4:21=E2=80=AFPM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Instead of parsing the entire EM table everytime, add a function to get t=
he
> previous state.
>
> Will be used in the scheduler feec() function.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

No objections from me.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  include/linux/energy_model.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index c909a8ba22e8..89cf109cbca6 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -224,6 +224,26 @@ em_pd_get_efficient_state(struct em_perf_state *tabl=
e,
>         return max_ps;
>  }
>
> +static inline int
> +em_pd_get_previous_state(struct em_perf_state *table,
> +                        struct em_perf_domain *pd, int idx)
> +{
> +       unsigned long pd_flags =3D pd->flags;
> +       int min_ps =3D pd->min_perf_state;
> +       struct em_perf_state *ps;
> +       int i;
> +
> +       for (i =3D idx - 1; i >=3D min_ps; i--) {
> +               ps =3D &table[i];
> +               if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
> +                   ps->flags & EM_PERF_STATE_INEFFICIENT)
> +                       continue;
> +               return i;
> +       }
> +
> +       return -1;
> +}
> +
>  /**
>   * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
>   *             performance domain
> @@ -375,6 +395,18 @@ static inline struct em_perf_domain *em_pd_get(struc=
t device *dev)
>  {
>         return NULL;
>  }
> +static inline int
> +em_pd_get_efficient_state(struct em_perf_state *table,
> +                         struct em_perf_domain *pd, unsigned long max_ut=
il)
> +{
> +       return 0;
> +}
> +static inline int
> +em_pd_get_previous_state(struct em_perf_state *table,
> +                        struct em_perf_domain *pd, int idx)
> +{
> +       return -1;
> +}
>  static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
>                         unsigned long max_util, unsigned long sum_util,
>                         unsigned long allowed_cpu_cap)
> --
> 2.53.0
>
>
