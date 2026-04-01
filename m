Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619842E62C4
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052797; cv=none; b=PfkBvVY4ZHtplhpBl8HJXWk7COrktEuUTByVwHQtVwPOksT5G86fnLYtVRw+WW7jMT2vIHVwH008QYckE4P+cos1GjTjeM23S5hnjwF7OYlX3ChuvdicspHtgj92KF6j/F3Ag8kHmPDe4sH9XzBQftVKtRXXIma3c3zpygNq/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052797; c=relaxed/simple;
	bh=aS0SAiFq5A7WJ8N+gPtZQSzSsiDmZBYyXQIvdpL6q8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UykUTnSR1o/Jz+HqerTQxCMcXJxgyD4afQL0T3W92URDfpzdh7Gt8HB89ZrWA6lMMOIuD67i0oIxVbLRuGyxVXFBAEX8Vrhti+nEhBivUo/hiYGu+/VatfPuTldLprLcN236ysYX3JZXIqr8shWv0Ct99JI6NMXsBnpyuSrGy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD0GtjQc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD0GtjQc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16576C19421
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775052797;
	bh=aS0SAiFq5A7WJ8N+gPtZQSzSsiDmZBYyXQIvdpL6q8c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mD0GtjQcD+odeet5EBPi7H02yNFT5sLF5eoYpL7vl9EEGn2Ft4q0yWeAVD5XlV9ke
	 UkXoNQ+Z2Cy/iRAupD2+o7/nY5EkfdPeuCmfUi5aS2j+3aF2F/Q8AUPlh4yiAk6SnC
	 QckeFUbM9snIkQbpJisAtvyPWkdWmZllt3pmQnwxDbL9LNLlCZeSSIhcoh/3eLmJLn
	 y/dnw1Adagt+/KkmMF07VIzvMj8meL6s0aQAiEZ148PmI/9u1Za09AKsaaGK03WP2W
	 16+yQP2qMrok/ZTfOSxbLTsUv+eJXSrTe5q9qHI1EVWZMTeSWDkgNTez/Dc9FAowip
	 D6scLIl4VXwLw==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-466f00535cfso4290323b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 07:13:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDc8Ze2wbHYsdPhJZpofWuOadl8wJQceUefgB2wEw8W4ZPgdatLNd3D3276LYLcJxQrBMRkZoxZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIyEJK8wSro1D7FWElkVhaY0yQjxTCi+IJ3jWfiagEFOnejoOg
	LBdOZLCE/k0bOPCL21JmyBNdcwnsclUaXnvp7AVV0NcS+Q0m+v5axY7Ryy0D77jSVDZNOad81ZP
	YbAoZ8ie3w38OzaCLbEmQWvI7q9lc7lU=
X-Received: by 2002:a05:6808:1a20:b0:469:eb5f:891 with SMTP id
 5614622812f47-46ae0194519mr1974495b6e.39.1775052796239; Wed, 01 Apr 2026
 07:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401024535.1395801-1-lgs201920130244@gmail.com> <aziv3yszmqef3amj3wgnutif7eop5slnmf5eqrg6rl7sk5ghf3@7et2qcnti2y2>
In-Reply-To: <aziv3yszmqef3amj3wgnutif7eop5slnmf5eqrg6rl7sk5ghf3@7et2qcnti2y2>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 1 Apr 2026 16:13:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h2ZafW1H9NECCReyrSU9=o5YCreBnY6Q1SW=vQ1Gvcyw@mail.gmail.com>
X-Gm-Features: AQROBzB7rq7t1BHAKFwCMmmotmo2GMjHLmmHBFnGaOFB6hgRCYeW65pL0w6YDI0
Message-ID: <CAJZ5v0h2ZafW1H9NECCReyrSU9=o5YCreBnY6Q1SW=vQ1Gvcyw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: governor: fix double free in cpufreq_dbs_governor_init()
 error path
To: Viresh Kumar <viresh.kumar@linaro.org>, Guangshuo Li <lgs201920130244@gmail.com>
Cc: "Tobin C. Harding" <tobin@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 8:23=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 01-04-26, 10:45, Guangshuo Li wrote:
> > When kobject_init_and_add() fails, cpufreq_dbs_governor_init() calls
> > kobject_put(&dbs_data->attr_set.kobj).
> >
> > The kobject release callback cpufreq_dbs_data_release() calls
> > gov->exit(dbs_data) and kfree(dbs_data), but the current error path
> > then calls gov->exit(dbs_data) and kfree(dbs_data) again, causing a
> > double free.
> >
> > Keep the direct kfree(dbs_data) for the gov->init() failure path, but
> > after kobject_init_and_add() has been called, let kobject_put() handle
> > the cleanup through cpufreq_dbs_data_release().
> >
> > Fixes: 4ebe36c94aed ("cpufreq: Fix kobject memleak")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/cpufreq/cpufreq_governor.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 7.0-rc material, thanks!
