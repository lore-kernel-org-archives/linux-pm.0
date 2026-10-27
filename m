Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107381;
	b=NO+0hWaZ74guSdzbSjKDkUPMP0GkzsNLEQNWK2gMaqN2li+q/jz4kCeIo36ZI80Y8Qje
	 SQubItuhLGHXm7Yin8orxAbKGyVBdHY9yD401NOYDBJ4y29dREfhB4BTe87lGCoAqCPYr
	 FuvJtOMfSYKQ/tgpd6hkLhZ3MtSy7PBBHdSSw8TgKQ9QnNWt5dzAYQhIJLDZcWnwKgVAU
	 SRAd9BSdzOrXNXoXKwI58KcKs3qPLAsrMAmhN2yPAR9fVzkOWZaa64ktWTvugyzL2FkqN
	 wRPmqSq1OjuEIevXr+7MxqNNmSmPK8a62tvr6cq54S0CHlv5qnnuxEG3EnYDkY+3Y9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bt8+RMZDmd6s3sr6pjCs6SFKWlDJZBaHmutX4rG7P/I=;
	b=yT2VURbEVmI83iuKM9ObrAAVmJG4LJweKO0f2R+lhdQuZuNDotPqvXXLNRpDa1XW7uLs
	 /hQaL1TTJl8eSZMSkUw+5GRy4cvE8/U6Q43Qc6UpyZraDw1Z19N8NodJhR582lmbJp384
	 5nh2QqrVlh4A6kzGM/54C6M9Bx9sJ/DE4urm9MV78m7b0C03spX88irPQMKSnp5ziG161
	 G56FuejKHGQWI+KGQS4xn/bIzKS6ZQie+15Ot8Gnzos5B1uwmqOadtm0VOcL+YSXsYw2b
	 /H+aI9z5Q4QGKnKTjOp3kljX4C515tsbsLL2l88TcacsPCBjPXN2HB2tUA8hjNF4Fsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D9I2Gz1I;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEF8606A333
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 13:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FEF8606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D9I2Gz1I
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e47347279so1868073f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 06:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793107379; x=1793712179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bt8+RMZDmd6s3sr6pjCs6SFKWlDJZBaHmutX4rG7P/I=;
        b=D9I2Gz1I6TohXPedOvNnB4ot89+HPLVnTkGptL1nmvPR4Ebd0vQn2mx7tGT4eB0wit
         W+dL+ixtQthAPpXmXGw+in0Ctz2kcsbC7kvOahclFSp3KfkjUGqV3ABxYzaD+KwrlTD4
         BeGIYXqQXlyJOjpqkE4+SfEnC7QOcgIF3nBUyOkghRDfERqmQA81j0Cf9h1GY+YVjcQT
         pmi0J//7BiN8/L+QE6jbor1n6tDO9QgrBax8oRoYgFG5p1K5OAkUDsAmLXxsJOJH/haN
         VJR4dII5YeaaxYhDUvgLePp4t+Vaoq38Df1PdbOvbABf7w3llPt9EfabyodDQesC4ZgT
         wM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793107379; x=1793712179;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bt8+RMZDmd6s3sr6pjCs6SFKWlDJZBaHmutX4rG7P/I=;
        b=rVFPkfTdt3hI5X9bzDM9dR2Wpj942md+6+lrHXhOxPZX1PO+xMt+b/b4zu0qjDUKig
         n3Vb4OrzGYWz8azO7HVmHOGEd+ogx0VYcvWN2LX5VcrmRXV3DDr46dAtxbR+aNTRD73d
         TGZdSZWbG9Tariw4aSDSLrQ5stAgISHhFB5SzViV3SCV2sC3nqF/xtyukdxuDtMccpok
         WZXjesNudO077lkmuxagZHnHALV3pVt33V0/IVdRNSDhVLida7LBwHZ2xaXBl34qZSkY
         jwwyfKOnvWh1XaiX9Gd4dQMXUhHKw4yVe0U142CWGTmxwIJq1PlKtCr03WBOtKom/CmC
         W6sA==
X-Forwarded-Encrypted: i=1; AKwUvBwgoDfj3GKP3eapTZz6gIp4BRQ+BMJqBfgj8N+MKsYOTw+pa0DpZlojPdrZ3g3SG1xqY7qZbzTSGA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIoGvH1gJpQHCMI8g1bm9XlAjJCVB39J5AOk/ChBZtf2iboIR/c
	Q89o2OEZwctamLsdSLRd746uEqVhGdzEI+x7idza6s37xu4L5eJpICGs
X-Gm-Gg: AYBFou1YqUs2oZukUZWXkBRhFiFn+SIlBYMVuzDX7ii0q1ouv4rTsp/BERTMaQPlyJ+
	rHlZ3AErm9tOFQ//TrMVtEQmYxiwcSWhEA1u6dd8OE4uV9Z6KflPJNX6z15WW0yEPC42d4nhylS
	u/SoiLNlwqKdQfL7M2XVqgV/R1KRll4PTHW2eYB2ziDnszL5QedVqe1Ei7YkPJ07+cGt3yI7WuP
	0qzntAOR/xg0CXDWUjf4ndfnGkY5rcrepB0slc17gCPEPH2u+0M2Dl3Xo4jql8BLGrYYDp+xUjo
	Q4tKRsW1hZkkwN0H/N9HME/I2EZBcUCOZlS7zrCN6betkfR4oHPwjU1cH031sFn0emJGZsskBT0
	ttZGXMVYh+9VtgcWQsGz4zhJzzDDcUKwUdzybtP/4qzXAQBe8v3swKOeAEbgJBSLFEeDcXoYzzg
	7thnRHHEg3dP8cg++Gv9XqY1/vE9hXu5yhTTcjV2ZqLtdNJFe6DONRx0LjhbmYO+o/0Nu3hxfCA
	afjh2ijIP4glunO34lNYZfDd4xbd93ZWTS5i9Nt6lAn+23UjVCUHAhqxepgPwhUWrPHM/ejYJEf
	wRWsGz+zvYJop+UCm1bONW3bYHXd84j0cL2/bg==
