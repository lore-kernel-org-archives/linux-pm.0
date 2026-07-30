Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484903939BC
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449341; cv=pass; b=bwRgie18KMcBIyONQ9n6+FVqj4VUe84Iyu76hFNAPnsQceMulHiaN2tUBUjrS0cQHCTZBMg9YJ5rHLeizGmUMUa/+U7lVRTR+ecBKmAqZW29YR2LlGGEquOqWE0NGZ9OztLdzxz6ZHEvvaNsK01fIAR343Zm9Mx6UQ6C33Az7I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449341; c=relaxed/simple;
	bh=2dK4sfM1RIGKBm15KQ5O7/X7SkT+i+aDhkG3TV91y+U=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jRIOUWRZDxCjPNV2kir+nGXMzFiAQQ1Hg1vXGLIEYKRNoWdveDquvcry9x+czMZLgSv6OnwL/xDl3n1Gn0fsOiF5Ok25kMA/N6slM/hkxlP5KSqz+HQV+S1P7MdgwyafqOaomBndXN+TPtYbz+h0spPbxDQ305WgIeiUCX5tBho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=si/dR2d1; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="si/dR2d1"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81ed2a00f12so4862607b3.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 15:09:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785449339; cv=none;
        d=google.com; s=arc-20260327;
        b=Yv2CjyguCUNZG54smhvrAiWaWmUEgIrw/scmd3JiNCbek9683yyYER/KfEsZu4fOxW
         swqzgtj5kF95O38fnwJ4ICPn3cTQDsurAWWmg+jkDkCfg89xEszsjlFK6Q1k2vljtd0S
         n5QIvpMAoJqSzh7jDbB9j6S5Odc/l8kvWlQ0ZQOzUTp5FcjpGCX+e1gN0zty2wYAPLkk
         pqWOv0jzDlsmGQ1EaZAvrpNUYjrl2Gn/OuPewUkfcMp3GxDPc6VPPVMZYfw2dU8ycqBX
         xWS7ynuPui6LMwk/s/MfG1h64Dc9XNZNkTbzA7gNOu2aoXZOjw7UoHfNGBxP5cvtlHCv
         scZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=2dK4sfM1RIGKBm15KQ5O7/X7SkT+i+aDhkG3TV91y+U=;
        fh=R5J/ezV5Cf4C7pBJh16GJteLQTRh6ctdBSNVwQbknmU=;
        b=m4T9mXZti7uu60RoT8CMKDUFPWZI0ooh1OI5vBjsUsZK91zRh7bP0jT823vXruPibT
         JwJzVF2qdyzUQDx6vaKg9jy6pZvwRkHtGtpDFzonwjkeLJiCf7d0cfb+2lIbnUrBqqUR
         enqcoevsZrACFjS6rjTfOGNHV6iG66kl3tfuCe3aNMgVYDh4UClb76ktEip60h/BQ7eI
         t+E9WTiUSddL+Cphw0RgRpABk+a15XQR+/I06AQV12zM4ZS/LxlFa/JeJ0mWsK0p4uNF
         9JCL8RAePhAogA9zv1X9b6eQJGtc1gFWOwMCWbGB1Umyhb0F5UvZFqVznuNZeGo3pWDz
         nfyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785449339; x=1786054139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2dK4sfM1RIGKBm15KQ5O7/X7SkT+i+aDhkG3TV91y+U=;
        b=si/dR2d15tBXW3SZarnLgx3mjNkZDdUkqfpBZmAnQeUFvGU3VYDp9pxYewCifZGkUR
         O2lkXu2Z0l6j3+dH1oDZys+QOl80yuVPiAvas1O3calALNZ1WFqzkJtJpn9yOGG4xTcn
         tZldUzdW1eX4IJWnAm0LLRD4Y/QfDWxjnD+FvfaFyyR1mnwTZrexm6aZgJIqS/lhI0pg
         SPbMRhlQ9pKDqxZ5+4sypeTEwaLhkr5P+/18Xw8nyGidOSE3RiYQfoT/v0xVZ+UDBT/X
         hH+voW6LDcQZN9K300laJahwEfeN7f3IE/IlBxyARQiVkU3/6zvn4XhLcHRfwe4kiSco
         KMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785449339; x=1786054139;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2dK4sfM1RIGKBm15KQ5O7/X7SkT+i+aDhkG3TV91y+U=;
        b=ddDUwbiS6XxT0WZINNJjYu3+mAqjPEqFtBNRj5nd2vQkEnGrr9tzpeT5Vormf87aEO
         RoZ6mJMpW5G/6SO4qCBy2M7gDuzLbxW3PV0f0VAbiiJFh7zjlFlyCsCj1HsKqYM+jVO9
         xdVBibxDaO7/UKQEk1T5OLkW093DwH2CyAhkJxU7qgyUR34uDL4G3pCGdiAratjhbsIR
         4+xURzeTJfts0flZdgsDZDc5lTJfO6S2Ak1vJaka78LF/N2ZUDQiw5nuVNG3YaLsy0cG
         cx6NPzJ1jfBDtMnM3eAFjKEpxGY2hMe3mCZhbF7Zizadq1/eRHlaxp5SNu1gIBS8wswT
         HTZg==
