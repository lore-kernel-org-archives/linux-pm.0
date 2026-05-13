Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C203AF67F
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778701965; cv=none; b=t85E23GkpamOHq+43FP68BHFJ+bADrif1IHQ2Wwasx6tdJFqZ//2dOJfgU72Ht70xP/zDXfKMPX5KkoV5ug0nxh0I7BiWfp+JYxT5p6UX4Vbb9K3K6j4cJs2cjvquZhjqwsrJbINtRNbVHbD1a7ekgiD5RxUFTkvtG4u4sz9K5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778701965; c=relaxed/simple;
	bh=xBRPX/Dfojxagl7fZvimMhfqlgUmbDz+PjfCGyhfbT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwZXY6SJWAv57mZ16WijpkyU/lxzv0V5vhaK4UzfUUtvDXLjmkVvFp7i9p05u4eoHAqET61rmfZqJtBLhMU4uFlwvQvw20Uw7hbxBXZpgHn38N9u2YYXdVGXAwaxqgjahOK2fDD42ScJ1FRsC8vmJIE7SqS2bPtQVGFQN/JUIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhXiTBfD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhXiTBfD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FC8C19425
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 19:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778701964;
	bh=xBRPX/Dfojxagl7fZvimMhfqlgUmbDz+PjfCGyhfbT0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AhXiTBfDu63RgeX0ZPQZp5HzQtNlaR96YvSwQeHom3/3OZISPFHKHez4ljM4ldAp3
	 msN4zoZvt84NAn8P8WrIIqFjp44nF6PjNnO5RYfdjA5aH3xEnTvPj5JeiKSP2HFEFD
	 78BkYoM0pKTt9vsgVamMI3J47nTWRUzO27IB+BSHFdNcLwyHS59t9PrZee22E+PDxm
	 TLOf1EBKNXzC6yF95cOULO3cuBKM0iP4tEWODWwr/F1CJZLYjStxSzau/N0tJZ5SOz
	 HhWKyF+ndSUXJKtmyWVQ8+IPMSi05d2dzEmSyQljXu81XjMNQb4UvO3g4v9DOX5bSP
	 qN3WXqGDrWM5Q==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a88db610ccso8540793e87.2
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 12:52:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9o7GW2Xsl2wNNBiBn8e9/FODYm1RXIEGINcbiIubXawTSfprzDAekBdZthGJ71fyBN/oZlw20qXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyV9uQz5++NHr6arHBKyiwjlT0qIdxKbpgt3Wc6jM09s6KJO+aG
	N01a8M2fX2CFq3bxnLuQfsPGfiIQgLBVzU9rlJ5vBIXf0nuYi7Qr9ceOT0LE4dI4PdMK9G8tG1r
	gkOMEgD00WVs2Abd/Gi8ttthzJOx5FPU=
X-Received: by 2002:a05:6512:2397:b0:5a7:470c:daed with SMTP id
 2adb3069b0e04-5a8ef979ad1mr1519384e87.16.1778701962988; Wed, 13 May 2026
 12:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511174559.659782-1-wusamuel@google.com> <CAP01T74KQ6bie5o++i_gHM19J+s2RzDyM6=w87=oUZgPagPejw@mail.gmail.com>
 <CAADnVQJtuKQh-bpDDeqWCQRM1zb2sSgo0qET_+1+JFOL-6cpDg@mail.gmail.com>
In-Reply-To: <CAADnVQJtuKQh-bpDDeqWCQRM1zb2sSgo0qET_+1+JFOL-6cpDg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 May 2026 21:52:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hqdyMnBtvvo7RwUkh5saLvAHkTEVz8Ln09UaKMqoP=Dg@mail.gmail.com>
X-Gm-Features: AVHnY4LmM8Vv_OoKGu6J_Ex4o-83kMNCI18g9TG-3cwnjduMTe-j6feES7nw_ic
Message-ID: <CAJZ5v0hqdyMnBtvvo7RwUkh5saLvAHkTEVz8Ln09UaKMqoP=Dg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Support BPF traversal of wakeup sources
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Samuel Wu <wusamuel@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Android Kernel Team <kernel-team@android.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 2:51=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 11, 2026 at 1:44=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Mon, 11 May 2026 at 19:50, Samuel Wu <wusamuel@google.com> wrote:
> > >
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
> > > traverse the wakeup sources list, and a kfunc to get head of wakeup
> > > sources list is needed to start traversing the list.
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
> > This looks good to me, you can add for the set:
> > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> Rafael,
> how do you want to route it?
>
> If you ack it we can take it into bpf-next.

I guess if someone really wants this, I have no particular reason to
object, so please feel free to add

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

to the first patch.

> I'd think patch 1 shouldn't conflict with other 'wakeup' changes.

Sure, there are none ATM anyway.

Thanks!
