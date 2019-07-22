Return-Path: <SRS0=qrRL=VT=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE1CC76188
	for <linux-pm@archiver.kernel.org>; Mon, 22 Jul 2019 09:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A5021993
	for <linux-pm@archiver.kernel.org>; Mon, 22 Jul 2019 09:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfGVJdr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:33:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41516 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfGVJdr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 05:33:47 -0400
Received: from 79.184.253.188.ipv4.supernova.orange.pl (79.184.253.188) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 02c7aece4bf1d215; Mon, 22 Jul 2019 11:33:45 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        kenny@panix.com
Subject: Re: [PATCH] powercap: adjust init order
Date:   Mon, 22 Jul 2019 11:33:44 +0200
Message-ID: <4518853.ESMkGYUoe6@kreacher>
In-Reply-To: <1563677384-20163-1-git-send-email-rui.zhang@intel.com>
References: <1563677384-20163-1-git-send-email-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sunday, July 21, 2019 4:49:44 AM CEST Zhang Rui wrote:
> The MMIO RAPL interface driver depends on both powercap subsystem and
> the intel_rapl_common code.
> But when all of them are built in, the MMIO RAPL interface driver is
> loaded before the later two and this breaks the system during boot.
> This is because the powercap sysfs class is not registered and the
> rapl_defaults ops is not set when built-in MMIO RAPL interface driver
> gets loaded.
> 
> Fix this by adjusting the init order of powercap subsystem and the
> intel_rapl_common code, so that their init functions are executed before
> MMIO RAPL interface driver in any case.
> 
> Fixes: 555c45fe0d04 ("int340X/processor_thermal_device: add support for MMIO RAPL")
> Reported-and-tested-by: Kenneth R. Crudup <kenny@panix.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 2 +-
>  drivers/powercap/powercap_sys.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 9fd6dd3..6df4818 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1454,7 +1454,7 @@ static void __exit rapl_exit(void)
>  	unregister_pm_notifier(&rapl_pm_notifier);
>  }
>  
> -module_init(rapl_init);
> +fs_initcall(rapl_init);
>  module_exit(rapl_exit);
>  
>  MODULE_DESCRIPTION("Intel Runtime Average Power Limit (RAPL) common code");
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
> index 540e8aa..f808c5f 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -671,7 +671,7 @@ static int __init powercap_init(void)
>  	return class_register(&powercap_class);
>  }
>  
> -device_initcall(powercap_init);
> +fs_initcall(powercap_init);
>  
>  MODULE_DESCRIPTION("PowerCap sysfs Driver");
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
> 

Applied (with some subject and changelog tweaks), thanks!




