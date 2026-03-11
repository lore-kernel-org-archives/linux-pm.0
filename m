Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39625367F4A
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237990; cv=none; b=gLHlsYRo2IxJ/YqY6FVOO3vMIPRHKMvAjXq3CDWIukes64JqazUDwMKPdbMRgx8rHhncjKvgsfKTRFoV+we/I4v7LiMHa3dHMGEgfOICqbQsg517HR6SfnvytkzRe6g6P66u8yaufcKpVrWZyouCCNaLz58N3F+1M/Ap3iQ2OVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237990; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BS+F+zpHQ0DfODoAr3SoNvPqUpOHjogKF8jrQkb5WG19UClroEgFDUDrJcuXGfyNXVSdKgcXFoGSpnkqNj++/+cpwHFaC9o/gTJ11GaM7OP8vKLds8WZnlilPnjJFc+xNeTRgtDn9x2W846qmPlS6ZUBC9S/D2z/zwIF5ww4Rrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-660ea6ceb5aso1628107a12.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 07:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773237987; x=1773842787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=fJbWBnsLL2pq1p6haw5gN6B/d44h6jnOOJnx186QC+KBAXqy0fKoVTvkTgudupky/V
         0Tz2Njg6wnxyA1KwsUuyMzheQcjs+BnwbwwXrb6H/GdOkMDnKtKGw7aynhCZ0dTYbdoT
         3mJUyOHpMgqq03qRjcpdp7p89+mu8mfKR6ksh4glFVQJE+luB5EpJII6b4TK0dodailx
         mZsXHmIel4tmwRXFz/kBbd08H5TmyAABNp75P+E69/LG9t4MC106Lpu90QuhbiZvk+uy
         MCunDYUV/81KxMVGUenUiwGt0R6jtQb0dKTwN+dj13zDJSnPCDWcV9zdCA7xjYXa+h+I
         1+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCU1ql4w8IKltMq6L4Qy2Z3V8J4WmmTfYlz9O1gCpjO4gY3CrHsjo5MWV+9+PloaCd68FMhyruRP9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV1hvC0DtWqw4v8ackBG0QtfVm3zEyzorpVGcXCA3w+svesSXx
	wIr+F+RkEa3IuAThTF9Gbxsd067wsz5KIdp7ORSfd2HjeKwK9gsJysiRuAdNROpnnXWVeA==
X-Gm-Gg: ATEYQzwURTKIA3Laih5srzDS4FA42DBK0zbPg6jN65tnAfp81Na23qnqmHd7ptOCuYU
	ma0zK9l8PplNwwha5KHULaZ6ik2k8Qr9PRmxaC/nOLuScWKxHhr24btA6tNx2CbZqymaLe2M+1A
	SXYSK8dNbZSklgftdIRC/21t3LqjZlWrePgvHv0jM/gbFD2cppYJr5eu0/xx6A6HgyxVz969OW5
	S8qlsozzDqb3ESp/c1/x70ww/SfKskNOknVkv/jpoojR6ejeI+u8jj+cSuxKRoY5KE4zBqpYVyD
	9M66SsQO6qOFQiD2lIN4U+f5joRVgKCEEa2MwPHp099pmEmmPAbNie3a3VOc/RFZ5rB9mrQlvRe
	IQnqSLjn4UA1L8CZ/rfThlLLBLNJ9h28aUJelHMOQuw/vinqAlWGww0zq1ffiJ26qI9aFSJ8u8G
	/HfqLnJAzGH1dNdE45c/X0HJQBLUYdJz5dpQsttu07xknCtW1jtPrJoGHGs/6E
X-Received: by 2002:a17:906:6a02:b0:b94:2bb4:c5d8 with SMTP id a640c23a62f3a-b972d7bc636mr165778666b.19.1773237987293;
        Wed, 11 Mar 2026 07:06:27 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97307dde54sm49298266b.11.2026.03.11.07.06.21
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:06:23 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b93698bb57aso169025866b.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 07:06:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVL424gOB7bnIEFEdlAZysPEKiOcJjBPD6fyH96dXDZFtOp/Yz3MfQyC10NRjO7iv0noxW2hIMpg==@vger.kernel.org
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
