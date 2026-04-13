Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13554393DE2
	for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776112773; cv=pass; b=AvygfddvT7v5svbKUd13VyUC0w0c9l++6kKnitbEXaL1F4LPhQF0a9jJyW9UyUTQu6lCv3hhWsklVc6CoU0B4hjpZVn8IHWLfmsPtexkEH+kXaabxcB0TKBrpRV+3InxbJcXeaa5ZvfZv4ru2Qkc76cd+BXYc4EqO8NWzB3Km2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776112773; c=relaxed/simple;
	bh=PEZjoZa12UUj5SyO1b3BkdxKCeo86DiqtO9Y9tXDXgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BAL5++W04BTrTHhwSe69U3mNZ1uB34PhZvS+snY5V3bTESAASKRlscdse6YwMJuLD85VgLVjyUa0Q12H4u4ukCQQRNu+7AaTDVppv1HLL6GCoi55BHDKtf5VDxpaEihqtSwe+tm13c6OiQUGUKfmpv4p7IN0rrDJUS3h8gLuS5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AYuEVTNO; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYuEVTNO"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8f9568e074so778484566b.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 13:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776112770; cv=none;
        d=google.com; s=arc-20240605;
        b=PS9VLCF0GcNAeNfdFGPlKMQJNWXly5SyJtKVgi7PXtRnuOGlA15O907fZRi8ItTFCz
         X1TPPo4pZDpso7os4g12YwE6C7nblYc0nJjMO0KnNBC3SYXHFbmstPxCh/hfYcWV521j
         chGRKRcGlwmAMAGON7pDcRkBSF3A6PCJDUI29YbFHAx2oxuZ9H0Z4KgIbbpb6Hx7e4GZ
         HN64ARo8jL5xDtD395V7p4CA5tNCZZe3Kk/Z4QQHtFgREKSjqpBcpUoJijbqyzcvSDJx
         guxlhKF0KJ4VBPXdHHeefSmRNuC1ZCrbAfbmyGzBxNLLNMAJOLdx2LZe6+99Gs1ICYZZ
         eqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TH4m/idJ4M3FjDEc3vL3oLYbFEZ5XJk9GPdaO6YXJ0Q=;
        fh=DSTu3ywptU15QqnPGSASg0Te8ksb/dMZiNT5ljRc0Xc=;
        b=OD9XHLUISD+A/rZ8Vxdhl8UiYj0QBROf8RDCjLKcdTM418vzVeMHwK0viZztHe/S7c
         s+IZUXplWtCdi8A2vCg0hGegS/eNHyz7Jg8N07V5S6FZAikbphDBmW/dlkYg0Ej4HE2L
         BnrAXfSxguZ7CHXIZ2mhSO84bKO+0/dEgVCYpu6Hi1SMjKjyTEy9JQfVtAQLp2ZEki1W
         bE2SFix7ZJrwchaUOj05QdaCQAGWtfreQmzJpCESnFADkTzPYGEVjI4fNDA5rjY+hN3O
         SId3CrKEiKiD6jThENIjn8PFS0ZqluFzaAFQzfmYSjuTDXGnEObgAPFPPVQhRM3391wF
         QAjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776112770; x=1776717570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH4m/idJ4M3FjDEc3vL3oLYbFEZ5XJk9GPdaO6YXJ0Q=;
        b=AYuEVTNOxkfjOnhiGgaWyFJXPBfPMBLT9Lbr2ZambnIGebfZFxb1S+VYVHJZUb/Kh0
         MLKk8m+sF1yTVJGmr2X9Vv4SsVD2/hElrbcXczRepLMuW3ghoBiy0q/nf57gPc0nHZ7k
         uCEoVkp+J7F/+4NVvOGzQ/tE2wCh0TElZOKe6ITjBjM+/3yrwkHSUc4fmkeBqBNlLIbE
         D/bnmUcH04UeUHrVfROCdRfywUBszRrqoer40a0XPBn9pOqe8+wgFir5e8DsP5pcXyEB
         Er3Da7YxYWTg6plfcWkzSwh+qdKihMHeM5Un5pkkF/jbHWFqwsOMmeq+mX1EnM580vZb
         avgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776112770; x=1776717570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TH4m/idJ4M3FjDEc3vL3oLYbFEZ5XJk9GPdaO6YXJ0Q=;
        b=DenxUcFUSeirdr4sWPNoPyuLbr5t+DPPiQUC5JKxYA9kYx3pXw8xAPhmKrAEAB6waQ
         4IAbRnZxZpFItyN95LgcASLAr+jwFoDLWViigvR9jEPi4XehrQSzOXuwMQI/c8OtSI9d
         KOMKOelDIgoulmiWLUasRcnktNlwUr/XWQ5JpqqYUXsNuRhNvcbqeY3X534vONzZTSnQ
         RIABVimE4IrLlPfqc+UxtXW8BxiupMymHPxhO6liIT5Aw+bFo/UbZe1iZoTgoF4nYbDp
         xgDmmnI/chyUc0p6Gg9Wakj/dSoMboMC9E+q+peVFvyh2Wh89Bl/94qJrCkQtwXH9Ob0
         5X6Q==
