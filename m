Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433689;
	b=4lCIyx/eeJmVfGBOmolZYfRF+jHurWujwBJcp9zDIOVgQfas5ChPYN7I3D0PWTnafbJp
	 WpHzyxywWACLhYTf/TL+r9+tn1Ujmutpoj6ZUQd8kMjzoZOwlzjIa96N6SwOye6HuV5iQ
	 2ex3eL4ajxcKDF6b2RUuCVO6zF1xx1ByS7UltrB2JWpf4iOgX5X99JsFCnuIIG9GmOSRU
	 lOwWWpRDfDQuwLU6KbTBjDQ+eXCJaaCTdzpUSLEWXowlrsc7v4ZA1HWeE4Cqx7QTCju7G
	 UaH+KeGHI0DchPQoJZSz57qGSv/Ucpto5CaT2uE0HTyQLdZ/WXUbMPzF0sjQcRkcRng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433689;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XNapb0FlYNiMzf484coWRZ4BJd0SDLSUVPDu3zsHX/s=;
	b=ZuM+9nJSyFBwKPGHyEGPl7yQ50mmX0faAka6izn3wnUVNWWm00DdTq6EG85gWQmOTW+m
	 7eb68J38RX1frvgRArwO9FcH3zr8pOnXqCA/WuGR2Ro1QtvZzS6RD5B6m2ALsQhjLHyqe
	 haWD3pkehnjjqKnOgTWc42MqLVbPGLzjOg2eqyqmYqurrKfgiInwXqh+n59cfUCfJ+A/k
	 PDRvg798Tt3btSKJaEAWJq0cjdD3TScxOYrfxBYJ759d043BYvFDJZJL0WQ4X00dU/fHM
	 t/F3b3lrJ68Ete91vKNO3faMRCEJuqbapL8l/9yuN7zfH1Y5A0Xbah5qgh0fsyuZSyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQDWYFj4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2792606A31A
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQDWYFj4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A8C1F00ADB
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 18:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792433688;
	bh=XNapb0FlYNiMzf484coWRZ4BJd0SDLSUVPDu3zsHX/s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NQDWYFj4tlQAKIbvMKzC8saEpDDmYogW6KW98HNxWn3ZxQVGlMuUm3MPDj3Tknw55
	 0t0rSSfAzUeUr9Q8pbgej8rMCexrZF7DqN8UP7nsAIl/5pjFaxRvg9+8mXyQBDMbLV
	 mmjzJj1BNaNU6HupMHtInohiSI1yWct8jmjNR5VZrZr8osKz8T1HaHvnVOU2QmHd52
	 x8rTXR6/NyIPF++bhTKtlvdDW2Kl7bDoJA0v3/doU5PkfQMFHXEMl97dXyFQijXCzf
	 qeask0Veh5thSBFmVS7YBkNs4EVXwFeOr1GBjqu3Y0u14l4j+6YgJiXm1LpbBnDGyn
	 1WnVn9QCNfPyw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ba35c0df4fso2432371e87.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 11:14:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxvCQs91+cJToTR67t8GydIP+6u899o47/Um4OitD5805PbgHSjmb5lMR2PoLyZTJJKOz+6oRNDfA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIn1jbQgXNM+VmlKSBpXiCDBe6975lEoI/7h40uLJmu+do90WJw
	ehha1MnT3lkavTZ/PcWEtviL7P8ke42Q2hZhvJ0ICkdNjJ5ONPIczy/ZW2DlPl0Zz/0QbsRcKEv
	BYfUtjlGTe88krKIRYtQwENvf9tJfkDA=
X-Received: by 2002:a05:6512:3050:b0:5ba:3d82:3bbf with SMTP id
 2adb3069b0e04-5be50a6a8f8mr2852643e87.40.1792433686787; Mon, 19 Oct 2026
 11:14:46 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019073930.2352283-1-daniel.lezcano@oss.qualcomm.com>
 <20261019073930.2352283-2-daniel.lezcano@oss.qualcomm.com> <2818716f-3502-aa4b-0b7b-4efc61e46f6c@linux.intel.com>
In-Reply-To: <2818716f-3502-aa4b-0b7b-4efc61e46f6c@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 19 Oct 2026 20:12:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iRDbPEQWL+gXO1zd_7SZtHLmwhwtmF3A-z9r0VXHAcRA@mail.gmail.com>
X-Gm-Features: AclHuK9h8u8T4xQ7W0VEcO3CuHD6d-ur3g7Fnq_OHExwJkfacOxWTJ5OSEtGnw4
Message-ID: <CAJZ5v0iRDbPEQWL+gXO1zd_7SZtHLmwhwtmF3A-z9r0VXHAcRA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] platform profile: Separate handler locking from
 sysfs lifetime
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Hans de Goede <hansg@kernel.org>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>, 
	Jai Luthra <jai.luthra@ideasonboard.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Mario Limonciello (AMD)" <superm1@kernel.org>, 
	Jack Wu <jackbb_wu@compal.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Zhang DM <jixianqiang1540@gmail.com>, linux-acpi@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 10:51=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 19 Oct 2026, Daniel Lezcano wrote:
