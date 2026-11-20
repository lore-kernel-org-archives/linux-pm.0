Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210179;
	b=mXImOfjk+2caU8IbaaDq7o5xV1vOzsEn3fMPyDqhZj6DHVxd8lpGsBEuupu+MdbgySUT
	 GVMUesw8ysBvmN7drFlg1by5M93HTz6H9LOAjbZRI0GvjWIpCxX0NSeRzXmE3VO68HN0R
	 jcvpZya2qeMwciISxCsUKzvkxFdkgiZUBnQHJq4Dia1nNFXIA4VOjzXN7HO1p9gk+/cpE
	 zlIBgGgdwY4dr6X2qMOb57m+cLNaekY5rt3PU4qypTsfZT5LXriqyJnROhGGjbAWEKV1a
	 7Ztb66t8fnXL6ROLkIaLCH7ghBvLltRu7IxdcG+tcjFjQqfwpNppQWQbJkQkDDhoBzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210179;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FsvYp4djSBIDmHAC1c5u5erJZri7FVrJBQWQouXKwyc=;
	b=lOA8EY2xkxQXIrKmqEp/4K6Mbnc4Fcn1gQyB40x4Mq8RcoCCoxtIv99zBuywrdbIuSMz
	 U7+6VhCDgad70qJev/kduB+WxuzFrQKQzGsenwnOOBaVq+khWGFijwGUlN7E+Xm8yVv4s
	 2AKsXWhueblblBgfRZK3PfLwpPf1CK1qR62VBWS+irDCnAjmR7GtbigAKuGJ1EzJNh2W1
	 vDFW3jIZSnFy6RBH69MGGdynpEch8LKTsM3GYUVp4gtPu21SM01nAkcAmwJAjR7XOL2oV
	 /d3ZqnK+fTuiYmPDtrkODSvTidOmd/HZqShiLzdm3wpwlY3BgGsUr3uCP6JdTrH/TGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXknR2Rz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0AA606A69C
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXknR2Rz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285881F000C4
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 21:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795210179;
	bh=FsvYp4djSBIDmHAC1c5u5erJZri7FVrJBQWQouXKwyc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GXknR2Rz1t7tDuZiPvhGN1UVwKm2NXMTfMD/MQmn8yVVqwAtZadc+ks4POd5QU8uj
	 Zdr1Rb+i/rLw1KX30JD0mlUOu5pxlxvsxc83FhyXgEhwmN6k8j4ieKj1zWYigq80s3
	 kMTpUtk+NsAIncNSHReu/kPCUft2HmoPFLV4kx74v0ptV3UJ6c6yTiwPOA5GjJeV6b
	 y1YnsNUWNiCAkJsJ/oQRvZ+4Y4lgKUlg86n2LsjWOEeV6vXqF1wjXdzQ83+zOw1vlu
	 SewiAtJQ+ET6fEvFUT3Ykq2IWRt6C/zR9J8qLRLEdUT+s1ifeOwWolUgSGj8lfUR8T
	 9hZK/LvtST0Cg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3ad5529ae64so9805671fa.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 13:29:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG+hFvlh2Dov/wyEo6wP4f8p10Z449WnA8Ll4MzH/me7JUAaKMKBdyG9fgsgETzaymh9sxzHm54yw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8+RyfqOMByBCjQLA9qRpmglY/nVMS4iMCf2P3GuJCKuJzrTgUQ
	Zb9hGsBpcZXth5k53NtoAQNbdc7iZopM+AV5gaBHLFC+3ERlOWAlQ4DSTnHt34F/xGry1+XGP8e
	1tdXP9WgwhfMeo6Qbjh7yd2p3akl2fCI=
X-Received: by 2002:a05:651c:31c1:b0:3ab:119a:81c5 with SMTP id
 38308e7fff4ca-3ae7fa21104mr14526741fa.23.1795210177574; Fri, 20 Nov 2026
 13:29:37 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <1978814.tdWV9SEqCh@rafael.j.wysocki> <3076901.e9J7NaK4W3@rafael.j.wysocki>
 <awC0tcqgq2KvCyxO@google.com>
In-Reply-To: <awC0tcqgq2KvCyxO@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 20 Nov 2026 22:29:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jjxWzL-NLkm5B2ayGfXYdQcE4Shq8B9TGz1ghHBybSAg@mail.gmail.com>
X-Gm-Features: Aa3M54q07MgJ4reO3fe89RIbr4EZ2z_u5OP9TjboNs4OyJVP8mc5Po1RCdwK3q4
Message-ID: <CAJZ5v0jjxWzL-NLkm5B2ayGfXYdQcE4Shq8B9TGz1ghHBybSAg@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] PM: runtime: Update last_busy in all rpm_idle() paths
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>, 
	Linux Driver Core Development <driver-core@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 9:59=E2=80=AFPM Brian Norris <briannorris@chromium.=
