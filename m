Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5D547A0C7
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064788; cv=none; b=M7AdJ5RKxwoiP1bpFeY3h+w+KJjrcKqG50hXdI8v5CMqILpRdAJIDP6W+nmeGKFMVsXfWsb1B10Cw5hYqASGwMLOmWOt8Z36CvxW082aUlGLvgHeLzb5/ig6z8X7rnb1aGjUJnjUmXjLxN54X/Y+IWIv7EARbGER770CRpdTeYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064788; c=relaxed/simple;
	bh=sEkgNEoNFrwBslL4sVxb0uVvIjOiGbn5x3ZhU2UpNyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oipAzhQTIuqCAgoeaQauXeBE1xS4YVK2QzpUTMykTu3dRGzzjMvvcBlAOleSmYaNKGxJjXnPYlf7iss72q0jgW3QcRKgUacNd8qCB0cAY5PJE+oGVSR7ls2MDkr9p9lIbPhxyWA49sxhZ2L+rhDKp7jChXGTYQq1WId3JifDuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR5+hFgR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR5+hFgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4001AC2BCB3
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 17:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775064788;
	bh=sEkgNEoNFrwBslL4sVxb0uVvIjOiGbn5x3ZhU2UpNyk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IR5+hFgR/Bgu6mAZ+dbgdnXzKtA0jhoG45fRxB9dsOQtWxXHRHgupPBYYcgiqGCfM
	 CSq663dDJ4CYpj3koGn1Ex4pYtF970QEUKRLMNhN0ZiG8WW6XJfjzr+gXT3c1U3D2k
	 Ax5IVniDiSXdP1SDYTWkvamxTSIPaWW+yHCaNoSecp5Q/8blG2z1vGCMN6eFu1FLZb
	 NdEqvetWdbfLH7tfmAAGeh6zyggk/NZIcx9PgX4HrDaeErN297+yCeomQqgCv1Y+9y
	 Q5zGQyIICnmS02TOhusEQXHU1tssWBJKVcE0+B+cd8HyWd1Weic/nrt2lOnuhJc4g/
	 wqq+hN3KPjiig==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-41c4d660b19so7573fac.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 10:33:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWjbKDCQDMpna+4WYsonvHnQywpzCo6fNRR1Xftg+FFqqOP52MZmYrZZsJMei3+q2LWJPYjLj8PQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHeP8bYduzvpnvfzUiBpC8sNGg8ghlwbBiMgCJdQOe8Wopi4gH
	XE+o4ZTGAA4glXS4M31gkWL2lMi749yfMtqzll3aea6xaF2bRtJmrLeE5nm2zHcPOZxN8RBNL0+
	vpEqw2FKDFT2c8zWqVtapP+aza8g9jMU=
X-Received: by 2002:a05:6870:e9a9:b0:408:9c83:5b1a with SMTP id
 586e51a60fabf-422ec4b18d6mr320595fac.4.1775064787326; Wed, 01 Apr 2026
 10:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0fe1b679-ab28-4505-b0db-14e7ac3ba749@gmail.com>
 <CAJZ5v0iMfiqjkkvOMU6jWEZ+nBvcRtWNwjvBW0pEva1G_owFcg@mail.gmail.com> <744440a6-e1cb-4792-a848-57755de0686b@gmail.com>
In-Reply-To: <744440a6-e1cb-4792-a848-57755de0686b@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 1 Apr 2026 19:32:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i5dSuQ7f8Okb-Ch5igzNn=L_Fj5d3H4pftvxoEVBaDUw@mail.gmail.com>
X-Gm-Features: AQROBzDhTBIFu7dvBt4y-4eQwrO9u7phnBAcNBILEjL4e8VqcC1EcoI93TH9aRk
Message-ID: <CAJZ5v0i5dSuQ7f8Okb-Ch5igzNn=L_Fj5d3H4pftvxoEVBaDUw@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: Allocate class wakeup_class statically
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 5:45=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.co=
m> wrote:
>
> On 01.04.2026 16:19, Rafael J. Wysocki wrote:
> > On Sun, Mar 29, 2026 at 6:14=E2=80=AFPM Heiner Kallweit <hkallweit1@gma=
il.com> wrote:
> >>
> >> Allocating wakeup_class statically avoids a little runtime overhead.
> >> Define groups and device release function as part of the class, so tha=
t
> >> we don't have to repeat this for each class device.
> >> Whilst at it, constify wakeup_source_attrs[].
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >
> > Can you please have a look at this and let me know what you think:
> >
> > https://sashiko.dev/#/patchset/0fe1b679-ab28-4505-b0db-14e7ac3ba749%40g=
mail.com
> >
> Interesting finding! I think the diagnosis is right.
>
> But: I would say the current behavior isn't a nice solution as well:

