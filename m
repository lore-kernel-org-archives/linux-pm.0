Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793060149;
	b=CU7Vx+PNzt7GeTq4LilgtkPmO5JA8KwD0WbF0yfUogqt+nLA2fuQn/oz9IPmHjxK5HYc
	 pkGcP+LPFK6ui2dWrvMIOyq8f2gz4qTdPjn3dV4JEFp+QH26Is/Jb5Ao3h21i5LAKBBAM
	 XmYuOeFyb7hrhwZu+Qu8YN+EiLs2MkmNXAsBUJi6+ij6IdTJv2+PXhbw1rCSFy0gyy4YW
	 AFZpkkqtXiAIDeqQEpXHzfqn96/hZeqhTcF/t7ux0u33pKoU14q/yewcpAiluaazEkE+t
	 6i7lgkmVfQGWkHF1O2wac6oYHC3Jx90KEFr3hT2olQNtmUyU0lSr3gaF/eFCxle59Qw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qKeQmKdHS147YBCUhe6/TQHxqYO/kgxJinnL8fZRSJA=;
	b=l1JropvIOmExTyXPxrxMRcj/iNwQm7ekDa9cSSokD+zoRt5ijH5+F2Mx95lsvOYzBuJE
	 eA5s3B0dMxVboX+T1HzM8MRvkVIjIT2Fcm9DTCp2WE5h8RczZD8DwMYeEUJf+jb5rQuC2
	 QCVNXA66g8gcmSF5JhKFyLHcgOzqMeqVgdkMIv1137+yECsrxP6jvQqKvN2/Yl3OhA0Np
	 wKAF6IbAXb/c8RKfolkfFcI6Q8uQomov8KJyd0Q2N2fi1f7/pbJkqcabcG8gzeUTkZKSj
	 Avvk7swFG87ej7oFX6/AJho5CPvT3WHsaN55o8JgQaqzV+NXePEC33g5IB3jGDY4QKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s0Wfg3DQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.45
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4706F606A328
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 00:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4706F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=s0Wfg3DQ
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6798eb0d13fso3790892d50.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 17:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793060148; cv=none;
        d=google.com; s=arc-20260327;
        b=A8CmRmhrCSOn9YkYNJNX+C330vdHWadYpUY+S8WCVxEGFfVjxkAHSqXmvNKb8XqtfN
         g4QImP1+d1R+V+aRtWCPifGnQPr8ijkkjsUQ6KqsTc4tFXrSlV7nUHE4gRD3zg5mm2pm
         KUBYUNoz6z1yqpyfXavRk7gqhzpeLhFwjCFg/CC9Nxs3QnnjqM2kH86RxI+LyNnj2XZk
         aa8ef2xf7ZOzrYaU49fQuEBdxEOyswbqzH11qs9/KeaDtWmyXg4XqXV7N579iC5HjARP
         Q3rI4Krlea4PUP3DYvs0B2Pp+GSSlWFVwrKK8zGmO7GkTgxD86jI83VYRY0hAYafGKfM
         wUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qKeQmKdHS147YBCUhe6/TQHxqYO/kgxJinnL8fZRSJA=;
        fh=dcDCRgxGpGEKcRtD0GxLMVpL115LdWEjkvzcdzNJrUw=;
        b=PoSyolrpvte4TSTE+VlTP8fZQKsaHRFNLUdLtvdrwBM2E/y5HHdou8HALAAtK8B8jO
         Rh+CtQqTRlFaPx3DRf9YRuKf5K0fQ16hcx4EKzhk55g26HlHPeKGSzVbN1FLAkKKsV5u
         +PwSj+yxs7fGDfUzD5o+VNZ/r0pueNzJ2xUG7PH1gTZK3GqFPeSXEKV0Jnkssw2dIAXK
         FzleLNfd1/oDUliC1wAt0dpvjJk8lSGFZHPiOSd8/PxqWRnnwgV5tCVoXZn+/L6Y4Swb
         sZvETN/Mqz1wLhrSeMUnpzc3RhnpwOgLdXfFvKPGHm5CGnOF20u4M/X2RkEiK5xXaqP9
         zwyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793060148; x=1793664948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qKeQmKdHS147YBCUhe6/TQHxqYO/kgxJinnL8fZRSJA=;
        b=s0Wfg3DQSfdPBtgTrPJ7hEq4HUweU0fxNhhrERYXULKUVGjvojByBZj8KKVt7nRxU+
         qfuMSheIJo5HVMHmH35pJ0m4FosgwDQvoFqO6hWdyPRkiWPWjpgGD4+44lYarYwcj4p9
         lwGrCp9TiIJ7Y9Q7o3VLX5IDHtJph2ZfYWK9hb7nwFZcN/EGzSOwKwJdiqW4e4tKM19a
         TwcHswoqbtz3QUq2JqUArNS2ontBIM0U5Az1Xxt/qvNOY6jlotL5RVH54V4eQYaO9/UJ
         cfXBJNeZLYP/7FfHZRk1FnPXiW2XAqkAAz+W61A369XeoogwEs/6FcBTuT08s5U96hTP
         UsKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793060148; x=1793664948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qKeQmKdHS147YBCUhe6/TQHxqYO/kgxJinnL8fZRSJA=;
        b=t6E82Zqr8k8FhfeC2tuNOKI5c4Lb6ftF0mYt2/3PGCZN5jPY6G/Eup/LqjMBhk80mt
         R6yRSLY2cuR/S79IbXSrMRBuxf6auoLJC0KPQHMAPejTRWInu9Kh+kcl9r9lFyCpe+/+
         lxLzkiVWXxAdQnLc7ZtEMRMshiOvHrkXZEcodTbz+NLRuNQ4cU3RUL9PMBdajKLfzXai
         D2mnvzXkbLxEFdseFC1hVpAdYT+Lsv9FwfVrhC8QMHuaLMeeg+0UAG9E1mDq2vBFWRXW
         FwB7jWdDq0A+/1Ithvch3LGXoL5FycsGQt2aGdIbzKb457KEwir3U+8vye7gTUdecDwO
         ig+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxxnJOVX/oy+R9WuenRurWve9wkok1rtgTxTD1SQblCAzUcqHyQnoh4lMTPGMIut/9z/0F9xyjQJg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJc+Mu8f0wmbIeLoepK+XPXC42o2V11hSLUvDoQukckpOKCweEK
	VpNzZWMF8AYzdQGwhfEkAXyAW02Th0FtKg8PUpAeq0zeNMgUnkoxgAV2g4+/8K3Xuzs83TzHogx
	KQkItPfxSAGTE6Wq94xS/dwaTbsu5RoA=
