Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31062848AA
	for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2026 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774179092; cv=none; b=QNAAQ/+kASWDbsFcItzopvs70yAcD+aq/ACH9R32MFxH9l+QTy/6KISnXY3Z5sB/zoG8y9CQP0khw+eKMO5NXW8SiEaA6zYqoaJi6TBAEo9jEB4G75Odj/xPAc4HCEb+IU2B2KdLrWv1FfMK55doVfApu8GnR5qCJ1sNGGYAG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774179092; c=relaxed/simple;
	bh=CZXIAphpEoAXPXJOqhiWoTDgIfpM0+mqwqQXnEDj07s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRKhAEgTtlbrYJnYktSYoF/4INMMnGswSs6qoK5bKlKdPzEXmoDnBaLQm4IF4kd43xLbW45g83kHyPI9DBCbjDjwYEp92Sd5wKZKq80j/boswabM1ssrOYmFUskAS26gU7cSN+ZDKn7Q55S4CGefijmbjX1RW0RQTXBjSKOGkSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQMlHXyh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQMlHXyh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF24C2BCB2
	for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2026 11:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774179092;
	bh=CZXIAphpEoAXPXJOqhiWoTDgIfpM0+mqwqQXnEDj07s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uQMlHXyhsJZG7NGkoYUAvBCrMwmMf+VXI+IvMR9O31GZpRJ0tT7vQTJW1xf7oRt0F
	 5KxNGyzPe1omNM40tbwWkHrbNriK/lJsipfqO7Vu28yQIA9P9Pli7N0N/EJL0w9h9m
	 Jq9bBsL8CqJ5jNQEv7k/w9MukfeNIjCZKilCFsMDLwr8A/eyhWdXmHnfr3m5d3FqJ5
	 sxh+ryUWv8ltmu+ThOsjeTcw9A0eF2nkdvZFukrOCv2CEopTUYF0QGiLFD5l/3WKBf
	 B/nKeFCdIfH5k0ouSbvR7Giop5mzdOz99k1OV6MT8/fy8R3yz9cyzhoD/D1kZMi331
	 cNw241Fz9RuDQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40ef10ec84cso3115627fac.2
        for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2026 04:31:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGhv9q0EA8JGysV3aUGoTnKeOhHo7Rmy+jIVPy1G/6NywoCN6q9cjNT06caV141Y54ehPPE1Q4Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVoRHlSlb89KBvn2K/2OdRWza86I8HoX+YUCUJdjkkn2qQ/EbF
	9TGa24cnZALSMUxyQM0eZ+LitEO4LHn3ILcM6b+7D8+C3ldhWwG6fAg2+BWjB06mWt54/Cdw004
	4bC7uj5XTCBCavm3td+eUksomZFhg01g=
X-Received: by 2002:a05:6870:812f:b0:417:6b32:f50 with SMTP id
 586e51a60fabf-41c114ad093mr5987793fac.50.1774179091364; Sun, 22 Mar 2026
 04:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320170313.163386-1-youngjun.park@lge.com>
 <20260320170313.163386-4-youngjun.park@lge.com> <CAJZ5v0gHTPCkVySAuPBkPoV=SwmBRG_c-TtPbz0CNsUUPEkY8w@mail.gmail.com>
 <ab53krr0y981Qyk8@yjaykim-PowerEdge-T330> <CAJZ5v0gVbQQdpyWb72qDcsAoj7vg2v=pXOjdMuWzKHJsdJcHNw@mail.gmail.com>
 <CAJZ5v0ge3K4DOZHxJyWARZWu_N96_sAw2T-8nr54zSKH-hOfRA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ge3K4DOZHxJyWARZWu_N96_sAw2T-8nr54zSKH-hOfRA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 22 Mar 2026 12:31:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gBHLz7T2qRJRjBfOWY6UXM6L6+Kw8UcsY4+OaB7+qQcg@mail.gmail.com>
X-Gm-Features: AaiRm53xYV_EZSYGQrEKmhLGtdzk7WdbJ8VpXBo1B9uzpzij2dzrLdLvtlNqx20
Message-ID: <CAJZ5v0gBHLz7T2qRJRjBfOWY6UXM6L6+Kw8UcsY4+OaB7+qQcg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PM: hibernate: fix spurious GFP mask WARNING in
 uswsusp path
To: YoungJun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com, 
	pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev, 
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 12:45=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Sat, Mar 21, 2026 at 12:32=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >
> > On Sat, Mar 21, 2026 at 11:48=E2=80=AFAM YoungJun Park <youngjun.park@l=
ge.com> wrote:
> > >
> > > On Fri, Mar 20, 2026 at 07:20:24PM +0100, Rafael J. Wysocki wrote:
> > > >...
> > >
> > > Hi Rafael,
> > >
> > > Thanks for the review. Sorry for the back and forth on this one.
> > > I'm preparing to send the uswsusp GFP mask fix separately as you
> > > requested (with _nowarn rename and lockdep_assert_held).
> > >
> > > Before sending, I wanted to check on the approach. I originally
> > > found this WARNING while testing uswsusp and thought it was a
> > > localized issue. But AI review has kept uncovering more cases =E2=80=
=94
> > > first SNAPSHOT_FREEZE + snapshot_release(), and now
> > > dpm_resume_end() when dpm_prepare() fails.
> >
> > dpm_resume_end() should not be called after a failing dpm_prepare().
> >
> > Which code path is that?
>
> OK, I see.
>
> Let me have a deeper look at this.

So I agree with you that the most straightforward way to address the
spurious warnings is to remove the WARN_ON() around the
!saved_gfp_count check in pm_restore_gfp_mask() while retaining the
check itself.

Please feel free to send a patch making that change.

Thanks!
