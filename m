Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E283A382282
	for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774092778; cv=none; b=lFqew32+21yUqHB2hZpsfvdLGHj9hw6bbgtbiiJSoFOdmr2RF/7d2IJKo6uZ6wifZ+0urmnSLP9g0NE3Ikn/BYlzL6R7JCvtEBkUehImL5zrUNqXSkiD7gjD1DKeY3B0M7/DTo5HNaKTdZePqEeyOLo3i5ch8/pYH1Zs/SyMa40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774092778; c=relaxed/simple;
	bh=KAM88FjdiVIi8VSewrRhuQcMYwar3Jb0jVu/scAesWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFhTIcKaxbK2hHJQrkkuxyn1GSNnn5hPx+iFn/oDIBrEprs77srJkCSZB6rQAVxUn32EdRo7FHKxpmbNiE8EXdY4FMBm+Jr3Gg+O6+szgtO/2aCLiEYjTnpVvRqYgT9/1N6XXD/fRy+rTnX/SdrZgSC2Z4m/vEQvwTBJxQdSRJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCK0Tutn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCK0Tutn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F92C2BCB5
	for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 11:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774092777;
	bh=KAM88FjdiVIi8VSewrRhuQcMYwar3Jb0jVu/scAesWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RCK0TutnkpyNYAkgwcCuwMpJgOfQ3gPoRlwe/X12p2GD1x2ZTdF9FvNCXX1pPxbxe
	 MMRnLxouUzn9wHZJd02V9aScmnT9zjrcuoKEZj6aB8EpLspc+5+PuyFucNUCS0/oTD
	 KOdZkKY7awb65aqnPpGSCqqQLyq8F7lpeWsG0MerxI2l4jGh2sMyI8TbwVEqw61ENR
	 AJ/Uy8gt99dWyzFXY9AmpY+0tbnZ6FELjcHSEEcH/KwsbcuyrzcqQnkrD0kO8F8KP7
	 2o7S4OMcALYCSNZF8BEzyvb1aVOUXeq+IznS0qoxoreOTK4lMPntvZwdAasFxJ3GVa
	 nabYQx7IwPk0w==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-417400afaeeso2764037fac.1
        for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 04:32:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6wczIPS771zUu8BA+ZRtJcqGDbzZ9pBAaycm9lt19nh8ZxTxkLw/r8RDZhMjp7tpu8NzlS/TEfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQD3ulpBNkop0u5I1mPO3FhqxdTrtvEyQ+G+Wwnqv+JO/viwF+
	X4eqtr2w67aL/xBhKw5kr/RErGTNuJDmCM473tStynqqq8TXot7Kn2be3t6iabEjEVOasUyPKfA
	VNhcWoRKvqcfmta5QeODwnlir9DpSRZs=
X-Received: by 2002:a05:6870:3b88:b0:3e8:926e:bf9f with SMTP id
 586e51a60fabf-41c105fc248mr3773776fac.13.1774092776566; Sat, 21 Mar 2026
 04:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320170313.163386-1-youngjun.park@lge.com>
 <20260320170313.163386-4-youngjun.park@lge.com> <CAJZ5v0gHTPCkVySAuPBkPoV=SwmBRG_c-TtPbz0CNsUUPEkY8w@mail.gmail.com>
 <ab53krr0y981Qyk8@yjaykim-PowerEdge-T330>
In-Reply-To: <ab53krr0y981Qyk8@yjaykim-PowerEdge-T330>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 21 Mar 2026 12:32:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gVbQQdpyWb72qDcsAoj7vg2v=pXOjdMuWzKHJsdJcHNw@mail.gmail.com>
X-Gm-Features: AaiRm53bzs5VbehqkGDb-NN8rRSI02pjR5TR3QpNVYJGELTNnMRcKAWlWJyMnWI
Message-ID: <CAJZ5v0gVbQQdpyWb72qDcsAoj7vg2v=pXOjdMuWzKHJsdJcHNw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PM: hibernate: fix spurious GFP mask WARNING in
 uswsusp path
To: YoungJun Park <youngjun.park@lge.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, akpm@linux-foundation.org, chrisl@kernel.org, 
	kasong@tencent.com, pavel@kernel.org, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev, 
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 11:48=E2=80=AFAM YoungJun Park <youngjun.park@lge.c=
om> wrote:
>
> On Fri, Mar 20, 2026 at 07:20:24PM +0100, Rafael J. Wysocki wrote:
> >...
>
> Hi Rafael,
>
> Thanks for the review. Sorry for the back and forth on this one.
> I'm preparing to send the uswsusp GFP mask fix separately as you
> requested (with _nowarn rename and lockdep_assert_held).
>
> Before sending, I wanted to check on the approach. I originally
> found this WARNING while testing uswsusp and thought it was a
> localized issue. But AI review has kept uncovering more cases =E2=80=94
> first SNAPSHOT_FREEZE + snapshot_release(), and now
> dpm_resume_end() when dpm_prepare() fails.

dpm_resume_end() should not be called after a failing dpm_prepare().

Which code path is that?

> More callers than I expected use this defensive restore pattern.
>
> So I'd like your thoughts on the approach:
>
> 1. Introduce pm_restore_gfp_mask_nowarn() and update each caller.
>
> 2. Remove the WARN_ON from pm_restore_gfp_mask() itself, restoring
>    the pre-stacking no-op behavior.
>
> I'm leaning towards option 2. Defensive restores are an established
> pattern in multiple paths, and warning against a legitimate no-op
> seems counterproductive =E2=80=94 we'd just be playing whack-a-mole with
> _nowarn conversions as more callers turn up.
>
> What do you think?

Using the _nowarn() wariant would help to annotate code paths where
omitting the warning is legitimate.
