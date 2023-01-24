Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB15FC25B4E
	for <linux-pm@archiver.kernel.org>; Tue, 24 Jan 2023 16:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjAXQlp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 24 Jan 2023 11:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjAXQln (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2023 11:41:43 -0500
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0F54901C;
        Tue, 24 Jan 2023 08:41:21 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id k20so1762627edj.7;
        Tue, 24 Jan 2023 08:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FhVguK7QkXmViLLwLaGonolvtzheH4NjuCYF4wtX2iQ=;
        b=bG9b4H3KllBC42/gpNsn9NIYmDrsp+NXHw7notIB2fQSFqrtTXsHMnpFnkm/cOAA0M
         t6KJPXo95jFHhvQDh09RY9r63uhkMRIcFJ2WI20E/VqmG6oaNbKfspOSVfgqTFSx6dot
         TlvIxmS809N6vKK/dpKtywmxQufxl+ieLS/4e962zm9CHnY0EibUrYTewOlqu+MLpLTI
         yEIyK1EuRY/A2ZXjLszluwZ8YyZlRizrWSiZ1z4PcobbYc3/ecgeaytBv3hw+w4eLzIY
         KGurYavMBP+cYfUjnQDSdxhR/migMH1TZgDlobuqDuA5BoDycbTGrgIbGnkmaB34d9Fk
         +jjA==
X-Gm-Message-State: AFqh2krk+VZefCqrJa0xlBt4IBPfuYnfDeLy3Y+j0kCPO6XSJgJiwO0B
        rtPHi6gcRO/neSc1ILLWg1iwdzcXVmLWH76Ke3Q=
X-Google-Smtp-Source: AMrXdXt1cavl3RCc2KhGhe+dXZSGmpkd91bpuo2Nyv+9nJ4CMnu/i++PjeK+X6X7BPUfayFKLmQ3b12e515gAp7l2E0=
X-Received: by 2002:a05:6402:1002:b0:49a:1676:4280 with SMTP id
 c2-20020a056402100200b0049a16764280mr3489288edu.16.1674578479668; Tue, 24 Jan
 2023 08:41:19 -0800 (PST)
MIME-Version: 1.0
References: <Y8/1ccQLn41w+Vek@kili> <20230124163127.445942-1-daniel.lezcano@linaro.org>
In-Reply-To: <20230124163127.445942-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jan 2023 17:41:08 +0100
Message-ID: <CAJZ5v0gShFD09cS6Xf3shD9zZkWY7_kzrPr_KYHi+kOaUHgzaA@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/int340x: Fix uninitialized trip_cnt variable
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, error27@gmail.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 24, 2023 at 5:35 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The conversion to the generic trip points missed to initializes the
> extra trip points to zero in case the _PATC method is not found.

The _PATC name is incorrect.

> Set by default the trip_cnt to zero.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> index 7ff5d9b1c490..c113962a599e 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -121,7 +121,7 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
>  {
>         struct int34x_thermal_zone *int34x_thermal_zone;
>         acpi_status status;
> -       unsigned long long trip_cnt;
> +       unsigned long long trip_cnt = 0;
>         int trip_mask = 0;
>         int i, ret;
>
> --

I've just posted an equivalent fix and I prefer mine.
