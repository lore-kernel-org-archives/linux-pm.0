Return-Path: <SRS0=JVBr=SU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD00DC282DD
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 20:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C20217D7
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 20:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MbH1S6za"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388982AbfDRUfo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:35:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46681 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388358AbfDRUfo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2019 16:35:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id 10so1312848pgv.13
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2019 13:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BbxZ1Wm3vrcS9rLeR0qxSNVZn0SFBfcNjWi2YkD4UlA=;
        b=MbH1S6za1ShbicEWvBz4SvdQrGZEtT2+ggWSg/UIQoXd/22DBvpUlLbUamWzGMGZU6
         Xjy6X2VgGHPCwwlJJ+EFTgj9GA40yTdwhK6uQu3wplSyCVb0dODkl2COmAod+1kn5SZS
         p/PpQWsHKmzWdBJ2ZslhHdNHypKgHSmfeAoy+0I834YIQp/shyH/Nl8dr1ki2RSY8Xru
         uyUhs9QQWCOL24hZZmOpYfBaf+uTUcEMxUu0syEHqk4R2wT4bM45VpFLC6wHvWqO1xfA
         lBOzlXU/V0l7DKbVEVopqf/4knCZz2FzM53ZoXkZgSghf2N6ByBfVLgeG1HZGROSw1Nb
         YYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbxZ1Wm3vrcS9rLeR0qxSNVZn0SFBfcNjWi2YkD4UlA=;
        b=g3/zFnBeGN0Q2UkVSBIzuXvLbFpgNwOTzkcZxJufBpi90ZpBeYGw8kOIPvFY3B++S7
         4DCAiR4ZRaNudU1C+rdc7bDt9Qb6ddhQ8q3BIoGXbIwSHHCotyjqMjm7Ihxz05ix/99L
         E9usBSbH9WizjisoxA1ox1gVcgAItgc6G2GKX0ASXaPW4IUyaIeD4AqHCJA9p33G/oY6
         m+HeJjnlKE7A9OhOD5L+NWlA9qcCT+N/l+fs6elbjIj7Wz3Yy0FIGSryigNwUiisHyBt
         1At/dGbg/AxRFIEndFV2Co1qskK1dJpRsFvj3ksTUZFfcGzi5KkVIs6cfoZkjibrfEJ7
         8FMw==
X-Gm-Message-State: APjAAAWXrlrVow4Wxd4lUnH717k+8B+oIK2aeO8XhGr1k508WUIR8GL5
        quWw4FDrS3/Tc6SdIsj3EAiYv3CAQbxpO2iSBJmEIg==
X-Google-Smtp-Source: APXvYqwJu5yh75P2ZTkxNCKTm19mCqS0f4dpN9Cz+/MNhiMAUzkgt2ELcK9WvoF55QgihDmewEjQ5sRxNZQ3THh5GlU=
X-Received: by 2002:a63:e850:: with SMTP id a16mr86906748pgk.195.1555619742538;
 Thu, 18 Apr 2019 13:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net> <1555617500-10862-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1555617500-10862-3-git-send-email-linux@roeck-us.net>
From:   Patrick Venture <venture@google.com>
Date:   Thu, 18 Apr 2019 13:35:31 -0700
Message-ID:
 <CAO=notxzQUyRJ4L7w6o4Cdbwp-Sg4FXyMDgJUN-7YPm9JgiQuw@mail.gmail.com>
Subject: Re: [PATCH 2/6] hwmon: (aspeed-pwm-tacho) Use devm_thermal_of_cooling_device_register
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-pm@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mykola Kostenok <c_mykolak@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190418203531.gPM9jyAtmckbtOJIhHByJt8Hr38Pg11F_oCOCItdTgU@z>

On Thu, Apr 18, 2019 at 12:58 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Use devm_thermal_of_cooling_device_register() to register the cooling
> device. As a side effect, this fixes a driver bug:
> thermal_cooling_device_unregister() was not called on removal.
>
> Fixes: f198907d2ff6d ("hwmon: (aspeed-pwm-tacho) cooling device support.")
> Cc: Mykola Kostenok <c_mykolak@mellanox.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Patrick Venture <venture@google.com>

> ---
>  drivers/hwmon/aspeed-pwm-tacho.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
> index c4dd6301e7c8..0daf0b32aa4a 100644
> --- a/drivers/hwmon/aspeed-pwm-tacho.c
> +++ b/drivers/hwmon/aspeed-pwm-tacho.c
> @@ -830,10 +830,8 @@ static int aspeed_create_pwm_cooling(struct device *dev,
>         }
>         snprintf(cdev->name, MAX_CDEV_NAME_LEN, "%pOFn%d", child, pwm_port);
>
> -       cdev->tcdev = thermal_of_cooling_device_register(child,
> -                                                        cdev->name,
> -                                                        cdev,
> -                                                        &aspeed_pwm_cool_ops);
> +       cdev->tcdev = devm_thermal_of_cooling_device_register(dev, child,
> +                                       cdev->name, cdev, &aspeed_pwm_cool_ops);
>         if (IS_ERR(cdev->tcdev))
>                 return PTR_ERR(cdev->tcdev);
>
> --
> 2.7.4
>
