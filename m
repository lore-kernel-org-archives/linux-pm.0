Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D569402432
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542364; cv=pass; b=gcazm4bv5oJ9RSkCg4+kYJ1/+m92+goeHXKH9QMq+bBkzx4KQar+8cVMtKCEQyYkQFZvpga4m2VpW7YMX2ZvhXk48+tNLbMx4hd4wCPxyybXpg8o2NRRgpWavYRZ6o01i8kVEpbiJsLYXWfraIdgIywv4C2ttYrXn5MfSe2twR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542364; c=relaxed/simple;
	bh=+1VIbwYlD5P6U8aunjd8muf/Soz0/OQ+HB4vCQY8XcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEj2ymjiA9xg0BQNE4M7i6GTuMobm8UbZcMnKrmcte1wTeNFT+s9VsdX5kE8rmphpqYtQxt6/DIa2Js2bQIT7zSSer7Sr4XllRxZKYswxuWZ/ES46dJI/3jUh+6QASTi3gA19/0SMGXygIUnOiqian+AtusSJmWJAWXunlsGF8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=byQbkAp2; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="byQbkAp2"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so146153766b.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 09:26:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542361; cv=none;
        d=google.com; s=arc-20240605;
        b=EaAq59f1LfD6moSZge1GYFX8qi1hAG6wCIeCaObwoN3OACHDSbDOmB9ldaVWY5VNNc
         I4e+KWpaS4T2PxRp2YlyOZyXz3Bwp4gy16jsf5ly+qsRz5WY3TmeB6Os15FVR1Hr2f7z
         atSSA9YYk30PgFhaKG7QfXYFGaihuRcMc1cSAwDRxGPDlCzMHSVi5YEZx+QCoBsDj5sV
         EtsfvLZM2LvYgxzOP8H5xcE3+lpAMHStEX1nYgZ0ecHYVfFds8/N1WoLHIfgEQZoJPX2
         Gu60AMJr4ERje0G5L5U5NdCJ+yq04/jm7a/RmggEe745oXRfB0n5/y1luDKLl8468ywY
         O4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8weEZ4/v1Q8ThZTOa9v3bW52mEvoKROcLFNZAFrpZyo=;
        fh=Q1vtQCWtfzV953GoeEq9mOknQceagpkdnDwR6vMLdPM=;
        b=KmFGTaYHJG0K8OGTT2kjBwnBBnBQ8sbCOM9gH3x1swGb6Pn4DHHrFsSU3PUgn4+Gxw
         cM/VFnjSPzLkmPTDfDhT31SiyMjXqzwhcv2yxR4ngySTHCKMgsbASinn8kpeRUceX3Qr
         W7PPQWWuAkXAFT9pM1wwWd0nFmYbCkLf7nC3zDLH1Hn++JGZ4U40FYzlMlmQ2BzdWuCF
         Y7AfZqxsqwOP09MDXeEe8DfYTkiK2mzx2d3LhqrRpINSArhm6QG0bOq5bEL+w0i+WHeg
         2WwaIJYPITKhb+dYWNAfgudPhbsA8Msoi8x6AjDURLgM4oVGsLZ7PgDxx+cTs5mdtu2n
         TnWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774542361; x=1775147161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8weEZ4/v1Q8ThZTOa9v3bW52mEvoKROcLFNZAFrpZyo=;
        b=byQbkAp2gXL9dtnx9R3g30En9cn9BNM2StZcVwrvid8YtA0Odn9evNZIGedXdDX0B+
         t2YNfmaTfMU5sBsKn8nkiO5QYRkN6P8mxI/rvIqgDCK3acg1ppiVcDGNS/JwSoWUjIrD
         3+qtygp3cFtUcsvPjPOEKiHOdZ58WgMXyC5+r2cK9F6kFbsjd9CGQ8K/mpvb6R7JxGHX
         APWBQbvKfydnPskVWm+v0L9amIdmQwif/HvEMaISJZNVyX5OIg3MvdhrD9y6jxRUSRhc
         Rfvt6LW01w+vev9+NMtTtWVEiiHjiW3LI46DIFgp+Beydm/5SLDyix9E84NZdi19sTAo
         gVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542361; x=1775147161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8weEZ4/v1Q8ThZTOa9v3bW52mEvoKROcLFNZAFrpZyo=;
        b=KxGdF0MrWcyoOwcrrXBzSek/q8Ptr9TzWdpXymwrgaAQvBfXzIWL9IJjvNk8guzdpQ
         1MWSEGp48aknM3rMy9j8oKd472bFMb/4rV1bClbp5aPX4xhR9pY/jQfzSEFMWVPmxnKM
         y5PxhHbpj+O5dZdSZoHL7UObI7oGkNKko3jof7ieUf/SkL4ujSS60r8xxSjJMByki/Qf
         Rr4AsU5ZQfVlS+klJp49mvj6vAJ8KMS32hRq2sf2Jn2N52oLEmHjvxSAQXZZZ1vY8gaC
         HsCYlZI1ELi6PsIGtMLSuWiSSF+HGv4Cf7taYchmPnMxG6Sv/j88fEYjsMHT3FsXxY0D
         VzwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvxTKXZTgy6TRAARV4Fo7kRnypEjHjNxootXRY3OmUnSuH57OmPJOha16dyomdmW1YQEB6/9fxig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7dOatO4ILpbHXT42Yl3xeSmm31IsJjje9WxuM1xVk96ayQLLN
	dj6KttdpZ57XOKpGd2hIVP3SdDAUD/PdmpoST7HVtL5jVbvT16rmtLYNh24+gxMUvCY/hhC5tbD
	Qr0J5taeF5Q4/3CF2fnWUJXZWbYxAocsQ7mRn4ECb
