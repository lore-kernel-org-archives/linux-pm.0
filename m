Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FB63B8BA4
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 19:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749993; cv=none; b=aXFHoqnCRLVAb+tkn+9waTF+Bxysz53WIWipTlCChzqA7lJP2TAzexxQQNBo4c3isGKI5GY5XBEGHx/IbBFUYOjG8xqUw0+kAZLwxiMnR290Z1TLnHRSgFMXF0zx6u1OgqxU44cxkHyZClWfzjZYg+85dax50oSuqWCumxPBygs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749993; c=relaxed/simple;
	bh=ZOzjNe33N6WOv/F+Vqi9XJcIXpySIpqWA7L9PackUP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M344QbvVifYPAu8iuVKkspWd0Tlrmzu6EP9d5KWl0CpYwoD4zxclNWXkFZk0mfDMVydZgvyzM+OLl6hudNEhP+mXWGMyCa0pZvlCzb8d9TqOjgfzyVrtkeZEk71c7hOlCd9s6XRsA40FpbUDCK5rgj143BX8FpFQlgssplm8xaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W03tfNtE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W03tfNtE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65791F00A3D
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784749991;
	bh=jX3keiGfASMpUfc6WbdXTYn8yg/AOKhNn+GCulK3FjY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=W03tfNtERQIKHqZKLT4oU2vmZvmUD36xDPWTIhyrXDd8U4L+o23awH6lNsGpfeAgR
	 CT5nBn1wK/oRYw062O/lJrmxAWQhZrX/7nArBKiAMNuusG29pUPCyckDtjjkUC6a6k
	 1hDo3v7mTkiZrPmMs+vhv1BiRbUnWcieCaUuCWa6frKhBR8rK9NxATH8wTIVRhL/fQ
	 p9N3ukyjoAE5I88Elw/ppSE3zPLfeC95p5H08nayZFEpQunbBgcAViftrBtzvxCWP5
	 fJmAa/K8dh4m8DtFS6bjWGeC3wdpLgFNlReRpJPdVKhqocUtSg6VpmxynwYh75kBB3
	 H61qr6nk8n39w==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39c7ce122c7so112218591fa.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 12:53:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqMCC/TIe1va30Qsb4eQFzIqpAUFyqc2tFFsrpK7IaqGEyimFfb3v1ia7MC9fhRlNtKlGJcUSxa1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4b/klgNv+iWd85Dh5wzv5PyypAJiIPJ34GsHwO0tseK3qFjdq
	vgIMUX8P8VvhF3heDpBe5wJ5YWJ9vT0AerX5/qur/2v2uZ/j7zAZCFJ/kYcfRTy65DJewMQGsly
	wAgZv6ZaCdx+QIoMFbj7HmlHHOvRAfyg=
X-Received: by 2002:a05:651c:43c8:10b0:39d:b717:622 with SMTP id
 38308e7fff4ca-39f07c806eamr193201fa.12.1784749990308; Wed, 22 Jul 2026
 12:53:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706143857.3306-1-always.starving0@gmail.com> <oz7lhcfan7rpy5ixlqlaea7rqjhagepqqzpssueai4qcwe357y@ilky5ez6eyd4>
In-Reply-To: <oz7lhcfan7rpy5ixlqlaea7rqjhagepqqzpssueai4qcwe357y@ilky5ez6eyd4>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 21:52:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iVzb_w46mPfSZ9rXC2rVSXJ6K4cxM5w7aWGH4i+CP1RA@mail.gmail.com>
X-Gm-Features: AUfX_my4pB0trjcAkBTns0MfbQQLw9BYF62nfqgc8l1ImV90LQEvqv_HA_yIhps
Message-ID: <CAJZ5v0iVzb_w46mPfSZ9rXC2rVSXJ6K4cxM5w7aWGH4i+CP1RA@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/cpufreq: Remove unused local variables from switch_show_governor()
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jinseok Kim <always.starving0@gmail.com>, rafael@kernel.org, shuah@kernel.org, 
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 7:10=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> On 06-07-26, 23:38, Jinseok Kim wrote:
> > switch_show_governor() assigns the current governor and frequency
> > to local variables before switching governors.
> >
> > However, these variables are never referenced afterwards. The function
> > does not restore the previous governor or use the saved frequency, as
> > backup_governor() and restore_governor() already handle state preservat=
ion
> > elsewhere.
> >
> > Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> > ---
> >  tools/testing/selftests/cpufreq/governor.sh | 5 -----
> >  1 file changed, 5 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 7.3 material along with the [2/2], thanks!
