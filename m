Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793285817;
	b=EnRb+niy58OaeKZqnSODq5KMMU19FS5QjIp+0mEJ2fqZx0Ijgf5RD5WHmGjCA35st50o
	 ZX9N1qI2jfE32MLeVsvDXGIiS3dvxkIuZizJFY4LphkpkQmSM+ZDLgtRrwcSTNBL8iqAL
	 AV85/zmBTGHTD242+FMvi5RD7i+Av95HuUvdRHOeqrTLZg5J+QMfS+EoDttl7r/oHQS7K
	 wVNy5NIsm6sFRI5kzT18qzpa0JPpeWlJihRWv3NEKvsqj2seLCZSvY2Hy/3xJZi+FKdMr
	 DqGp4s0kP+ax3cHvyndlp8lQ1Vr34zlpOtKWd+OjTA2kL0xR6upF82AeAgVxm6L+J6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793285817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=PiLUJIzj7M85elEEaNM0ojSu5Qbzbb6E3aVU0YwZNoU=;
	b=Zxig/AWypwqf/p8MjUnTHbg3ib6gj2OVrEPx3eoQlcfaC74Xr1vpRQFat5b6lsXFmbD8
	 PEY24lj0CRJD3QDiI75eJJladDwZC+yGit9KXzwjvTEDDRtHaVaM+4TgIvduY06U0UfIT
	 465JOPuvzYYKwidE3i0Aie1uVVAFYH4E8jUwjUzVFS+z2tfrOhm29lwxlEr+M/Ry1iTpc
	 T9MF4V7gzyiOFMiJGpD9DhzLCARI+eiZ9eCqMcj4FLhBhJs7rs9jc5NsiWDuIBixPOJ+o
	 frUIlYGQXid7zCzc2u80slWBYlgRhB5XAzD3rPFCKpGXTAqJlbSxKX7KZqaWFDqveiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VBBtzV54;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B283606A31F
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 14:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B283606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VBBtzV54
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c4be28b82so1992663f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 07:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793285814; x=1793890614; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PiLUJIzj7M85elEEaNM0ojSu5Qbzbb6E3aVU0YwZNoU=;
        b=VBBtzV543IUjp3L3nroXQrlC/QE6S+8gXo6jr4I0eHzp4Q3/fgQ96if7xtxcQ+VqLz
         s19qARniM3o+7h8g7xtxQPTJw/6p358LWMNXRgqkJIbnJXHxlMrWB7nJPDaF+NKET7mJ
         0JgVER0btUhOoW8vZ34IN5qvDsQpFvfF6CMOLDdw4Cr5yB+LzHLeARk1o3ukGjmCmDUt
         kXFNpVftEBMuvndsJvgf76u6usMMe1SZa9+N1Z3DTuOK6veiNZBgg/utXmh9//asLtiU
         DoqQFHQyI8iPg6OBshBXAjQR+NUPAsqfXG2eCbmRTIiNmqjpPisFlRbuRJxjKj3j8X9p
         322Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793285814; x=1793890614;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PiLUJIzj7M85elEEaNM0ojSu5Qbzbb6E3aVU0YwZNoU=;
        b=qxqnA7iHSxOQUSJorzaejmYfvz2RkjOsy6UNjUUHYQSet33zJUT24Vl5DoX/lWyJlC
         eBZi1Ab6cPgYN4gpARClMh0+NqbbNMasjkQAC4uOOSXh/WZItqlGRwEkYMWZXMl1ZSyY
         Vcba7XRNC8BWHZbE/37L5wVT2pQf8qbxY/WSJlPQ2YHVjIn6Y7Dc121PHphXOQTXKD+q
         DATGYzX+qiPKCAojjC7BTnzjk0qn7/bnmqTb5piFyEyBoienn4OfwItGLzjpH3HsyGUs
         CEXOg89di47grXIne1XX/IDmFZvXs5ma3jfvaaaQiC+/bcm9oS0Zsh+O9UgOCvbZFTc/
         bY5w==
