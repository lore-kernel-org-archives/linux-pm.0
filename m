Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B271738AC68
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364166; cv=none; b=i3yaIN8Dfnl/GgIYgmsifpX+daudQiyYJ67+k9SxA/h2CI+XGWq1TlS5QL2ezaM/Q/PWqju9kBtcjgxQ6UejDXe47hcQPKBVSxFG+7eIYAorVtLlH2MTLuzDmFmZYvT77k3ohZ0GKkPZg9lGVhBuTlJoTWJLNhX1I3KL/POB6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364166; c=relaxed/simple;
	bh=vGzWmhmfK5+msJjtqqDpL/8yiq1ZzPnKCmsyqZQPYuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uc2y6bLQq+vjpOhS/dErMhd1aNifiXph1lve0nV5/LZ4SWiAZvB8BBJgtNOfWt5dx6YGugWKiAjYSaEju91AFEZw9JHRLN1EcFlqNWNt7hCoZDLabboQeKCL1phBXZiotbkSK9DqUbKwljlzuzd3VpH5TkUMb8PCK4dfxUggoSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jk18WX5X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk18WX5X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52191F0089E
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 19:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790364160;
	bh=6ow/A/OW+wK5EkwH7DjhZj9xv4azuS0V+QzcTkjBalI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Jk18WX5X3grRl2Lz40D5NBuNmMGEvbFhXlRzscj2TfNsigZ1fFVYDpS0WolM2uQox
	 NxxevCqoftMKfxww559cQvHEYci7icFEtCSbufr1fuOeRBVztjfyEdZuxy8VFXd1hB
	 vwXOLezdWw2VYnhTGBeXVK60Z3VDuSOC3X2UCOOZzL0wsMWfx+nXmtfIv+WyyWSTkI
	 s3uvNROTpRDtGRjZe/mWjacjBZO21sTzOdt5566cRpDMdhDrdEOoeRi5kJFJypuyF+
	 P51DxlW1HLJAP0elczKj99MWDO86CIvhx0RWiow9aaCoJ37ndn177BCQm+a3h1C3pq
	 Ceri/XiTEtbvQ==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a49bc59559so8901411fa.2
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 12:22:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx6qWjizNyHvJ34CPqHtsu5O2/OwmJo/+pKUtSTtfskV0jVL4TWcqjyKXPmp9HxPsYRGfKyi4b2Qw==@vger.kernel.org
X-Gm-Message-State: AFuF++lEpiG/QwOvQmn8Y2W2KmCpkcYKEme8zFGdjNV65cbTnaJ5RD+g
	dYEX8wkEpIh0BxTokjAT9PataC3VrHLdnlmVidcKT9CvqduNruxNma9+PiHRAj3/AN8rXwdyir6
	I8RCvXoWQeHlFmehMa99Q6EFN8hqZHw4=
X-Received: by 2002:a05:651c:b23:b0:3a5:e027:1b49 with SMTP id
 38308e7fff4ca-3a64c71fe9bmr7397371fa.2.1790364159052; Fri, 25 Sep 2026
 12:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915221548.104852-3-blum@kernel.org>
In-Reply-To: <20260915221548.104852-3-blum@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 21:21:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h4RvH-Yg6y8H6+6wqVQRvrY7zJZknrEqjiftKf3vWx7w@mail.gmail.com>
X-Gm-Features: AclHuK-Vdpf60QGX2Zw2meAjmYNb7AVQ44cC9-5GsRSxXzi3TvHsdGbIEGCjEX4
Message-ID: <CAJZ5v0h4RvH-Yg6y8H6+6wqVQRvrY7zJZknrEqjiftKf3vWx7w@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: intel: powerclamp: Simplify duration_get()
To: Thorsten Blum <blum@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Yury Norov <ynorov@nvidia.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:16=E2=80=AFAM Thorsten Blum <blum@kernel.org> wr=
ote:
>
> Use guard(mutex) and return the result of sysfs_emit() directly to
> simplify the code. Also use %u to format the unsigned duration.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/i=
ntel/intel_powerclamp.c
> index bd7fd98dc310..8ceb1270646c 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -103,13 +103,9 @@ static int duration_set(const char *arg, const struc=
t kernel_param *kp)
>
>  static int duration_get(char *buf, const struct kernel_param *kp)
>  {
> -       int ret;
> +       guard(mutex)(&powerclamp_lock);
>
> -       mutex_lock(&powerclamp_lock);
> -       ret =3D sysfs_emit(buf, "%d\n", duration / 1000);
> -       mutex_unlock(&powerclamp_lock);
> -
> -       return ret;
> +       return sysfs_emit(buf, "%u\n", duration / 1000);
>  }
>
>  static const struct kernel_param_ops duration_ops =3D {

Applied as 7.4 material along with the [2/2], thanks!
