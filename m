Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45BA4E8DEF
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790365902; cv=none; b=KZmd6HElHruyTNL6NlsAXrzgfc7BbIRISWTYl7QNvIP8izs2Dl5E+IICsB4ItA4OgRTJeod8e4o4Dy7NJX4NE3fBIrTeCyFE4ypTmalMMAkDW/6yILvo85gfneoV0MkSw+uNowcCEGQLtStQQOItMfC0Ncq6PVcbev6Vx6Qc+ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790365902; c=relaxed/simple;
	bh=2pKdO3h1Su01tEz4Iq9muFSMNq+nPhG24Qel2AaGW1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LraQUA8t3VtfcDsIyyeQ7NDCPTs7HU727ZTQpWSyycjErKgt4HgrjegLSH2+4/tviib9GI8qUK832ZsMrLNO0VvbHfaICL/wA59LqkYFYNZU+tz2EaUK1N9AVr+MPvcf7LER/Xx3+68ac3D5bEGv7/igaEiBvK9c6T8w+9es2HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQQSQ7lq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQQSQ7lq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4C21F00899
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 19:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790365901;
	bh=4B7e94SXd49oJbq/xM76z20C0J2FDWZN5SoKxn3ph4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mQQSQ7lqhEbPy0Bg5CRVfBLmVjYDS+qOSYrWWuqQylY29b4CLgO6VoDpv+O7TJHEh
	 w4JFrKhvkJNl8h+H/izj+4IGC02IJdOjZOzCFGw/J+kCuoUGGem3BV+7KdEEpDJ1kf
	 2W8tYoG3QN+scWDa2JWd0bt52WrnuTvaXQ6/B0JSrXXADUfpwYbe2C6ixDceAIQCe2
	 zrFnRSQPeWnVXXOJeaH07kjwnZ2ZDiqjXj8GtJLRpseLZjGquzr/SrREIID2FqTJn8
	 mSVi+/BI0Deb/ltW3HLm37wnL+ro+YnW2fbWR3bH846utxAnXX31BCsLe3o+cH9GV4
	 l0zzvES3O/jcA==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a64e7f4892so3215621fa.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 12:51:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzwb2a7ww8Xbn/5cNjoYIe55t85mptLzA/iO4D1WULvTnDGC7a7+YE7KE3tyzof7KgnCbt5HfnJ7g==@vger.kernel.org
X-Gm-Message-State: AFuF++nHO1UYkD+tla1UXfOC0rRMiH/ld4KtGvnFMXsb7D/zUDXkEUOc
	DY8GZEQCMUbFVZA3A7asK6a4+Pz/T/a2hzIf/XJvUrtRxdQz94nh1O5M/UrBOhSJrNcJgPCyS4R
	5dTBc6vni3V8peePofpQyHxzcU0Yk1GQ=
X-Received: by 2002:a05:651c:54f:b0:3a4:9881:8de0 with SMTP id
 38308e7fff4ca-3a63bf5cf4cmr14741281fa.7.1790365899771; Fri, 25 Sep 2026
 12:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919-move-dont-use-autosuspend-v1-1-f6e2d1315c23@gmail.com>
In-Reply-To: <20260919-move-dont-use-autosuspend-v1-1-f6e2d1315c23@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 21:50:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jzj0QdaYvYcUOF=h5JkV-oYmRZ3U+v4gtrmPkJnGNpTg@mail.gmail.com>
X-Gm-Features: AclHuK9N0CY2rxHQrszYK4T8Nsdnpx1GicGt8vAlTD-qOhnRvw_jso2Nf_Tn79s
Message-ID: <CAJZ5v0jzj0QdaYvYcUOF=h5JkV-oYmRZ3U+v4gtrmPkJnGNpTg@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Frank Li <Frank.Li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 10:25=E2=80=AFAM Joshua Crofts <joshua.crofts1@gmai=
l.com> wrote:
>
> Add a pm_runtime_dont_use_autosuspend() call to pm_runtime_reinit() to
> ensure autosuspend is disabled on driver teardown.
>
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
> If a driver doesn't use devm_* functions for automatic cleanup on
> teardown and autosuspend is enabled during probe, it should also be
> disabled on teardown in a _remove() function or equivalent. However,
> due to bad documentation, driver authors usually omit the
> pm_runtime_dont_use_autosuspend() call on teardown.
>
> Reason for investigating: this week, several patches popped up in
> the linux-iio mailing list, adding these missing calls to several
> IIO drivers. For some reason I ended up writing a cocci script to
> find other instances of this and found ~195 offending drivers.
>
> After a discussion with Frank Li on the matter [1] when sending a similar
> patch adding these missing calls to the clk subsystem, we arrived to the
> idea of actually adding the dont_use_autosuspend() call to
> pm_runtime_reinit() and have driver core handle this instead of
> submitting 195+ patches to amend the issue.
>
> [1] https://lore.kernel.org/all/aq1N863eJpD_ZrLU@SMW015318/
> ---
>  drivers/base/power/runtime.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index fab38bc98113..9a37f6162fe0 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1874,6 +1874,9 @@ void pm_runtime_reinit(struct device *dev)
>         if (dev->power.runtime_status =3D=3D RPM_ACTIVE)
>                 pm_runtime_set_suspended(dev);
>
> +       if (dev->power.use_autosuspend)
> +               pm_runtime_dont_use_autosuspend(dev);
> +
>         if (dev->power.irq_safe) {
>                 spin_lock_irq(&dev->power.lock);
>                 dev->power.irq_safe =3D 0;
>
> ---

Applied as 7.4 material, thanks!