X-Gm-Gg: AYBFou2xzWn2WZOTcgf7sNSotKtBe+jOSQlmV0zaWIV4AFZuaTrLHAamXTFGTjSH7pL
	6sn8isJ7jeWuZz0SZ8aC7DcIgY3uKIBxrfZ1KwBeLt16LrapBX1ivbp7Ov8krsVGM16gSz/FQtm
	r7T5ACznE1T9TIEJUCecyqf4gT+vs5mBuJ7AbxMkOQlzMTlUj38FOcCvpm+Wh1PySV0Hvcb71Gv
	aoU+4VBFafwWryuYzGLlfuAJPbydIJvxZLtmup2R/bG73q6Li79X1+UVg7qO/7BvqLP1UiELOJN
	IvoxzoycY+vAH96s+rmPbzRb4rBfnUxw3W3+n9fLW4edUhHZyrFYbyjN6lRYu4LeR2w8ukag5aO
	jRXJOgop1l7Z9TmUMLjUzVyZnPeDNbeD3htavhSUNxLMYlyx+Q8R4yJ6DM1Cicekv839lTrbs5d
	2TYZkWjJFU6mUJTWE=
X-Received: by 2002:a05:690e:150f:b0:679:c803:98d1 with SMTP id
 956f58d0204a3-67a45496c6cmr4080476d50.152.1793060148265; Mon, 26 Oct 2026
 17:15:48 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-33-3c8cc5725def@gmail.com> <as4W9hToBqAvbzJ-@pathway.suse.cz>
In-Reply-To: <as4W9hToBqAvbzJ-@pathway.suse.cz>
From: jim.cromie@gmail.com
Date: Mon, 26 Oct 2026 18:15:21 -0600
X-Gm-Features: AclHuK9LH_u23sCYiYKMz0I-9md-phfbwb6JA9KZbhXjHlVRGYmTapsg8H2JBYc
Message-ID: <CAJfuBxw-cq3AYXKZ07Y3732tDM-NYxt+rs8Fz6S=P7+1TF5WNA@mail.gmail.com>
Subject: Re: [PATCH v12 33/40] dyndbg: Ignore additional arguments from pr_fmt
To: Petr Mladek <pmladek@suse.com>
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@net.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
	Philipp Hahn <phahn-oss@avm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 5:33=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Mon 2026-10-12 20:37:04, Jim Cromie via B4 Relay wrote:
