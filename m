Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF33CF02D
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053166; cv=none; b=r+J9QfomOdMXP2Rjir3nWHH9zgV26HMuyXGUcBx7tFJg/qfDbTFtiWiImsL5SJjnNsD5FzssPcYlctnJfMtApzXTXCRf0P+RXI0UJqs2PqJqWS9I4sWBTLLGx0yt26R0JH8v31yl+icho1JOB5OQ/VP5Q0slyDKqddO9c6luE80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053166; c=relaxed/simple;
	bh=5Xvf1DZxQyzz23nQMLhsEeXLBp5uZqrIvZY8Z6bRByI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMTO9552WA/HUh4GsYsKAUmyPEoKQ8JbIn7lqdRJc4EFr+tbQTDUm7eaKtQyEUHoy10rQsi5tmVJ291vP+Aw102BYKuA2LhW5v/ZjGrfOHZN/cAPzMuHqKdgDmMklAFVOkkmcofP8UR1xNpL5CBV0gvrePjNNMRpQtXjmKntQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8FxG+tm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8FxG+tm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08DFC19421
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 14:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775053165;
	bh=5Xvf1DZxQyzz23nQMLhsEeXLBp5uZqrIvZY8Z6bRByI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M8FxG+tml1wclak8ctY18k1fT5Y0l/jnkQQHRHFSIe+4wVlHynlFyhuxiOjH7RHzR
	 AWS532iwctPW3lDfGGe4Zp0N/MD+v9ta4MEKLOtZwMIHILyE/7dv37g/claQM7CHmC
	 f131Mk86Q/8cCeNmzfAcs4ZOMZAPIMej9Ws6jpGTTnPirMhONCY6uw1ZCtYyp7hMNw
	 FvDgvE5uJ52DlqMBJwHnl2tdVSVIl1mTTQb4TKc6Ddof7P6fEiGJ181AijT13M2bYG
	 hQxa13jD9eyzSEvUC2fEj28x8wU0EUHn9twCyRdOVREke4p9YmZHTFMHk2XBABuLEc
	 rzd7IXu2vV8WA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40efc77933fso4414586fac.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 07:19:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBaK74gssEHJ+S5YOf1cT0SPrZMiIR2AsMCeWw0bMrswBEybrUHaOOa5nni0l0p6GFxDp2l7FVpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyT1E6eNRNROGj2mn/M7/0Z16Nz439YdwG1KGCSuT9yscyZrek0
	L0qMVzLdkDA8jNpWIqVu25SAwR6Rm3yk5rcZ9gYWA2ZnxY6hVl/PTUBgTTPPxV+ZsEDZ0pSVZko
	kBAoFY3cWxo8Tfc8Rnr3JT6ej7xBr9HQ=
X-Received: by 2002:a05:6870:7d1b:b0:3ec:4f31:42a with SMTP id
 586e51a60fabf-422cfc2c35fmr2510228fac.7.1775053165049; Wed, 01 Apr 2026
 07:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0fe1b679-ab28-4505-b0db-14e7ac3ba749@gmail.com>
In-Reply-To: <0fe1b679-ab28-4505-b0db-14e7ac3ba749@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 1 Apr 2026 16:19:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iMfiqjkkvOMU6jWEZ+nBvcRtWNwjvBW0pEva1G_owFcg@mail.gmail.com>
X-Gm-Features: AQROBzB5Bp9YhswkJwozBpdEd0Qzj8LYEr3UbNJO1YuTrXyZZSTTzTnDFCZErik
Message-ID: <CAJZ5v0iMfiqjkkvOMU6jWEZ+nBvcRtWNwjvBW0pEva1G_owFcg@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: Allocate class wakeup_class statically
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 6:14=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.c=
om> wrote:
>
> Allocating wakeup_class statically avoids a little runtime overhead.
> Define groups and device release function as part of the class, so that
> we don't have to repeat this for each class device.
> Whilst at it, constify wakeup_source_attrs[].
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Can you please have a look at this and let me know what you think:

https://sashiko.dev/#/patchset/0fe1b679-ab28-4505-b0db-14e7ac3ba749%40gmail=
.com

> ---
>  drivers/base/power/wakeup_stats.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeu=
p_stats.c
> index 308f8bde9..72beb8fce 100644
> --- a/drivers/base/power/wakeup_stats.c
> +++ b/drivers/base/power/wakeup_stats.c
> @@ -18,8 +18,6 @@
>
>  #include "power.h"
>
> -static struct class *wakeup_class;
> -
>  #define wakeup_attr(_name)                                             \
>  static ssize_t _name##_show(struct device *dev,                         =
       \
>                             struct device_attribute *attr, char *buf)   \
> @@ -114,7 +112,7 @@ static ssize_t prevent_suspend_time_ms_show(struct de=
vice *dev,
>  }
>  static DEVICE_ATTR_RO(prevent_suspend_time_ms);
>
> -static struct attribute *wakeup_source_attrs[] =3D {
> +static const struct attribute *const wakeup_source_attrs[] =3D {
>         &dev_attr_name.attr,
>         &dev_attr_active_count.attr,
>         &dev_attr_event_count.attr,
> @@ -135,6 +133,12 @@ static void device_create_release(struct device *dev=
)
>         kfree(dev);
>  }
>
> +static const struct class wakeup_class =3D {
> +       .name =3D "wakeup",
> +       .dev_release =3D device_create_release,
> +       .dev_groups =3D wakeup_source_groups,
> +};
> +
>  static struct device *wakeup_source_device_create(struct device *parent,
>                                                   struct wakeup_source *w=
s)
>  {
> @@ -149,10 +153,8 @@ static struct device *wakeup_source_device_create(st=
ruct device *parent,
>
>         device_initialize(dev);
>         dev->devt =3D MKDEV(0, 0);
> -       dev->class =3D wakeup_class;
> +       dev->class =3D &wakeup_class;
>         dev->parent =3D parent;
> -       dev->groups =3D wakeup_source_groups;
> -       dev->release =3D device_create_release;
>         dev_set_drvdata(dev, ws);
>         device_set_pm_not_required(dev);
>
> @@ -212,8 +214,6 @@ void wakeup_source_sysfs_remove(struct wakeup_source =
*ws)
>
>  static int __init wakeup_sources_sysfs_init(void)
>  {
> -       wakeup_class =3D class_create("wakeup");
> -
> -       return PTR_ERR_OR_ZERO(wakeup_class);
> +       return class_register(&wakeup_class);
>  }
>  postcore_initcall(wakeup_sources_sysfs_init);
> --
> 2.53.0
>