X-Forwarded-Encrypted: i=1; AKwUvBxi9f86+p+ZLzWfMOzPp7HKJl9sWB37DCi4L2uFyJFq3OH2FyJK0m4xNuYxgALcwTACXNANRCAmWw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL6a5mTLSOHiK4Dqa8CZn9qdm+EiWEOqX0HHRx9Nb0HF72CS6VM
	1TLmq/UZoT4+2CCcHO7ZHgeXsumWxOcgarEz0jfS8fszOK3UgYVdqivdrXt+dVrCGj4=
X-Gm-Gg: AYBFou30Ga9VCi8/5FP+hAV6dhwQhh47/cfM2cV16gubh4UOHL4m5AVADkW1qeRV9f0
	ozMfsIARvDSzSsYQDZV7l0n+pJIfovAlbFhzeg19snyAxA7Z0itQDpLg4ag0d4ldQkuTkuAbm5v
	RtJIp3G8p9rHc0RvmafleA1pvpI8FszH5cKuiVd3z7q7K3VKQppfvvm2fd+COTKNu1srnadbCZP
	7irLM4MDYXKD6kxdWXA1+a78kbOEizrOYTBCGb1dm4irXn6wsqUEfxot70GdmOUrXa3k51kffXP
	F6zQtKTaGmQM+c5A0WvbXp5X/8xC3v2OMnA9apB7N+Vr5g30Zs3v0SN0oqhR+vTLl4owefvzexR
	QnkZckCHujIqdLXQwa//BDMUp9G2RPZUztxanVN9KTZ+cPEjEo6B8CgTQPfInuW4hRSJ9Z7mYA/
	hxzXeORsYa1uSg2FxvNJXIW1y1W9qyDqv6xWLAoL5sD4i/wkwbTPKHxjxdWARlVY8rxweEf19Ow
	Ad79QIArwBpBTJ7YI5P6awWq9dgkC5PIGPCPXD+VeIGciE+FnRhhnKtFD/PXSadMY5PhCk+9ceA
	03W9Sqp+XtucxX40nuXvmkfE/rMYJ9pxmsE=
X-Received: by 2002:a05:6000:290d:b0:48e:6a23:4a09 with SMTP id ffacd0b85a97d-48e6a234a62mr3002384f8f.54.1793285814407;
        Thu, 29 Oct 2026 07:56:54 -0700 (PDT)
