Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4906441D201
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814146; cv=none; b=cwansSclygxgArC/BEwQNPNELuFLqgYtfSCtbRwu3ChPMrrOFC1Z2HkIs5O42J53ah53yv9nB9RUn9WcoJYJ8DMMIIeWOlUAfIeAfdfhh41y3LVP9sjTs1y7AKRMUTaH5Mi9lA2FAwlIaX1UsOroPKXMoqIeEfVibWIhtkX/jT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814146; c=relaxed/simple;
	bh=E0JCz5YGlaU/MEUjn/RT+NGKoCIPiPfw/qcpQir7G2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngMOi5dFXkJSzkGhz9FpTpe9vOC87rJTtLFW4FsPP3wqUBd47BpRmJzC6R6oFud1mxslCn9Wl5iKRLOXV2AGwlqxL1dNEoH+sPGb+xZ4qi69u5YaHtm7l90mnP5RDthxdPLraCEVJjnB6sG6i1vJWFAfFreNoWaTD3dCgPVK1ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D231F000E9
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:42:24 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b15dcaca31so716028e87.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 06:42:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqrhsaeft7CcSHaV64jpvnnUexr6Y4NRLKNwHv0rXlt1QIwwm8O3LlP7Rzq7L6ylgg5zGIKXBebKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG76hmf1TysqodeG+RwOTv2GYu16lORnzgihgqhoL7h1/8fAn0
	EnnLRzrmziUwBPlSA+v9UogWdPJ33S0m0Nt/gduT8QJt+2z5SxL1/DQwbOqSbz+jneh75z0zCCN
	KPidlqtD+Y4/IJ49AmF9LGjL5hzXL5U8=
X-Received: by 2002:a05:6512:3e23:b0:5ae:c34c:aefe with SMTP id
 2adb3069b0e04-5b2b2f7eed7mr701769e87.62.1784814142672; Thu, 23 Jul 2026
 06:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719132251.31936-3-thorsten.blum@linux.dev>
In-Reply-To: <20260719132251.31936-3-thorsten.blum@linux.dev>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 23 Jul 2026 15:42:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i5eXx8_T5ysmgmqv+1K5z3RqgGRuhN1+HQoprbrKgOkA@mail.gmail.com>
X-Gm-Features: AUfX_mw3VjQKS2UYbnnWtBvBRsFKjuJ4VXcpP7KnPP85HQF5E20pVNX6Np2EDgQ
Message-ID: <CAJZ5v0i5eXx8_T5ysmgmqv+1K5z3RqgGRuhN1+HQoprbrKgOkA@mail.gmail.com>
Subject: Re: [PATCH] thermal: sysfs: Use sysfs_emit_at() in trans_table_show()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 3:23=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Replace snprintf() with sysfs_emit_at() in trans_table_show().
> sysfs_emit_at() is preferred for formatting sysfs output because it
> provides safer bounds checking.
>
> Convert multiple PAGE_SIZE length checks to check the number of bytes
> actually copied by sysfs_emit_at(), thus avoiding manual buffer size
> accounting.
>
> Consistently return -EFBIG when the transition table output exceeds the
> sysfs buffer, including the header row.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/thermal/thermal_sysfs.c | 49 ++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sy=
sfs.c
> index b44abfc997ed..adbcb2c011e8 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -706,7 +706,7 @@ static ssize_t trans_table_show(struct device *dev,
>         struct thermal_cooling_device *cdev =3D to_cooling_device(dev);
>         struct cooling_dev_stats *stats;
>         ssize_t len =3D 0;
> -       int i, j;
> +       int i, j, copied;
>
>         guard(cooling_dev)(cdev);
>
> @@ -714,41 +714,40 @@ static ssize_t trans_table_show(struct device *dev,
>         if (!stats)
>                 return -ENODATA;
>
> -       len +=3D snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n")=
;
> -       len +=3D snprintf(buf + len, PAGE_SIZE - len, "       : ");
> +       len +=3D sysfs_emit_at(buf, len, " From  :    To\n");
> +       len +=3D sysfs_emit_at(buf, len, "       : ");
>         for (i =3D 0; i <=3D cdev->max_state; i++) {
> -               if (len >=3D PAGE_SIZE)
> -                       break;
> -               len +=3D snprintf(buf + len, PAGE_SIZE - len, "state%2u  =
", i);
> +               copied =3D sysfs_emit_at(buf, len, "state%2u  ", i);
> +               if (!copied)
> +                       goto buf_full;
> +               len +=3D copied;
>         }
> -       if (len >=3D PAGE_SIZE)
> -               return PAGE_SIZE;
> -
> -       len +=3D snprintf(buf + len, PAGE_SIZE - len, "\n");
> +       len +=3D sysfs_emit_at(buf, len, "\n");
>
>         for (i =3D 0; i <=3D cdev->max_state; i++) {
> -               if (len >=3D PAGE_SIZE)
> -                       break;
> -
> -               len +=3D snprintf(buf + len, PAGE_SIZE - len, "state%2u:"=
, i);
> +               copied =3D sysfs_emit_at(buf, len, "state%2u:", i);
> +               if (!copied)
> +                       goto buf_full;
> +               len +=3D copied;
>
>                 for (j =3D 0; j <=3D cdev->max_state; j++) {
> -                       if (len >=3D PAGE_SIZE)
> -                               break;
> -                       len +=3D snprintf(buf + len, PAGE_SIZE - len, "%8=
u ",
> +                       copied =3D sysfs_emit_at(buf, len, "%8u ",
>                                 stats->trans_table[i * (cdev->max_state +=
 1) + j]);
> +                       if (!copied)
> +                               goto buf_full;
> +                       len +=3D copied;
>                 }
> -               if (len >=3D PAGE_SIZE)
> -                       break;
> -               len +=3D snprintf(buf + len, PAGE_SIZE - len, "\n");
> -       }
> -
> -       if (len >=3D PAGE_SIZE) {
> -               pr_warn_once("Thermal transition table exceeds PAGE_SIZE.=
 Disabling\n");
> -               len =3D -EFBIG;
> +               copied =3D sysfs_emit_at(buf, len, "\n");
> +               if (!copied)
> +                       goto buf_full;
> +               len +=3D copied;
>         }
>
>         return len;
> +
> +buf_full:
> +       pr_warn_once("Thermal transition table exceeds PAGE_SIZE. Disabli=
ng\n");
> +       return -EFBIG;
>  }
>
>  static DEVICE_ATTR_RO(total_trans);

Applied as 7.3 material, thanks!
