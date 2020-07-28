Return-Path: <SRS0=HuBt=BH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCD9C433E0
	for <linux-pm@archiver.kernel.org>; Tue, 28 Jul 2020 07:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE01022B43
	for <linux-pm@archiver.kernel.org>; Tue, 28 Jul 2020 07:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgG1HtG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:49:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:50459 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbgG1HtG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 28 Jul 2020 03:49:06 -0400
IronPort-SDR: wR3O3ZVRAt72bo9cgCOcRtARJM5v0PIEjmFlemTtB+NwQAOamUUMswHgWohTMO/+7bpfVD53YK
 RUenE9Sq9bpg==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="149029291"
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; 
   d="scan'208";a="149029291"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 00:49:05 -0700
IronPort-SDR: KC616d0CQifWl7NP+kbEYsAOXk7y5CwfLZZYx9niVblfvnmHSdxWFLT8nGg6fDrOpKLZijAxKl
 9HKns/qxreUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,405,1589266800"; 
   d="scan'208";a="490262246"
Received: from wenkema-mobl.ccr.corp.intel.com ([10.255.29.50])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jul 2020 00:49:03 -0700
Message-ID: <f3db48d231bbd3ccc08b9aea6dd1cf7b250f3251.camel@intel.com>
Subject: Re: [PATCH] thermal: core: Add thermal zone enable/disable
 notification
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     amit.kucheria@linaro.org, andrzej.p@collabora.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com
Date:   Tue, 28 Jul 2020 15:49:02 +0800
In-Reply-To: <20200727231033.26512-1-daniel.lezcano@linaro.org>
References: <20200727231033.26512-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-07-28 at 01:10 +0200, Daniel Lezcano wrote:
> Now the calls to enable/disable a thermal zone are centralized in a
> call to a function, we can add in these the corresponding netlink
> notifications.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/thermal_core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c
> index 9748fbb9a3a1..72bf159bcecc 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -509,6 +509,11 @@ static int thermal_zone_device_set_mode(struct
> thermal_zone_device *tz,
>  
>  	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>  
> +	if (mode == THERMAL_DEVICE_ENABLED)
> +		thermal_notify_tz_enable(tz->id);
> +	else
> +		thermal_notify_tz_disable(tz->id);
> +
>  	return ret;
>  }
>  

