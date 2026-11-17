Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947811;
	b=uB6aiakppqM28VN0IJdslM27tkEZdfEMc2YH5QtPbxxcCGii41IH1UQV3+ptWQDCg9qP
	 r1jfXF43sRDogUy5gNmhcbTEv55+R95KR3I9xMA+gB31UGDrkrixuEzrc+qlLB36bS4gv
	 F+LQJHue2uLta6dq4vZ0kwN4lybPjzOKecXxLCinIagtmfEuZeQJawghTvjwMiBuyMz3H
	 aoSR+cCL/rnmT4JtUQMUNilUfAzkLInx2vfGt3LakIJwRxsVVhXsAtgGe2MhJeZYT3cGp
	 shkzMnKJEpdO59AsSsvqEBtgB19E+H5iLd5jCAlJXeZiMVdw/c54Dja3JlY2OSWJwKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947811;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MjqKu63EhuXlUYh8LB06tgo8mBsbsVVaUxCBaQO/J5w=;
	b=5H1Z1f4EMAWPNNq7W9eV7xxU48xBJgWpYKk6O1nzngqmRwMe7dRiA7PupsMHrp/DbjJ0
	 BYy5f4Qvhawbie/Kyz7qMADyyAex2ZpF/j4dZ5UdhW/RY1zavbC3nZZ889HmXaxt8m9aP
	 TmwlXSTvpnMl03dPHafisjBKwy90n0agcspmj5sLf+0NXcDpaWE/bk/kJtuJ7KQ1lC4yy
	 dRcwbQqlIOEifZbsnAsbCHvoXUbPHqjIP2yzA+MMOZRId6mF+X06sMfWhOJaAYtbt0swY
	 2xk7mpJQDQgC21PFySaKropx+/XzL6bOKCgx3C6FJJRC8x/KNQf2SPjEdqEL82UcaFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C7fArxqa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8293606A31C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 20:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C7fArxqa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B47B1F000CA
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 20:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794947811;
	bh=MjqKu63EhuXlUYh8LB06tgo8mBsbsVVaUxCBaQO/J5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=C7fArxqab1A+kFeEYCRrWWEdFMcafrJ0ZtE5leXLcL9w3bVGvyD4Ex8GYiSqKjZvJ
	 OGtOTyXmNgvFQ7ih9XnSdIM+mH67+1chLKpjS6tHevfQK+0nL8cSBUzi9K1xfwVGve
	 4gH9aI8B9nj5U30E7duMPXEXrY5smww6CsIvOalDvsnnNqjm6F9n6zb2qUP6zDyktt
	 D0FoetB7qPJe+N/WNo1UVe0XqVljBYYChSRBakCTUfS1AOfrbntGoXzH0r2vvAILeQ
	 4W3VocL1Lw3iQt2kHKZ1O8/alLj0CtNxW4jg3HjvMF+EAiymqjpyZ1SyE03Qt3eD5I
	 YAPZmk9UXEqQg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c17a1775fcso149740e87.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 12:36:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFKAHU1Ac34b7WZEs/C/J5Xgs6us6dK+T4fQnNh11TDIBsuY+pEdZe3lXqJAWTq6llZ06WUheHRnw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9WmDQ18VvbJqUlDdnEbfWf3rhHl0g48TFkf1m7XG0LOvS4k6sb
	9VYDY8dHwa6qG3Crlit/V4l3ypoVQ/MbQsmtFBK9aFIRTLNqYL5M5ZngC5BsbpOtnm8+MvnZd8q
	d/l0PItu5zv1yKBWP0QPoIspJh2D1vwU=
X-Received: by 2002:a05:6512:1046:b0:5bf:c3e2:be3a with SMTP id
 2adb3069b0e04-5c1a9f27cccmr86339e87.37.1794947809944; Tue, 17 Nov 2026
 12:36:49 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <4789427.LvFx2qVVIh@rafael.j.wysocki> <aveybY5Z9OWQYkRS@google.com>
 <CAJZ5v0h3Q3ySm0BmHG80QAQReV-6mbj2A0J5cSG1Pwc_ziGyDw@mail.gmail.com> <avuNxXw7YZ4ZeO-1@google.com>
