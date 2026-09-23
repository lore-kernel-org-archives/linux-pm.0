Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C836248124D
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790163921; cv=none; b=B+BQKwq3RgTrkMB6V04bdm/BuLArcl/qKupvnyFSCWNkLSJUQKwE8Ronj8dY1CP8PL5TmRTMDczOL3fCO0626FM5HFEW6GxvTlYlL11E96UGIHRqwRMnj4FXspXuZmudOGqup2jiPD6eFdmtf0X66Lp2W80EA3fx5gHIm3YNRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790163921; c=relaxed/simple;
	bh=qaYwF3YTeK9Wi1Phlhw0Z5y5kCe2NZCu2c8tBmHa3EI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olZsbz5u3RlTv4sH3NuyaDLVsBZq1jOQYYtPThIAlNgDTmG6q267bb9UfiDrncfgGzRv/owfBJzLEOFJ0SAGE1f16xLZ7LAWteU3Ayy808HaIN4fGHfjZTbQEVBmjfTwipaGdE4OMgSDPFygGd4jkZ3XL1JegXZW4M4ThaQ2lDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs2-f41.google.com with SMTP id ada2fe7eead31-7856441f7d9so321152137.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 04:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790163914; x=1790768714;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q8PGd4XOq7wfScnN+X4IsZNJiCrIHxCuJIp0rtqKSow=;
        b=U7eCLx3NQ5OsVuwo1T04WeuEcsHWvebhg6eudv3mAyopQ7E2yTqLL5mkuOzi2lclvz
         UCDqSDGG8vTeKFutRbROOg7yKaTGbRa7c3QGmIGiUoeRoaE4uj+FmIqA3Lty9bJ0EFNJ
         5mzWDu5WLSggzRocEUUMRF4ArefcmrYBS1X0mM4euokv2rPtwaxZjYVoQb+rZdlLij73
         9O86eNPceH+Vhp6Jbp4CXzRy+tY+iBiRx+PBXltJo6wsfGGapvz4GtV0HBVCWPz0v3he
         T0wUU1TMkmkQTc3z8q2dNc1rso0YYp38qKVd1xMItzXtcpUxSnKhawCCHO2SJrmlt/2o
         OXnA==
X-Forwarded-Encrypted: i=1; AKwUvBw/Cty8JUInJigvXPCKNvvahbNzn7z/4ONdw0xqMYv7LCENbU1C3HvhSofmrrYTCEGGvuQv5vCmnA==@vger.kernel.org
X-Gm-Message-State: AFuF++k/Jr13DmR6iABWZzAiha9bZ/VFxMPzqRrO6shCELqoIAb8uKvc
	NljkTUsYBm8AhLYD6L+XM3TEuDnxcBz/JSGhjQiH7FBPI+kaORv5AOH5EpV5prCGxHw=
X-Gm-Gg: AYBFou3HfJk4mkct2I9qkW2xt9JEhPMYcvo267ilyclsAkJYlKTwGFVAYQ3UcTGm5+s
	oSGd4MG1XkjurHPInwlj3CESfx2ML/K/JLLsvy/kK1SgoQbl+TEk2/x0BWrSrVxIhDndjZeNqaJ
	NZp4eQVde7dGWr0xi1vW486y8lxwUaZ6k2dH4Ap61qV0/3TwjzDNhvZD1fNai15u4WbftANmBNu
	vNaZVyCishUTen+Vj1ZTLO5UtVKDjBVW8EzvSpYk4VWhsthfzBI7cTr87FGh50XL/WT+fO30sqI
	V0aTnfwjLNz+wVRqhXYkKgiVIdB7M0VCnhEzEIrXYj7uIyAtUaiOZF0Ztk/bse39O1TDYbe9KSI
	Rv6fwD8mC0eZWMIlgHK+PYtDlYMBlcVxTF9VhvBGN99QY8y91K+MOqKoQa0QtXHb5l9+UVtLjL+
	1fcYOwJsbnOizFVhqWD5FGJLNG+mcGhn2JGgXbpVgupPP+nglxvky4wBEMLlMbsF2712BH1pjkt
	wb5/Az6vx5zAOx1BaOoB1dmHwDwyBmOqB/arg==
X-Received: by 2002:a05:6102:2928:b0:7a6:c647:cf50 with SMTP id ada2fe7eead31-7ac1b0005c8mr2143697137.8.1790163914064;
        Wed, 23 Sep 2026 04:45:14 -0700 (PDT)
Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com. [74.125.226.235])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf6087f6dsm3605174137.9.2026.09.23.04.45.13
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 04:45:13 -0700 (PDT)
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-9851d513a70so240007241.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 04:45:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxBU8y9z3ABk5Etk/YLr3efAHzyVSW3dv+/vzzB3hsiDoZX9ji/YWkSG7g8ZumbRe3ApffzoC4OiQ==@vger.kernel.org
X-Received: by 2002:a05:6102:4b04:b0:7a8:46fb:eb3e with SMTP id
 ada2fe7eead31-7ac1e45b0aamr2126477137.36.1790163913085; Wed, 23 Sep 2026
 04:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921134432.50338-1-ayman.chaudhry.kc@renesas.com>
 <20260921134432.50338-4-ayman.chaudhry.kc@renesas.com> <CAMuHMdVkh_qpJKqD7N=njG+35gS+rE7cFfWQ-kS3aRoTByxH_Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVkh_qpJKqD7N=njG+35gS+rE7cFfWQ-kS3aRoTByxH_Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Sep 2026 13:45:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXmJWu5DD5sQ0epWX8FnWc7zt0CTvJ5_jpjj-Hnvgg_cw@mail.gmail.com>
X-Gm-Features: AclHuK8RxVewtu2RzsoGD8diwlu0sy6STWZ6sjM0IUtrbgAydvfKpy5BJVcpi7M
Message-ID: <CAMuHMdXmJWu5DD5sQ0epWX8FnWc7zt0CTvJ5_jpjj-Hnvgg_cw@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] pmdomain: renesas: rcar-sys: Add r8a774a3 support
To: Ulf Hansson <ulfh@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Ulf,

On Wed, 23 Sept 2026 at 12:33, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, 21 Sept 2026 at 15:45, Ayman Chaudhry
> <ayman.chaudhry.kc@renesas.com> wrote:
> > Add support for Renesas RZ/G2M v3.0 (a.k.a. R8A774A3) SoC power areas
> > to the R-Car SYSC driver. The RZ/G2M v3.0 SYSC is similar to the RZ/G2M
> > v1.3 SYSC, however it lacks the A2VC0 power area.
> >
> > Signed-off-by: Ayman Chaudhry <ayman.chaudhry.kc@renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v1->v2:
> > - Added space before closing brace for `ca57-cpu1` area
> > - Updated include path to SYSC dt-bindings
> > - Added Reviewed-by tag
>
> As this has a hard dependency on "[PATCH v2 2/9] dt-bindings: power:
> Add r8a774a3 SYSC power domain definitions", I will provide a shared
> branch with the dependency to Ulf.

Alternatively, I can just collect all pmdomain patches in this series
in renesas-pmdomain for v7.4, and send a PR for that, similar to what
I do for clk and pinctrl.  Up to you...

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
