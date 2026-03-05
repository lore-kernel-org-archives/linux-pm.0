Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681C3ACA45
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722032; cv=none; b=sQNGboG+aArn0JWy2IV7ilISFU+2ViFcwgJZ8HZttqrw6ne9tvelEaIZTfY4KHeX+JggxPrcHMLPlBRZiSXTQDjSg5Jk8HBg+yvi8e30UFAZbF7eG2BExUVtVoe7g1/rbeO1/kFbuL6PmEBsU1+YuEb31QGwPQR3+ypCutg7Z3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722032; c=relaxed/simple;
	bh=haCCzeM16uqa0idk+B4jKGHTSfi3L+3y6kmR8mUCc9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIi2PLKKZHFhubjz2QUj0GV7XzhONRXMlQBplRfs1lGBOHh5Vf/EyKbBWtxxLGOHzUG+x7xEtdeWiYvRyRKbcJCN12ODlLbcP5G9xSOCuP6WYwX4rYDDzFoIChUd23LYYyB6qZFsI2ef7PBQH1EuhYWDWuAN0iZZ8ZZuOJRy+/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBndz/oO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBndz/oO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88920C2BCB2
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 14:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722032;
	bh=haCCzeM16uqa0idk+B4jKGHTSfi3L+3y6kmR8mUCc9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oBndz/oO9YJz3C2h/DrlaUde1irljv4/50pD5l2sEiA4ANMNAQK8ut71a5+QwIPb6
	 uE3QRCzDp6pzylsMNDrV0kFxVl/Dl2WqJ7PFN6Lor1oQiayJoGuPJTcVbANxQ5z5//
	 /+IRbX6jMT4fnUgulrd9wZ/NVW/j5UXsz802D/ta8lJGXHiqEiusdOcXzqlrglo5Mv
	 rTmmKxTdo+tC6deQK0RAoIDkcZxbsNElj+nTPr7VHM6nyksjXeQU9zplq2LOuqBtO8
	 bwh+ZXetzblmlrUqSsoIMnQ2l+/j7nU5nhfN8QIMn+RSucuVXk3cBl0McPc2vWVK7x
	 HgEaRGhPdWBNA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40946982a78so1327343fac.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Mar 2026 06:47:12 -0800 (PST)
X-Gm-Message-State: AOJu0YzgcjU1H6zhmR24iwPGGmX0DIQFZZSe9zo/fbbfYNWJ3pps9Wji
	MHyNL/PMllLIySWsByX9DiO/H5La/+REYKok6JEqjtgOq7aFmkj7ViCRuoLKpsUA7gjpbdxx6Vv
	rzfj3Gzf2Ty7XyZ0/mUH876ymzRYQO2k=
X-Received: by 2002:a05:6870:92c7:b0:40e:fd1b:b74b with SMTP id
 586e51a60fabf-416aba434a8mr3719347fac.27.1772722031597; Thu, 05 Mar 2026
 06:47:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129121813.3874516-1-zhangpengjie2@huawei.com> <ezppyby2fs2k2njwcty4dpaf4637g24kzmemjm5sedeerl6ihw@brxxfglbitxc>
In-Reply-To: <ezppyby2fs2k2njwcty4dpaf4637g24kzmemjm5sedeerl6ihw@brxxfglbitxc>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Mar 2026 15:47:00 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hkRc2UCVAHt8XjYsspBd=r-TFjnTWeQuxzYJ-niBuPeA@mail.gmail.com>
X-Gm-Features: AaiRm52wBp5o_YAVDwyW3vxWcHMWMcyEmcC7KUFjRzA5k19MNWf_VMgGw7XyVMQ
Message-ID: <CAJZ5v0hkRc2UCVAHt8XjYsspBd=r-TFjnTWeQuxzYJ-niBuPeA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Add debug print for current frequency in __cpufreq_driver_target()
To: Viresh Kumar <viresh.kumar@linaro.org>, Pengjie Zhang <zhangpengjie2@huawei.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, linhongye@h-partners.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, wangzhi12@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 7:27=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 29-01-26, 20:18, Pengjie Zhang wrote:
> > Include policy->cur in the debug message to explicitly show the frequen=
cy
> > transition (from current to target).
> >
> > Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 4472bb1ec83c..b3d2d2e0c864 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2361,8 +2361,8 @@ int __cpufreq_driver_target(struct cpufreq_policy=
 *policy,
> >       target_freq =3D __resolve_freq(policy, target_freq, policy->min,
> >                                    policy->max, relation);
> >
> > -     pr_debug("target for CPU %u: %u kHz, relation %u, requested %u kH=
z\n",
> > -              policy->cpu, target_freq, relation, old_target_freq);
> > +     pr_debug("CPU %u: cur %u kHz -> target %u kHz (req %u kHz, rel %u=
)\n",
> > +             policy->cpu, policy->cur, target_freq, old_target_freq, r=
elation);
> >
> >       /*
> >        * This might look like a redundant call as we are checking it ag=
ain
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 7.1 material, thanks!
