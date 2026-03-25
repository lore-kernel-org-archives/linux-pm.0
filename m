Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3713D5660
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442892; cv=none; b=BEYfoYEk9kO7r61coRYIN+2KMthM7UW6TF0rnH0zSpeMe6whZEZWPIPSGkbfTkUq5W4tYJZr0ieikZ4cp7Y2e8dg9MIRrTT/bznDmvj5nMDzplRP5WHqcn6Zvj1VXbzlh3qfAr4OEMwDc7wrNYxdbud/bPpeg5x+wFJhCWCWNAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442892; c=relaxed/simple;
	bh=snlC/IBOeUi8hwiOX6kljNOdSdN6bRjLI2GlNzJ2ggE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eklaMgRwd+1kjvMJ9pnxbexlK3NYr8Rb/I2WLJlkkD9QL10QsPZ2Y6M+/y5KHjMp71FBVYYnVdbHNgYWT0GKYGC4AkzdB4o9VOvqf4iZEPqnmh3jQUjDMHeU2L/fS6xEUOJ4wnL5YQRbrX4eAMz8DgQsNX5fa6JfiQwUA5lLNCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLSPPOO7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLSPPOO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5109FC2BCB0
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 12:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774442892;
	bh=snlC/IBOeUi8hwiOX6kljNOdSdN6bRjLI2GlNzJ2ggE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OLSPPOO7x1QkOd7XBl04YlqVv2enAGDJiWe6QvCmr87vZ6FT+kWKFZzgPnADmit+m
	 n88TaNjDSg2oDuQ/tMROQLr0JiJ8AD+FzYK57gEVZ/yOLamFtBPcjpjcL6KWf9YyCw
	 x++dPHP5Xrhc7sHnFXUR0twnlu64ZuTbEszYRgQySomidR4uXR4if0ZNoupmAStk+H
	 MJtGe5rjNamSxN+bn+ep4DFG5H5rHmlynU+iBXVO91izbRNg61XvAcKaiZqUrTOSDn
	 CkHWn94tQsmuZABkwK1rGALVhBFKzct+GFh+T+qP2L2rZLH84kRdETy2zPeINjfD4h
	 ZlLgNS+Q1LOlA==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-466f00535cfso3853171b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 05:48:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEd6wcPVEKFJQaAqIhKFI4hYFWWTr+vWVub6jfZeI7w49vyIMDBD1e2sgljuafqBL6C6ihO5ed0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzMfCNbCs8lPuONHtj0TI3eII0knIqQJK3etKuJMknFD7ZgKzP
	JJz1hHPDVcqDedKmuseCCxqbptb6Xyr5OqxU3ZelWnGVniK7DU5/YEFMK/DSI+S1c/ixeQTqWV/
	V7Ry4PgvuEMJarpePu6+2RphMmBsJZUg=
X-Received: by 2002:a05:6808:1b2b:b0:467:e5a2:a9ef with SMTP id
 5614622812f47-46a5c719a55mr1503022b6e.38.1774442891426; Wed, 25 Mar 2026
 05:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-thermal-core-uaf-init_delayed_work-v1-1-6611ae76a8a1@igalia.com>
 <CAJZ5v0h8Q-Cs-05hwKUF9wPbOzg2gyG8yH6tOfzJgXQCh5Ohbg@mail.gmail.com>
In-Reply-To: <CAJZ5v0h8Q-Cs-05hwKUF9wPbOzg2gyG8yH6tOfzJgXQCh5Ohbg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Mar 2026 13:47:59 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iBh6BjtwhS7RK_GE8QmYLAwW71P+YpA92SiGu4wy+syw@mail.gmail.com>
X-Gm-Features: AaiRm50UZe_MGNwYAvyU0MWvQAL2QvlTOXHkHEoVTVk07kPSEDtHWjxoOagyJzo
Message-ID: <CAJZ5v0iBh6BjtwhS7RK_GE8QmYLAwW71P+YpA92SiGu4wy+syw@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: fix use-after-free due to init/cancel
 delayed_work race
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
	syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 1:10=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Mar 25, 2026 at 12:51=E2=80=AFAM Mauricio Faria de Oliveira
> <mfo@igalia.com> wrote:
> >
> > If INIT_DELAYED_WORK() is called for a currently running work item,
> > cancel_delayed_work_sync() is unable to cancel/wait for it anymore,
> > as the work item's data bits required for that are cleared.
> >
> > In the resume path, INIT_DELAYED_WORK() is called twice:
> > 1) to replace the work function: thermal_zone_device_check/resume()
> > 2) to restore it.
> >
> > Both cases might race with the unregister path and bypass the call to
> > cancel_delayed_work_sync(),
>
> So this is the problem, isn't it?
>
> > after which struct thermal_zone_device *tz
> > is freed, and the non-canceled/non-waited for work hits use-after-free.
>
> Which basically means that a TZ_STATE_FLAG_EXIT check is missing in
> both thermal_zone_pm_complete() and thermal_zone_device_resume().

Actually, thermal_zone_pm_complete() runs under thermal_list_lock and
thermal_zone_device_unregister() removes the zone from
thermal_tz_list, also under thermal_list_lock, before calling
cancel_delayed_work_sync().

So either thermal_zone_device_unregister() removes the zone from the
list before thermal_zone_pm_complete() can run, in which case the
latter won't run for the given zone at all because that zone is not
there in thermal_tz_list, or the cancel_delayed_work_sync() will see
the work item queued up by thermal_zone_pm_complete().

So where's the race between thermal_zone_pm_complete() and
thermal_zone_device_unregister()?

I can see the one between thermal_zone_device_unregister() and
thermal_zone_device_resume(), but that can be addressed by adding a
TZ_STATE_FLAG_EXIT check to the latter AFAICS.
