Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1CD3E1CE2
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774455893; cv=none; b=PaYhMSg2wyO8YGgCDlRRAFyVwikHa10+wln5T1qpAlhW4RLwfIclJI4VuCDX0QMIem91uixAj5PRSIyHZEnqKBlaermgFsvQxAHT7QnsWJPta8fbC0wiYPKWAzwVCPqqJE3eHc0WdNckaJSB2A+DjeGgM/CMg5ZF9wXPAHR96/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774455893; c=relaxed/simple;
	bh=pJWe+PbuYzwyKyTT6QZKc5jnPh3dqAjxLyvs/4gkA6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSijeKk+9+Drh44REXJkZaTJzSPQmvlm+LIGmWxdkbqGDqjHWan981gWDXcmPHV/4HGKtgH6uyF5zlFRpoaKHnvj2Qfv29B8ZSefa43cGiEvrvDW8R78krdMTKF5QpK5OHQKcnjebfrKAbGjc1uLUUktAU3p37Qa56ffRSLIAqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PagBb1Bd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PagBb1Bd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203A7C2BCB0
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774455893;
	bh=pJWe+PbuYzwyKyTT6QZKc5jnPh3dqAjxLyvs/4gkA6U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PagBb1BdaTCTf1QTXuw+7hSIHuMITki8bVms3Z/DcSgjrC8m1J1T/Oexb9Qy5r7mC
	 vaJbcIUj9Ve3p84kDobQBsGkGEBIvRy8u0VG1Lj/kWUCN1ygtlAaUVPPVFHo6SoC5k
	 SXrgTFSfL/M0qtvG4aIkxRUsHTbMxE1MV2U9MoFF3gnm4n5/vbHfo89Eq5D4JlDbe5
	 cwBlybwYER7tZi+Oz27Piy/+HROqin3andsYdW8kYb3eVjyBJqxkZt/pc5c3p8PDid
	 dUeBIPizyoz0+OemIaIHbR7zU7lbVJ4IzkxtZ3cY86bxzdbb3U7HBNN5GuRjkUgsLI
	 moq8VRJrapUPw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-40efc77933fso21739fac.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 09:24:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXEqu2jyMGONbAb1B13Zif/1rONkwrLj5t8ZHCsmD2Lj2j3EAwtTafDOTbOzxcLssya+YyJ+ujv2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeG0dAUUoR4EKYGANVmkqG4Ho/8DDLYOIHothR0Ew0VSgk17zv
	3LGHgW1tQdMx5WVdJC52ggLIhHEp3hmJuGSSwkT74+lgOe4/o39BzrucXFSIFvD/XgA4jcXAjbJ
	jkIKlAENQ9RaBrvKgkYwuwLv51lJgong=
X-Received: by 2002:a05:687c:3084:b0:41c:9844:1baf with SMTP id
 586e51a60fabf-41ca722a011mr1812497fac.30.1774455892225; Wed, 25 Mar 2026
 09:24:52 -0700 (PDT)
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
Date: Wed, 25 Mar 2026 17:24:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jcK0eg1fjSmMDDhTqNqFxUmhdNs=exs13nduRivCiLQQ@mail.gmail.com>
X-Gm-Features: AQROBzBJxr8EXOSZHL3xbhmtiZ62doG9HlfCtZzg0QVADkpMuxYSqnlFDB8_p-I
Message-ID: <CAJZ5v0jcK0eg1fjSmMDDhTqNqFxUmhdNs=exs13nduRivCiLQQ@mail.gmail.com>
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
>
> Then, thermal_zone_device_resume() accesses tz and hits use-after-free.
>
> Hope this clarifies. Please let me know your thoughts. Thanks!

Thanks for the analysis, it sounds accurate.

I'd say that thermal_zone_device_unregister() needs to flush the
workqueue before calling cancel_delayed_work_sync() to get rid of the
stuff that may be running out of it that hasn't seen the changes made
by thermal_zone_exit().

This should take care of all of the existing races because if anything
is running out of the workqueue when thermal_zone_device_unregister()
runs, it will be waited for after calling thermal_zone_exit() and any
leftover stuff will be caught by cancel_delayed_work_sync().

Of course, it's better to switch over to using a dedicated workqueue
in the thermal core for that.
