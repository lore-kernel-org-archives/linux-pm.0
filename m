Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97BE31E822
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070447; cv=pass; b=lPaMjNR1djIZCZHIGGccExjHrC+s10bw+w3sNcXOJtv1Jau7VoRr5X2yBAxzukoMTf48RqiEM57MY1t94tZDvxR6uXPlYGdTIi2W96XLszMuJaCQ2vqxIf3uBmnX5AI8XiMh+LRKsbzvnD2JKelAGC2ECZbOKoUIu2+kPxFp9HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070447; c=relaxed/simple;
	bh=oPmpGJgra+J/X4ds4wcUHLxA6Eg7GvkHp+DXASeWwJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nb2bGhrOw5rLkWxnpyhgeMKbfj9pu/AWn991L+nmHLCf/55RWmJtemKeRL5jROIYWdgReqk2PVcMtNekRIQuRfQH/1GzPASG1lRh0/3MeRP9SC9UQNjuWld3ol5kpEVB11PmJdL3PwsVMG8ynigp8JaHVGFlAruIMvIXzZAxhf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a1//AZe5; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a1//AZe5"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so10284466b.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 12:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775070444; cv=none;
        d=google.com; s=arc-20240605;
        b=EvDV2XM4iFOU3ed2wg9jSa+cm/ktaWBJciCvQyJX66HUD9PkcFgqORNUwX1oLTAKCL
         5c9CgKlCSlPAtcxRS9ZZWtKlY6KI5g7Ru2UQYchU1OT7pLEw0WrfFDnb3djEHZ+HThye
         D+d2hCceiwE20G6Jf/WLdyykElxwhHTIisjcGpBfY3PHVsWIPff4D3CtCV1N8y4XEmo9
         FyOYTGkykOCbkG8I4NiNiD6PYR5EoH/PoGhO7LdvdDizlE0YONXeEyRSV4RFDvDoXPHN
         g5Qy3OaHcMRUy3/PYHd2SOw9xg3IAaNV8gl0/fizREXnv4PSQ9jnbASdnhlJiOua16kT
         Ul9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tbulKj8l3zNdTBhluioK0AGuzttA7TtmTV4oAVYitSw=;
        fh=e12JbUYvWmjS6W+815jlHaN9hs4yitw9Qn6+5g7FZQc=;
        b=dJbkSKiLqPe0FeD0Qjnd64lqe4IFPo3VUOOk3pxTXiluq1DzaMWqkH9kxU1pnjBpS+
         pkZiI88CBe+usufObKYIHF6dal4IiNNiEQs/HS8Ybbqz94x3WUvCexMQYlKlGFM1hIxQ
         14ZFr7XBRooAaKmnFxZGlO2XYPKWyVw05DGFWROX3zc1ckjQc71Z8EWNzUyheoN0qIb1
         Gsi8+lxYnjiwBXv/PexGNgmVDPHZ9HqEpIlI0o4shz4FudcUl0da8+Kt3lV4AHRJV2kU
         OuUZOBWaKG4ByfnPhrPvFAo8/8GllJmY7ncvG1gmgdLzS99k5iT17zFajKI7+4RX8D51
         gGTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775070444; x=1775675244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbulKj8l3zNdTBhluioK0AGuzttA7TtmTV4oAVYitSw=;
        b=a1//AZe5DdgS5fEZq0/0QEqk9mG6WFqo1M2mVCPIGwJratfVF9Q8YNqsXDe1cUWJax
         fsuZz6klosQzCNo9xAyYm3I1UogQscr6pdkjOPiNqV4//KkaFAj90Sm5wF5p2I27SLCb
         aQcLgWyAXcEZjyAknqF176bxnWUWElv1qfbL+4lqrCKOCdMejByVmHZTb9qYr9fyiFly
         c4yarJIxvfSV96KdkRV6sIVyDg8aalM9zaMEXYjhHTnwwWGJl6ZuMT0sghhzAHb2OkMZ
         6sDqT6BulxNVCVECJVB09GPwU0xos9b3u+D0FOtstJidKEivN2T0LfuTJAKj5YkwEl2h
         otRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775070444; x=1775675244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tbulKj8l3zNdTBhluioK0AGuzttA7TtmTV4oAVYitSw=;
        b=kBFq890Oxoqd0vMRdIEDpiLob/5F19EB3Q1pmHgee+91wmr6PmvdbDDA8qCoYSTny1
         q2xGV5PCaJEL2ykQjIqpiaEL/bxHorcoseZa3knLsq+FW43b/bvh39rcY78R7Y8cvRGO
         HcB8AEsBx/HIvWhL+vfYiKJQPWMh3r5rRj5clBDUaNtB5aWAMRoVrUUkRtAYVxWC0Xuv
         8FY5+p01hN5UeTCv8ZFDaGHtCSvcM/O9aip4cxa2m5QjWboc+LZUk67SJFTxchbioLCz
         4zE5MP9lGio8H83HiGntswRW2d1HvrBFSJDmpoik3vV35WO+mh70GeSL4R4sXwsu1oHW
         UUmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKQWHVZY7Az06EzMmSzTg2gDvZYfkg38tjoZdeEI+Wnx+PeDHk/WudbIuf/DS1UxezARkRE2LpWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEvo19OaWru3dDYBmQLdNfEd/3RyoBGSTan8LxlfDGrm4imO46
	y1F4fFaxeu64MqjQQYlKwkmFU0VzCRxT0dLIBkdRxMrrJZLfZudIiCgSD3s3dxehOvwD1MmC45V
	Cdqfk4BrTlh7O7b6tLSG42ZAEbpnCvVzPhTywHb+A
