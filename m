Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B81C433DB
	for <linux-pm@archiver.kernel.org>; Thu, 18 Feb 2021 19:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50D464EBD
	for <linux-pm@archiver.kernel.org>; Thu, 18 Feb 2021 19:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhBRTMA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbhBRSCf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2021 13:02:35 -0500
X-Greylist: delayed 1326 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Feb 2021 10:01:55 PST
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BD8C061756
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2021 10:01:55 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.93.0.4)
        (envelope-from <daniel@makrotopia.org>)
        id 1lCnHG-00017r-Ho; Thu, 18 Feb 2021 18:39:46 +0100
Date:   Thu, 18 Feb 2021 17:39:39 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Daniel =?iso-8859-1?Q?Gonz=E1lez?= Cabanelas <dgcbueu@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: small oddity in commit "power: reset: add driver for LinkStation
 power off"
Message-ID: <YC6mW6hebIg7z9eA@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

I stumbled upon a slight oddity in acommit you have contributed.
Please see my comment below.

> commit a7f79f99541eff4e6bcae0014eb08d3019337565
> Author: Daniel González Cabanelas <dgcbueu@gmail.com>
> Date:   Wed Jul 15 15:35:14 2020 +0200
> 
>     power: reset: add driver for LinkStation power off
>     
>     Some Buffalo LinkStations perform the power off operation, at restart
>     time, depending on the state of an output pin (LED2/INTn) at the ethernet
>     PHY. This pin is also used to wake the machine when a WoL packet is
>     received by the PHY.
>     
>     The driver is required by the Buffalo LinkStation LS421DE (ARM MVEBU),
>     and other models. Without it, the board remains forever halted if a
>     power off command is executed, unless the PSU is disconnected and
>     connected again.
>     
>     Add the driver to provide the power off function and also make the WoL
>     feature to be available.
>     
>     Signed-off-by: Daniel González Cabanelas <dgcbueu@gmail.com>
>     Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ...
> diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
> index 5710ca4695170..c51eceba9ea39 100644
> --- a/drivers/power/reset/Makefile
> +++ b/drivers/power/reset/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_POWER_RESET_GEMINI_POWEROFF) += gemini-poweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
>  obj-$(CONFIG_POWER_RESET_GPIO_RESTART) += gpio-restart.o
>  obj-$(CONFIG_POWER_RESET_HISI) += hisi-reboot.o
> +obj-${CONFIG_POWER_RESET_LINKSTATION} += linkstation-poweroff.o

Why are you using curly brackets (ie. shell variable) here instead of
normal parentheses (ie. Make variable)? It might work, but if there is
no special reason for this, we should just be consistent with the rest
of the file.


Cheers


Daniel