X-Received: by 2002:a05:6000:2388:b0:48c:7386:af18 with SMTP id ffacd0b85a97d-48e3eb2cf0fmr19717600f8f.8.1793107378393;
        Tue, 27 Oct 2026 06:22:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39a8sm23819954f8f.11.2026.10.27.06.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:22:56 -0700 (PDT)
Date: Tue, 27 Oct 2026 13:22:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: jim.cromie@gmail.com, Jason Baron <jbaron@akamai.com>, Shuah Khan
 <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Arnd Bergmann
 <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Jonathan
 Corbet <corbet@net.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel
 Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, Philipp Hahn
 <phahn-oss@avm.de>
Subject: Re: [PATCH v12 33/40] dyndbg: Ignore additional arguments from
 pr_fmt
Message-ID: <20261027132253.5f3a461d@pumpkin>
In-Reply-To: <as4W9hToBqAvbzJ-@pathway.suse.cz>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
	<20261012-dd-cmap-part2-clean-v12-33-3c8cc5725def@gmail.com>
	<as4W9hToBqAvbzJ-@pathway.suse.cz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Oct 2026 13:33:10 +0200
Petr Mladek <pmladek@suse.com> wrote:

> On Mon 2026-10-12 20:37:04, Jim Cromie via B4 Relay wrote:
> > From: Philipp Hahn <phahn-oss@avm.de>
> >=20
> > pr_fmt can be used to add a common prefix to any output from a module:
> > 	#define pr_fmt(fmt) KBUILD_MODNAME ".%s " fmt, __func__
> >=20
> > But adding additional arguments breaks dynamic debug: =20
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
> > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ =20
>=20
> I wonder what this error about undeclared macro means.
>=20
> > > note: in expansion of macro =E2=80=98DEFINE_DYNAMIC_DEBUG_METADATA=E2=
=80=99
> > > |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));    =
     \
> > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > note: in expansion of macro =E2=80=98pr_debug_ratelimited=E2=80=99
> > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > |         ^~~~~~~~~~~~~~~~~~~~ =20
> >=20
> > Add an additional ', ...' to DEFINE_DYNAMIC_DEBUG_METADATA_CLS to slurp
> > any additional argument, which `pr_fmt` might add.
> >=20
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -351,7 +351,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
> >  		dump_stack();					\
> >  }
> > =20
> > -#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
> > +#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
> >  	static struct _ddebug  __aligned(8)			\
> >  	__section("__dyndbg_descs") name =3D {			\
> >  		.modname =3D KBUILD_MODNAME,			\
> > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > index f594c1266bfd..5d701952e739 100644
> > --- a/include/linux/printk.h
> > +++ b/include/linux/printk.h
> > @@ -742,7 +742,7 @@ do {									\
> >  	static DEFINE_RATELIMIT_STATE(_rs,				\
> >  				      DEFAULT_RATELIMIT_INTERVAL,	\
> >  				      DEFAULT_RATELIMIT_BURST);		\
> > -	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));		\
> > +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\ =20
>=20
> IMHO, this changes the existing behavior. The prefix added by
> pr_fmt() will no longer be stored in DEFINE_DYNAMIC_DEBUG_METADATA().
> Is this intentional, please?
>=20
> Anyway, if we do not longer pass pr_fmt(fmt) then we should not
> need to add "..." into DEFINE_DYNAMIC_DEBUG_METADATA_CLS().
>=20
> By other words, we newly pass just the format "fmt" without the parametes.
> The 4th parameter was added by pr_fmt().
>=20
>=20
> IMHO, the right solution is to keep pr_fmt(fmt) here and extend both
> BEFINE_DYNAMIC_DEBUG_METADATA() and
> DEFINE_DYNAMIC_DEBUG_METADATA_CLS()
> to accept var args. I would expect something like:
>=20
> #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
> ...
>=20
> #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)		\
> 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt, ##__VA=
_ARGS__)
>=20
>=20
> or maybe, we could "eat" the extra parameters in
> DEFINE_DYNAMIC_DEBUG_METADATA. It would mean to keep
> DEFINE_DYNAMIC_DEBUG_METADATA_CLS() as is and just add the "..." into
> DEFINE_DYNAMIC_DEBUG_METADATA(), aka
>=20
> #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)		\
> 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
>=20
>=20
> Or do I miss something, please?

Don't think that will work.
Won't you end up with ".%s" fmt as the string without the extra argument.
So you need to keep the expansion of pr_fmt() together until is is finally
substituted into a printf-like call.
It is possible to enclose it in () so it is passed as one parameter and
remove them on the final expansion.

David

>=20
> It is possible that the macros work another way. Or this depends
> on another change. I checked only this patch...
>=20
> Best Regards,
> Petr
>=20
> PS: I was curious what Sashiko says about this change and it seems
>     that it does not review this patchset from some reasons.
>=20
> >  	if (DYNAMIC_DEBUG_BRANCH(descriptor) &&				\
> >  	    __ratelimit(&_rs))						\
> >  		__dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);	\ =20
>=20

