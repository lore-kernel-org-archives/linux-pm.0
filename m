Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19DD35970F
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774466994; cv=none; b=LiK86ZQKSmiyR8ALu4HND5rZCEZE4ib3jh7N82N+3EDHQjTJvJBMLdqZqshTN7Rr3K3s1vapiyFC9qzUvL9QxJY0/HMz3tUo5hA2KxCYD2PA2gwKVPpl3PEBfqE6/FpSAk4SnzPWuvkzWJUzqAY0Y8GrYJC1tnV6M+7u0wFbPhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774466994; c=relaxed/simple;
	bh=2G9N8KBGfOqIgIrY/BsykeYDuUrwjQhuoZyDS2oSa1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uogYin3WnsdwHTPm27FG4cLZbiyB/CGB7ABarXIo8ih1netbU9SC+34xRbrkRhvtj7kK+yM/vjydY4WvmVfF5TeINGhfIBbFC+Tl89W1+1Nfnw8RIDBNgi/0SGPDGZZYhJffRJsW75ybnWLqLZyeWuYa0VqkKLt15tNpu77Jrng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLlip00c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLlip00c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84556C2BCB4
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 19:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774466993;
	bh=2G9N8KBGfOqIgIrY/BsykeYDuUrwjQhuoZyDS2oSa1A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PLlip00cW99Zcuu2iqheJmRx2uTqHdbBsW2nT7htacuOP+OJfkRsEgUFrMalWdeba
	 NuUlzf8Mr4Rd3pqG0ulSRc+v1QVObh0P+BlT6cVkomXiWmFsfR9S/2LhdJBzdRThAA
	 l7ZV8C7FMnHsKVEEGyNEXF+4W/Nsda2823q6XqYDnK7CXzv7azxAP2w/qEbgbQZPrD
	 aqyDOF5c8VkJpp0HMkK4A5uh8pjZmS6FmiV66RrBwWlcw4aWcK+ARiwR/xVY7RoB3H
	 98p/Bg58yC1iXI8bLdakHO5MFgQ0Mt0N8xO5piL8m0LGHqRL3exa9eszRb7dQa/mkr
	 8jOAEn+r22iRA==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-467161c4b7aso78645b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 12:29:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXYIVnhtD5WGz1mIkG5OuMK0JikEkxUS1EqHHNRm9YtKDDOHFoutOsMRWJEKamiCbWNJzzE2+olw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQRmYFoi6zuA/9xyrCKZftm2apMJA5lQM0kk92ZW4dovdezpzP
	BzL244BjsQtsiBubmAr1OB0+OQpRv1n1sgj4NCpLseCxBHL6o49m2BU9PAC7i9+p/ecM/Rb4c+k
	RXOvCfGs+jCtjwfFo3jskKienR9yvElU=
X-Received: by 2002:a05:6808:1911:b0:467:1462:a9b3 with SMTP id
 5614622812f47-46a5c6b4cb3mr2365681b6e.38.1774466992590; Wed, 25 Mar 2026
 12:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-thermal-core-uaf-init_delayed_work-v1-1-6611ae76a8a1@igalia.com>
 <CAJZ5v0h8Q-Cs-05hwKUF9wPbOzg2gyG8yH6tOfzJgXQCh5Ohbg@mail.gmail.com>
 <CAJZ5v0iBh6BjtwhS7RK_GE8QmYLAwW71P+YpA92SiGu4wy+syw@mail.gmail.com>
 <772a77c80b6ad216dec4cc10d3fbb133@igalia.com> <52d861b9a215150424ae4d49b4e2c90b@igalia.com>
 <a61c19043dcf579e46f7d4f124013e60@igalia.com> <CAJZ5v0jcK0eg1fjSmMDDhTqNqFxUmhdNs=exs13nduRivCiLQQ@mail.gmail.com>
 <cce6cb6e12b09bc97cf684e378c874f4@igalia.com>
In-Reply-To: <cce6cb6e12b09bc97cf684e378c874f4@igalia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Mar 2026 20:29:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0irL14vtz35zKF9ZPH8M1TN6i5mWkT2zQyB5d+LBPUXHg@mail.gmail.com>
X-Gm-Features: AQROBzDvG-6ThfgZRnhq6oyt-zj-rmRiW2iR723NoJ7COdCvId36uYVaHqiMjZA
Message-ID: <CAJZ5v0irL14vtz35zKF9ZPH8M1TN6i5mWkT2zQyB5d+LBPUXHg@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: fix use-after-free due to init/cancel
 delayed_work race
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
	syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 8:22=E2=80=AFPM Mauricio Faria de Oliveira
