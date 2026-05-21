Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C77E33C1B4
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374732; cv=none; b=ae1HNM5yMiJgKF4P5cEh0DA//lLroKmnGUI8/o4vz5HvTLwuRWJXVYUqUCwF87kLMoKxWy5f9o4TJTdK81chT5Gvdh9gNxEJrAhlCxEy0IlgNTwN2U7mIKQkmi5pdqIJk7c5sbzEnl1iPe2Zvoq92gUB8SjOtuWiuYicyyuhhVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374732; c=relaxed/simple;
	bh=XwkEvUWSwFuzy0TZ9CixnXFx7oFCWYz47jRFWJ3sfM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMrBxhKj4lSSkMTdetYsXyaTDc0NexbBjgO/sWH8/c6mFKfUNaQHnfvC2u7R6z61tgYg04nIumQWkmgF9LR2j+A3rrA+hMNq+WbIbSAEM3O/AbEecIoDo5lEZ+mQmKKwgEvFZPzzQ37np/7cNH9TZwn9fTJzeqZYABd0qs4p4SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5pRyHis; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5pRyHis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310F81F00A3B
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374731;
	bh=Iyub21GW2fVdfiJB2gsWGwjhhIYpi8EzhUGXYJ4fcfo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=m5pRyHisVAbbIP3CDO8RUL9823ou0aQaFwUKvDjl5rruSBTSQKPmWJW0IhQMvVzFZ
	 19nNXQWcNIjMgZIDeNjQ05zgOul0dPTXnMZQQPLKEff/10uc4v7ESlIRYKZb8F23f8
	 mZUcgKWzDL7j3DJSMf4DDvNEJtRbSppPf0Jn6bi0ezO/IdiZh1QdRDYANJTApdoDpC
	 LU6GdtOfPMyi6iJ9t54ydZpkYsk+WrnFyehcWLzxJa/wlRmuQ7qGkuvna0KZfMfdPn
	 52xN67yrJ+zoABcm2HkXF1++suuxmd48H+irXxgF4loPR65+a9lTJPJ2SL5RC/vHB+
	 fevaG4wDKlgwQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a8891f0c51so6645100e87.1
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 07:45:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9KOmLBQCm1fYblJAXC+2tNhhOAIgl/uMAlY82Lko40h2gALP0JwquWKaDqXiuBGUP27YuwUtCCYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzL7rq7Gk8/jnAUS9h0g3VFp8kB56G70s6As7lr12XO5Gn2hS89
	ybCXkcM0Aqrri1uE4JGlNp1xLXHF4NisJC0tVdnNn665/TDmmkb3uasgP4nP/BFiMrVO0goZVSh
	UPdvsCV6BE3OtazrU7bgvJAfu3bkpb6A=
X-Received: by 2002:a05:6512:800d:20b0:5a8:9f6f:3212 with SMTP id
 2adb3069b0e04-5aa2ba9ab38mr976634e87.34.1779374729672; Thu, 21 May 2026
 07:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416144621.93964-1-dbgh9129@gmail.com> <203f2e52-bf9d-4055-88bd-d911bfecf082@oss.qualcomm.com>
In-Reply-To: <203f2e52-bf9d-4055-88bd-d911bfecf082@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 May 2026 16:45:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hQnTxFp-T=WvXNMO45ucfb2X0Km8tcFSRvsfh9HgUqhg@mail.gmail.com>
X-Gm-Features: AVHnY4JAY7qrxW6kff8W2_kXVCgYxIJ2GfDpoIfnqoEFYJQFH8uUUvtpEIckfe8
Message-ID: <CAJZ5v0hQnTxFp-T=WvXNMO45ucfb2X0Km8tcFSRvsfh9HgUqhg@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: pcc: fix use-after-free and double free in
 _OSC evaluation
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Yuho Choi <dbgh9129@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 5:29=E2=80=AFAM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 4/16/2026 10:46 PM, Yuho Choi wrote:
> > pcc_cpufreq_do_osc() calls acpi_evaluate_object() twice for the
> > two-phase _OSC negotiation. Between the two calls it freed
> > output.pointer but left output.length unchanged. Since
> > acpi_evaluate_object() treats a non-zero length with a non-NULL
> > pointer as an existing buffer to write into, the second call wrote
> > into freed memory (use-after-free). The subsequent kfree(output.pointer=
)
> > at out_free then freed the same pointer a second time (double free).
> >
> > Reset output.pointer to NULL and output.length to ACPI_ALLOCATE_BUFFER
> > after freeing the first result, so ACPICA allocates a fresh buffer for
> > each phase independently.
> >
> > Fixes: 0f1d683fb35d ("[CPUFREQ] Processor Clocking Control interface dr=
iver")
> > Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
>
>
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
>
> > ---
> >
> > Changes in v1:
> >    - Drop spurious #include "acpi/actypes.h" (Zhongqiu Han)
> >    - Keep kfree() between the two calls and reset output.pointer =3D NU=
LL
> >      and output.length =3D ACPI_ALLOCATE_BUFFER
> >
> >   drivers/cpufreq/pcc-cpufreq.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufre=
q.c
> > index ac2e90a65f0c4..a355ec4f3dd4c 100644
> > --- a/drivers/cpufreq/pcc-cpufreq.c
> > +++ b/drivers/cpufreq/pcc-cpufreq.c
> > @@ -352,6 +352,8 @@ static int __init pcc_cpufreq_do_osc(acpi_handle *h=
andle)
> >       }
> >
> >       kfree(output.pointer);
> > +     output.pointer =3D NULL;
> > +     output.length =3D ACPI_ALLOCATE_BUFFER;
> >       capabilities[0] =3D 0x0;
> >       capabilities[1] =3D 0x1;
> >
>
>
> --

Applied as 7.1-rc material, thanks!