In-Reply-To: <avuNxXw7YZ4ZeO-1@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 17 Nov 2026 21:36:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hLADFoZQWRariyUYq+s8FhWv2B2JndGp1u=D=9vn5bnA@mail.gmail.com>
X-Gm-Features: AclHuK-E1jVhE1_vxeyjUgci-XT6TTk354gpltVNrXs68b-GKFjvPZI6DM3eUjk
Message-ID: <CAJZ5v0hLADFoZQWRariyUYq+s8FhWv2B2JndGp1u=D=9vn5bnA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Update last_busy before calling
 rpm_suspend() in rpm_idle()
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 12:12=E2=80=AFAM Brian Norris <briannorris@chromium=
.org> wrote:
>
> On Sun, Nov 15, 2026 at 06:35:04PM +0100, Rafael J. Wysocki (Intel) wrote=
:
> > On Sat, Nov 14, 2026 at 1:59=E2=80=AFAM Brian Norris <briannorris@chrom=
ium.org> wrote:
> > > Is it worthwhile to note (or at least hint at) how many other things
> > > change along with this? e.g., how pm_runtime_allow() (and therefore
> > > auto > control/power), all non-autosuspend pm_runtime_put() variants,
> > > etc, also extend the autosuspend timer? I think we agreed these are
> > > acceptable effects, and likely even desireable, but I'd say these are
> > > fairly major changes.
> >
> > Fair enough, I'll add the following to the changelog when applying the =
patch:
> >
> > "This potentially changes observable behavior in all situations in
> > which pm_runtime_put(), pm_runtime_put_sync(), pm_runtime_idle(), or
> > pm_request() idle is used on a device with an autosuspend delay.  That
>
> nit: you split "pm_request_idle()" oddly

I noticed that too and fixed it up.  Not sure what happened here.

> > includes changing a device's "power/control" sysfs attribute value
> > from "on" to "auto" (if there are no other active runtime PM
> > references to the given device), accessing PCI configuration space
> > from user space etc.  Namely, in all of those cases, the runtime
> > suspend of the device following the runtime PM helper call (if it
> > causes a runtime suspend to occur) will be deferred by the full
> > autosuspend delay, which arguably is more consistent and predictable
> > than deferring the runtime suspend in question by a more-or-less
> > unknown (and basically random) time depending on when the most recent
> > update of the device's last_busy timestamp has occurred.
> >
> > It will also cause the majority of the direct
> > pm_runtime_mark_last_busy() calls to become redundant, and they will
> > be taken care of later."
>
> Seems good, thanks! Who knows if anybody will actually read the
> changelogs, but at least it leaves a paper trail for future cleanups
> that will likely reference this change.
>
> > > In any case, the change looks good to me:
> > >
> > > Reviewed-by: Brian Norris <briannorris@chromium.org>
> >
> > Thank you!
> >
> > > I meant to make time to test this out a bit more, but ran out; maybe
> > > next week.
> >
> > That will be much appreciated.
>
> OK, I made some time:
>
> Tested-by: Brian Norris <briannorris@chromium.org>
>
> It tests out well (passing) with:
>
> (a) the KUnit tests that try to imitate the stm32-adc parent/child
>     structure from commit c537d3457542 [1]
>
> (b) my original KUnit test [2]. I've appended a slightly-updated v3, in
>     case you want to merge it
>
> (c) some targeted PCIe tests on Pixel phones. Specifically, I see that
>     the portdrv.c 100ms autosuspend delay is now consistently applied
>     after both lspci (this used to work OK, simply because rpm_resume()
>     would also update last_busy) and after endpoint suspend (this
>     previously did not apply the autosuspend delay, as the endpoint
>     tended to stay active for a long time)
>
> [1] https://lore.kernel.org/all/auzlLwlleGLPsLcw@google.com/
>     This test is inherently timing sensitive and therefore flaky. It
>     just serves as an example, not something to commit.
>
> [2] [PATCH v2 4/5] PM: runtime: Add tests for last_busy propagation
>     https://lore.kernel.org/all/20261103141442.v2.4.I8ab8b7f662fe1921c708=
4a47d554535597cc2702@changeid/

Thank you!
