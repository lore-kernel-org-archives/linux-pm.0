Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE062737FC
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775158647; cv=pass; b=FtfRyU3uSt0v2uWdftoxWqyaURDdC/fjhE66xQAV0tdDK69VFQoK7W8FYc3ea3Bt8fCu7E5uhztPWCQxMCHZAZP1b3Vklg5HJjIJ3I7cEYPW7CZ1BATcw3r6zZ/nBK/6za9jbnPBoLCwK1sLof9IH+5wRb7MNbolc/1lY8WAWVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775158647; c=relaxed/simple;
	bh=doMwYSTuXe/JETZRl1N7Raoz/ERAK0foPnDNZyFizSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXF0CLscuJxHHdKHaeC2WuPdSfLTFJTfDCeMu/o8Nr7XiWQr2PjyGbmJb5HFjgpac8kuZmswG4WJfsaeypwejAMoaKu4VPNDNp9bFLvQ4ZLF8A5tVCpVEn33VHz/4bXyNyF/COWF43aXRq2WMjKO0Zn3yGWKeW5VgDv2xysPD2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JODTMHvv; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JODTMHvv"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso46905866b.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 12:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775158644; cv=none;
        d=google.com; s=arc-20240605;
        b=gI/ivkqZWAP+dQ3rwOwT9SeyT0lTXML5MBOWr+YJPxv4K5Tw3HN1ja/xGyjMmoN1LA
         23UqB8mR5QZhcTi1kqrgqXU1PfN3s43LQC149yyNCuCUVjKe6OmoF+w8+1dBFqLm/Qz9
         2AJGZcGxFf625v/7zBTdmYLn0hhcjPlnmeJZezRQ5PbIk4Vn/bRkdbtYqyP5WTktYqjj
         uakgEkNhUpUV1TZHOsPwhKB5NJECNT4eEGP4pvV6UHWQYeNHuhStdDWSWz0UgWwFaxlL
         Mu+uSxzMdl6u3UvapYYyPZ+fZhbCgMgVqxJeo+1NkRRdGIhggdRBCmyuMUkmHuNz5xWd
         Gdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VvxBK4KP6iOeP3Xbm2ZCHQUuUvym2Uan3OJJLKtWlWc=;
        fh=MN9gZjNpFHboL1u248tb+EIxrKOx09K3XMqpCiqQ2dU=;
        b=h9rZWTj2ihYQF4Mvnvs7b7e6sKSv9uMmrRnqCMC3vQnIiKb7WdOrhDYOOhtTwNu3AV
         hHPE9lfcukHsqYBUgtm99FRo1zwvboiIYyE+gMTHeSy8roAq+CzqPX2JPy4sRL6Ukc9T
         NJs5E4u9EXHNz3/0+tItJR/HFQ8a8W7daVCYshM1Lr3RbxhpGpQER8WFcjDZCzUTrvra
         nSChgPs84A6s3dVFjsitTZhKgVMm1c4OCg+KdklcECfwcsrWDnh0k9rvDBwbU+a3KLAu
         h2vrjt8t2mE0B+3pwvIQXKnisRPX3CvtyTHj4tXZqKrntZlyIp50aTegqTEl7C1NHum7
         sCIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775158644; x=1775763444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvxBK4KP6iOeP3Xbm2ZCHQUuUvym2Uan3OJJLKtWlWc=;
        b=JODTMHvvyZqxvt1TS85u6XFqiirfBpBno+oIjSasOSVMES9Ugs6IIdMyDMzgvaY0rU
         qHlFkrSgW4attLx/GnfXy1VtKquehTbbtUPwnot0S9Le2Hy3Cou1OCysyB6/8vqnYuTB
         SLs74p1eieESlFXQ3d7mQQ3JAI3CYWXwFmxyBqiRb6AwSLYWDkkDMSHWfEPSfxjF/7KH
         CBsYDXyYhqug6UdzOqYVdbVN+cXfZV8jYCR4d9p15s3trB5hhytMS7L9VGnbs5K6cn2H
         JQdlyO8Kodqo5shWMien+4CWf3WqPGdDzEsy/tcIW1y4/YVWVT9Oa9Lau0AF8fuFpeqU
         2Qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775158644; x=1775763444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VvxBK4KP6iOeP3Xbm2ZCHQUuUvym2Uan3OJJLKtWlWc=;
        b=jJJexVLjBM9O4IxjoWEdGBSOc1ltF/F+zP+sIMCq032gGJfQUc/XYgNcbC/zpP6bho
         agMgfr8IWJO6pGrqZFcdP1nRBnjpjRjWMLPGKncbpQ4YQOTGgmUhz9btDla/bPVPp6u2
         BHhwu8JwwlzHF1V/oLpxATTTZNlXgVBtd+FBGjqCbDTqkY5sRT22O2d66owHzj1NAQy9
         eEOGVEnTEyzAvvb2eotnKh6H7G4WHjvStXrIRzFhyXXcFPKq8NmUBVKDpWBNUOYmmfBv
         HDp8G7MZD0PYoO0mtx+j9hr6HMg/15HmrRcmSFb+1Q9YeYA5W3JoAg61QIhFqMUFKz5b
         Ezpg==