Received: from pathway (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc39b3sm35816798f8f.10.2026.10.29.07.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:56:53 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:56:51 +0100
From: Petr Mladek <pmladek@suse.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: jim.cromie@gmail.com, Jason Baron <jbaron@akamai.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Jonathan Corbet <corbet@net.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org,
	Philipp Hahn <phahn-oss@avm.de>
Subject: Re: [PATCH v12 33/40] dyndbg: Ignore additional arguments from pr_fmt
Message-ID: <auNes2b11NqUey3C@pathway>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
 <20261012-dd-cmap-part2-clean-v12-33-3c8cc5725def@gmail.com>
 <as4W9hToBqAvbzJ-@pathway.suse.cz>
 <20261027132253.5f3a461d@pumpkin>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261027132253.5f3a461d@pumpkin>

On Tue 2026-10-27 13:22:53, David Laight wrote:
> On Tue, 13 Oct 2026 13:33:10 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > On Mon 2026-10-12 20:37:04, Jim Cromie via B4 Relay wrote:
> > > From: Philipp Hahn <phahn-oss@avm.de>
> > > 
> > > pr_fmt can be used to add a common prefix to any output from a module:
> > > 	#define pr_fmt(fmt) KBUILD_MODNAME ".%s " fmt, __func__
> > > 
> > > But adding additional arguments breaks dynamic debug:  
> > > > error: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" passed 4 arguments, but takes just 3
> > > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > > |                                                  ^
> > > > note: macro "DEFINE_DYNAMIC_DEBUG_METADATA_CLS" defined here
> > > > | #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)       \
> > > > |
> > > > error: ‘DEFINE_DYNAMIC_DEBUG_METADATA_CLS’ undeclared (first use in this function)
> > > > |         DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
> > > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
> > 
> > I wonder what this error about undeclared macro means.
> > 
> > > > note: in expansion of macro ‘DEFINE_DYNAMIC_DEBUG_METADATA’
> > > > |         DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));         \
> > > > |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > note: in expansion of macro ‘pr_debug_ratelimited’
> > > > |         pr_debug_ratelimited("%s", "Hello world!");
> > > > |         ^~~~~~~~~~~~~~~~~~~~  
> > > 
> > > Add an additional ', ...' to DEFINE_DYNAMIC_DEBUG_METADATA_CLS to slurp
> > > any additional argument, which `pr_fmt` might add.
> > > 
> > > --- a/include/linux/dynamic_debug.h
> > > +++ b/include/linux/dynamic_debug.h
> > > @@ -351,7 +351,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
> > >  		dump_stack();					\
> > >  }
> > >  
> > > -#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
> > > +#define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
> > >  	static struct _ddebug  __aligned(8)			\
> > >  	__section("__dyndbg_descs") name = {			\
> > >  		.modname = KBUILD_MODNAME,			\
> > > diff --git a/include/linux/printk.h b/include/linux/printk.h
> > > index f594c1266bfd..5d701952e739 100644
> > > --- a/include/linux/printk.h
> > > +++ b/include/linux/printk.h
> > > @@ -742,7 +742,7 @@ do {									\
> > >  	static DEFINE_RATELIMIT_STATE(_rs,				\
> > >  				      DEFAULT_RATELIMIT_INTERVAL,	\
> > >  				      DEFAULT_RATELIMIT_BURST);		\
> > > -	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, pr_fmt(fmt));		\
> > > +	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\  
> > 
> > IMHO, this changes the existing behavior. The prefix added by
> > pr_fmt() will no longer be stored in DEFINE_DYNAMIC_DEBUG_METADATA().
> > Is this intentional, please?
> > 
> > Anyway, if we do not longer pass pr_fmt(fmt) then we should not
> > need to add "..." into DEFINE_DYNAMIC_DEBUG_METADATA_CLS().
> > 
> > By other words, we newly pass just the format "fmt" without the parametes.
> > The 4th parameter was added by pr_fmt().
> > 
> > 
> > IMHO, the right solution is to keep pr_fmt(fmt) here and extend both
> > BEFINE_DYNAMIC_DEBUG_METADATA() and
> > DEFINE_DYNAMIC_DEBUG_METADATA_CLS()
> > to accept var args. I would expect something like:
> > 
> > #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt, ...)	\
> > ...
> > 
> > #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)		\
> > 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt, ##__VA_ARGS__)
> > 
> > 
> > or maybe, we could "eat" the extra parameters in
> > DEFINE_DYNAMIC_DEBUG_METADATA. It would mean to keep
> > DEFINE_DYNAMIC_DEBUG_METADATA_CLS() as is and just add the "..." into
> > DEFINE_DYNAMIC_DEBUG_METADATA(), aka
> > 
> > #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt, ...)		\
> > 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, _DPRINTK_CLASS_DFLT, fmt)
> > 
> > 
> > Or do I miss something, please?
> 
> Don't think that will work.
> Won't you end up with ".%s" fmt as the string without the extra argument.
> So you need to keep the expansion of pr_fmt() together until is is finally
> substituted into a printf-like call.
> It is possible to enclose it in () so it is passed as one parameter and
> remove them on the final expansion.

My understanding was that the format is stored in the metadata as is.
I mean that the string is not formatted in this code path. So that
the parameter values are or can be ignored. We just need to make
the compiler happy.

But I might miss something.

Best Regards,
Petr