X-Gm-Gg: ATEYQzwTGx3Zq/2iYcWB8LPT8LJupHbvaaMTQgE79L7YBzIj2czC8sIBZ+0AwIW1/gv
	BHO9bN2qZwtbZNmZGHJaJAwwgJm6xSKLy0VSgwllSS5Zj0O//dBZLEjh7+4ZRoFZzCo5gy9NrgT
	N6eLCyO51UWBXKdk2Yv+vNwDH9jRFa18MJ6Lgsdi2rqg2YivpYIBsPnotdf4dmAiOBSXJRlgf4g
	SxkTJd9OpLynC3ynEzErJesVEF+fxdoELCsDaRnwXDZleSBOPcAFnz3C1VVxs6PsqSalxtH8Jfk
	fyTydf5xHqEsuX130kQ2J86trczAkCU/IX0r9A==
X-Received: by 2002:a17:906:194a:b0:b9b:e5d:71df with SMTP id
 a640c23a62f3a-b9c1390345cmr238853766b.19.1775070443780; Wed, 01 Apr 2026
 12:07:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153413.2469218-1-wusamuel@google.com> <2026040136-ocelot-simply-8981@gregkh>
In-Reply-To: <2026040136-ocelot-simply-8981@gregkh>
From: Samuel Wu <wusamuel@google.com>
Date: Wed, 1 Apr 2026 12:07:12 -0700
X-Gm-Features: AQROBzDAv1zFg2qxt-3Ch7XBslSJIDWmAx0yiNuGqnKyk-N-jI_iMZvmNf44ICs
Message-ID: <CAG2KctokEVVuhrs6tYuMjFF4ALR=tX80iZHrt4bhVvEKyoHzRQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Support BPF traversal of wakeup sources
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 2:15=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 31, 2026 at 08:34:09AM -0700, Samuel Wu wrote:
> > This patchset adds requisite kfuncs for BPF programs to safely traverse
> > wakeup_sources, and puts a config flag around the sysfs interface.
> >
> > Currently, a traversal of wakeup sources require going through
> > /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to qu=
ery
> > sysfs is inefficient, as there can be hundreds of wakeup_sources, with =
each
> > wakeup source also having multiple attributes. debugfs is unstable and
> > insecure.
>
> Describe "inefficient" please?

Ack; I=E2=80=99ll provide a more detailed breakdown in the v4 cover letter.=
 To
summarize: the "inefficiency" isn't just the number of sources (150),
but the fact that each source has 10 attributes. We are looking at
1,500+ sysfs nodes to get a full snapshot of the system.

>
> And if you really think that doing an open/read/close on a virtual
> filesystem is inefficient, then I have the syscall for you!
>
> I've been trying to get readfile() accepted every few years, looks like
> I last tried in 2020:
>         https://lore.kernel.org/r/20200704140250.423345-1-gregkh@linuxfou=
ndation.org
> but I keep the patchset up to date in my local tree all the time.
>
> Would that help you out here instead?

`readfile()` seems like it would be a great optimization for many
usecases, but it doesn't solve the context switch bottleneck.
Additionally, current userspace implementations attempt to speed up
this traversal by caching fds, so this new syscall wouldn't help as
much as one might initially expect.

> > Adding kfuncs to lock/unlock wakeup sources allows BPF program to safel=
y
> > traverse the wakeup sources list. The head address of wakeup_sources ca=
n
> > safely be resolved through BPF helper functions or variable attributes.
>
> Who is going to be calling this?

BPF programs call the new kfuncs. I realized I left some stale text in
the v2 cover letter regarding the interface; I'll clean that up for
the next version to make this point clearer.

> > On a quiescent Pixel 6 traversing 150 wakeup_sources, I am seeing ~34x
> > speedup (sampled 75 times in table below). For a device under load, the
> > speedup is greater.
> > +-------+----+----------+----------+
> > |       | n  | AVG (ms) | STD (ms) |
> > +-------+----+----------+----------+
> > | sysfs | 75 | 44.9     | 12.6     |
> > +-------+----+----------+----------+
> > | BPF   | 75 | 1.3      | 0.7      |
> > +-------+----+----------+----------+
>
> 150 sysfs calls in 44.9 ms feels very slow.  but really, what are you
> expecting here, sysfs should NEVER be on a "fast path" that you care
> about performance.  Why are you hammering on sysfs here?  What HAS to
> have this type of performance?
>
> In other words, what problem are you trying to solve that having access
> to 150+ sysfs files all at once in a faster way is going to fix?

The 44.9ms is the cost of reading ~1,500 sysfs nodes (150 sources * 10
attributes). This is even worse on wearables, where the compute and
power constrained platform exacerbates performance sensitivity even
more.

On these platforms, the CPU is suspended as much as possible. A
byproduct of this is that the wakeup source traversal occurs on a
user-perceptible path, which impacts battery life and UI
responsiveness.

Beyond the performance improvement, moving to BPF offers other benefits:
1. Reduce Memory: Drop the fd caching logic
2. Simplify Security: Consolidate SELinux permissions rather than
managing labels for every single *possible* wakeup_source

Thanks Greg!

-- Sam