<mfo@igalia.com> wrote:
>
> On 2026-03-25 13:24, Rafael J. Wysocki wrote:
> > On Wed, Mar 25, 2026 at 4:13=E2=80=AFPM Mauricio Faria de Oliveira
> > <mfo@igalia.com> wrote:
> >>
> >> On 2026-03-25 11:28, Mauricio Faria de Oliveira wrote:
> >> > On 2026-03-25 11:17, Mauricio Faria de Oliveira wrote:
> >> >> Thanks for looking into this.
> >> >>
> >> >> On 2026-03-25 09:47, Rafael J. Wysocki wrote:
> >> >>> I can see the one between thermal_zone_device_unregister() and
> >> >>> thermal_zone_device_resume(), but that can be addressed by adding =
a
> >> >>> TZ_STATE_FLAG_EXIT check to the latter AFAICS.
> >> >>
> >> >
> >> > Please disregard this paragraph; I incorrectly read/wrote _resume()
> >> > as thermal_zone_pm_complete() discussed above. The rest should be
> >> > right. I'll review this and get back shortly.
> >> >
> >> >> In the example describe above and detailed below, apparently that
> >> >> is not sufficient, if I'm not missing anything. See, if _resume()
> >> >> is reached with thermal_list_lock held, thermal_zone_device_exit()
> >> >> is waiting for thermal_list_lock before setting TZ_STATE_FLAG_EXIT,
> >> >> thus a check for it in _resume() would find it clear yet.
> >>
> >> Ok, similarly:
> >>
> >> Say, thermal_pm_notify() -> thermal_pm_notify_complete() ->
> >> thermal_zone_pm_complete()
> >> run before thermal_zone_device_unregister() is called;
> >> thermal_zone_device_resume()
> >> starts, and by now thermal_zone_device_unregister() is called.
> >>
> >> If thermal_zone_device_resume() wins the race over thermal_zone_exit()
> >> for guard(thermal_zone(tz) (tz->lock), it sees TZ_STATE_FLAG_EXIT clea=
r;
> >> note its callees (eg, thermal_zone_device_init()) run with tz->lock
> >> held,
> >> so they see it clear as well.
> >>
> >> So, thermal_zone_device_init() calls INIT_DELAYED_WORK(), everything
> >> returns, tz->lock is released and the thermal_zone_device_unregister()
> >> -> thermal_zone_exit() path can continue to run.
> >>
> >> Only now thermal_zone_exit() sets TZ_STATE_FLAG_EXIT (too late),
> >> returns.
> >> cancel_delayed_work_sync() does not wait for
> >> thermal_zone_device_resume()
> >> due to INIT_DELAYED_WORK() in thermal_zone_device_init(); and kfree(tz=
).
> >>
> >> Then, thermal_zone_device_resume() accesses tz and hits use-after-free=
.
> >>
> >> Hope this clarifies. Please let me know your thoughts. Thanks!
> >
> > Thanks for the analysis, it sounds accurate.
> >
> > I'd say that thermal_zone_device_unregister() needs to flush the
> > workqueue before calling cancel_delayed_work_sync() to get rid of the
> > stuff that may be running out of it that hasn't seen the changes made
> > by thermal_zone_exit().
>
> IIUIC, cancel_delayed_work_sync() has that effect: it waits for
> (specific)
> work that might be running and hasn't seen changes by
> thermal_zone_exit()).

Sure, but you argued yourself that this didn't work if the work item
in question had been reinitialized in the meantime.

Flushing of the workqueue would take care of that.

> > This should take care of all of the existing races because if anything
> > is running out of the workqueue when thermal_zone_device_unregister()
> > runs, it will be waited for after calling thermal_zone_exit() and any
> > leftover stuff will be caught by cancel_delayed_work_sync().
>
> Likewise, the wait-for part is an effect of cancel_delayed_work_sync(),
> and AFAIK, there is no leftover after cancel_delayed_work_sync(), as
> it waits for the running work function to finish.
>
> And no further work is queued in the 2 code paths that can queue work:
>
> 1) thermal_zone_device_check(): even if it misses the tz->state check,
> mod_delayed_work() does not requeue the current work item if it is
> canceled/waited for by cancel_delayed_work_sync() (tested locally).
>
> 2) thermal_zone_pm_complete(): this function will no longer be reached
> because tz is no longer in thermal_tz_list.
>
> > Of course, it's better to switch over to using a dedicated workqueue
> > in the thermal core for that.
>
> Considering the points above, AFAICT, it should be sufficient to call
> cancel_delayed_work_sync() for the 2 code paths in unregister()
> (which thus require the distint work items for each code path).

And I don't want to add another work item to the thermal zone
structure just for the handling of suspend/resume.
