Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B252EC7EE2F
	for <linux-pm@archiver.kernel.org>; Fri,  3 Mar 2023 15:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjCCPst convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 3 Mar 2023 10:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjCCPsq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Mar 2023 10:48:46 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3A965BA;
        Fri,  3 Mar 2023 07:48:44 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pY7e6-0005wL-Hm; Fri, 03 Mar 2023 16:48:34 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     rafael@kernel.org, daniel.lezcano@linaro.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Dhruva Gole <d-gole@ti.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:RENESAS R-CAR THERMAL DRIVERS" 
        <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v5 07/18] thermal/hwmon: Do not set no_hwmon before calling
 thermal_add_hwmon_sysfs()
Date:   Fri, 03 Mar 2023 16:48:38 +0100
Message-ID: <1943849.usQuhbGJ8B@diego>
In-Reply-To: <20230301201446.3713334-8-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
 <20230301201446.3713334-8-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Mittwoch, 1. März 2023, 21:14:35 CET schrieb Daniel Lezcano:
> The thermal->tzp->no_hwmon parameter is only used when calling
> thermal_zone_device_register().
> 
> Setting it to 'false' before calling thermal_add_hwmon_sysfs() has no
> effect.
> 
> Remove the call and again prevent the drivers to access the thermal
> internals.
> 
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se> #R-Car
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com> #Broadcom

Acked-by: Heiko Stuebner <heiko@sntech.de> #rockchip


