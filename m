Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157353FC5B9
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787587817; cv=none; b=JS49zRbpOqaWTeFYRCc7aVCuuJDwqBvWviuBRMvEnAS3cTAcj49+Zk2eObsHgtiYvlbPJf7emE/xACjZeX8Veqa0rn61nXrAKSWYvzIT+K6hji/0wubPXvwSnACMMUk6qZjTLFDncc4HnAY6jY2ffTcs0qEjYF8mOY0T+YzPAy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787587817; c=relaxed/simple;
	bh=WYp79WvhieUNZCmKVcztP08DuWzU2r2nD9piZtP2e4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeNwngVHPPmN9YPxsDEtbVmfQxZn7a+PXwERXuaOY9U954CQy5MJeSUGaeRsEfm2V2NDobINnCjsTBWElpv1NN4JgB/THx7wPXNFfpE7ZHq8NDAPaV44IsNe7JEbpjltfGIrSRH2FsRik/DdlEww3fDHMi4CoIJmTcnFUTQRr2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYH5cA2K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYH5cA2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD361F000E9
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787587816;
	bh=9lfE4kJBZz3AqUd+UVhYQB7YyX6PkGx6pUwKpB5sKG0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OYH5cA2KUwZwkSI+n9o41oNxtoiRF41uqnHCXK4h91qks1o6VL5i4zRSXoczX1BBm
	 RXd0Fu186mGnoU0yjo+R/CChP0PWvn4ZV40wI6g4CSuDM9zIjHTKQnN3eJIPMOGLA5
	 ivD3JES8/IKNdEVgh+v21SJL3PcorNGv6loS5cCOvCPUO7WQN4LWja4pcHqdCqBLvB
	 7fLgD6g1GzYlPgY31RBLGg457nfJ6sDaZX0rucZGuXpp47+OgPnDxEmaa/naGgMECl
	 zCEUjiwk+6kbAN+vfVm3TYaqsKE8zRM2w5Vm1Y8cXMxbE/MivibTh7lwlmSRx9aCvS
	 Cg8cI8qhOiuJQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39dbe684115so320281fa.1
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 09:10:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoluYORR/gWmYRsCFuZOn2FDv2OLV7ISDvDoYm9BReWa9TTixt1/xa3UbnI5WrUxCKJwzG1AsHZkQ==@vger.kernel.org
X-Gm-Message-State: AFuF++knIWnud/C9pdBjqd4xIt6psbrXZf6GcXSeDrtP7r8HlngQ8dwB
	Yf5lmUSmLEoE4LDaM1bx34qFVOE//CPkARUIZZ9PivtZfNitqAQ/K4qfQeqsz2ibHIVXrylEFM9
	djK9y5uL3ReLegBhMbR+Spu/bdNuR6Yg=
X-Received: by 2002:a2e:bc82:0:b0:396:ade7:4153 with SMTP id
 38308e7fff4ca-3a1ed6f4061mr640871fa.0.1787587814368; Mon, 24 Aug 2026
 09:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811061530.21789-1-jkoolstra@xs4all.nl>
In-Reply-To: <20260811061530.21789-1-jkoolstra@xs4all.nl>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 24 Aug 2026 18:09:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i0PQEMTOT6UqWO87jCdV539ns-KcP69n++eQsz_NG0zA@mail.gmail.com>
X-Gm-Features: AcwNN1Vw_f3gJ9-ik0-5o_-rxbVsDApCxrOUXBD3-HgJUcrld_w14x51Y6yKZxY
Message-ID: <CAJZ5v0i0PQEMTOT6UqWO87jCdV539ns-KcP69n++eQsz_NG0zA@mail.gmail.com>
Subject: Re: [PATCH] thermal: change thermal_class to a const struct
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 8:17=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> The class_create() call has been deprecated in favor of class_register()
> as the driver core now allows for a struct class to be in read-only
> memory. Change thermal_class to be a const struct class and drop the
> class_create() call.

This has been deliberately changed the other way around not too long
ago, in commit

34f54003643e thermal/core: Allocate the thermal class dynamically

