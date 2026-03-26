Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FDE2F5A34
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537335; cv=pass; b=pquBfMV9wAV8dw1QCLehpKtQu52LiU5p45bPnxEGyJlnGDZnbymuT6CkFFEpT+pD1BGMeg8B4CL1Idt16Bba5LwiOIcU4E7nk2n26PW54iZ9nGDx6EtzG33bLhwnY5ZNrGaI75cc0lAzPN5fRvYxzprUGA6sVclM0Z5xUN4VBVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537335; c=relaxed/simple;
	bh=fQBoj1TH90YinvX7tOqOMb4BmPMJ09nlNwkXs74qpl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/NxK8NdalaJ1/t0F7vvBG+pDQ+xpfrrd/zCoBqfWfSoHfJu9ug3Quv9u5J+NVUym0ZXJIHaGNI+Mr939URXlW2Oq7uinz3mR6B13ek1ApmaqTYvyShj/wRC/+BoHeWo2ynwzVAW3kZQIS/J0Jdz4EnsSzmi73IIt7gVq1sfY0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UK3s+lPl; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UK3s+lPl"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so1655315f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 08:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774537332; cv=none;
        d=google.com; s=arc-20240605;
        b=FeJm3BDfL/UHL96MdPKxJZ9k5pYB0g0KqBnMaLNiJWBZz8gkQQG6YV0c6z14xJA5Rj
         HM7zcgg4d2nsP42zceP3DcwYbU78No8xHthepHKVq8Z4vyivBdmzksDS4mUgZpp/9zP9
         2CXjKghDTs8XJjC2H9Ni7RP7O2cE6PwOAA1ZHtaZDy6hbCHuH7w9BkSkjI6vFIvr3Bad
         aufHmA6qXYtbYEYGcsxfUNhizzu1DtQe1xxFq0QaRKfuR0XN+p3TZqfpmxcn440Gu7QX
         TDQJ+o601/PoHrX6GAHqhxbelpdON1c/QeZgBI+ZvLMlzU5e9svCxwmz4NaVOT2OfnCw
         ZBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u/Sf6wOkMweWv83xQm9DiuxVskt6+OUeojXwOwVW50E=;
        fh=qdu3lERdaPtr/uLNweZEFBqG71BK2HCIwRfuRJBs9Lw=;
        b=gJk8EYZkl8oL43tFuBQUxckIAL/bmDrJBHXYKDvqQEJrVZ9HBaksVqEytpPySaXsC1
         QB9GppTRsmwWoiO2FO8OQCgWceZJUiOZCyQ2mahsSnEWNOtbWKY907ehBO5zbE2DotbD
         RApzrph46pgG1hcr08fpTKu2SudzXRwXH/TmVEZd7YHzlA/Duy73RHTom6bmtut4z5w3
         9o9m3VOUvUNOLP5WdwF1duylchLCnfsMfDNzjtTCGSablfuW8ewfl7mBQeOc7ErR+iE6
         kcio5H0V1HUbL7CWO/ILU7ImxufgLJopcd1inyMeTRonIjpy4Vhtg00InIjM+VLDtOqp
         7Mkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774537332; x=1775142132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/Sf6wOkMweWv83xQm9DiuxVskt6+OUeojXwOwVW50E=;
        b=UK3s+lPlD9MYqLbq2XqOb1LxIBTr7cQc3F+6Gvs2+Q3tcGDYwgES+sAUQc3pohNKup
         NgxgItPP7kiMQQZCAVtjB1OTiLYbWvEj78uVJxEX7VFAJvjHjVg2I/2reW6reU1/0T4b
         0+UGSHLyiqGsDDyTbwItbuk7keXVbLJCE4PlW6gYWUKCo0Y4p2Q7qoBFGLkvX2MflY5T
         IcESzn6fAePJgfWulOELBEBfVPD2OG62+rNc8giuMNIqCS/N4+eLEf2XQWz8XPHjV+vn
         EvnhCjcUl2QeEbjdCDSAaaFRmClBkKiVP2tNR2ViQmRLhE5qkVqd7duYgudQQyEWYww/
         KxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774537332; x=1775142132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u/Sf6wOkMweWv83xQm9DiuxVskt6+OUeojXwOwVW50E=;
        b=Yew/+jvFty+MenMQPPOw1Mqyp5yO07Ix4dzpXsjxEtYZrKyS9qOFa1PHlhNceKKT/L
         a5KByXw+G6fqTROcAK8yseb+f3Uf3IecpPuJE39Ula25lSr38cd0lp5hnGaYxyCwOPtX
         B8eSlaqLamgX/XhROadaJ0u/Itb8hSj9azOIaPmj700tWy2yLW6Y+6YZOCuIkMfNjDza
         DWcM37R0ScgOC4SkXdN2y9E60dtf4j4S/XlMEAJXQ5Lv3etQ+uLw9waYBKyhPQ4Rie8J
         feX/uHIiBIoiTmFy18kWzBITozdoYu45er3r8mBbeZEu1FHQVAGz7VF/EzEI1C6BqOq1
         do4w==