X-Forwarded-Encrypted: i=1; AHgh+RpKCDpN94jLkEy3DLNX3SnohTebvbUqhgAqPg4JHOExJq0yfGeeRiF8qc7w/iPUBpD9tMFvpjNlIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn/ZSysO7E5CCPoJh+xuao1QGGbb2vOUcDRONESX8tw8f8vJjV
	cUUPut1tvdQSBYKIZsv+8pGXLNEuzM8yz86bX41kmIkSbq4JdVE6V7lz70bZQCIM6Ch7U/LUcZE
	rdlra77oyVOTUJIyusPohfobbYmZqKL8=
X-Gm-Gg: AR+sD12f+Q3nSsc3KNqZH/1RgqamUGsmO08nCERyaFNnDhg6HBOTpkwD1YBzejxO8zy
	78e9oVHIYWYDvBXsR1fyQKKHRVHSVvYNwGyA+94frwIcfX6qnQO4IdeZxgGdr8FcxLxJwYGag2+
	Q9r2ejXLvJUBjwirQi59jZdAnPGnYlbyY/2BwB7Q8eKRe+WvB5WWmCn6ydnIwEPrnq1XmUAM9WA
	khTIlFjllD3+zgAMX7AsYvUAC5jGeK38e+sBDPCX5JFawDq89f9Nh1uUSmeektjugRBlhgLlqOz
	59XMN7ozUfB9Xy6+zdunRd0UNOOzjwFv54RlVUU+Jdtr8cGArNeNtLE=
X-Received: by 2002:a05:690c:4b81:b0:81d:af23:964 with SMTP id
 00721157ae682-81fb8a39752mr33388687b3.40.1785449339134; Thu, 30 Jul 2026
 15:08:59 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 30 Jul 2026 15:08:58 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 30 Jul 2026 15:08:58 -0700
In-Reply-To: <e2c30baa-4994-4d4d-9c67-d9e4389dfb4d@amd.com>
References: <20260624123135.7193-1-alhouseenyousef@gmail.com>
 <CAJZ5v0hE8RyBwi6imwgzADMaRzL8FrD95KeH+Eo54rfXboyggg@mail.gmail.com>
 <d4839dda-75c3-4a82-bad0-8ae29e67c16c@amd.com> <e2c30baa-4994-4d4d-9c67-d9e4389dfb4d@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Thu, 30 Jul 2026 15:08:58 -0700
X-Gm-Features: AUfX_mxF5zceUpTMQnzec0AfGivWi_2gPS710L0K-j7OfKxnFHSrnKi4BnBhk74
Message-ID: <CAMuQ4bW_uKyvrh3MD2S2E5EL-cedty0QCP2-LTGaoUQ+kK=1pw@mail.gmail.com>
Subject: Re: [PATCH] tools/power: amd_pstate_trace: fix help path dependencies
To: kprateek.nayak@amd.com, rafael@kernel.org, mario.limonciello@amd.com
Cc: ray.huang@amd.com, perry.yuan@amd.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prateek, Mario,

Agreed. Moving the NumPy import below argument parsing is not the
right way to manage a required dependency. Please drop this version.

I will keep the NumPy import at module scope, split out the narrow -h
output fix, and handle dependency/venv documentation separately after
verifying the shared requirements for both tracers. The unused Gnuplot
import in amd_pstate_trace can still be removed as a separate cleanup.

