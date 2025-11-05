Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A232C0276
	for <linux-pm@vger.kernel.org>; Wed,  5 Nov 2025 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762324054; cv=none; b=HEAkC7nkM/+yr5Rw2zm8gE2/SdZJPr3EsL+iG/mmu0qfpyQCkHFulMgA2EmobSOYWZNxO4CdaXkAvsUwj6imEC4GCYKNG95d5aDfbJwLcT/T7y1+fT2MdllK9mY9ngSTGipJivoTyH/7LBxyIzUpDgk5xay9Ze6csiR3P6ovOnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762324054; c=relaxed/simple;
	bh=M6FUQeUrV5rYIQp0llWDN3mc7Yy127273TKo86Q9E1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xsb8XQZ2I31eqT/d7/ax2r94FoIreJ7GgJvJ88JJe1J0igkpbVFybIqdyDkFodBbBMwXBsY8j9kkfze9EquUluO+iDDEkVBcwixhqzxC1b9mkgi0nPkVfBHGYUUU/1u2CnjK7wX6M7PobdAfZsvwFhNkDpvR7UOS4xo3N+J6rhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YctSue6G; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YctSue6G"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so6145984b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Nov 2025 22:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762324052; x=1762928852; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qRgQgDQGc0CtCpQFbq1uegdY2ZYKmCrZ81QG9UF3aXw=;
        b=YctSue6GHuVbKwzerLpAKfKHFlDkM+OmFKklCH//rfpl1MnUJsO/n9dwzOig9S2Ix3
         UEw5hivpJUPDueR1c4IW3TsUbp0s4tIJXFMuIEerd3KWfWMJ3dFpsl+BGfO/5imiHMy4
         VtXaf6lPu0JDs4eoo/8WM0/4DCqBblakFobeKMPqyzXlUq5Hzf4B15cb5Ru2Dm92wmR0
         IT0mBo/MvzAN3hfdCjKe4WMcHtLatmsVN00+krMgVcrQdoM5DT55brHOaFlJA8hcFG1S
         Sx9jog7Ho3T9Y5LesfC5lCfP1l8+6/iE7vFHNstIk8EmIiud0XeDxxiiIqMLa4j1WwW/
         b8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762324052; x=1762928852;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qRgQgDQGc0CtCpQFbq1uegdY2ZYKmCrZ81QG9UF3aXw=;
        b=MWiiqQDPKkYLrbbCvKCVtA44TCE7tCta19eTLu09KY5vYwt241AqyW3T/+BFw8A9nq
         MsZX2Aj9BAvxZ/SWL+p2lD5lRHKdczVbpascPR18NdpUcIxziND5gl+mZ9b/8LIVKKs+
         bnO/QTaU1fu2CJ82RmV3exla44/yhIf+ebvCLGpBsjXpU+XhOf0FcCSb1UpqpGKfueLt
         a8e1H+UShcfQECwWfJ8zLiBu8EVEVNW0L/SeKiEDJapfnUKVDQUSagl6TYLnSQfbga5G
         6xZLzUvgszxtwiOPzy6M79DQb7zi/JSKadZ0g63pG2DiuGcpSq8rv3jhx03XmJ4NfE8H
         liMA==
X-Forwarded-Encrypted: i=1; AJvYcCX115+X5udSgj+45VCCdefxZUFsZ3sTlWo2Yog0d3npppfbZPUMm7G2LgNryhzmHbVZMY8RdGi4bQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxiQ5FcYNOAxsQeZ14/8h+xIjNKX7FTc/us5AoOi0YlhR0jSTze
	Q2754eu1HMS0pFlvDBI9LAqMFM6cfXlaW2ZhY1ylZ/EHblmIayZW9RM/
