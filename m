Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1C3210F59
	for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774093527; cv=none; b=LSwAr0IPAA3VU34yJZeVpJvN9cnrPfmPIEs+aY2J64l1dF9zLRmOFv1oNLmGVKrWEdOjZmji0GvwppYh6mvaau3Wsn5qE25K7wCk8tddIUiZkaz/HHtAZb+NdDcQeMlH71sdlsIdM3o+DmKsCo8dYf05nX6RCQCmmjMtyDNWvBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774093527; c=relaxed/simple;
	bh=5gWxRnA4o5J88o0JU8bbrSYGV7Oh3v8+lDg2wG9wC4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOofvzyGtsAmD0KH441UXcTPzePTQ7MzSLpJYjbo8kazZbkNIXWfgvUiSahdSnjXWyRDV9uPVK8RIG4ZnoYhmCU9DJlviGvLZRccV+Fv/zGluhEgXdfxrv6BcaeqYmMoUwIxi1IN5VTFSJEsZOAj+bepZ+id6TMJfCCNxXwkLlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5PzIng9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5PzIng9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A381FC2BCB2
	for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774093527;
	bh=5gWxRnA4o5J88o0JU8bbrSYGV7Oh3v8+lDg2wG9wC4Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T5PzIng9XmAWU0NElccFBg+Fcow9B5GpUB0kcYpiX/1+wDVah7EamOiBYce3LajqH
	 QBqQ3xPIv2iCZEqESFZ1Bw6UQhRtwtnG4N25KQrpP9kUBqv37FdIfG4zMqhBaUArrw
	 NqwYPfm/7W5jRMCb/5HjQiQeY02oog3qqU8IQk2aM9ljPYYfs1TVc4Cs6MJ+8VZT7Q
	 EuF8fd33rRdKw/YG27pPef5xS0Qi8gF99Qoeh3SCXU+HRjc3HFro3+TYVY8Q5vqh0N
	 vN0btUMuhhjf+Pa6vbPOHta+XUj4JQDt3IALXSUzZlyDk1kqcyk7egF+w2oIi9Al+d
	 K9jxRxf7Ax3NA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-417571c6083so1730456fac.2
        for <linux-pm@vger.kernel.org>; Sat, 21 Mar 2026 04:45:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXr/WMIETwuBDmXkdoLJFDOy39A/mq/D4Y88ZArxwSD6mFbTQhNo7GlC4YxVTMyjlCAyqNHPJTX3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlW1ZAeqlWo9oCf+GPrDDi0dsKm6IXeJLPWhnVE1hmL3Pynouw
	kcdb56qMWU+9Vg/QFqXT4Rz6eR+3ThOw+lSoGricvRv9yTnN9sgsL0DD65FYMvE5vMuGbzcmiUM
	1lQW6XAJr+B4CBiWUIi3vl5SDnykjGhI=
X-Received: by 2002:a05:6870:781a:b0:417:53dc:9ae9 with SMTP id
 586e51a60fabf-41c10f0cf0dmr4084666fac.11.1774093526776; Sat, 21 Mar 2026
 04:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320170313.163386-1-youngjun.park@lge.com>
 <20260320170313.163386-4-youngjun.park@lge.com> <CAJZ5v0gHTPCkVySAuPBkPoV=SwmBRG_c-TtPbz0CNsUUPEkY8w@mail.gmail.com>
 <ab53krr0y981Qyk8@yjaykim-PowerEdge-T330> <CAJZ5v0gVbQQdpyWb72qDcsAoj7vg2v=pXOjdMuWzKHJsdJcHNw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gVbQQdpyWb72qDcsAoj7vg2v=pXOjdMuWzKHJsdJcHNw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 21 Mar 2026 12:45:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ge3K4DOZHxJyWARZWu_N96_sAw2T-8nr54zSKH-hOfRA@mail.gmail.com>
X-Gm-Features: AaiRm52gCEdxK_vakaMhQSOho6CDMu4blBPb341noC6S01UTTzbvP-c25uXYVbY
Message-ID: <CAJZ5v0ge3K4DOZHxJyWARZWu_N96_sAw2T-8nr54zSKH-hOfRA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] PM: hibernate: fix spurious GFP mask WARNING in
 uswsusp path
To: YoungJun Park <youngjun.park@lge.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com, 
	pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev, 
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 12:32=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Sat, Mar 21, 2026 at 11:48=E2=80=AFAM YoungJun Park <youngjun.park@lge=
.com> wrote:
> >
> > On Fri, Mar 20, 2026 at 07:20:24PM +0100, Rafael J. Wysocki wrote:
> > >...
> >
> > Hi Rafael,
> >
> > Thanks for the review. Sorry for the back and forth on this one.
> > I'm preparing to send the uswsusp GFP mask fix separately as you
> > requested (with _nowarn rename and lockdep_assert_held).
> >
> > Before sending, I wanted to check on the approach. I originally
> > found this WARNING while testing uswsusp and thought it was a
> > localized issue. But AI review has kept uncovering more cases =E2=80=94
> > first SNAPSHOT_FREEZE + snapshot_release(), and now
> > dpm_resume_end() when dpm_prepare() fails.
>
> dpm_resume_end() should not be called after a failing dpm_prepare().
>
> Which code path is that?

OK, I see.

Let me have a deeper look at this.
