Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C294F30F7
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368287; cv=pass; b=J4wb0D9vPYOmWIsUvZJra1WwuEzUYdYT/qtw3zeVtTFEvDR/eWcdBnwEx6F9xdYBBMpS5LKyBY7/oxUh2zmf8e5MIQVTyxpizXKkSwSgjtkvRO7FRA31YWuBmPBuMdZdDd1yLH/A874522p3c8DHvMDARfI0DEvntTODMymkkOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368287; c=relaxed/simple;
	bh=i8K2V7iauqRYBnywpRsfGwdqYCZfWv4UWx7sJDax4N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2XnTbfLaiKR/uuFOuDbOP47kuk5HE42GoVaR3XFZHbXimS2lqaE3MSCOFgGWH+Hk5ZwjZgzhjHw2EuSMFkfcLYoCmV7K8V5UMpfj5tF7BdWLKjh6bGiPpYnB3ycUJ5vB8sZFl2ACaQmzuVhSfsKXi//bVOKLNSpTaEdOk7WUMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjpNXmLz; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjpNXmLz"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895353e9051so12489847b3.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 13:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790368282; cv=none;
        d=google.com; s=arc-20260327;
        b=QiTw1MGTjkjC9BUuh5sRT5EEh1hIWeXzHmVvQS2/usJOe3dsRu5Likc2pE24KqDEjE
         A/8srUh3G0OzR+hW1yD/i9sQrp6bry9r3feNl/WK/VlLnq4YX3XrnRc8UCf2Xh7C8sfM
         JqS+ao362vyiqY6jdVPXRTxtuuiBIXjmy+G4zBRidixanzSaSwCy9oTBLGND9xfJTSTc
         rbcmSh8GT5ASTxhMTgQg+Qia/UGf59fILyomj5Q2xuR6eUmjm2EVmfHoMWGX6vYsXfnt
         2ejdNGm44XGLRoDVh+8EYaZ2vW7sYnMSAaHKjoa4pOpfjxpnUDYU8TbBW7bjK2BWCl7m
         rPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=noxPgsc3ymzPUXdD7j20u0RQJiwVbYzVMSbEnyT4ByQ=;
        fh=zc648zXKNa6gS0QM/wEL2tnolREegM4XZfhXAGSj8AE=;
        b=LM1uh3c9FEMS9ek6RGUpmihBBp0oc50NrmiXvqngUk9C4II/eKLQpGtzblccZlCor3
         tq0gaX9plcqIUAtHk4pt5VH4OFIub7VyFH//B9xMb4HAoNw8Jq+8LzpUSpMamARxKxfe
         gSRV5A5A49ujxHLnWVkEJg5N0LbjAgnf5Svofsqlty2uO+/f0COljCVVbvNYznXGoCxV
         sf4h6yAi83aqckWUJEZLwXzhbKqA5b6kSg70PmRBZrc0cxIHO9vNKwwg9SYg5sCZl6uG
         Y9f/kVLPrq41yqA11iA0Tgq6Wm9RC1de31UG77TcUSExzUD2ctfMuOwdRJ+kkAKFymcG
         lalg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790368282; x=1790973082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=noxPgsc3ymzPUXdD7j20u0RQJiwVbYzVMSbEnyT4ByQ=;
        b=TjpNXmLzBaIdJEpWXZQ+rE33LSI7Ijg4oqvYvQ8zcO1X4TIybbM9R7tW+Rx6PJ94e6
         VL9xrMXYP5AoQ+b2+Lvexr8ZUqvzm5VAO32nn5LsfFgf7KyxWMiL3fwwKV2VAF44BJ25
         /3ZuVluFlCo490TVbBuLDq0x7fEwGBek7zym35Z9sHhXJ9/aIGj0NNK5WaxUMLABOtuy
         PaTWKoHMvq8svAdwg2t14P+TNeADlcXCbREq4dN0mDj/eq7kE8QdAwzMSbdAT13vDivf
         VrMILSLZSdZiBeMumuRGXPqK2VGB8kzp4kE3GIGtqSkT407KGvLiHAm/oVl/92qqPuzP
         cVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790368282; x=1790973082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=noxPgsc3ymzPUXdD7j20u0RQJiwVbYzVMSbEnyT4ByQ=;
        b=B25uYiPAncHfwJFUHUy4C7qZQbo7zOZlWBu/tjvCA44n8vQMFtBEPQhU37evWdYIZc
         hyRNJ8EIlNp9h2Rd/3ARuMcqiO9PsgcA/ZYKWmNHV07PgfJ3ufgEHdoQmmPFDSAiPUJm
         w7/Sm4gqMolA+4RHwpC0ZOHMp+VPoMNqvdcKxdHRnvGSC3lKYlVDhJEMX0N5p8wynPnJ
         t7n61ok3G6Kb2hvFBEEBxDbx44wJQgs1xR7HI+a8loj5Fwa+KkTwYqNDyioipvFZUJnw
         vVLbsI47d+VxMXpSH4D9dDf0at+7GBVCQM8Mlmt2lCNOu572JZBHVoCya+982HAzX/te
         M5Xg==