and it was then argued that it would be better to allocate the class
dynamically.

You seem to have a differing opinion.

Is there any plan to remove class_create() from the kernel?  If there
isn't, I'd rather stop this back-and-forth dance and leave the code
as-is.

> Compile tested only.

That is, not tested.

> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  drivers/thermal/thermal_core.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_cor=
e.c
> index 28a20d4b475c..36220113ca8e 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -889,7 +889,9 @@ static void thermal_unbind_cdev_from_trip(struct ther=
mal_zone_device *tz,
>         kfree(pos);
>  }
>
> -static struct class *thermal_class __ro_after_init;
> +static const struct class thermal_class =3D {
> +       .name   =3D "thermal"
> +};
>
>  static inline
>  void print_bind_err_msg(struct thermal_zone_device *tz,
> @@ -973,7 +975,7 @@ thermal_cooling_device_alloc(const char *type, const =
struct thermal_cooling_devi
>             !ops->set_cur_state)
>                 return ERR_PTR(-EINVAL);
>
> -       if (!thermal_class)
> +       if (!class_is_registered(&thermal_class))

Any chance to reduce the overhead of this check (in all places where
it is done)?

>                 return ERR_PTR(-ENODEV);
>
>         cdev =3D kzalloc_obj(*cdev);
> @@ -1010,7 +1012,7 @@ int thermal_cooling_device_add(struct thermal_cooli=
ng_device *cdev, void *devdat
>         mutex_init(&cdev->lock);
>         INIT_LIST_HEAD(&cdev->thermal_instances);
>         cdev->updated =3D false;
> -       cdev->device.class =3D thermal_class;
> +       cdev->device.class =3D &thermal_class;
>         cdev->device.release =3D thermal_cdev_release;
>         device_initialize(&cdev->device);
>         cdev->devdata =3D devdata;
> @@ -1447,7 +1449,7 @@ thermal_zone_device_register_with_trips(const char =
*type,
>         if (polling_delay && passive_delay > polling_delay)
>                 return ERR_PTR(-EINVAL);
>
> -       if (!thermal_class)
> +       if (!class_is_registered(&thermal_class))
>                 return ERR_PTR(-ENODEV);
>
>         tz =3D kzalloc_flex(*tz, trips, num_trips);
> @@ -1483,7 +1485,7 @@ thermal_zone_device_register_with_trips(const char =
*type,
>         if (!tz->ops.critical)
>                 tz->ops.critical =3D thermal_zone_device_critical;
>
> -       tz->device.class =3D thermal_class;
> +       tz->device.class =3D &thermal_class;
>         tz->device.release =3D thermal_zone_device_release;
>         tz->devdata =3D devdata;
>         tz->num_trips =3D num_trips;
> @@ -1745,7 +1747,7 @@ static void __thermal_pm_prepare(void)
>
>  void thermal_pm_prepare(void)
>  {
> -       if (!thermal_class)
> +       if (!class_is_registered(&thermal_class))
>                 return;
>
>         __thermal_pm_prepare();
> @@ -1776,7 +1778,7 @@ void thermal_pm_complete(void)
>  {
>         struct thermal_zone_device *tz;
>
> -       if (!thermal_class)
> +       if (!class_is_registered(&thermal_class))
>                 return;
>
>         guard(mutex)(&thermal_list_lock);
> @@ -1789,7 +1791,6 @@ void thermal_pm_complete(void)
>
>  static int __init thermal_init(void)
>  {
> -       struct class *tc;
>         int result;
>
>         thermal_debug_init();
> @@ -1808,13 +1809,10 @@ static int __init thermal_init(void)
>         if (result)
>                 goto unregister_governors;
>
> -       tc =3D class_create("thermal");
> -       if (IS_ERR(tc)) {
> -               result =3D PTR_ERR(tc);
> +       result =3D class_register(&thermal_class);
> +       if (result)
>                 goto unregister_governors;
> -       }
>
> -       thermal_class =3D tc;
>         return 0;
>
>  unregister_governors:
> --
