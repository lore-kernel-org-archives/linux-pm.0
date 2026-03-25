Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92183537C9
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 20:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470049; cv=none; b=f7a7yBGXvYnVvk9JQFh69Qm9qF4dOny7lQMkcbh3iK7DwkKk8tJ8KYckje+VABwsDRY+Y8WbTDXzVgsP8tBgyGUD2HsqTLTN8H3ubPHuNS5sniU7GA9HyrtT2at7yCzrAHLitqxYx1O5tGG5COL9VXd7hs+c90K2Mo5DXtM3JMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470049; c=relaxed/simple;
	bh=0C0HgsgYnFx7Ir3a1uFaQXfZIf5+KpqK9gAr2u19t2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnzV62NoYMwkNz9asy3Dlk2SrvhJv5Vf/t9y1jrchxQN8SAk+IW/LIDMuZeB/cjnn6cjEeR8lKjQhdzX0nBaIcGyOUHJ8GECdKg+uV1cS9vMM+iu0eAS3z+UXdDrEqEzff6itsO1nfiYhkRJ8aCZ2ytX2GoGyH+uWiNpjw51Vow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZHN9iyd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZHN9iyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA64C2BCB5
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 20:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774470048;
	bh=0C0HgsgYnFx7Ir3a1uFaQXfZIf5+KpqK9gAr2u19t2s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GZHN9iydOHy9IRb9uVmXDBIor+TYqGgLSU+OKWpdoYBaMy0YMmCNLjLK4nEJTyCmB
	 DG38GGuLH4CmfQt3+uRWrkXFnsS/k6QVaaDqfrYwOy3Xsm7U9ZLXSNgnWl2rLVJV0B
	 daPpYE4Vawj39dT43LNC3DvfMYS7gNOv3H0E9/DrVOY9ZNJnlQX3Ygxt+EV0azJUfP
	 ehOI1ETwUgubcjS0MxVxB535x3OrLMb1HGsJ789Xl62AmwxDClh/sn0EWNlz92VDxh
	 lZ6fSDovmeiFjSBQBm+6cZi3TfoJAKq45utejzHtZw63OrTP/6opMoc7EypQ0PeE5X
	 vMw6BqABjQXFQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-41708f6c3feso173258fac.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 13:20:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUje2fU7wyoBYFShW0eOCt2P88h4OXVe78JyDVZyk6EI9ft1eLUK6vyDs879//qp8S6w2VGqIaaOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEPQwrIBXMXJ4jzk+OU/Mnkq232K6bnLqlHXyhu99X4xaaOJ1n
	iAb8GZxxCKIhtFpCGlARELCN1yYiWoeRA5Afb1/VZuPSMiDQzMp4uY38Gh4pgDTG0AxvwuxLPgD
	LzXSVZrHcd0ywjDnPCdWFhJnszJIA9l4=
X-Received: by 2002:a05:6871:806:b0:41c:c778:dc05 with SMTP id
 586e51a60fabf-41cc778fb6cmr539727fac.50.1774470047835; Wed, 25 Mar 2026
 13:20:47 -0700 (PDT)
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
 <a61c19043dcf579e46f7d4f124013e60@igalia.com>
In-Reply-To: <a61c19043dcf579e46f7d4f124013e60@igalia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Mar 2026 21:20:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0goUgYXwyR-G_5zu+wTfbCH5B4B0JL1pU9+cdHbKqT-Lw@mail.gmail.com>
X-Gm-Features: AQROBzCpQbF9qapnQTAr_UygTUHZXAIOMcfJJmHURYWjc4mAJnSKMsqQEud-PWA
Message-ID: <CAJZ5v0goUgYXwyR-G_5zu+wTfbCH5B4B0JL1pU9+cdHbKqT-Lw@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: fix use-after-free due to init/cancel
 delayed_work race
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
	syzbot+3b3852c6031d0f30dfaf@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 4:13=E2=80=AFPM Mauricio Faria de Oliveira
<mfo@igalia.com> wrote:
>
> On 2026-03-25 11:28, Mauricio Faria de Oliveira wrote:
> > On 2026-03-25 11:17, Mauricio Faria de Oliveira wrote:
> >> Thanks for looking into this.
> >>
> >> On 2026-03-25 09:47, Rafael J. Wysocki wrote:
> >>> I can see the one between thermal_zone_device_unregister() and
> >>> thermal_zone_device_resume(), but that can be addressed by adding a
> >>> TZ_STATE_FLAG_EXIT check to the latter AFAICS.
> >>
> >
> > Please disregard this paragraph; I incorrectly read/wrote _resume()
> > as thermal_zone_pm_complete() discussed above. The rest should be
> > right. I'll review this and get back shortly.
> >
> >> In the example describe above and detailed below, apparently that
> >> is not sufficient, if I'm not missing anything. See, if _resume()
> >> is reached with thermal_list_lock held, thermal_zone_device_exit()
> >> is waiting for thermal_list_lock before setting TZ_STATE_FLAG_EXIT,
> >> thus a check for it in _resume() would find it clear yet.
>
> Ok, similarly:
>
> Say, thermal_pm_notify() -> thermal_pm_notify_complete() ->
> thermal_zone_pm_complete()
> run before thermal_zone_device_unregister() is called;
> thermal_zone_device_resume()
> starts, and by now thermal_zone_device_unregister() is called.
>
> If thermal_zone_device_resume() wins the race over thermal_zone_exit()
> for guard(thermal_zone(tz) (tz->lock), it sees TZ_STATE_FLAG_EXIT clear;
> note its callees (eg, thermal_zone_device_init()) run with tz->lock
> held,
> so they see it clear as well.
>
> So, thermal_zone_device_init() calls INIT_DELAYED_WORK(), everything
> returns, tz->lock is released and the thermal_zone_device_unregister()
> -> thermal_zone_exit() path can continue to run.
>
> Only now thermal_zone_exit() sets TZ_STATE_FLAG_EXIT (too late),
> returns.
> cancel_delayed_work_sync() does not wait for
> thermal_zone_device_resume()
> due to INIT_DELAYED_WORK() in thermal_zone_device_init(); and kfree(tz).

Wait.

I'm not sure why this matters because the zone lock is dropped at the
end of thermal_zone_device_resume() at which point it has done
everything it had to do.  Then, the cancel_delayed_work_sync() in
thermal_zone_device_unregister() should properly wait for the work
item queued up by thermal_zone_device_resume().

> Then, thermal_zone_device_resume() accesses tz and hits use-after-free.

Say thermal_zone_device_resume() has lost the race for tz->lock to
thermal_zone_exit() though.  It runs after the latter and
reinitializes the delayed work.  Now, thermal_zone_device_unregister()
continues and cancel_delayed_work_sync() doesn't see the
thermal_zone_device_resume() running in parallel with it any more, so
it doesn't wait and if thermal_zone_device_unregister() continues to
run, it may free tz prematurely.

I claim that this can be prevented by adding a tz->state check to
thermal_zone_device_resume() before the reinitialization of the
delayed work.  Namely, if it loses the race tz->lock to
thermal_zone_exit(), the new check will trigger and the delayed work
will not be reinitialized, so the cancel_delayed_work_sync() will wait
for it to complete.