X-Forwarded-Encrypted: i=1; AKwUvBwftIitWMfHMXIPWWIxYV49XixyFsvOhFnbf8tUjy9Xko5B8jd5dGCFfrciSvRBdHLamqaDHt/UDQ==@vger.kernel.org
X-Gm-Message-State: AFuF++krTQXfkkZ1KJ5u7mj7/WQmHKd25Nl009F+NitvNH+1ZAXFuBcF
	dpJQkswpucpVHcsFHBz210aElBDOk0Fb0f+FfM7SiiigKSPJE4GHRnsIoE37l3M4ursILrKbjaO
	Mbz9MoLnA9r9NLqM8iRWmriHKHKleZTo=
X-Gm-Gg: AYBFou0NgtqZghCBFXOIO4uz4wRnwHgSHRVKIccAd+PtIB02y2zLI5Dnu7/m9zULF3U
	IePmh4nsMQZP+WB5RLN/Yx37hYZin3PmVURnwurld6ryq26wXo0PSmkxhEKtgaICZ+6FO6cwrRW
	D1sDFuMCx+3TSgWzYa24cp3dAZbWjnWgo1OSnA7c8GsRiwm6mSwjk/j4UOryS4WuHEYLRW7uDVx
	l43eizu1ep0EQ6oWgB42oLPRQPydKQzKezzZRDpQEPBOVp+FCmMaa1eXlRMdBe8mT+6IFXpzRSQ
	ScJiP281vAWBG4Aq7L6hhFJGKNLLKTjMd55VBzFxQZTBFFViZR3L1pZ5sih2CvbIwXQcJu3LFt6
	hCAfPnGr67TPPWfHNzgIMaCgMCcJQV0d5OQ==
X-Received: by 2002:a05:690e:1382:b0:672:a289:7b0 with SMTP id
 956f58d0204a3-672ed93a88emr3463724d50.76.1790368282266; Fri, 25 Sep 2026
 13:31:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com> <20260923155339.bdc677e8e688611bcf190ad9@linux-foundation.org>
In-Reply-To: <20260923155339.bdc677e8e688611bcf190ad9@linux-foundation.org>
From: jim.cromie@gmail.com
Date: Fri, 25 Sep 2026 14:30:54 -0600
X-Gm-Features: AclHuK81aQy7pcphOyoCN0Cv4efDR1k93Uxkj909m52hc-_PgnQGdKhUE2sknH8
Message-ID: <CAJfuBxxd8hMf0OcnOK+w-QyizaKY=WA4VL+fyoD3y6EsHW1+og@mail.gmail.com>
Subject: Re: [PATCH v11 00/38] dyndbg: Fix classmaps API for subsystems, query
 extensions, selftests
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@net.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
	Louis Chauvet <louis.chauvet@bootlin.com>, Philipp Hahn <phahn-oss@avm.de>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:53=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 23 Sep 2026 16:34:24 -0600 Jim Cromie <jim.cromie@gmail.com> wrot=
