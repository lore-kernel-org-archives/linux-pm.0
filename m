Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE7A54652
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779396051; cv=none; b=pIk5BmeCYh6GZAu9JQJB9KUa/2fVRBb2NRD3CXXua+/zK94TixBTw0soQBqBOOr4Grx6CH5PAMoiZb9FdTW6+NQ4AVda/jCTl8iRZ++7HvP3LqH5GY6oiPQLhMKbtWdiG61Vkbb7oukuPaQEsZNYJA9J4i8KsdiwYxMKOJ21zX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779396051; c=relaxed/simple;
	bh=N27coMYwEp2DGiyL4nrNVp/z1fPJIQn6P59rUqU2+7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b14nV5BnOht2PRDxJg778tRoQF5fyPz+x7qh5cpmx3OVwlKRd5LRHnw5bTO6lYoDKpcVmXfXYvPZKkkREPItFIBsfmB1DTKKF2QECb7V9hbW00W+E4VtlcsLsAByjBT5dhlZKp5i5LGxVIkWa48iSCOoHJPH6Qbfo47jmyalmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mfb6G+lN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mfb6G+lN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE771F00A3C
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 20:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779396050;
	bh=ZXzST3Bh75Y7QSlnRUQcKaXhhYpqam08EzqdmLwma0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Mfb6G+lN3KXu40twFKEARLPCGCOSvoLMvoJd4EwHh9pkxhnGJdrw7QRqS6cXLlXod
	 fH5qCbt/I6ylmvzFjowEpJSHqD2tXY/SiTzM1O4W5+rmDPv6DjidWYf6+AzkQuD8Gl
	 2tyDi9c6X4o9CLbBPNbqSefzAcDKI88b86myV7Lyn7GGjwMmHuqq9GNHwj1VZKWMmi
	 1SAptJO9QXKY2i182VSadZHAASZTURVU5SlfJ9O6W6JEVSUWhYHqMgtFLWlz/xgwC0
	 WR7SdlohnM+VPDnIrvYfXzKY/lZe1PBaQreM56dKH2fuNUMyqLfGzmnqqLqSO87IGr
	 yj1nP7UcmNT0w==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a88db610ccso7025391e87.2
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 13:40:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8E0BLKTXGbkeODOJ9F3eEJnTw7BHdhsBF4ZKMR3QmMhlGCd2amr1mT/ItqXeA3bD8SikfhKto3hA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6AZDpi8JXwnclk+7jLnz+h3KkBjbNniJJl+mCEZ94FGDGOeXx
	dK9bXXvpOk0Y6YVdeKrydiAehabLXvnl+Sqmxy9jSl7oZUtDeahtuVPJ5Jb5qYkC4M1K6OfcGiF
	puv3SLeXrS8y77mFJaE9z/7HyoAGveHM=
X-Received: by 2002:a05:6512:378b:20b0:5a8:6391:4fe5 with SMTP id
 2adb3069b0e04-5aa323a9bd1mr71115e87.26.1779396048430; Thu, 21 May 2026
 13:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6fef156008fc6b70069f3cfedb7de02fe54f2696.1779360823.git.viresh.kumar@linaro.org>
 <4c0a951bc57b7fd5cacb6211a96770e5791b1fbc.1779360823.git.viresh.kumar@linaro.org>
 <0078ab64-05a9-428c-a8ea-ae5a2df4c1e1@oss.qualcomm.com> <2l2wp32sms7vkr6brhdpi2jlcschagdrhrb5n7dimnqz4czpwo@3agems2d7qkc>
In-Reply-To: <2l2wp32sms7vkr6brhdpi2jlcschagdrhrb5n7dimnqz4czpwo@3agems2d7qkc>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 May 2026 22:40:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hfj4a3PGj6W0_CMS-HF6hsrstBQP=O6E0rzhqyzFzsdQ@mail.gmail.com>
X-Gm-Features: AVHnY4Jkb221ZS3XuigO4rP2GehBmvxPza85DcTHbf-0u5BWAg8aCA37tzd8nlE
Message-ID: <CAJZ5v0hfj4a3PGj6W0_CMS-HF6hsrstBQP=O6E0rzhqyzFzsdQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] cpufreq: Avoid redundant target() calls for unchanged limits
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 4:33=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 21-05-26, 21:58, Zhongqiu Han wrote:
> > > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_p=
state.c
> > > index 1292da53e5fc..7f19ec6b70ba 100644
> > > --- a/drivers/cpufreq/intel_pstate.c
> > > +++ b/drivers/cpufreq/intel_pstate.c
> > > @@ -2942,6 +2942,7 @@ static void intel_pstate_adjust_policy_max(stru=
ct cpudata *cpu,
> > >         policy->max > cpu->pstate.max_freq) {
> > >             pr_debug("policy->max > max non turbo frequency\n");
> > >             policy->max =3D policy->cpuinfo.max_freq;
> > > +           policy->update_limits =3D true;
> >
> >
> > Could this be redundant?
>
> Yeah, this won't even compile I think. In my first attempt I tried to
> make the update_limits change from within verify in cpufreq.h and that
> caused a build failure and then I moved to cpufreq_set_policy() and
> forgot to fix this one. And my arm64 build didn't cover this file.
> Sorry about that.
>
> > It seems that intel_pstate_adjust_policy_max() is only triggered when
> > !hwp_active, whereas CPUFREQ_NEED_UPDATE_LIMITS is set when
> > hwp_active is enabled. If so, the update_limits flag set here may not
> > actually be consumed, as __cpufreq_driver_target() would skip the
> > update_limits check for drivers without CPUFREQ_NEED_UPDATE_LIMITS.
>
> Good catch.
>
> Rafael, is the understanding correct ? I can drop the intel_pstate
> change in that case.

Yes, it is.  intel_pstate only sets CPUFREQ_NEED_UPDATE_LIMITS when
hwp_active is set, in which case intel_pstate_adjust_policy_max() is a
NOP.