> > From: Philipp Hahn <phahn-oss@avm.de>
> >
> > pr_fmt can be used to add a common prefix to any output from a module:
> >       #define pr_fmt(fmt) KBUILD_MODNAME ".%s " fmt, __func__
> >
> > But adding additional arguments breaks dynamic debug:
> > > error: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" passed 4 arguments, =
but takes just 3
> > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > |                                                  ^
> > > note: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" defined here
> > > | #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> > > |
> > > error: =E2=80=98DEFINE_DYNAMIC_DEBUG_METADATA_CLS=E2=80=99 undeclared=
 (first use in this function)
> > > |         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT=
, fmt)
> > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> I wonder what this error about undeclared macro means.
>
> > > note: in expansion of macro =E2=80=98DEFINE_DYNAMIC_DEBUG_METADATA=E2=
=80=99
> > > |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));    =
     \
> > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > note: in expansion of macro =E2=80=98pr_debug_ratelimited=E2=80=99
> > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > |         ^~~~~~~~~~~~~~~~~~~~
> >
> > Add an additional ', ...' to DEFINE_DYNAMIC_DEBUG_METADATA_CLS to slurp
> > any additional argument, which `pr_fmt` might add.
> >
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -351,7 +351,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor=
,
> >               dump_stack();                                   \
> >  }
> >
> > -#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)    \
> > +#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)       \
> >       static struct _ddebug  __aligned(8)                     \
> >       __section("__dyndbg_descs") name =3D {                    \
> >               .modname =3D KBUILD_MODNAME,                      \
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index f594c1266bfd..5d701952e739 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -742,7 +742,7 @@ do {                                               =
                       \
> >       static DEFINE_RATELIMIT_STATE(_rs,                              \
> >                                     DEFAULT_RATELIMIT_INTERVAL,       \
> >                                     DEFAULT_RATELIMIT_BURST);         \
> > -     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));         \
> > +     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);         \
>
> IMHO, this changes the existing behavior. The prefix added by
> pr_fmt() will no longer be stored in DEFINE_DYNAMIC_DEBUG_METADATA().
> Is this intentional, please?
>

yes, its intentional.

515a9adce0f0 ("include/linux/printk.h: include pr_fmt in pr_debug_ratelimit=
ed")
added pr-fmt to both the METADATA macro call, and to the printk() just belo=
w it.
The commit-msg was clearly about adding it to the __dynamic_pr_debug() itse=
lf,
the METADATA addition was overzealous.

Removing it brings pr_debug_ratelimited() into conformance with the other
*_pr_debug_* calls:
    dynamic_pr_debug, dev_dbg_ratelimited, net_dbg_ratelimited.

and as you noted, this makes the ... variadic unnecessary.

Ive added the Fixes: tag accordingly.

thanks for the review & pushback.
and apologies for the delay, I picked up a FLU shortly after sending v12.




> Anyway, if we do not longer pass pr_fmt(fmt) then we should not
> need to add "..." into DEFINE_DYNAMIC_DEBUG_METADATA_CLS().
>
> By other words, we newly pass just the format "fmt" without the parametes=
.
> The 4th parameter was added by pr_fmt().
>
>
> IMHO, the right solution is to keep pr_fmt(fmt) here and extend both
> BEFINE_DYNAMIC_DEBUG_METADATA() and
> DEFINE_DYNAMIC_DEBUG_METADATA_CLS()
> to accept var args. I would expect something like:
>
> #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)  \
> ...
>
> #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)           \
>         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt,=
 ##__VA_ARGS__)
>
>
> or maybe, we could "eat" the extra parameters in
> DEFINE_DYNAMIC_DEBUG_METADATA. It would mean to keep
> DEFINE_DYNAMIC_DEBUG_METADATA_CLS() as is and just add the "..." into
> DEFINE_DYNAMIC_DEBUG_METADATA(), aka
>
> #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)           \
>         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
>
>
> Or do I miss something, please?
>
> It is possible that the macros work another way. Or this depends
> on another change. I checked only this patch...
>
> Best Regards,
> Petr
>
> PS: I was curious what Sashiko says about this change and it seems
>     that it does not review this patchset from some reasons.

I checked shortly after sending, it was "embargoed" for 24 hrs,
perhaps cuz it was so soon after rc7

>
> >       if (DYNAMIC_DEBUG_BRANCH(descriptor) &&                         \
> >           __ratelimit(&_rs))                                          \
> >               __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS_=
_);    \
