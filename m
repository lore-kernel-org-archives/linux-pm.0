Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404141EC01B
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773487049; cv=none; b=a9cT2q3w0kKCN7zHeYrsunozzHJtcaA45qDrOYm9dhcWqI6/J3DisGAormEJ+u0Uv2/xJVhRldoGRUATfZk0555zu8XNiAFY/xx55YtfSmfT9x6rZg0Dlfr2TYDil2/C80OPHGxrpCS5kjuOY2oi/e6N85J3hlXuMb0Ki3Hq7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773487049; c=relaxed/simple;
	bh=GzdoR5p/CHTyiZzD1vZNRmYLw8QXa8A9TTli3+1Ag80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpF2skJSV7GFlicG4/zkO3Fci2mnAuLdbuWA1//RI5JppJSbAE4JRukjVq14JC68DmlLfYNZEj1Pcub3jna2b0FWERvkzjGiR4xJomyZjl4E10BnBgBV1INSwWlPMw8CT5+nU1RRmrdmExRa9VzhHDBH7VmT2R2CSdx3g6wieug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2rUWEZZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2rUWEZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C0BC19423
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 11:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773487048;
	bh=GzdoR5p/CHTyiZzD1vZNRmYLw8QXa8A9TTli3+1Ag80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p2rUWEZZMkYlvlgiH/28u30yOKXNaSuJgMr2yuFf8Fw0L3sIBa4sapojhm4Zon4P/
	 1K8tgOzyyXmKBETUkWgVCxYupTH8e2m7w9RblbysqdMhTpo5AB3QXR+EldiWFPJzne
	 MPMQTjI8QNQI//JGxaDqjoxrvDuwcM9bp663Lfh4OyMuWi2cQ7vKbAV6Xrk8xlWEkj
	 nnVJeYJp4OvnjVXWa1BRrD4LR0MIxyEIrDLs92XAjG84UHldQ4cJGzt7taG+FHMQNo
	 6Tq2dv2GsABsSGa8j0neceK/O2ez9ClAQNJxZga5bQPFF7CUspoq3VKKb6apsgPDwF
	 Juv9Dqo2htZEw==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4671cbce626so1464518b6e.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 04:17:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXDBKnbaRPuddhGL4AR7ePAkQ2mhDsJs60DuEXTQpBZm0oO+v8cNFT6vmLxMvjeOlNv//WdhW71Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOT5CytJC0k4etp39Ex935x389OPN74Jq2Z6r9mcCQQmW0sTva
	2hx/9fmYLIFTHZmxTQEF3pu3m8ZUR54aUavSXQw44n8uurfMAKRXEtiorxQxdJwDuxphlISG4Zy
	6TEhFO/8x+xM5su8nWlDO6bvK3lFLdhI=
X-Received: by 2002:a05:6808:6909:b0:450:32f0:4887 with SMTP id
 5614622812f47-467572d3896mr3363924b6e.31.1773487048046; Sat, 14 Mar 2026
 04:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311164212.405981-3-thorsten.blum@linux.dev>
In-Reply-To: <20260311164212.405981-3-thorsten.blum@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 14 Mar 2026 12:17:16 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0innBWW+94tqfJFmy=BGVwByVh7NQEoEk=KUwoTbHAOnw@mail.gmail.com>
X-Gm-Features: AaiRm51jNzG8AhGGpiNTgw_sbVINCXGloZKWcTFtShSrwhzPHgPl3yvCj1o_QYA
Message-ID: <CAJZ5v0innBWW+94tqfJFmy=BGVwByVh7NQEoEk=KUwoTbHAOnw@mail.gmail.com>
Subject: Re: [PATCH] thermal: sysfs: Use str_enabled_disabled helper in mode_show
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 5:43=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Replace hard-coded strings with the str_enabled_disabled() helper. This
> unifies the output and helps the linker with deduplication, which can
> result in a smaller binary.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/thermal/thermal_sysfs.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sy=
sfs.c
> index 46b3b2df935c..5eecae13f07d 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -18,6 +18,7 @@
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <linux/string_choices.h>
>  #include <linux/jiffies.h>
>
>  #include "thermal_core.h"
> @@ -56,10 +57,8 @@ mode_show(struct device *dev, struct device_attribute =
*attr, char *buf)
>
>         guard(thermal_zone)(tz);
>
> -       if (tz->mode =3D=3D THERMAL_DEVICE_ENABLED)
> -               return sysfs_emit(buf, "enabled\n");
> -
> -       return sysfs_emit(buf, "disabled\n");
> +       return sysfs_emit(buf, "%s\n",
> +               str_enabled_disabled(tz->mode =3D=3D THERMAL_DEVICE_ENABL=
ED));
>  }
>
>  static ssize_t

Applied as 7.1 material, thanks!