e:
>
> > The drm subsystem has *lots* of debug statements, in 11 categories:
> >
> >  $> git grep '\w*_dbg' drivers/gpu/drm/ | wc
> >    5663   30159  542864
>
> Methinks this regexp was overly promiscuous, but point taken.
>
> >  $> git grep 'DRM_DEBUG\w*' drivers/gpu/drm/ | wc
> >    2206   12834  202332
> >
> > All of these are bit-tests on __drm_debug, exposed to users as
> > /sys/module/drm/parameters/debug. Many of these are done often;
> > vblank is done ~100/sec for some displays. Over the uptime of many
> > boxes, this is a lot of cpu cycles on bits that are almost always off.
>
> A __test_bit (or |) every 10ms sounds quite negligible?
>
> Especially if __drm_debug is __read_mostly.  Which it isn't, afaict.
> Um, low-hanging fruit?
>

__drm_debug certainly qualifies.
I will send the patch, separately.

patch 37 adds a +c flag, to count invocations of flagged callsites
it counted 5M calls in 60 sec.  or 83 KHz.
That seems "fast-ish" at least,
perhaps worthy of a static-key over a __read_mostly



> > Dynamic-debug excels at replacing such tests with NOOPs (via static
> > keys). Classmaps was devised to bring that 0-off-cost to drm's
> > categories.
> >
> > Classmaps-v1 went into the kernel in Sept 2022, in 2 chunks:
> >   b7b4eebdba7b..6ea3bf466ac6    # core dyndbg changes
> >   0406faf25fb1..ee7d633f2dfb    # drm adoption
> >
> > Sadly DRM-CI found a regression during init with drm.debug=3D<initval>;
> > the static-keys underneath the drm-dbgs in drm.ko got enabled, but
> > those in drivers & helpers did not.
> >
> > So in Feb 2023, it got pulled:
> > commit bb2ff6c27bc9 ("drm: Disable dynamic debug as broken")
> >
> > Root Problem:
> >
> > DECLARE_DYNDBG_CLASSMAP defined the classmap, but its repeated use in
> > both core and drivers violated a K&R rule "define once, refer
> > afterwards". This flaw resulted in a regression; with drm.debug=3D0xFF
> > boot arg, drm-core got enabled, but drivers/helpers did not.
> >
> > This patchset replaces DECLARE_DYNDBG_CLASSMAP with:
> > - DYNAMIC_DEBUG_CLASSMAP_DEFINE (invoked once in the exporting module)
> > - DYNAMIC_DEBUG_CLASSMAP_USE (invoked repeatedly in drivers & helpers)
> >
> > _DEFINE exports the classmap it creates (in drm.ko), and other modules
> > _USE the classmap. The _USE adds a record referencing the _DEFINEd (&
> > exported) classmap in a 2nd __dyndbg_class_users section.
> >
> > At modprobe, dyndbg scans the new section after __dyndbg_class_maps,
> > follows the linkage to the _DEFINEr module, finds the (optional)
> > kernel-param controlling the classmap, examines its drm.debug=3D<initva=
l>,
> > and applies it to the module being initialized.
> >
> > To recapitulate the multi-module problem wo DRM involvement, we add:
> >
> > - tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh:
> >   Alters pr_debugs in builtins and test modules,
> >   checks results against checksums of expected results
> >
> > - lib/test_dynamic_debug.c & test_dynamic_debug_submod.c:
> >   Builds parent & _submod modules with _DEFINE and _USE inside #if/#els=
e
> >   blocks, reproducing the 2-module scenario under selftests.
>
> So what I'm understanding is that this series presently has no effect
> upon DRM?

I have 2-3 DRM adaptation patches,
then a single 1-liner patch per driver,
to get DRM using the new API.

39 patches seemed big enough for now,
if you'd like the rest tacked on, Im happy to do so.


> What subsystems *does* it affect?



>
> Sashiko had quite a bit to say.  It hasn't quite completed at present.
>         https://sashiko.dev/#/patchset/20260923-dd-cmap-part2-clean-v11-0=
-9b6c217fdf2f@gmail.com