It is not fantastic, but it doesn't have this issue.

> wakeup_source_device_create() does: dev->class =3D wakeup_class;
> I think no reader will expect that wakeup_class may be NULL here due to
> initcall ordering. In addition this behavior results in such early
> wakeup sources not being shown in sysfs.

They are registered too early to show up in sysfs, but they can work regard=
less.

I think that it's just pointless to call device_register() for a given
wakeup source if wakeup_class has not been registered yet.

> But I'm not sure whether registering class "wakeup" (and registering
> classes in general) would be possible early enough (core_initcall,
> or even pure_initcall).

driver_init() is called before do_initcalls() is do_basic_setup(), so
class registration should work for all initcall levels AFAICS.

> >> ---
> >>  drivers/base/power/wakeup_stats.c | 18 +++++++++---------
> >>  1 file changed, 9 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wa=
keup_stats.c
> >> index 308f8bde9..72beb8fce 100644
> >> --- a/drivers/base/power/wakeup_stats.c
> >> +++ b/drivers/base/power/wakeup_stats.c
> >> @@ -18,8 +18,6 @@
> >>
> >>  #include "power.h"
> >>
> >> -static struct class *wakeup_class;
> >> -
> >>  #define wakeup_attr(_name)                                           =
  \
> >>  static ssize_t _name##_show(struct device *dev,                      =
          \
> >>                             struct device_attribute *attr, char *buf) =
  \
> >> @@ -114,7 +112,7 @@ static ssize_t prevent_suspend_time_ms_show(struct=
 device *dev,
> >>  }
> >>  static DEVICE_ATTR_RO(prevent_suspend_time_ms);
> >>
> >> -static struct attribute *wakeup_source_attrs[] =3D {
> >> +static const struct attribute *const wakeup_source_attrs[] =3D {
> >>         &dev_attr_name.attr,
> >>         &dev_attr_active_count.attr,
> >>         &dev_attr_event_count.attr,
> >> @@ -135,6 +133,12 @@ static void device_create_release(struct device *=
dev)
> >>         kfree(dev);
> >>  }
> >>
> >> +static const struct class wakeup_class =3D {
> >> +       .name =3D "wakeup",
> >> +       .dev_release =3D device_create_release,
> >> +       .dev_groups =3D wakeup_source_groups,
> >> +};
> >> +
> >>  static struct device *wakeup_source_device_create(struct device *pare=
nt,
> >>                                                   struct wakeup_source=
 *ws)
> >>  {
> >> @@ -149,10 +153,8 @@ static struct device *wakeup_source_device_create=
(struct device *parent,
> >>
> >>         device_initialize(dev);
> >>         dev->devt =3D MKDEV(0, 0);
> >> -       dev->class =3D wakeup_class;
> >> +       dev->class =3D &wakeup_class;
> >>         dev->parent =3D parent;
> >> -       dev->groups =3D wakeup_source_groups;
> >> -       dev->release =3D device_create_release;
> >>         dev_set_drvdata(dev, ws);
> >>         device_set_pm_not_required(dev);
> >>
> >> @@ -212,8 +214,6 @@ void wakeup_source_sysfs_remove(struct wakeup_sour=
ce *ws)
> >>
> >>  static int __init wakeup_sources_sysfs_init(void)
> >>  {
> >> -       wakeup_class =3D class_create("wakeup");
> >> -
> >> -       return PTR_ERR_OR_ZERO(wakeup_class);
> >> +       return class_register(&wakeup_class);
> >>  }
> >>  postcore_initcall(wakeup_sources_sysfs_init);
> >> --
> >> 2.53.0
> >>
>
