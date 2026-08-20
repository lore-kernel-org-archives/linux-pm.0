Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1853D566B
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260979; cv=none; b=BgjvFe3k/+uLjl9iLwdRubdKU0AktbbBZKMNFVzfAN/Q+ictkXZ6/x3gLSnF1xatZZ78fzmkKwRFHyFMU6SUp0hWtwTxbpadWuqZnFeUfW12U9fADh08yj47m37BUP7LooPIpO8bVVv5KLj1ocjUcTdBirIucymkTSuiS2lC0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260979; c=relaxed/simple;
	bh=HJQbxsoH0cwuqnv8/ixox7FiIthbzATvp6/cnyjjGYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUN8xns1aI7lkmRlkZtlhgkDY2Mm4EqXcMrZWoPNvAfeyIveTYfoOkfSwXFhhJAN6U5cFROaoi2iFp2O0OxytRdvqR3/0Nw5nIO7O+9wv3aBJULwEQ1PVkjWdbmWSbkOSqB9HEQwAcLFVsAy4KHpSjbvv72rCtwdyMshP13CA2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G33WI/ET; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G33WI/ET"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC571F00ADB
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 21:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787260978;
	bh=VJLcJmZ7PKLdiogUheBUseQCClad5bh7dSYg6Zcb9lA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=G33WI/ETVtK3djnOudzyTnd3jxLil4nNaQGs9fpWawPfDtgLh+rqL9iGXnUV+hZLD
	 57JTJ558flF+OgpgNq5YNGbov39lYivMN/+JKYzrQQqVw3i+uQ1VXUPvX23zAHvRh4
	 d41BWPC+w/vl06iOPkG6P3PMP1Dkbu1MZVRPyyJyi/gUFH7gLRGv2mJEjSFKCxva4K
	 UcBlG2VmgIKgWLaxiw8wjp9prfI2MSuVk2356v3GFWXTowOyjpozXdZxjv7eN7uH9R
	 G04pIrMQ7vIVeJWznsrlPZw6nb7ux9lNSHnLcS1CVmzFFrGAQx0hTh94FJZN+MDU4t
	 MV2zHETalGCFw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39ca300db70so4428051fa.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 14:22:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpo1/C8IRIXCg8uwahkoHaHbMNufPLNicf9MmUqT7LO67ZaWcjFMINLezQRMsZpBV2DakzukbfgZw==@vger.kernel.org
X-Gm-Message-State: AFuF++kvHfGb3NYS5ZTFRzBEmyJ7w+ZiW1FHzc5Ll+GRF7oLpNqKjZw/
	3erqAuurZQE3mWQN2pwTymML32pddvVyhI9LwhdWsg6eiAxLYLZ4tUqmVZUdP7tkpAaM2dorbbI
	cN2N3tK7tK8UKCJVtprKxXbBT2ewJfMA=
X-Received: by 2002:a05:6512:3c98:b0:5b1:5fb6:5cf6 with SMTP id
 2adb3069b0e04-5b48421a6c2mr388620e87.17.1787260976694; Thu, 20 Aug 2026
 14:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812042842.15209-1-phucduc.bui@gmail.com> <20260812042842.15209-2-phucduc.bui@gmail.com>
In-Reply-To: <20260812042842.15209-2-phucduc.bui@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 20 Aug 2026 23:22:20 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iBTiz=q5Gyrw3tbyq8nQmCkcdP3Y4NA4i_2Qa1Qn2dPQ@mail.gmail.com>
X-Gm-Features: AcwNN1UDN7rZHwlTLDGYe7_rY75ivBxiKIpjATkCxD6Ta0HOwsVH8As-3Siqjrc
Message-ID: <CAJZ5v0iBTiz=q5Gyrw3tbyq8nQmCkcdP3Y4NA4i_2Qa1Qn2dPQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] thermal: hwmon: Remove redundant OOM message
To: phucduc.bui@gmail.com
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, rafael@kernel.org, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 6:29=E2=80=AFAM <phucduc.bui@gmail.com> wrote:
>
> From: bui duc phuc <phucduc.bui@gmail.com>
>
> Remove the dev_warn() after a failed devres_alloc(). This is
> consistent with checkpatch's OOM_MESSAGE convention: no error
> message is needed after a kzalloc()-style allocation failure.
>
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

and I'm assuming that this will be routed along with the rest of the series=
.

Thanks!

> ---
>  drivers/thermal/thermal_hwmon.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hw=
mon.c
> index ec73d03a1e60..747ac87d1c37 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -269,10 +269,8 @@ int devm_thermal_add_hwmon_sysfs(struct device *dev,=
 struct thermal_zone_device
>
>         ptr =3D devres_alloc(devm_thermal_hwmon_release, sizeof(*ptr),
>                            GFP_KERNEL);
> -       if (!ptr) {
> -               dev_warn(dev, "Failed to allocate device resource data\n"=
);
> +       if (!ptr)
>                 return -ENOMEM;
> -       }
>
>         ret =3D thermal_add_hwmon_sysfs(tz);
>         if (ret) {
> --
> 2.43.0
>