org> wrote:
>
> On Thu, Nov 19, 2026 at 09:16:30PM +0100, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > The changelog of commit 26236a3e8803 ("PM: runtime: Update last_busy
> > before calling rpm_suspend() in rpm_idle()") stated that rpm_idle() onl=
y
> > needed to update last_busy when it was about to call rpm_suspend(), but
> > that is incorrect.  There are still cases in which a device may be
> > autosuspended earlier than expected.
> >
> > The first one is when pm_runtime_put() is called while a leftover
> > autosuspend timer is running.  Then, dropping the device's runtime PM
> > usage counter to 0 allows rpm_suspend() triggered by the timer to
> > suspend the device immediately before __pm_runtime_idle() is able to
> > grab the spinlock.  Prevent it from occurring by adding a last_busy
> > update before the rpm_drop_usage_count() call in __pm_runtime_idle().
>
> Do consumer->supplier and child->parent refcount drops have the same
> problem? e.g., in pm_runtime_release_supplier() and rpm_suspend() /
> parent->power.child_count decrement?

I need to think about it.

I don't think it affects the $subject patch anyway though.

> > Another one is when rpm_idle() returns without calling rpm_suspend(),
> > for example because the callback has returned a transient error, while
> > an autosuspend timer is running.  The timer may then suspend the device
> > without respecting the autosuspend delay.  Moreover, the timer may fire
> > while the callback is running and it will not see the new last_busy
> > value in that case.  To address these cases, move the existing
> > pm_runtime_mark_last_busy() call in rpm_idle() before the first return
> > value check.
>
> I suppose we don't care about: "what if .runtime_idle() is slow?" --
> that makes a small delta in the expiration time.

No, I don't.

It is actually absent in the vast majority of cases.  And if it is
present and it is slow, it may as well call
pm_runtime_mark_last_busy() itself.

> > In both places mentioned above add comments explaining the rationale fo=
r
> > updating last_busy.
> >
> > Fixes: 26236a3e8803 ("PM: runtime: Update last_busy before calling rpm_=
suspend() in rpm_idle()")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > Commit 26236a3e8803 is present in linux-next.
>
> Semi-unrelated cleanup: pm_runtime_put_sync() some stale kerneldoc now,
> saying "this does not update the last access time".

Ah, good point.

> > ---
> >  drivers/base/power/runtime.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.=
c
> > index 0b15c718c1bb..02e7b4953c38 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -518,6 +518,14 @@ static int rpm_idle(struct device *dev, int rpmfla=
gs)
> >       else if (dev->power.idle_notification)
> >               retval =3D -EINPROGRESS;
> >
> > +     /*
> > +      * Update last_busy to defer autosuspend by the full autosuspend =
delay.
> > +      * Since an autosuspend timer may be running and the new last_bus=
y value
> > +      * needs to be seen by it, update last_busy before returning an e=
rror or
> > +      * dropping the spinlock and allowing the timer function to grab =
it.
> > +      */
> > +     pm_runtime_mark_last_busy(dev);
> > +
> >       if (retval)
> >               goto out;
> >
> > @@ -563,7 +571,6 @@ static int rpm_idle(struct device *dev, int rpmflag=
s)
> >       if (retval)
> >               return retval;
> >
> > -     pm_runtime_mark_last_busy(dev);
> >       return rpm_suspend(dev, rpmflags | RPM_AUTO);
> >  }
> >
> > @@ -1132,6 +1139,13 @@ int __pm_runtime_idle(struct device *dev, int rp=
mflags)
> >       int retval;
> >
> >       if (rpmflags & RPM_GET_PUT) {
> > +             /*
> > +              * Once the usage counter drops to 0, a leftover autosusp=
end
> > +              * timer may fire before the spinlock below is acquired. =
 Update
> > +              * last_busy first so it does not find the expiration tim=
e in
> > +              * the past and suspend the device immediately.
> > +              */
> > +             pm_runtime_mark_last_busy(dev);
> >               retval =3D rpm_drop_usage_count(dev);
>
> This is somewhat of a pre-existing issue (e.g., in
> pm_runtime_put_autosuspend()), but weakly ordered architectures don't
> really enforce the dependencies you want.
>
> rpm_drop_usage_count() uses an atomic decrement, which has a full
> barrier.

Right, that's why the last_busy update is carried out before
rpm_drop_usage_count().

> But this is supposed to influence the rpm_suspend() behavior of
> rpm_check_suspend_allowed() (atomic_read) + READ_ONCE(last_busy), which
> includes only a conditional dependency and no barrier.
>
> https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0124r6.html
>
>   "Control dependencies can order prior loads against later dependent
>   stores, however, they do not order prior loads against later dependent
>   loads. (Use memory_order_consume or memory_order_acquire if you
>   require this behavior.)"
>
> So, rpm_check_suspend_allowed() should probably use
> atomic_read_acquire(&dev->power.usage_count).
>
> (This is probably an extremely narrow, practically impossible issue.)

Yes, this sounds nearly impossible in practice, given the number of
branches between the usage counter read in rpm_check_suspend_allowed()
and the last_busy check in pm_runtime_autosuspend_expiration().