X-Gm-Gg: ATEYQzy8HlY9+VtQhBuftmdZuE48P+QskcNI1Bg0DVC9BZ3RFXa3iOjXRmo6WlpCGby
	GTxfodZnduL2Dg9/jh/cuZTAHC6h+VjD+pkUD6KoVC+F0+C5chqliE0Ny+iAewE1cZuCc60ckZa
	IARUoALH2BMrMrxDMKJnYlerBi3ummwZ4O/O8EGdhKVKDjESPUj1dthW3rX+UJYLPKQ4WU2ulDr
	uxiABVB4av1uiF/sS93QlRsIXuuJtDWQ206hpKQrqX2LzEHrU0rD00sRtFLgwqAtyOEUnJ3gbPE
	76Voa6feQhtLj/BayVL9bIciFisqWAs2WEr4
X-Received: by 2002:a17:907:7fa9:b0:b87:173f:61b with SMTP id
 a640c23a62f3a-b9b348a060emr151018566b.9.1774542361098; Thu, 26 Mar 2026
 09:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326112521.2827500-1-wusamuel@google.com> <m2v7eig4ue.fsf@kernel.org>
 <CAP01T74KNVT2SVRR+XPbFb1vy85W=Jkp4_yD6xvTSg2avQo8AQ@mail.gmail.com> <CAADnVQK252XxmxM3enS4wPREshTEawQKbChgN-teX3+wmxgdBQ@mail.gmail.com>
In-Reply-To: <CAADnVQK252XxmxM3enS4wPREshTEawQKbChgN-teX3+wmxgdBQ@mail.gmail.com>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 26 Mar 2026 09:25:49 -0700
X-Gm-Features: AQROBzDpxR80sNDZIp7I-1jwQ56Npkte6GZeWCLG3T-hio_UtCQbkOqHje_ZuUg
Message-ID: <CAG2Kctqd4p4pJtH=tSfKT57qfecQrpcoYu3SsAzJ-zGEiYVSQA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Support BPF traversal of wakeup sources
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
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

On Thu, Mar 26, 2026 at 8:02=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 26, 2026 at 7:54=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Thu, 26 Mar 2026 at 13:20, Puranjay Mohan <puranjay@kernel.org> wrot=
e:
> > >
> > > Samuel Wu <wusamuel@google.com> writes:
> > >
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
> > > > traverse the wakeup sources list. The head address of wakeup_source=
s can
> > > > safely be resolved through BPF helper functions or variable attribu=
tes.
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
> > > I left some inline comments on patch 1, but the high level concern is
> > > that encoding the SRCU index into a fake pointer to get KF_ACQUIRE/
> > > KF_RELEASE tracking is working against the verifier rather than with =
it.
> > > Nothing actually prevents a BPF program from walking the list without
> > > the lock, and the whole pointer encoding trick goes away if this is d=
one
> > > as an open-coded iterator instead.
> >
> > Which is fine, the critical section is only doing CO-RE accesses, and
> > the SRCU lock is just to be able to read things in a valid state while
> > walking the list. It is all best-effort.
> > Open coded iterators was already explored as an option in earlier
> > iterations of the series and discarded as no-go.
>
> kinda best-effort...
> the way it's written bpf_wakeup_sources_get_head() returns
> trusted list_head. It's then core-read-ed anyway.
> Ideally it should be trusted only within that srcu CS
> and invalidated by the verifier similar to KF_RCU_PROTECTED,
> but that's bigger task.
> Instead let's make bpf_wakeup_sources_get_head() return 'void *',
> so it's clearly untrusted.

Thanks all for the fruitful discussion; this is more rigorous. I'll
update v3 so that `bpf_wakeup_sources_get_head()`'s return type is
`void *` and I can add a corresponding selftest that directly
dereferences the head and expects a verifier failure.
