Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11A44AA3F3
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150875; cv=pass; b=rWnLJxlEuPE6Aqxu4rJfuuGYH6z5qzW5iMcXJYVlCzJDMNtN+vqPMT0N9FhfPhokHfJojDkiqLaOm3dEK1QgkLuysOVO3RqNPYoOezrwVgF7yp/VRK9OhcQASMr9IYraRmhcGPIn3Zls2kgcq3O2DSMgnMH1bdDiEv0tmEgmELo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150875; c=relaxed/simple;
	bh=ospiNi4mvJbHDyKvltQYpdK+X0l90zSr5sr0fKih89Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvrTAoNl+YPNmD0RxBWH6V3i5dgm9JABTe6kqsI6IYg7lEWu2nZXoxkXDRtQmj39XLENoV0a31nIEjOm7gcg7XnfN4VNBqPdEZQrbBvL/NSrwCzrGF7CY8jNarKTZFcThxJB3j1QZ5gDqopt5h5GkSPvpsoGXi3BTBTykO1/5Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePCVvAZO; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePCVvAZO"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-671061b015eso1382166d50.1
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 11:21:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789150869; cv=none;
        d=google.com; s=arc-20260327;
        b=ZxYZ60eT63YIeL8lK3jlZfUbMWAp1KClb8muxEy6D51slCNvuPD1yOlCxFZ0iRoOUz
         imhKlP2nmobcYPsw/4NfnEBeLtTfuNhUekAKqtk8P58YBse1Zare/jOQAiRm0fm6qsIZ
         EfZ7ILE+JKWiXxNX+Qg7zo8zcKYhz9YG30DLvrKdS9KpsyeOg6FemboHJrVydqrD6x67
         fKR9A0n4Mc1DovgDt0mmF+u6rLtXsmug2Sg1W56j0ImfYfwz4pIk7NJSOTSBGV/kspcg
         jXyp7Te/JTRcnYQxZNXRdU51CIATaiQd0gASjyQZTwW18liTs6dAXCyo6tceufLUj1xv
         b1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0PfkoOh/05AN64bzT3WIDHrUSVJxMax1VSqub7HGYzA=;
        fh=5etonGnSGTqp6tSuG8PNG5KtEvCezSSYh9bJjULrqzw=;
        b=S4TZJsz+4Zp6Qi2PJ4PDnbzqb+bjdASkotSxFW001sqHJk/gMpzhWMTQTpU9Wwczzf
         Y9Ef0ChaikfaIJgEeLQ3QjIsne3RkPXIglDBrbDhTr7QF1tjITA+kIH/hcR8Vm44OHFa
         Np2NdbeV4XShrWEfWJYZLDtQLsv8oX2ZnHQ/0o/2S4quIpmh9BdIkeqLs6EBZMscTyzo
         ivIJDWQBfKo5P5TqZnDlCVLybo0n1bw/1pMwzSyw2MnN4BXAOmcjl2KnsDED3CjS2Vp+
         ZnwY0/73I02D+KWNZNFAAXtnpB1eYUrfgjNzdNBmaIt+IUJFolaHjV4XskI7MtRl8xX0
         PKIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789150869; x=1789755669; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0PfkoOh/05AN64bzT3WIDHrUSVJxMax1VSqub7HGYzA=;
        b=ePCVvAZOucaz3Du47vnaY9QiJGuFrq1XOFX02ygIGcK1FQy5t51WCZKYoRQ/tle3Q4
         cYiOCpZXhnTkCaKOJzRJLpR8ewpUnvkjWb1nZ2dXSELWFaNGg1qwwc/H7V2cL0wpBB/v
         X4iG4JGUEOjjlYm03AzyX8lNEgUEHrNpVqtBg1djc7q4SBB/iPUMdrPLpM60Cbx7J8OM
         h6MqfewHF2jo2/keKX430BMY9hcaS/brOaf2A9JxYddMp6S57AscbktbaPdXRLbTArLt
         HZWqPl9Grw5LnoUOy1LOGjXoppBJs9gKO4DP2Hjq7ouEzagLKTZ0KDVkpxBzvrWFCzu8
         SruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150869; x=1789755669;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0PfkoOh/05AN64bzT3WIDHrUSVJxMax1VSqub7HGYzA=;
        b=D9RYRuOrtL+dM6cJYu0uGaWqEKGFiZraVGrdyjvKT0/Cx2nglPfyKjH1VpWKEWcFX2
         aMDbrO+HKLDpDtIs7QNEuMgPDevi0g/cTfTVxLZCA8YGWSbzbUWdC4YIpCFi5WQTSBmg
         GkYPtcXYn2FE/t1FyvYWuoscf4bB22jW3y91HVvlwYv/xUK1+HfHRpuQSbqYSZ9D42d+
         Cseh+dfOtO8wh6f6JO1LA19MOSieeulLF4eLuf8zkYCJlcuVYli/A1zrH/Yt6D4Io326
         3lUhqJixaJA3Dyc6LgyCoyOCcyeJp0Inv6PiYcg9n5iqL4n9uxWLH2FhKbLvfJRizBI0
         F1fA==