X-Forwarded-Encrypted: i=1; AFNElJ86EWZ3xpR6SwIwLsQ6LlZ4BdTuKXgrLXSwKistqLjJDt0cI03xaoklEUY+kL+W8toPwWWhLZ7lOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTj4TjyRvE1T25t+/RoRJgGxS70o2TUUafjl1zhCLyC0PWg1Ve
	QTxXbaEiHlYhSU7jUPzZ6rs0YFA53N1ByA30Oaa0s5rUT25pxZOnQf40877DhcmFaihV/IbmDkI
	Zm9+MykCMY09HfCPV1m1rGtXSKF1oyiXsuG+a97Td
X-Gm-Gg: AeBDietEAJ7WZs2k/a3s+0BwPzZIBR+Av+WJPu/sbJdOLvU6dgwq2C5vrA6myqkayG0
	qRvWtyuiepEEIvkSbVrvGzDBx/wQuC0ohBZA7VhcYDUprl7y4CPlWtQbqXWBC1GVxup8XvK6U2y
	ebR53UfI+m/f5v1SymrfnP0IUDuaiK6y0mUOU7y7NsS+Pz9VohFeiQIaGyxkOZruDUU6FYZJ7wJ
	uWlZpkkGoAvAiHQX5DzQSv13EGmzf+Cabv2iePnCw73WIhUhexWR9zIrZrLON3WpZ73pDB/aLOB
	XdlTt+bIEbhTG2zMg1OxpjDFl/0kK1bhWQnXUopjeioIp6HMbzItOPyeF9UB/bE=
X-Received: by 2002:a17:907:74d:b0:b9c:bc70:e928 with SMTP id
 a640c23a62f3a-b9d726577e3mr820713966b.25.1776112769834; Mon, 13 Apr 2026
 13:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153413.2469218-1-wusamuel@google.com> <2026040136-ocelot-simply-8981@gregkh>
 <CAG2KctokEVVuhrs6tYuMjFF4ALR=tX80iZHrt4bhVvEKyoHzRQ@mail.gmail.com>
 <2026040236-kiln-carat-bb6d@gregkh> <CAG2Kctpr7vBm_=Xz4H5FHYAfFxg=bDt35j6B4EprfUGio=Ftew@mail.gmail.com>
 <2026040357-undefined-gave-c98e@gregkh> <CAG2KctqOLeYm_NFUjGdXQcBo1KhSZpXFQxQdM-DQBV4Mn0ahTw@mail.gmail.com>
 <CAADnVQLELWyv0kuv8wK3FJVFdJPbp-tD8d3p2pgCiVrcw_cVNA@mail.gmail.com> <2026041315-oval-rut-cb8d@gregkh>
