Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590626;
	b=jEftIgUQKIigTI/rluHlAB5zoGB4y4SSiEzmietu6/UZegXcyIymHDmVStpSB/DRcnE/
	 GareWuP1dh4G3G/7V3ZCEDQW8i8s3P/prlSHmY6PUoL2vfQyJA2rFztU64VU9VfzGHAs8
	 l6uOSnPdHbakMgNVd1DmY9sAr3+daTsRBOUZvnDhOX4OVhoMEU7+9aTLSIPlFwg+Qg4eo
	 fWtEgObHsfafjfpAtC2uFOCLmUyC93Dm4VbKwI2efPekQUwD0i2vGYBmA7qGGmI/i73/d
	 wdNuBpFCpSSQAhq0CmBv/6PaXbo9vH7yMsoCIiVGYke9Lrm5kWfRXmPLu8FSR0iQsOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590626;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=I2bvdWY0t31KXpwJf/u0Qjl1LLzrtu3wyozMDwdTeBg=;
	b=qAQO7sZNDWDnweKlwrkPA1XIVbN64n2EltuURGirjsXZcCaF4zNvLyOihkRlCOIMSGt/
	 8w2t5xP88bFYUEplzE6ygx7eut1sum1nOrNv1350XynlbJ26TavrcCvD+FsWG6nh+2HgR
	 irUYSiaeY4GVpp6VKesV/S6Cfj0qAn+L6C68QOz7dZIH4fi/191TTXTN2DXD/dY/5zMqI
	 sWhGLn5DNVmx03Lgcjd4RxppslUToqfGwePBzI2QCRA+IgzAai1P4ml2ZG4wIoldV8lBR
	 mSr+BW3m96gdPYz4ZQ3OyaAU8wlg75u+YtbJNpkTsPC9DPb/dbAl44ORPxQN1KQYjxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X19jAfgv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72A5606A32D
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X19jAfgv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868871F000C8
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792590625;
	bh=I2bvdWY0t31KXpwJf/u0Qjl1LLzrtu3wyozMDwdTeBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=X19jAfgvAld7gT/j9w83YYYU3N6XYsJW48KDz8G6dL72nfLBbMVaQb9nX9cY2pDcp
	 6IAUm7jhxeP3F2nCmrf7F98bJLIEOsCtFHPjvgXYVViAzXvdl/NMIV/n6HbqRN6hQK
	 5p+D9vBMtiR0AxGW8NRQHaIAIdw8CAYBWbZ3qyVhujKrHuSRTZ9AySgC9ZWic91bOV
	 zoi+jn9gvc5kq++bm32WOSQCgaapKtTPOuozvu0ftqOUCjM2ST8nPeoRQh2wssqNjS
	 zbeoC0tfnKMejAqW4gHyl/wE7HoXGwdb+ZOW/ycgDDVwvNevHe0jaJqkIn4iJ31947
	 rDDWJ0sXGBW3Q==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5be416e603cso485912e87.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 06:50:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByHJctKX+C3fhcVDxEnqFd/3vNtnfbNoehE88q4siF1ojbDwNHel0WZUJtwum25IAGqsXn1tVOI0A==@vger.kernel.org
X-Gm-Message-State: AFq9FYK7BGqMzwrrAer0QxnezHnrC1tNJZYzrCWvWg6BdqcmlB4uUeve
	jd/zFb+ObFmw9BtofOhU9QSg/vO5rmAcem7lrevLXvooOGcIJVQNyVhcITOgE4cODnt58jMvLXY
	L43+ulF1efOzgP9/dudzw28d6IWLIsiE=
X-Received: by 2002:a05:6512:b8c:b0:5be:4f5b:4078 with SMTP id
 2adb3069b0e04-5bfa1c11845mr962396e87.61.1792590623962; Wed, 21 Oct 2026
 06:50:23 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021134243.35103-1-daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20261021134243.35103-1-daniel.lezcano@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 21 Oct 2026 15:48:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g5a+0eaULxGG=RFm=JN8Gh3_A=7mGUTmFUiXsxVKvpDQ@mail.gmail.com>
X-Gm-Features: AclHuK_jJY-EtqEPHznjMyJCffRjO5WHMEjz4PwIVEEKCe7K_P5iT99bHlcHwog
Message-ID: <CAJZ5v0g5a+0eaULxGG=RFm=JN8Gh3_A=7mGUTmFUiXsxVKvpDQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: Share THERMAL_NO_LIMIT between kernel and DT bindings
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rafael@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 3:43=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> THERMAL_NO_LIMIT is defined separately in the thermal core and the DT
> bindings, using different expressions for the same no-limit sentinel.
>
> Define it as 0xffffffff in the DT bindings header and include that
> header from linux/thermal.h. Remove the duplicate kernel definition so
> both interfaces use the same unsigned 32-bit value while preserving
> the existing DT encoding.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

But THERMAL_NO_LIMIT is also used by the core on systems without DT,
so why is defining it in DT bindings not confusing?

> ---
>  include/dt-bindings/thermal/thermal.h | 2 +-
>  include/linux/thermal.h               | 5 ++---
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/include/dt-bindings/thermal/thermal.h b/include/dt-bindings/=
thermal/thermal.h
> index bc7babb1a67c..018f75febb9f 100644
> --- a/include/dt-bindings/thermal/thermal.h
> +++ b/include/dt-bindings/thermal/thermal.h
> @@ -10,7 +10,7 @@
>  #define _DT_BINDINGS_THERMAL_THERMAL_H
>
>  /* On cooling devices upper and lower limits */
> -#define THERMAL_NO_LIMIT               (~0)
> +#define THERMAL_NO_LIMIT               0xffffffff /* ~0U */
>
>  #endif
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 083b4f533933..a6f635f0e1f8 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -17,12 +17,11 @@
>  #include <linux/workqueue.h>
>  #include <uapi/linux/thermal.h>
>
> +#include <dt-bindings/thermal/thermal.h>
> +
>  /* invalid cooling state */
>  #define THERMAL_CSTATE_INVALID -1UL
>
> -/* No upper/lower limit requirement */
> -#define THERMAL_NO_LIMIT       ((u32)~0)
> -
>  /* Default weight of a bound cooling device */
>  #define THERMAL_WEIGHT_DEFAULT 0
>
> --
> 2.53.0
>
