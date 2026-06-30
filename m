Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB3C3FFACC;
	Tue, 30 Jun 2026 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819538; cv=none; b=b8oK+cRJyc6EzSgOZmtpPjXQRqGIS9PZx/s36b0j+lNEgKjT44RpYS5UOjJxYaWntZ1eQNBhAYQ9AhW7Dfsr+P0qJfxNabop0aK+TItm6VB3JEbwh8kst06t9z+RwCm8URm+fYjku2XfVXqmM3mgS2ydKa4qLm4RJAC9sJwzMAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819538; c=relaxed/simple;
	bh=Sz2uinVuwSHndPQ4KZgNtJjPZT0iz2BaJMxIyuCZfRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1If2fkcrWsy5AQs6+zq1idk0xzbYAlUiAdFPvezpeOH9UEBLiHUA79P8wvgUYm/NfjyjDnNIQ61Jdr0T8VQ6P5/Q4qNRzMuOcoENVwTwvlaHrUjpqVVfQl7VzsCkbmRcu1cHuDRCfRBUBX6YtadZwwxNAEPceLhShpirUcT6S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqZ+J78w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqZ+J78w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B661F000E9;
	Tue, 30 Jun 2026 11:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782819537;
	bh=Sz2uinVuwSHndPQ4KZgNtJjPZT0iz2BaJMxIyuCZfRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mqZ+J78wyuBuqhjKVOwXYg5JEd4j7EcpdEzJRVl6Z5A5aUxLfhQNAgm8jrmmu1e/D
	 5s4thqtO4ypG60u58r6dRkJ78NhOOi0UpLsVFr0/dZAwd2wmclcaugXNUj4N1b2NeQ
	 MLAJQqfrY4Sa5oGIryDbkmrooiG77FsWjDF6T6EhANdSfj90GnEMBtfq6lY9HAWKzM
	 vEL2S/NNFIiwl3VtxKbtj+IOqvpIy8QT6TOeYOOsk0oA70tl1lm6js78/2D2+qKWTC
	 mXd4EGRR3sHie+HrNejjaO3atCDIM1svP4NenLh7pSFMA4J8QYbNqTpDHnKSizhzMF
	 apCN5N+so9p1g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [GIT PULL] ACPI support fixes and cleanups for 7.2-rc1
Date: Tue, 30 Jun 2026 13:38:54 +0200
Message-ID: <6023934.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12935226.O9o76ZdvQC@rafael.j.wysocki>
References:
 <CAJZ5v0juZ6YJVALVEi1s_O0qgcr_o880TJbRHXWsd-Drb-sUXQ@mail.gmail.com>
 <CAJZ5v0jQyELy6Zyqn-ngTmVG7Gj+CFMtL_t7qDEQjWSjgcLCmQ@mail.gmail.com>
 <12935226.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Monday, June 29, 2026 3:15:12 PM CEST Rafael J. Wysocki wrote:
> On Monday, June 29, 2026 2:22:51 PM CEST Rafael J. Wysocki (Intel) wrote:
> > On Fri, Jun 26, 2026 at 10:14=E2=80=AFPM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Fri, 26 Jun 2026 at 10:54, Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > >=20
> > > How about just adding a trivial strncpy_pad() to
> > > <acpi/platform/acenv.h> or something. A place that already knows about
> > > the whole "I'm building the app side" now.
> > >
> > > Hmm?
> >=20
> > Something like that or define acpi_ut_safe_strncpy() as an alias for
> > strncpy_pad() when that's available.
> >=20
> > I'll figure this out.

Interestingly enough, the ACPICA tools don't even call acpi_ut_safe_strncpy=
(),
so if it is defined as an strncpy_pad() alias, the original definition of it
can be dropped entirely.

I'm going to make this change.



