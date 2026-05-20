Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C312E395DBF
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275802; cv=none; b=hHawLCxFFuasNFSm0SgZXzk+FA8KPJvSyPYbC4htGiLEOJ+T7A/Z+M+6OPGAz0x5Ov7kwaY+6XKGXC9fZzZsyF3xcvq/sz5vxzGA4hEoFiXqXM67ImrC9oeg3Dy+NKWPp++PRANDUEq/qnuTAwG3ucz8TqCNt6OwTK+3qjCAG6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275802; c=relaxed/simple;
	bh=HK2L8GYcyvFen3RsKjQLL9V2bUHBT0R2L1ucEkObyEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5rbO0qkUsSdBCqQXM5cxUQwWcRQM+oyK+ehz1YDrnh/qQzUspEBjs2rXslYgRLwF+eIBW2WhYzRMzXrEN+XivYeD6gIqfSWH4kRbX2yGBQ+TOEQdEgwibtCKNhAR2yEVfZGoNKJ+j56gm5c8A5uF+BhGhzrF1XUTRS74ILkm+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmG3j+9o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmG3j+9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C719F1F00899
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 11:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779275798;
	bh=HK2L8GYcyvFen3RsKjQLL9V2bUHBT0R2L1ucEkObyEA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MmG3j+9oMp9E66t6NBfPkBgDylmEBz4SdwXph5L6j/jGkn6eZ71ot8B7frPwL7n2E
	 dYBbWpsvL/zghY10Ti3mU2YwOg5Suhnmg6zbGLTgNJplY9XkgRHdjW0VGCOv/4y3YT
	 WGF1N17G0x4AKPBUeDa4R1o/U1wQpyz8fdcXdNrj80QvSpaEusUNDQLgH7nQFETNNe
	 D6f6UDCwyNeGUzZM/lpsyJ1YFDJc8OfI85BBR2Y85OezWGqA/hSEvWbtCJsyHushjs
	 AUClS2LPUaJKLRCTXAFL2OyAJgMkblRWPkxJMG95nMdCYUGvRC+PH9V7e31Wb6rEdo
	 afXdz6PYVhFrQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a87edf88b3so5085324e87.0
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 04:16:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ppaKHaBXyvkaDJ5BoRJgtWJwHCtvNYoMbQUK3lTKxWeKM/MQn2xhXgW9VWQw5X/gzluAD3QzwdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxLa/s7pFtcaiqvSSma/+sfwDrtZAN7HvCpSID8Ggpj8T/iQFZ
	irrrUiJQHkeBojlEFgXRUt+6KcVwok0oUVmuSiidyk0SDXTIpWAJhONRJ1KT4LRBbClew4AGSQP
	kSap+DR8RGYgJgtzX22PvLc+2YGnwFfA=
X-Received: by 2002:a05:6512:1590:b0:5aa:b6b:93c3 with SMTP id
 2adb3069b0e04-5aa0e74512dmr7661008e87.45.1779275797274; Wed, 20 May 2026
 04:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421123545.1745998-1-zhenglifeng1@huawei.com>
 <cb369a6a-5462-4e6b-a132-ee016a4163ea@oss.qualcomm.com> <b6d995f7-91c0-4f87-82e7-87cc50faa43d@huawei.com>
 <aoo2k2uzi6zg6owrmi7qgcgjryxzk7l7f2mdo6vtjjdd576hpn@rg6zyqgn7grr>
 <80d32bdb-f661-44cb-b529-3d5ce2142af0@oss.qualcomm.com> <pr25udlbea4vwtx27gfzlnqzv3lmmphkjx5xj2ggzdegmd4ntn@kiytfovoifi3>
 <a028421a-de24-43cd-ac80-17de9b2fc523@oss.qualcomm.com> <5ivkhopr53lsrnlu62ucdn5yfyeh42nwq3knfifp4ihgv6kpzy@sd6eekl2r45a>
 <fc82e05b-db8b-4a15-b46d-332c9f2d95da@huawei.com> <ygm5rfevkxzoaapktjhku35ajrkzu75ebbwva4o4spp6wqay4z@txtjcnbjhx63>
In-Reply-To: <ygm5rfevkxzoaapktjhku35ajrkzu75ebbwva4o4spp6wqay4z@txtjcnbjhx63>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 May 2026 13:16:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i4_G+yzV0BSEOR=MVnV-9O-rXEAOLKWUKbMjgCvQuuQQ@mail.gmail.com>
X-Gm-Features: AVHnY4LLrcb4Ps3HJGy3Q4ATObjfYkYBlMX-1Y19b3y-fTE3uuC1Xf7D8hirbrQ
Message-ID: <CAJZ5v0i4_G+yzV0BSEOR=MVnV-9O-rXEAOLKWUKbMjgCvQuuQQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: conservative: Fix incorrect frequency decrease
 due to stale target
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	rafael@kernel.org, stratosk@semaphore.gr, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, zhanjie9@hisilicon.com, 
	lihuisong@huawei.com, yubowen8@huawei.com, zhangpengjie2@huawei.com, 
	wangzhi12@huawei.com, linhongye@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 11:57=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.=
org> wrote:
>
> On 20-05-26, 16:22, zhenglifeng (A) wrote:
> > For CPUFREQ_NEED_UPDATE_LIMITS drivers, dropping this early-exit checks
> > means cpufreq_driver->target() will always be called every time when
> > cs_dbs_update() is called. Is it OK?
>
> What about merging this change and implementing something like
> limits_changed for the policy, which can be checked for
> CPUFREQ_NEED_UPDATE_LIMITS drivers ? The variable will be updated
> whenever policy min/max changes.
>
> Rafael, that should be good for CPUFREQ_NEED_UPDATE_LIMITS drivers ?

Yes, it should AFAICS.