>
> > Registration and removal currently hold profile_lock across
> > device_unregister() and sysfs_update_group(). These operations can remo=
ve
> > sysfs attributes and wait for their active callbacks to finish. The
> > profile read and write callbacks acquire profile_lock themselves, so a
> > concurrent access can deadlock:
> >
> >   Removal/update path             Active sysfs callback
> >   -------------------             ---------------------
> >   acquire profile_lock            hold kernfs active reference
> >   remove a sysfs attribute         wait for profile_lock
> >   wait for its active references
> >
> > The removal path cannot finish until the callback returns, and the
> > callback cannot return until the removal path releases profile_lock.
> > This applies both to per-provider device teardown and to updates of the
> > legacy aggregate attribute group.
> >
> > Commit 041142d7d252 ("ACPI: platform-profile: Fix possible deadlock in
> > platform_profile_remove()") previously fixed this lock ordering by movi=
ng
> > sysfs_remove_group() outside profile_lock. Commit 55b1e68134bf ("ACPI:
> > platform_profile: Use guard(mutex) for register/unregister") reintroduc=
ed
> > the issue by extending the mutex guard over sysfs_remove_group(). Later=
,
> > commit 77be5cacb2c2 ("ACPI: platform_profile: Create class for ACPI
> > platform profile") replaced that teardown with device_unregister() and
> > sysfs_update_group(), still under the same mutex, extending the problem
> > to class-device teardown and aggregate attribute updates.
> >
> > Simply dropping profile_lock around these operations is insufficient.
> > Aggregate operations currently discover providers through the class
> > device list. A provider being unregistered could therefore still be
> > selected for an aggregate read, write or cycle while its sysfs files ar=
e
> > being torn down. Concurrent registrations and removals would also race
> > when updating aggregate attribute visibility.
> >
> > Introduce profile_registration_lock to serialize registration, removal
> > and aggregate sysfs updates. Sysfs callbacks never acquire this mutex.
> > Retain profile_lock for profile operations and use it to protect an
> > explicit list of handlers participating in the aggregate interface.
> >
> > Add a handler to that list only after device_register() succeeds. On
> > removal, unlink it under profile_lock before calling device_unregister(=
).
> > Acquiring profile_lock first waits for any aggregate operation already
> > using the handler to complete; unlinking prevents later aggregate
> > operations from finding it. Release profile_lock before draining sysfs
> > callbacks, allowing active per-provider callbacks to complete before th=
e
> > device is released. Apply the same unlink-before-unregister ordering to
> > registration error cleanup.
> >
> > Walk this list for aggregate reads, writes and profile cycling, and use
> > its emptiness to determine aggregate attribute visibility. The class
> > devices remain the per-provider userspace interface.
> >
> > There can now be an interval between removing the last handler from the
> > list and removing the aggregate attributes. Explicitly reject choices
> > reads and writes during that interval: the intersection bitmap starts
> > with every bit set, so an empty traversal must not advertise all profil=
es
> > or report a successful write without updating a provider.
> >
> > This separates aggregate membership from class device teardown while
> > preserving the existing class and ACPI sysfs interfaces.
> >
> > Fixes: 55b1e68134bf ("ACPI: platform_profile: Use guard(mutex) for regi=
ster/unregister")
> > Assisted-by: OpenCode:gpt-6.1-sol
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> > ---
> >  drivers/acpi/platform_profile.c | 75 ++++++++++++++++++---------------
> >  1 file changed, 42 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pr=
ofile.c
> > index 79d2e92e5c28..f98ce4cda02c 100644
> > --- a/drivers/acpi/platform_profile.c
> > +++ b/drivers/acpi/platform_profile.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/bits.h>
> >  #include <linux/cleanup.h>
> >  #include <linux/init.h>
> > +#include <linux/list.h>
> >  #include <linux/mutex.h>
> >  #include <linux/platform_profile.h>
> >  #include <linux/sysfs.h>
> > @@ -15,8 +16,12 @@
> >  #define to_pprof_handler(d)  (container_of(d, struct platform_profile_=
handler, dev))
> >
> >  static DEFINE_MUTEX(profile_lock);
>
> Should definitely add comment to this lock as well to explain what it
> protects.

+1

> > +/* Serialize registration and sysfs updates without blocking sysfs cal=
lbacks. */
> > +static DEFINE_MUTEX(profile_registration_lock);
> > +static LIST_HEAD(profile_handlers);

Also, I think that the rest of the series is not going to get into 7.4
in any shape or form, so my suggestion would be to address the above
and send a new version of the $subject patch as a separate fix, and
defer the other patches in the series until 7.4-rc1 is out.
