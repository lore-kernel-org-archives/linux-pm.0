Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28CA385D72
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706235; cv=pass; b=E/X7NmTg9JAYA1Y5H/ztYGpv+4pngx/Pb+Zuot8kUZVrk0LsxPNZtyOOmiGINhLwHp8/jMs21RTYUrzd+f5SCl0pKPNHslaeJqMbJaIanjHnbZlLiwewpWXT9m0ylzJR9LK8oBCZORHHrD7dV7o3OTyN/STa2XmjK62v1At0Xyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706235; c=relaxed/simple;
	bh=Ak9QebyPplmvEVZxfnV5E+i53CeeU7rfM7MEpmPpjGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHv7BMP5hUu1Wl83guaaCaT3Ot6fljOwMOLLg+NaPKQaMWFZN5t8zBPJv2vuNQfG6bdko0E4wEWHzlcyu3X2oEAxaaKCHpD0057zw2R3xJXmTCb6kzby+WgGztJj9j0c2PUG154SchtJzvPczg9OIQ3M4E5AoPHpXVvxZTgcsG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcVX9y5c; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcVX9y5c"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so6736658f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 14:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778706232; cv=none;
        d=google.com; s=arc-20240605;
        b=VMD5qGCfijp50/PpYHmAEHtE9SMIkV9FCKit86LHjiGQ4fpfllehxcOTBycCgaWsVt
         q1Apf38tS9QO5/USrvlmJjmUkYqIn44kb/NbCWUqfAhUvBiWoxGQzHwtxHrZVwfqz+pL
         lluFUPXhrnr6kPht+TvCKivIj9At6T29Tm87RfBzMnyX+BRzNphfBav9AzXLDFEgPmcH
         WpbKtea+5+rK5k5fObTjbFXtOtc7xOsreDq0E7kbdJ6zfH6g/FVzQCwNocSeu6enTTUQ
         zQC4kxivy7uDlKGRdWhbbwIWmzTora4INXplh97JjdlFqMYUtyEHsxj5s3wuYzXP/nYV
         i2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=11Jb0dd2cFuHeuXRLOYq2HD+pUqkjW/pEpvn5zyVRwI=;
        fh=K0vxZbwec3t+Eue0ix63t48cDGEqyG8GaHU6WbK8ajE=;
        b=j/w4qmbkk3gFCCXXabgELmNThXAcQH4qm/9VqrpHbh/SfIfEn8fiK5AXgCzPJ5YV1P
         PN+ZsQsyxyopC5i/9t8+T+UttsUywiqluovVoEQwd3V9gtM0r/imOctfmVm56EWEZEQb
         nXbPoWB22uNB7PxO57mW6LGi8eglrpuURn17bqTD3pYaO3jXVPtCdWAB8NfV4Bf2+DZ6
         5IwzcrXozXstkmOUrFBJAoi6FxtvRMsOr30B9tT+bxdzLBoGR8cvW4/rBvluIfyLxpT0
         zOlMtvapN/eNGv2WvOXiILJJMK1sTi935D18tuHn7jt7qbVEfyBSIM6KhqYe2wJ0PHfS
         VyzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778706232; x=1779311032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11Jb0dd2cFuHeuXRLOYq2HD+pUqkjW/pEpvn5zyVRwI=;
        b=HcVX9y5c47XWvgjfriKRUdvHTr8ETHDVDz0P1dnyPvS2r2mGIk9fTZJ6THBnxelHHd
         uU3m1Ai1ziyUb//eDySpqpncwCj3NPi9Odvbz8qYPlEdCHBgXw7/frR2sNMI+IMTDl/u
         jwukpNw/KmLQhQbqY4NqaxcE65XnrohvX8vt3IV6360EHTErMpMBGu0qr7cCo7FKXtj0
         EguRmnlJiwEUEHCcs9KqGle8j/9CGhq059T8XV3MUsVRlQppGWxkNeNmIWNd0oIjfmPh
         +z3jzpoVp8uBw42iOpuedHezYQjyM+gTZ57rJVWh+JMqslRL6hXXfmOOYEFTT6cguTq+
         sgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778706232; x=1779311032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=11Jb0dd2cFuHeuXRLOYq2HD+pUqkjW/pEpvn5zyVRwI=;
        b=cviZLSMZZDOyxzX3u6VtLQhXwbdEgK8yYmGhyEnMBo/Dm2uCXeeshCKVH0sQhBXNGY
         FIqrgd8wrpP8D7HM5UgJjvS5cS/10fOBEhrXvtHr53lE1LYjjZHEydoTdKgMfvU6jCU0
         rNO6H6Ov7cz7hJ/uK2fCgwnh2DB1lc0zSClrUSHnajIKVMp80kK+LUDJDvOg+DlJV7z3
         dVzLraSFKEmXXskFuLjFHe2gHC7AjTXc2lXq5BfyjemcZXWoLYxd46AcSrqXD2Qri8Za
         y0cvs5Tz+mGs4zkz8E6WKYKhFB4agraMMw9r0Viy7tnfAcCkJ3OyI0QtFFYIPdSt+xrM
         D73A==