X-Forwarded-Encrypted: i=1; AJvYcCURgqISYmG2+yIXRztd8lgMj2bdqsLgTWQ6mEihbGb+hfOQUxfF/+pQ+dGvQwssMld3qPghvjhZ1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7wNxqwk+eHErd7156VKvK3HkZTKfGwFY5fiUdqBqIATnzAYFc
	wyizBEC8rYXRGWHTHbxQj+zrnNofg/8QTLXvxJDZ05WY9Yt7jSqFCJPvo01s59065Z80MBDbEgl
	y/bEWlD2749Q9gkKT0zYV6XEeQfssXuM=
X-Gm-Gg: ATEYQzz8AvsdY3VRrfkua0La5Hg9iVyiMrMJDuc2NVJb2FJjmJFVwJniBMRUNJCsHvD
	Ozlcqm8Uj3KmlwGa9lJw4Yr11Q2tOlO9nax858SCvrbX4mzBhHmgA0orbu7Ucd3RczrT/BwBg/4
	re4H86ZXJ+oiaGpSDE8jjDB9rlQrnRq7vpkYRBB5aY9T7jXdQ5bVKPL64xzLyHuLOn80zuxQUGD
	YrqsEzS+ifLTyfSjKnSCeLHXrH0sg3yYHHTukLRMYXfcSZfrCI8w9599B7AaSQxO/W0ib0Yg9an
	bL7/IMWsbAAGL3A2QT+lDp/jjzpsT0/iYsmsZIkjjjMPREOFMaM3ha9baS4IOeDvug9DgAzhxT3
	2/h6Dd4ae
X-Received: by 2002:a05:6000:1848:b0:43b:9687:620a with SMTP id
 ffacd0b85a97d-43b979fc0fdmr3667446f8f.5.1774537331511; Thu, 26 Mar 2026
 08:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326112521.2827500-1-wusamuel@google.com> <m2v7eig4ue.fsf@kernel.org>
 <CAP01T74KNVT2SVRR+XPbFb1vy85W=Jkp4_yD6xvTSg2avQo8AQ@mail.gmail.com>
In-Reply-To: <CAP01T74KNVT2SVRR+XPbFb1vy85W=Jkp4_yD6xvTSg2avQo8AQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 26 Mar 2026 08:01:59 -0700
X-Gm-Features: AQROBzCGtnU5-dOrxHATP1abxYAIKp7uD_DNHv2-zLG2AdZOG74ShatkiLTI8Ko
Message-ID: <CAADnVQK252XxmxM3enS4wPREshTEawQKbChgN-teX3+wmxgdBQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Support BPF traversal of wakeup sources
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, Samuel Wu <wusamuel@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Android Kernel Team <kernel-team@android.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 7:54=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, 26 Mar 2026 at 13:20, Puranjay Mohan <puranjay@kernel.org> wrote:
> >
> > Samuel Wu <wusamuel@google.com> writes:
> >
> > > This patchset adds requisite kfuncs for BPF programs to safely traver=
se
> > > wakeup_sources, and puts a config flag around the sysfs interface.
> > >
> > > Currently, a traversal of wakeup sources require going through
> > > /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to =
query
> > > sysfs is inefficient, as there can be hundreds of wakeup_sources, wit=
h each
> > > wakeup source also having multiple attributes. debugfs is unstable an=
d
> > > insecure.
> > >
> > > Adding kfuncs to lock/unlock wakeup sources allows BPF program to saf=
ely
> > > traverse the wakeup sources list. The head address of wakeup_sources =
can
> > > safely be resolved through BPF helper functions or variable attribute=
s.
> > >
> > > On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~34=
x
> > > speedup (sampled 75 times in table below). For a device under load, t=
he
> > > speedup is greater.
> > > +-------+----+----------+----------+
> > > |       | n  | AVG (ms) | STD (ms) |
> > > +-------+----+----------+----------+
> > > | sysfs | 75 | 44.9     | 12.6     |
> > > +-------+----+----------+----------+
> > > | BPF   | 75 | 1.3      | 0.7      |
> > > +-------+----+----------+----------+
> > >
> > > The initial attempts for BPF traversal of wakeup_sources was with BPF
> > > iterators [1]. However, BPF already allows for traversing of a simple=
 list
> > > with bpf_for(), and this current patchset has the added benefit of be=
ing
> > > ~2-3x more performant than BPF iterators.
> >
> > I left some inline comments on patch 1, but the high level concern is
> > that encoding the SRCU index into a fake pointer to get KF_ACQUIRE/
> > KF_RELEASE tracking is working against the verifier rather than with it=
.
> > Nothing actually prevents a BPF program from walking the list without
> > the lock, and the whole pointer encoding trick goes away if this is don=
e
> > as an open-coded iterator instead.
>
> Which is fine, the critical section is only doing CO-RE accesses, and
> the SRCU lock is just to be able to read things in a valid state while
> walking the list. It is all best-effort.
> Open coded iterators was already explored as an option in earlier
> iterations of the series and discarded as no-go.

kinda best-effort...
the way it's written bpf_wakeup_sources_get_head() returns
trusted list_head. It's then core-read-ed anyway.
Ideally it should be trusted only within that srcu CS
and invalidated by the verifier similar to KF_RCU_PROTECTED,
but that's bigger task.
Instead let's make bpf_wakeup_sources_get_head() return 'void *',
so it's clearly untrusted.