X-Forwarded-Encrypted: i=1; AJvYcCVvBoiUrTjbXcuRtrg77QjB1q705VjCTgLxoRUFDQ4gjLNqiKjlAxarRvABnHw9wWVl+tC+EdCoKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDvaJD6d5fmAwcG+p+/4vqMq3oTR/gK6Q6Mg+iE6VWECvIXzKf
	xwllHlQqzY3B4Q4j3nPl5KbMBc4DE36l/0sl6WVuHt+VEdCzHf43GDBHr/PFUb6Jzo10AxOgTEN
	rkFLuezoXqtWglkGC50XRsw1g7huQ5yM5L/iA9/CC
X-Gm-Gg: ATEYQzzVt2pNJVRENUtGgbGYLTlHxCXkz7TLBTVhuwZzqwjsHpD79UQBWN0fahpVJEF
	YajatAZjSh0YTzAy3lxTQJIwTfAYCY7/StfByKeyd51v+u85z3zsoXY//tuSdEw5bBEJyQYjLLN
	KQWnDKJaAj+3pdm2A4j1FafHHPpuI5lHo7q3hKLEDRD860Pc16EteFnCP2icLLPYkVYSuvUuJGN
	9Hs7EAl3WxUcg7BlDg5dr/vK77Fw0KznW19o7S9kbskUs0gXJwzEHFfjGRrV8n3QVX2+3ZE2RxT
	AkO0iarTYj1djqfmNJ+XXouGce6oTGG1I60ydX3oANPlY89F
X-Received: by 2002:a17:906:9fc5:b0:b94:cfd:f37b with SMTP id
 a640c23a62f3a-b9c67b99e79mr7310666b.45.1775158643949; Thu, 02 Apr 2026
 12:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331153413.2469218-1-wusamuel@google.com> <2026040136-ocelot-simply-8981@gregkh>
 <CAG2KctokEVVuhrs6tYuMjFF4ALR=tX80iZHrt4bhVvEKyoHzRQ@mail.gmail.com> <2026040236-kiln-carat-bb6d@gregkh>
In-Reply-To: <2026040236-kiln-carat-bb6d@gregkh>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 2 Apr 2026 12:37:12 -0700
X-Gm-Features: AQROBzBlWCEOhUiKVBdAOMQhIYruKxtYmNT9c2ETd_EsKRwXfwQK638DgBnNr5M
Message-ID: <CAG2Kctpr7vBm_=Xz4H5FHYAfFxg=bDt35j6B4EprfUGio=Ftew@mail.gmail.com>
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

On Wed, Apr 1, 2026 at 9:06=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 01, 2026 at 12:07:12PM -0700, Samuel Wu wrote:
> > On Wed, Apr 1, 2026 at 2:15=E2=80=AFAM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Mar 31, 2026 at 08:34:09AM -0700, Samuel Wu wrote:
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
> > >
> > > Describe "inefficient" please?
> >
> > Ack; I=E2=80=99ll provide a more detailed breakdown in the v4 cover let=
ter. To
> > summarize: the "inefficiency" isn't just the number of sources (150),
> > but the fact that each source has 10 attributes. We are looking at
> > 1,500+ sysfs nodes to get a full snapshot of the system.
>
> Wait, no, something is wrong here.  You should NEVER be wanting to
> combine multiple sysfs files at the same time into a "snapshot" of the
> system because by virtue of how this works, it's going to change while
> you are actually traversing all of those files!

Agree, the current approach with sysfs might have stale values. The
BPF approach holds a lock while traversing the list. It's not a
perfect snapshot, but it's internally consistent and arguably better
than the current sysfs implementation.

> Why are you trying to read 1500+ sysfs files at once, and what are you
> doing with that information?  And if you really need it "all at once",
> why can't we provide it for you in a sane manner, instead of being
> forced to either walk the whole sysfs tree, or rely on a bpf script?

The data is fundamental for debugging and improving power at scale.
The original discussion and patch [1] provide more context of the
intent. To summarize the history, debugfs was unstable and insecure,
leading to the current sysfs implementation. However, sysfs has the
constraint of one attribute per node, requiring 10 sysfs accesses per
wakeup source.

That said, I completely agree that reading 1500+ sysfs files at once
is unreasonable. Perhaps the sysfs approach was manageable at the time
of [1], but moving forward we need a more scalable solution. This is
the main motivator and makes BPF the sane approach, as it improves
traversal in nearly every aspect (e.g. cycles, memory, simplicity,
scalability).

[1]: https://lore.kernel.org/all/20190715214348.81865-1-trong@android.com/

Thanks!
Sam
