Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581B13A3E97
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773743186; cv=none; b=f1NEbdShAghP32BV8KOneDBl//VIavRdu78Ck8RwZxiQw6ChRtMbX6J+dKZZNMHKZoMs4DVewiq1XvqbiI30pi9nH5sSMxPoiKuqNCtvq+u38z/8RUQk09o+Bompp++c978yy/Sw5SnSBNq9YxgpU5sw/qPnIK4X4r5V1AncFUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773743186; c=relaxed/simple;
	bh=CF+WDLRjvC4gqhgTSemAAUMIWp0S77QLL+9wiaDVsqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6j2tlHR94dqDNB0sqrw3fpjXwCCuZJhrb6J0v8esmmx30yBayV5l3KzlI2H2RB5KfLoxjLEOKjhCHVupoyMfpuk0K7Q5XOWpHu1XYr04ySr6PFpYeu9AeXNiS6pRYgCkZ7XtRbVpcKvl8xaDWdTsdH7IVsaXmLUki7z7513AgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyyiSrIn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyyiSrIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A373C2BCB7
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 10:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773743186;
	bh=CF+WDLRjvC4gqhgTSemAAUMIWp0S77QLL+9wiaDVsqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cyyiSrInBpzv2xYkIrLDr/ohj02N6OIVNYsIGuU5vyfAX8L+1UZjDzpO05bnhTsUb
	 HLz9DeBGG4Wkv2fKYtEOzv2VBegxWt/kJjHFzV5Nh9pcNP/gZqBgYz7tDU1Z4ZUJrC
	 4mEgucFOTteNHbhN3JtpRwX4qFtf6eyy54aIAXWJ4frileuTx3bCWxYedjEda/bR//
	 rNIsz8NQCk8y4rxDFxtmJEVcq7Fh3OqZp8hNSTQEGXaDdlN+wWvL/Mys46KYB8iNAG
	 IXL6Upe5M0TFotl+Sj83MVc69BOOakBuaoI7OrPIBrudXpzjHnMU1sMdrZ4iV10wwL
	 +f/fskylh8flw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4094b31a037so3559052fac.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 03:26:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVGYYFj+7QwUWWzJth6B4gW9QQpDDzK22BJO40ttQmDT4fsI7OvNP/yMHsLFE920IgfshroLLkZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCT/eUKKi8eZchNYOafZygRkZeDrXshe/yJgWrt+wp1Y2OwJrn
	Q1xN81kjjumeBVXUA+3ZsOTnJ2OShQkFufMCumWrW1qp360218lThi5F/Q4x4p4r0nAdMKMWiuv
	OSXx4UJplIWAYOD1AYnYJCzj3Y9dkgaI=
X-Received: by 2002:a05:6871:e708:b0:40e:95b9:40f3 with SMTP id
 586e51a60fabf-417b946c48fmr10483597fac.39.1773743184968; Tue, 17 Mar 2026
 03:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210115458.3493646-1-zhenglifeng1@huawei.com>
 <javy6tllyw7pcnri3s6s2gnpv3kewe2b4zkyoz3vj3jzmfu6c5@nikhlydadvcc>
 <CAJZ5v0h1FHH0Cvn0CQ8gMk9Zzt=bcA-RUfya4hYH4Em3nDzm7w@mail.gmail.com>
 <d21b9ad3-72d9-44b2-b194-4e2a24077eab@huawei.com> <utvxk3rn6icadx4llmzfu32auqk4ql7rckh7kxtgdgmtoyovqz@vo2lmhip5vk7>
 <b7d3819f-168a-48f7-99f2-2ba04dec77e6@huawei.com> <dqyn4dv3ecbzzmqr4l3jxfctuxpehstjhean5gi2iqfllwso4g@i4nodkyrhwpb>
 <8f29a0ce-4cbd-4c47-b866-b4f015f0792b@huawei.com> <swdjuguqfniecaqxgdjwihjieiwdzxjv3vq2agq5sbd5kcftuz@qwzhr43ydzxy>
 <08b96039-e31e-4278-8077-1f1b7c244f3d@huawei.com> <uo46emkyvpr4lzvnbdlkcgdrkvdzolkwuiqqey3pu3j3qqrbqz@z5ezeqhowy5a>
 <214213f5-6932-4ac7-8d4c-e4a994622890@huawei.com>
In-Reply-To: <214213f5-6932-4ac7-8d4c-e4a994622890@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 17 Mar 2026 11:26:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0if9y5q67ATvG-HRsCXzUA1CLzZ5735FrgpEkM+2Rd+5A@mail.gmail.com>
X-Gm-Features: AaiRm52P0w9g2Zu5dLRUIKfNcQg8Z396Bb9SCMrTv8gaCQnPGX6GVR3x24dPY88
Message-ID: <CAJZ5v0if9y5q67ATvG-HRsCXzUA1CLzZ5735FrgpEkM+2Rd+5A@mail.gmail.com>
Subject: Re: [PATCH 0/2] cpufreq: governor: Apply limits with target_freq
 instead of policy->cur
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com, 
	yubowen8@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com, 
	linhongye@h-partners.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 9:26=E2=80=AFAM zhenglifeng (A) <zhenglifeng1@huawe=
i.com> wrote:
>
> On 3/17/2026 2:20 PM, Viresh Kumar wrote:
> > On 13-03-26, 18:12, zhenglifeng (A) wrote:
> >> Let's forget what happens on our platform. The current discussion is n=
o
> >> longer about applying this patchset. What I really want to discuss are=
 two
> >> questions:
> >>
> >> 1. Is the platform allowed to adjust to frequencies out of the limits?
> >>
> >> My answer is YES. policy->min and policy->max can be modified by the u=
ser.
> >> policy->min can even be increased to be as large as policy->max. Howev=
er,
> >> due to some other limitations(temperature, power, current etc.), the
> >> platform sometimes has to (secretly as you say) reduce the actual
> >> frequency, inevitably falling below the OS's frequency limits.
> >
> > It is fine if you want to do that, just that you should use OS to make =
that
> > change.
> > - Update freq table to contain all valid frequencies (1/4 of min in you=
 case).
> > - Update policy->min to current min, so you don't go to those low frequ=
encies.
> > - Use freq qos or sysfs to change min/max when you want to go really lo=
w, like
> >   1/4 of min.
> >
> >> I believe
> >> this situation will occur not only on our platform. The OS should not =
treat
> >> this situation as an anomaly, and leading to unpredictable behavior. T=
he OS
> >> should have the ability to self-regulate. I believe that your patch is=
 for
> >> this purpose.
> >
> > When the OS is kept in the dark about such a change, it needs to figure=
 out a
> > way to get back. That's all we are trying here.
>
> I see. Then I think the point is how to let OS know when hardware change =
the
> frequency. It's worth thinking about.

An interrupt needs to trigger and then it depends.  On systems with
ACPI the OS will get a notification on the processor object, for
example.