X-Gm-Gg: ASbGncsiT9RzcSFmr9sAzoIRjCNJ92DkvdJbCdfHZ5UydgFoRwFTiwUyBPTkd8UFxcG
	xrOrizTcjRNp+Td8zWJd8gCVCmC3KpVHcqaQpSTIlxW8C9FoLP8JY7mVf5EHoN+Qo6bDQmyAYlv
	s6DE4Q+gyfsgntoa9ynwJrv1Uh/uft6771toJnK2TTjKIIf7jk8c5Xd770K/BPOgGZQi2h/bAFr
	IzHOR8/gxs0scL+XaEJZRCLuf6XSJgnAYB/fL3YN4Jlc/13uy//3sYzO4+MmuQFZ8/kp44wAEkf
	Rbx50ewiTr0QtzD9/J//m7R5urVgMg2j/JS/jFLftu10CLSq74Ckmk4vLnX3YxiPRDLBmZxEdzZ
	cdKH6XvKiOy+V3ZUHNmW77yKmHvrlH2qG8WpLpXhZ148TvhHOrNk8Kue/LhSOpUUFuBWiQinIXh
	fW2Zn5FmfAmR7ZaS45SSqkB6j9Yu6GF/UL9z/I7Mxp4zd+5VaD
X-Google-Smtp-Source: AGHT+IH0CHanNbujuWYsueCqQMvQb7Pe6lyE4kMBe2/tOk0WkpZ70b1GaoCWJdrL37L5RenwOdPqcg==
X-Received: by 2002:a05:6a00:2382:b0:781:1b5a:95b2 with SMTP id d2e1a72fcca58-7ae1f9856c7mr2725237b3a.28.1762324051551;
        Tue, 04 Nov 2025 22:27:31 -0800 (PST)
Received: from ?IPv6:2401:4900:88f4:f6c4:1b8d:9d63:3da2:d477? ([2401:4900:88f4:f6c4:1b8d:9d63:3da2:d477])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ae9c8e19bfsm669795b3a.65.2025.11.04.22.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 22:27:31 -0800 (PST)
Message-ID: <5bcc00da02d4f5e44a8fabcde406402ca31f0491.camel@gmail.com>
Subject: Re: [PATCH RESEND v3] checkpatch: add uninitialized pointer with
 __free attribute check
From: ally heev <allyheev@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn	
 <lukas.bulwahn@gmail.com>, Joe Perches <joe@perches.com>, Jonathan Corbet	
 <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>,
 workflows@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dan Carpenter	 <dan.carpenter@linaro.org>,
 David Hunter <david.hunter.linux@gmail.com>,  Shuah Khan
 <skhan@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>,  Stephen Boyd <sboyd@kernel.org>, linux-pm
 <linux-pm@vger.kernel.org>, dan.j.williams@intel.com
Date: Wed, 05 Nov 2025 11:57:23 +0530
In-Reply-To: <CAMuHMdV+12MoAGNHC9kf==Bt0cLuJ39Fs+W61DN67sE_p-u=og@mail.gmail.com>
References: 
	<20251104-aheev-checkpatch-uninitialized-free-v3-1-d94ccef4917a@gmail.com>
	 <CAMuHMdV+12MoAGNHC9kf==Bt0cLuJ39Fs+W61DN67sE_p-u=og@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 14:28 +0100, Geert Uytterhoeven wrote:
> Hi Ally,
>=20
> On Tue, 4 Nov 2025 at 10:58, Ally Heev <allyheev@gmail.com> wrote:
> > uninitialized pointers with __free attribute can cause undefined
> > behaviour as the memory allocated to the pointer is freed
> > automatically when the pointer goes out of scope.
> > add check in checkpatch to detect such issues
> >=20
> > Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Link: https://lore.kernel.org/all/8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@=
suswa.mountain/
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ally Heev <allyheev@gmail.com>
>=20
> Thanks for your patch!
>=20
> > --- a/Documentation/dev-tools/checkpatch.rst
> > +++ b/Documentation/dev-tools/checkpatch.rst
> > @@ -1009,6 +1009,11 @@ Functions and Variables
> >=20
> >        return bar;
> >=20
> > +  **UNINITIALIZED_PTR_WITH_FREE**
> > +    Pointers with __free attribute should be initialized. Not doing so
> > +    may lead to undefined behavior as the memory allocated (garbage,
> > +    in case not initialized) to the pointer is freed automatically
> > +    when the pointer goes out of scope.
>=20
> I think this is misleading, and can be improved: if the pointer is
> uninitialized, no memory was allocated?

yeah right. Will update in next version

Regards,
Ally