X-Forwarded-Encrypted: i=1; AKwUvBxdjhYrSrqnRwnpKNfD89MJ82RU07DX71euyXg/xYcgvI+aKnYxnjGbXR6uQuSWTCtTgVKE9Jm0DQ==@vger.kernel.org
X-Gm-Message-State: AFuF++n1vvLtHkotDoRM/sI9MpG9bM7ATYplXCNaftNMMKjVcA4qdftQ
	4MwpOiv+yelTQgQrP/iTNeXrqw14tdqGF/VtBNgjwPKuVK6mJh6eM0C1tdVbTOvfjHVeggHy8tY
	I/cgOk/wFpb64hkxcV4/Kw+8Oz89J+is=
X-Gm-Gg: AYBFou1n0cziPa0dBrRY/IDhn7UItQ9IuAQdFQJWxI7n/yW87iCg+B+rvNYs/GtQmxp
	T1o0Fvs6EdPFKlnFLnF6ZoiZB/K7LdwjyMrrd2UqthMbn6tBJbRyEE9piuiG9axa5qx8MbKfrsZ
	C5ssxvobipYCOlxpntCRRYYotZ+4bFMJMOpAeNJ+FPQe9vibejybjpHeaBXJlIsh15NFAItVXqx
	JS4N0YGAWar+ZkY8Qc++MUy+sPavw4v2T3AZuUj8+Dctl7fJlXD0EUwMqtPg/OqMDl75h//MkS7
	9PzEvbbBeQgcs+l0pSbMuWyaLOho2c8jLbPuT5Oz+L8uq5Fp9+v0iiFLbfEz7evluDP7/mOAkHa
	um8HPQydiSRY89HIo6UIxUqhy2soxBwvpDw==
X-Received: by 2002:a05:690e:450f:20b0:66f:c1bc:c072 with SMTP id
 956f58d0204a3-671246c1531mr1637688d50.58.1789150864802; Fri, 11 Sep 2026
 11:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-dd-cmap-part2-clean-v9-0-3a3f621f4a10@gmail.com>
 <20260908-dd-cmap-part2-clean-v9-15-3a3f621f4a10@gmail.com> <20260909-primitive-nano-hound-8ee2aa@l-nschier-aarch64>
In-Reply-To: <20260909-primitive-nano-hound-8ee2aa@l-nschier-aarch64>
From: jim.cromie@gmail.com
Date: Fri, 11 Sep 2026 12:20:38 -0600
X-Gm-Features: AcwNN1UJu3AgSAwYav9ulJp2R_HPP-fzpsFCD13LL3sQevEBQ_irSbDy0UqSCw8
Message-ID: <CAJfuBxx0VFCS820JLqawLdcpb49Nj-=xnSYdg6ytOub6NidM4A@mail.gmail.com>
Subject: Re: [PATCH v9 15/39] kbuild, dyndbg: Clean up builtin module-name ambiguities
To: Nicolas Schier <n.schier@fritz.com>
Cc: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@net.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 9:50=E2=80=AFAM Nicolas Schier <n.schier@fritz.com> =
wrote:
>
> On Tue, Sep 08, 2026 at 06:55:11PM -0600, Jim Cromie via B4 Relay wrote:
> [...]
>
> > diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Docume=
ntation/admin-guide/dynamic-debug-howto.rst
> > index 9c2f096ed1d8..99bbae37d34e 100644
> > --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> > +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> [...]
> > @@ -161,17 +161,21 @@ file
> >       file kernel/freezer.c   # ie column 1 of control file
> >       file drivers/usb/*      # all callsites under it
> >       file inode.c:start_*    # parse :tail as a func (above)
> > -     file inode.c:1-100      # parse :tail as a line-range (above)
> > +     file inode.c:1-100      # parse :tail as a line-range (below)
> >
> >  module
> > -    The given string is compared against the module name
> > -    of each callsite.  The module name is the string as
> > -    seen in ``lsmod``, i.e. without the directory or the ``.ko``
> > -    suffix and with ``-`` changed to ``_``.  Examples::
> > -
> > -     module sunrpc
> > -     module nfsd
> > -     module drm*     # both drm, drm_kms_helper
> > +    The query string is compared against the subsystem module name of
> > +    each callsite, as shown in the control file, or its simple name.
> > +    The simple module name is the string as seen in ``lsmod``,
> > +    i.e. without the directory or the ``.ko`` suffix and with ``-``
> > +    changed to ``_``.
> > +    Examples::
> > +
> > +        module nfsd        # simple modname (as from lsmod)
> > +     module init/main   # subsystem modname (as in control file)
> > +     module */main      # any subsystem ending in main
> > +        module main     # simple modname, selects same as above
> > +     module drm*        # both drm, drm_kms_helper
>
> The five lines above have mixed indentation, please switch them all to
> one tab (no spaces).
>

