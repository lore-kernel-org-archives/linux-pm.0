Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46704399E2
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589148; cv=none; b=jcmFMRaDfpjEV5sXVnf93PAobddY5Ji1823DCLfGncjrZbxj6IbMhxsuB60F6XFibaPcWclTKrww3b4I6fGYhxSDyzSIYjr1kHXHEzhMrq8SgBhHp9bZ+KCB0+VW4GmGypkNVMUEoNBAD+i1B175wJ+Bxb2VX90vZczhFBUJ70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589148; c=relaxed/simple;
	bh=delsunFBhigFzFxwVc6fV+1IhX8HaVo1TsY19s6s2bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xp5fWC+ABVFMllNpdFqEYEW+zpxq1iuuL+qWr+nNe4LszHerKqbYR6Xu+mT937lhMBuVGG995E2SDXkOJPecDA4C9hwP0YZ3ApwhMTsP/FmQrRLPGxcuhJv3dDhA4I6yHrSRvf7b/BRbp36liJzHDKj1nF6DzeguE+YlboMe/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WE1O6Eif; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WE1O6Eif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCC11F00ACA
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 16:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787589146;
	bh=delsunFBhigFzFxwVc6fV+1IhX8HaVo1TsY19s6s2bg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WE1O6EifxorV/Q1il/hYqO4C23MtUrGLr+0WdEJRK0msuV8FLUuBGt48iwehvL7GN
	 ptN5RIO8pJfZAWBoAaXnFlcCDK41PH2Wx7sf/l780IcydwIitnwHy+WzD1K9niZoeo
	 ab99MBArMN8hYBK7d6K2CSzulT97fYdIo8tEjl26R/MtAeMN+VLnJ3oDYkCsWAQY8g
	 wspmf3IDT0TaW7ambKZ0EOf3h2goaK3zdUoEoG11Qfb892ODpdZ+yHBWyeGK50cxrY
	 3NBJPqRX/eDuytuwNVrUu2YBAu6LDSm5H8CBemugIjpbKr7mI7Q992QI5zIMnc7Gbu
	 TqybGaqOtUMrw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39f1ac13687so24986891fa.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 09:32:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrHEymn1Q1SNdrRW6pNus+zdGbL40tt/sNqk5vTF44/z8rf9zDKfgqAEl8nXnOu2KB93/eYPr1fKg==@vger.kernel.org
X-Gm-Message-State: AFuF++ncxkqpyewWB2jHBBPICoLoHuWdJ09FuRjVxy71W1mz8uxut0aH
	IF4lhL0kIymQ5bM74Rc4Im+PHsLWDBFzvhMqAyv3jh8TDaQXiVAKZCLph4icFA9LFM6VBE78u5z
	3CFH7CaSjFr4Vrwvonhauop3Srb6pZpA=
X-Received: by 2002:a05:651c:54a:b0:38e:a12c:418c with SMTP id
 38308e7fff4ca-3a1aec6b9a6mr61528621fa.11.1787589145188; Mon, 24 Aug 2026
 09:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-critical_trip-v1-1-780d0b40bb96@oss.qualcomm.com>
 <CAJZ5v0hD7OvQfOUja7mC+nXpH2cDfYjeGMgf7WKREXt3rSNOEw@mail.gmail.com> <c372d0ee-7b55-4483-8e44-ea6c68c3501d@oss.qualcomm.com>
In-Reply-To: <c372d0ee-7b55-4483-8e44-ea6c68c3501d@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 24 Aug 2026 18:31:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i_=cZH3tB6W51wkh7Xq4XxbtKuMdUxnnKcdwokec4YsA@mail.gmail.com>
X-Gm-Features: AcwNN1WfZpeEFyPwplWIDryGNykfk71bTiZOWcDn8FpIfrHhgovB0XSuOdf1-uU
Message-ID: <CAJZ5v0i_=cZH3tB6W51wkh7Xq4XxbtKuMdUxnnKcdwokec4YsA@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: warn on non-critical trips at or above
 critical temp
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 12:12=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 7/22/26 21:43, Rafael J. Wysocki (Intel) wrote:
> > On Fri, Jul 10, 2026 at 11:12=E2=80=AFAM Gaurav Kohli
> > <gaurav.kohli@oss.qualcomm.com> wrote:
> >>
> >> Thermal zones can be registered or updated with non-critical trips at =
or
> >> above the critical trip temperature. Such trips cannot provide useful
> >> mitigation before critical trip handling runs, and a HOT trip at that
> >> temperature can coincide with shutdown.
> >>
> >> Warn at registration time and on trip temperature changes to surface
> >> misconfigured platform data and incorrect dynamic updates early. When
> >> multiple critical trips exist, warn against the lowest one.
> >>
> >> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> >
> > There are a couple of reasons why I don't like this, the most
> > important one being the overhead: two walks over all trips added to
> > every trip temperature update is a bit of a stretch.
> >
> > Moreover, the messages produced by this code may not even be noticed
> > on systems in the field and users may not be able to do anything about
> > them, so the benefit is questionable.
>
> Would it make sense to sort the trip points when they are registered.
> Then limit the changes to the interval between trip-1 and trip+1 ?

Sorting the trps in the core is problematic because by the time the
core sees them, they may have been associated with some internal data
structures of the driver ordered in the same way.