Thanks for the guidance.

Regards,
Yousef

On Wed, 22 Jul 2026 10:32:41 -0500, Mario Limonciello
<mario.limonciello@amd.com> wrote:
> On 7/22/26 10:21, K Prateek Nayak wrote:
> > Hello Rafael,
> >
> > On 7/22/2026 6:18 PM, Rafael J. Wysocki (Intel) wrote:
> >> On Wed, Jun 24, 2026 at 2:31=E2=80=AFPM Yousef Alhouseen
> >> <alhouseenyousef@gmail.com> wrote:
> >>>
> >>> amd_pstate_trace imports Gnuplot and numpy before parsing command-lin=
e
> >>> options. As a result, even "-h" fails if those optional runtime modul=
es are
> >>> not installed.
> >>>
> >>> It also handles "-h" by printing a blank line and exiting. Use the ex=
isting
> >>> help printer for "-h", and move the numpy import to the path that nee=
ds it.
> >>> The direct Gnuplot import is unused, so remove it.
> >>>
> >>> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> >>
> >> AMD folks, if this change is fine with you, I can take it into
> >> pm-tools, but an ACK (or equivalent) is needed.
> >
> > Sorry for the delay in reviewing! I have some comments below for Yousef=
.
>
> Yes; sorry this got buried in my inbox when I was out and I still
> haven't all the way dug out.
>
> >
> >>
> >> Thanks!
> >>
> >>> ---
> >>> tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py | 11 +++++-----=
-
> >>> 1 file changed, 5 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/=
tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> >>> index 875b08655..b1b201b2e 100755
> >>> --- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> >>> +++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> >>> @@ -27,8 +27,6 @@ import re
> >>> import signal
> >>> import sys
> >>> import getopt
> >>> -import Gnuplot
> >
> > We don't use Gnuplot so removing that is fine ...
> >
> >>> -from numpy import *
> >
> > ... but we want to keep all the imports together at top to easily audit
> > dependencies. Afacit, most python scripts in tools/power/x86/ follow
> > that convention.
> >
> > There exists a big fat comment on top of the file reading:
> >
> > Prerequisites:
> > Python version 2.7.x or higher
> > gnuplot 5.0 or higher
> > gnuplot-py 1.8 or higher
> >
> > which is a good indication of whatis actually required to run the
> > script. If users prefer, we can add a requirements.txt that pip can
> > consume to install the necessary dependencies and make it clear.
>
> I think a requirements.txt and a quick few steps of how to start a venv
> and use it is a great idea.
>
> >
> >>> from decimal import *
> >>> sys.path.append(os.path.join(os.path.dirname(__file__), "..", "intel_=
pstate_tracer"))
> >>> import intel_pstate_tracer as ipt
> >>> @@ -260,9 +258,6 @@ graph_data_present =3D False;
> >>> valid1 =3D False
> >>> valid2 =3D False
> >>>
> >>> -cpu_mask =3D zeros((MAX_CPUS,), dtype=3Dint)
> >>> -
> >>> -
> >>> try:
> >>> opts, args =3D getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","trac=
e_file=3D","interval=3D","cpu=3D","name=3D","memory=3D"])
> >>> except getopt.GetoptError:
> >>> @@ -270,7 +265,7 @@ except getopt.GetoptError:
> >>> sys.exit(2)
> >>> for opt, arg in opts:
> >>> if opt =3D=3D '-h':
> >>> - print()
> >>> + ipt.print_help('amd_pstate')
> >>> sys.exit()
> >>> elif opt in ("-t", "--trace_file"):
> >>> valid1 =3D True
> >>> @@ -291,6 +286,10 @@ if not (valid1 and valid2):
> >>> ipt.print_help('amd_pstate')
> >>> sys.exit()
> >>>
> >>> +from numpy import zeros
> >
> > Having it here needs users to skim through the file to know what
> > external packages the script needs and we don't want that.
> >
> >>> +
> >>> +cpu_mask =3D zeros((MAX_CPUS,), dtype=3Dint)
> >>> +
> >>> if cpu_list:
> >>> for p in re.split("[,]", cpu_list):
> >>> if int(p) < MAX_CPUS :
> >>> --
> >>> 2.54.0
> >>>
> >>>
> >