thanks, will fix.

>
> [...]
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 0a4fdd8bd975..e129c4d10ed8 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -23,6 +23,32 @@ modname_flags  =3D -DKBUILD_MODNAME=3D$(call name-fi=
x,$(modname)) \
> >                -D__KBUILD_MODNAME=3D$(call name-fix-token,$(modname))
> >  modfile_flags  =3D -DKBUILD_MODFILE=3D$(call stringify,$(modfile))
> >
> > +# Dynamic debug subsystem modname with clean heuristic and override su=
pport
> > +dd_modname_override =3D $(strip $(firstword $(DD_MODNAME_$(target-stem=
).o) \
> > +                                       $(DD_MODNAME)))
> > +dd_obj :=3D $(strip $(filter-out .,\
> > +             $(patsubst drivers/%,%,\
> > +             $(patsubst arch/$(SRCARCH)/%,%,\
> > +             $(patsubst arch/%/,%,$(obj))))))
>
> May it become problematic if there is a conflict with
>
>   arch/sh/drivers/dma/*
>   arch/sh/drivers/pci/*
>
> vs.
>
>   drivers/dma/*
>   drivers/pci/*
>
> ?

2 questions here really -
- what should happen ?   strip arch/sh/ and then also drivers ?
- what will happen - I will play with the expressions to find out.


>
>
> > +dd_modname_default =3D $(strip $(if $(filter $(notdir $(obj)),$(__modn=
ame)),\
> > +                      $(__modname),\
> > +                      $(if $(filter main core common util init snapsho=
t \
> > +                                    process,$(__modname)),\
> > +                          $(dd_obj),\
> > +                          $(if $(word 2,$(__modname)),\
> > +                              $(dd_obj),\
> > +                              $(if $(dd_obj),$(dd_obj),$(__modname))))=
))
>
> This looks quite complex.  I _think_ this should be equivalent, but
> perhaps a bit more simple to maintenance:
>
> dd_modname_default =3D \
>     $(or \
>         $(filter $(notdir obj), $(__modname)), \
>         $(filter-out main core common util init snapshot process, $(__mod=
name)), \
>         $(dd_obj)))
>
> (Removed $(strip) and the last $(__modname) fallback as both are already
> in definition of 'dd_modname'.)
>
> What do you think?

it does read better.  I will try it too.





> > +dd_modname =3D $(strip $(or $(dd_modname_override),\
> > +                       $(dd_modname_default),\
> > +                       $(__modname)))
> > +dd-name-subst =3D $(subst $(comma),_,$(subst -,_,$(strip $1)))
> > +dd-name-fix-token =3D $(subst $(space),_,$(call dd-name-subst,$1))
> > +dd_tok =3D $(call dd-name-fix-token,$(dd_modname))
> > +dd_modname_flags =3D $(if $(dd_modname),\
> > +     -DKBUILD_DD_MODNAME=3D$(call stringify,$(dd_tok)))
> > +
> > +modfile_flags +=3D $(dd_modname_flags)
>
> dd-name-subst and dd-name-fix-token are not needed, dd_modname_flags is
> used only once and can be folded:
>
>
> dd_tok =3D $(call name-fix,$(subst $(space),_,$(dd_modname)))
>
> modfile_flags +=3D $(if (dd_modname), -DKBUILD_DD_MODNAME=3D$(dd_tok))
>

yes, this all looks cleaner and more comprehensible. thanks.

>

>
>
> --
> Nicolas