In-Reply-To: <2026041315-oval-rut-cb8d@gregkh>
From: Samuel Wu <wusamuel@google.com>
Date: Mon, 13 Apr 2026 13:39:18 -0700
X-Gm-Features: AQROBzB9ayPqL4YBuz2jmsJ-T4uaqkCVLTD0LdsQ1h-gNQThCOSm7u-eqI2Gpsg
Message-ID: <CAG2KctpNTvkDEOnJAnsnXOfqEkzrVQSUF5S2=-NVoXiO-Tfk2g@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Support BPF traversal of wakeup sources
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Android Kernel Team <kernel-team@android.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 9:48=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Apr 12, 2026 at 03:48:58PM -0700, Alexei Starovoitov wrote:
> > On Fri, Apr 3, 2026 at 9:28=E2=80=AFAM Samuel Wu <wusamuel@google.com> =
wrote:
> > >
> > > On Fri, Apr 3, 2026 at 3:04=E2=80=AFAM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Thu, Apr 02, 2026 at 12:37:12PM -0700, Samuel Wu wrote:
> > > > > On Wed, Apr 1, 2026 at 9:06=E2=80=AFPM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Wed, Apr 01, 2026 at 12:07:12PM -0700, Samuel Wu wrote:
> > > > > > > On Wed, Apr 1, 2026 at 2:15=E2=80=AFAM Greg Kroah-Hartman
> > > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, Mar 31, 2026 at 08:34:09AM -0700, Samuel Wu wrote:
> > >
> > > [ ... ]
> > >
> > > > > The data is fundamental for debugging and improving power at scal=
e.
> > > > > The original discussion and patch [1] provide more context of the
> > > > > intent. To summarize the history, debugfs was unstable and insecu=
re,
> > > > > leading to the current sysfs implementation. However, sysfs has t=
he
> > > > > constraint of one attribute per node, requiring 10 sysfs accesses=
 per
> > > > > wakeup source.
> > > >
> > > > Ok, as the sysfs api doesn't work your use case anymore, why do we =
need
> > > > to keep it around at all?
> > > >
> > > > > That said, I completely agree that reading 1500+ sysfs files at o=
nce
> > > > > is unreasonable. Perhaps the sysfs approach was manageable at the=
 time
> > > > > of [1], but moving forward we need a more scalable solution. This=
 is
> > > > > the main motivator and makes BPF the sane approach, as it improve=
s
> > > > > traversal in nearly every aspect (e.g. cycles, memory, simplicity=
,
> > > > > scalability).
> > > >
> > > > I'm all for making this more scalable and work for your systems now=
, but
> > > > consider if you could drop the sysfs api entirely, would you want t=
his
> > > > to be a different type of api entirely instead of having to plug th=
rough
> > > > these using ebpf?
> > >
> > > Almost all use cases want all this data at once, so AFAICT BPF offers
> > > the best performance for that. But of course, open to discussion if
> > > there is an alternative API that matches BPF's performance for this
> > > use case.
> > >
> > > I'm not opposed to dropping the sysfs approach, and I attempted to do
> > > so in the v1 patch [1]. I'm not sure who else currently uses those
> > > sysfs nodes, but a config flag should remove friction and could be a
> > > stepping stone toward deprecation/removal.
> > >
> > > [1]: https://lore.kernel.org/all/20260320160055.4114055-3-wusamuel@go=
ogle.com/
> >
> > The patches make sense to me.
> >
> > Patch 2 adds a bpf selftest and corresponding:
> > +CONFIG_DIBS_LO=3Dy
> > +CONFIG_PM_WAKELOCKS=3Dy
> >
> > and almost green in BPF CI.
> >
> > Except s390 that fails with:
> >
> > Error: #682/1 wakeup_source/iterate_and_verify_times
> > Error: #682/1 wakeup_source/iterate_and_verify_times
> > libbpf: extern (func ksym) 'bpf_wakeup_sources_get_head': not found in
> > kernel or module BTFs
> > libbpf: failed to load BPF skeleton 'test_wakeup_source': -EINVAL
> > test_wakeup_source:FAIL:skel_open_and_load unexpected error: -22
> >
> > We can still land it into bpf-next for this merge window.
> >
> > Greg,
> > any objection ?
>
> Yes, it is too late for 7.1-rc1, sorry, there will have not been any
> time in linux-next to add it.  Let's revisit it after -rc1 is out, and
> again, I feel that "walk all sysfs devices in bpf" is not the correct
> solution for a system-wide snapshot interface you want to have,
> especially as the one you previously added you feel is now obsolete.

Sounds good, when the merge window closes, I'll send out v4 with the
s390 errors and remaining comments fixed.

Regarding surfacing a system-wide snapshot of wakeup sources to
userspace, can you elaborate on the solution you're envisioning? My
understanding is that "walk all sysfs devices in bpf" is a canonical
BPF use case, especially in this scenario, where we see improvements
in every core metric.