X-Forwarded-Encrypted: i=1; AFNElJ+zocwTtv+GxelrLyxs224+n0MMuxFWRUtjMCmrOQmHM94iyfJyzld/MA6fFbDot3dup6sYk6s4yg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2m2Gw2usdo4faMWELKn93EjQe/DS3Y2YrXYLBAV5Dw6BwK738
	RiY8Ee9QnpH0CPP0131m2lsUOro5G2910AMnByaujwrWTO+8BBzmfxeo1shETBbtZqltFEit8wK
	oKTy57R45GSHjNohGZMEa60D9F5IJKio=
X-Gm-Gg: Acq92OF7trLN4vF1DJCA6fr7gaY/U6blXFKqzoJHSIENhcHFvunkvfpc2bjF/Ss6leW
	T6xha7voaBq6pM8+qfh31Gl8mzadakZ37tDlsJJKST9DciPaUstYo5nRmn5FGtZ7dLb/7BCCFsW
	7gatUIIJn5Aqkx6rJvLsgYi3DJUQtb/tND2wvXGvpxg6bvYwcYpkpfjGijyUg/J+001o7PJ5czq
	s1JCyi+7HrRQcbinNi0msyWCbibwAjAEhDyTTvbetCQpyBEfiaBOb5L1s1SDTeYkJR/HjpPLb4A
	P8cxRnZoQ9JVgY0ThdZz0SYLOSMepEA3c7/ZskkNsHaTR+HptyiKFkt8Pt12I/e4Kw9xqkW//vi
	sJb5gogUETO/q12vlX6hdl7Vhhg==
X-Received: by 2002:a5d:5f51:0:b0:453:f951:4e5b with SMTP id
 ffacd0b85a97d-45c584a86acmr8273177f8f.13.1778706231832; Wed, 13 May 2026
 14:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511174559.659782-1-wusamuel@google.com> <CAP01T74KQ6bie5o++i_gHM19J+s2RzDyM6=w87=oUZgPagPejw@mail.gmail.com>
 <CAADnVQJtuKQh-bpDDeqWCQRM1zb2sSgo0qET_+1+JFOL-6cpDg@mail.gmail.com> <CAJZ5v0hqdyMnBtvvo7RwUkh5saLvAHkTEVz8Ln09UaKMqoP=Dg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hqdyMnBtvvo7RwUkh5saLvAHkTEVz8Ln09UaKMqoP=Dg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 13 May 2026 14:03:39 -0700
X-Gm-Features: AVHnY4JXZcwxzcwywRgvFsuXdvDflXIGcM__yxtCZ9WZk-JETjoc5UQtPM5_vFs
Message-ID: <CAADnVQLvuCKLUHnxcEx2+t4diLmuOb9VSthoDea5iktsAZxhTg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Support BPF traversal of wakeup sources
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Samuel Wu <wusamuel@google.com>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
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

On Wed, May 13, 2026 at 12:52=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Wed, May 13, 2026 at 2:51=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, May 11, 2026 at 1:44=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Mon, 11 May 2026 at 19:50, Samuel Wu <wusamuel@google.com> wrote:
> > > >
> > > > This patchset adds requisite kfuncs for BPF programs to safely trav=
erse
> > > > wakeup_sources, and puts a config flag around the sysfs interface.
> > > >
> > > > Currently, a traversal of wakeup sources require going through
> > > > /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls t=
o query
> > > > sysfs is inefficient, as there can be hundreds of wakeup_sources, w=
ith each
> > > > wakeup source also having multiple attributes. debugfs is unstable =
and
> > > > insecure.
> > > >
> > > > Adding kfuncs to lock/unlock wakeup sources allows BPF program to s=
afely
> > > > traverse the wakeup sources list, and a kfunc to get head of wakeup
> > > > sources list is needed to start traversing the list.
> > > >
> > > > On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~=
34x
> > > > speedup (sampled 75 times in table below). For a device under load,=
 the
> > > > speedup is greater.
> > > > +-------+----+----------+----------+
> > > > |       | n  | AVG (ms) | STD (ms) |
> > > > +-------+----+----------+----------+
> > > > | sysfs | 75 | 44.9     | 12.6     |
> > > > +-------+----+----------+----------+
> > > > | BPF   | 75 | 1.3      | 0.7      |
> > > > +-------+----+----------+----------+
> > > >
> > > > The initial attempts for BPF traversal of wakeup_sources was with B=
PF
> > > > iterators [1]. However, BPF already allows for traversing of a simp=
le list
> > > > with bpf_for(), and this current patchset has the added benefit of =
being
> > > > ~2-3x more performant than BPF iterators.
> > >
> > > This looks good to me, you can add for the set:
> > > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> >
> > Rafael,
> > how do you want to route it?
> >
> > If you ack it we can take it into bpf-next.
>
> I guess if someone really wants this, I have no particular reason to
> object, so please feel free to add
>
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>
> to the first patch.
>
> > I'd think patch 1 shouldn't conflict with other 'wakeup' changes.
>
> Sure, there are none ATM anyway.

Thanks!

Greg,
are you ok with it too?
I hear your api concerns, but imo it's a nice improvement.
And bpf is not a stable interface despite some sceptics saying otherwise.
Just see how much sched-ext api surface has changed.

So if pm:wakeup folks need to tweak it later they're certainly
free to do it. Of course, it's better to keep things backward compact
and deprecate gradually. All options in developer's hands.
