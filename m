Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BE2C77B73
	for <linux-pm@archiver.kernel.org>; Wed, 24 May 2023 15:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbjEXPLX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 May 2023 11:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjEXPLW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 May 2023 11:11:22 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71951E9;
        Wed, 24 May 2023 08:11:20 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-96f72e6925cso24433166b.1;
        Wed, 24 May 2023 08:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684941079; x=1687533079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nss0ucgr/ESmy+PjCm3qpugQV6w2aHePkSgyOIXHvM=;
        b=KgMx/g88W0NvPJ8qpLn3QiZhmXVyC+ZUqAr4C0z4GRvwVGKAFmtaT9XH0dR3gP/UCi
         /GNSq1qDV3dtRltoMdWU3HjoUdPCO6fi97cnLFzqwTgmr5tL+gg54y+/ebbkBTHIq+EL
         iASfWQ5z5h0h93BLzjwIJgMaQoDWb9MYHdWkBrAZBMw6JiIhuymUzMcxZYl+XkwuwEPq
         4X6o7XRIY6DePMWiUeytNbOPCIC5o1kMlWV5ME527tgEdbMAXjNpofgFOVzLz9w8DCQ1
         Il91kHf8xFnopVfk5lMachMglS+d+21gO7vk7iCVzLswl9tcTS1sauZJmbY6KDrOe3A+
         uxWQ==
X-Gm-Message-State: AC+VfDzAu7INL2m6rsmeLNyRRWd9oevzUXmcuQ/ijTAJT15Z7xXZvWwz
        u9bZsk/dFsaAXFRSLIF/3ZV3S+LoMA4h8TUQW6g=
X-Google-Smtp-Source: ACHHUZ641vcCCJosn7JXJ2lfLp7dhRWsBrg3n4CiXJeo2ypbFDpFROYj8sMPWI3wOIZFsVcQsGEKXSE/sDtoTunVh74=
X-Received: by 2002:a17:906:72ce:b0:96f:56ab:c69b with SMTP id
 m14-20020a17090672ce00b0096f56abc69bmr2531918ejl.3.1684941078712; Wed, 24 May
 2023 08:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230309140724.2152712-1-cristian.marussi@arm.com> <20230309140724.2152712-4-cristian.marussi@arm.com>
In-Reply-To: <20230309140724.2152712-4-cristian.marussi@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 17:11:07 +0200
Message-ID: <CAJZ5v0gUf3Vh=baW7PgPMnFcgV6CjMc2kNayhzP-MC=UvQogKA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] powercap: arm_scmi: Add support for disabling
 powercaps on a zone
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        tarek.el-sherbiny@arm.com, nicola.mazzucato@arm.com,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        wbartczak@marvell.com, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Mar 9, 2023 at 3:07 PM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> Add support to disable/enable powercapping on a zone.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/powercap/arm_scmi_powercap.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/powercap/arm_scmi_powercap.c b/drivers/powercap/arm_scmi_powercap.c
> index 05d0e516176a..5231f6d52ae3 100644
> --- a/drivers/powercap/arm_scmi_powercap.c
> +++ b/drivers/powercap/arm_scmi_powercap.c
> @@ -70,10 +70,26 @@ static int scmi_powercap_get_power_uw(struct powercap_zone *pz,
>         return 0;
>  }
>
> +static int scmi_powercap_zone_enable_set(struct powercap_zone *pz, bool mode)
> +{
> +       struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
> +
> +       return powercap_ops->cap_enable_set(spz->ph, spz->info->id, mode);
> +}
> +
> +static int scmi_powercap_zone_enable_get(struct powercap_zone *pz, bool *mode)
> +{
> +       struct scmi_powercap_zone *spz = to_scmi_powercap_zone(pz);
> +
> +       return powercap_ops->cap_enable_get(spz->ph, spz->info->id, mode);
> +}
> +
>  static const struct powercap_zone_ops zone_ops = {
>         .get_max_power_range_uw = scmi_powercap_get_max_power_range_uw,
>         .get_power_uw = scmi_powercap_get_power_uw,
>         .release = scmi_powercap_zone_release,
> +       .set_enable = scmi_powercap_zone_enable_set,
> +       .get_enable = scmi_powercap_zone_enable_get,
>  };
>
>  static void scmi_powercap_normalize_cap(const struct scmi_powercap_zone *spz,
> --
> 2.34.1
>
