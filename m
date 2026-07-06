Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705AE430316
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 12:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342245; cv=none; b=ui7Y3UBXoHl6GZ+vO2Rr7nWY66TwDXhpMqtmtjk70/YupdeOcH8W2IT+rLsKN9O7ssGHINLtJ149Z3LS9PAGnqOotooZDf7V7+eegdI6MU8dN9/TzDCC+qkcyeBvIu0Ijx5Pau4jJZ9mG/oaPZRttkOikvu/DuhiamUHdSkIRP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342245; c=relaxed/simple;
	bh=vTAKk70ZRRV8/efCs47Uzw+dFgt34Wa5TAsFvO4ZfAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QiFMGq9b3BkhpisFlvSJBIyJAiSthmO7CbtNOtTcY3d4KHPqU+QQhzf45iyh1CqaRzUs/celXBApTjRFoeXhOLUsBfKHMvQANdw4uK3mH2rHCHdMa1iDtTF+a0WMVLHgEPjim7yDK2vjMPjwTG1tRHnBRw5HRH1LWr8atkdxvHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPxYlOWz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPxYlOWz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336921F00A3A
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 12:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342243;
	bh=07GLEgOUI5a+j2cP0rEFk++m6bjbKk3uvfak/3Sku/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MPxYlOWzixi4WTzDOYkRsU0Ryo0ZLyNl/5WGLj0XbuFQRASl4U6dwbrGyoqsPn1O9
	 x2XBnTO29WhQ3LxGnoA/R6RCbbwZkLFQ8YqUatyuF1pgfkSBv/ajVPO+uZPLLvLHzE
	 0Bh3rAqT3EaK0BsRVeB2aQPtUPy3/pxmilggbRYXZ6I7ke3NIL4abIu/ZwdXPX54J5
	 fblTaqUxjzsc0fdt+FQqQsOtKVKc+E76bt00xU29ghPv8MsN+/Q0ngIZhnoVWHnfD7
	 AmeEwYL5Q/7xEydYPG7y90o64T+sjKisXdFO4JE0mXjC98LN8djBz6cIhVX24B+VIZ
	 JfYava5ykeCDg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aec5675c46so2920628e87.1
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 05:50:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr6p9WdC3eluR+OvWljRpBXaupAhRpcU1/sgBOrDgyn/R/vCEMi0ObQhEEdBFwLi2JoRc8vy9LSqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6rt8wuWcj4hfJXl3sKyg7LPk0T/k7onfeWAIRFTuTxD8i3YM8
	TgHFkVYVrWnC6IUk/X/Vv+iE6aoWV0PYbNpjYsmw6+z+1WNM1g7gedf1jRwv/fmcCTLLY+bgaLX
	cGvtF3N21BtkkfDFjnWsDY39s9Vgz/PI=
X-Received: by 2002:a05:6512:838f:b0:5ae:befc:97ac with SMTP id
 2adb3069b0e04-5b007c6ea82mr32613e87.55.1783342241685; Mon, 06 Jul 2026
 05:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629060526.3638272-1-jgross@suse.com> <20260629060526.3638272-5-jgross@suse.com>
 <CAJZ5v0itUVZ6=GCbRomkMiesy5uhZVWWjsUbqFqsZTyNeCBAbQ@mail.gmail.com>
 <akYskLix-iNOAbCM@gmail.com> <CAJZ5v0hZN2SsX1uVfDuVzV=7UoHsNbhe8DUaFCaVsd-ceLvZWg@mail.gmail.com>
 <akjDoZnJsZNxE1tg@gmail.com>
In-Reply-To: <akjDoZnJsZNxE1tg@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 6 Jul 2026 14:50:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hA+wwKKrnwKKaTjgoAzJ6Pe_KuW9VBrpROdvVv_w5fbA@mail.gmail.com>
X-Gm-Features: AVVi8CffklVcXY_CLFB1bxuR6U7mqoC6O5wLSBzLy8wKvsJS6Io-lsiwG0rzKlk
Message-ID: <CAJZ5v0hA+wwKKrnwKKaTjgoAzJ6Pe_KuW9VBrpROdvVv_w5fbA@mail.gmail.com>
Subject: Re: [PATCH 04/32] acpi: Stop using 32-bit MSR interfaces
To: Ingo Molnar <mingo@kernel.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2026 at 10:26=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Rafael J. Wysocki (Intel) <rafael@kernel.org> wrote:
>
> > On Thu, Jul 2, 2026 at 11:17=E2=80=AFAM Ingo Molnar <mingo@kernel.org> =
wrote:
> > >
> > >
> > > * Rafael J. Wysocki (Intel) <rafael@kernel.org> wrote:
> > >
> > > > On Mon, Jun 29, 2026 at 8:05=E2=80=AFAM Juergen Gross <jgross@suse.=
com> wrote:
> > > > >
> > > > > The 32-bit MSR interfaces rdmsr(), wrmsr(), rdmsr_safe() and
> > > > > wrmsr_safe() are planned to be removed. Use the related 64-bit va=
riants
> > > > > instead.
> > > > >
> > > > > In processor_throttling.c drop needless initializers.
> > > > >
> > > > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > > >
> > > > LGTM overall.
> > > >
> > > > Do you want me to pick it up or do you prefer to route it along wit=
h
> > > > the rest of the series?
> > >
> > > I'd like to keep this series together if you don't mind, so that
> > > followup changes can be done more easily.
> >
> > Sure.
> >
> > I will be assuming that tip will be taking care of this change going fo=
rward.
>
> Thank you!
>
> Can I also add your Acked-by to these two patches:
>
>   [PATCH 01/32] thermal/intel: Stop using 32-bit MSR interfaces
>   [PATCH 02/32] powercap: Stop using 32-bit MSR interfaces
>
> ? They both look fine to me.

Done.

Please also feel free to add my ACK to the $subject patch.

Thanks!
