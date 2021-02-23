Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71639C433E9
	for <linux-pm@archiver.kernel.org>; Tue, 23 Feb 2021 21:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CF2164E83
	for <linux-pm@archiver.kernel.org>; Tue, 23 Feb 2021 21:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbhBWVIV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Feb 2021 16:08:21 -0500
Received: from mailout03.rmx.de ([94.199.88.101]:37253 "EHLO mailout03.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230083AbhBWVIT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Feb 2021 16:08:19 -0500
X-Greylist: delayed 1863 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Feb 2021 16:08:16 EST
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout03.rmx.de (Postfix) with ESMTPS id 4DlW6k5R8Pzldby;
        Tue, 23 Feb 2021 21:36:30 +0100 (CET)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4DlW6d5zqMz2TTJJ;
        Tue, 23 Feb 2021 21:36:25 +0100 (CET)
Received: from n95hx1g2.localnet (192.168.54.49) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 23 Feb
 2021 21:36:07 +0100
From:   Christian Eggers <ceggers@arri.de>
To:     <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Zhang Rui <rui.zhang@intel.com>,
        "Amit Kucheria" <amitk@kernel.org>,
        "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:AMS AS73211 DRIVER" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] units: Use the HZ_PER_KHZ macro
Date:   Tue, 23 Feb 2021 21:36:05 +0100
Message-ID: <2578027.mvXUDI8C0e@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20210223203004.7219-2-daniel.lezcano@linaro.org>
References: <20210223203004.7219-1-daniel.lezcano@linaro.org> <20210223203004.7219-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.49]
X-RMX-ID: 20210223-213625-NLCNxGMyXFbP-0@out02.hq
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, 23 February 2021, 21:30:02 CET, Daniel Lezcano wrote:
> The HZ_PER_KHZ macro definition is duplicated in different subsystems.
> 
> The macro now exists in include/linux/units.h, make use of it and
> remove all the duplicated ones.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/devfreq/devfreq.c         | 2 +-
>  drivers/iio/light/as73211.c       | 3 +--
>  drivers/thermal/devfreq_cooling.c | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 6aa10de792b3..4c636c336ace 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -26,6 +26,7 @@
>  #include <linux/hrtimer.h>
>  #include <linux/of.h>
>  #include <linux/pm_qos.h>
> +#include <linux/units.h>
>  #include "governor.h"
>  
>  #define CREATE_TRACE_POINTS
> @@ -33,7 +34,6 @@
>  
>  #define IS_SUPPORTED_FLAG(f, name) ((f & DEVFREQ_GOV_FLAG_##name) ? true : false)
>  #define IS_SUPPORTED_ATTR(f, name) ((f & DEVFREQ_GOV_ATTR_##name) ? true : false)
> -#define HZ_PER_KHZ	1000
>  
>  static struct class *devfreq_class;
>  static struct dentry *devfreq_debugfs;
> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index 7b32dfaee9b3..3ba2378df3dd 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
> @@ -24,8 +24,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/pm.h>
> -
> -#define HZ_PER_KHZ 1000
> +#include <linux/units.h>
>  
>  #define AS73211_DRV_NAME "as73211"
>  
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index fed3121ff2a1..fa5b8b0c7604 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -19,10 +19,10 @@
>  #include <linux/pm_opp.h>
>  #include <linux/pm_qos.h>
>  #include <linux/thermal.h>
> +#include <linux/units.h>
>  
>  #include <trace/events/thermal.h>
>  
> -#define HZ_PER_KHZ		1000
>  #define SCALE_ERROR_MITIGATION	100
>  
>  static DEFINE_IDA(devfreq_ida);
> 

Reviewed-by: Christian Eggers <ceggers@arri.de>



