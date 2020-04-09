Return-Path: <SRS0=OdXI=5Z=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36254C2BB1D
	for <linux-pm@archiver.kernel.org>; Thu,  9 Apr 2020 02:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE0220730
	for <linux-pm@archiver.kernel.org>; Thu,  9 Apr 2020 02:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgDIC70 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 8 Apr 2020 22:59:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:60012 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgDIC70 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Apr 2020 22:59:26 -0400
IronPort-SDR: q3c9KRDFjULNmPrDCH5VJBY3AttErVL60tsm6TsRJj/l6xkw7rWKFLIg1r9LKXEet80wdQcfBM
 Mlv8o0wB5djg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 19:59:26 -0700
IronPort-SDR: kGvpwQYUTQrE57SkndmuuPyzspzdT3LmXFWqp1BT/OmsP7PV9yDozFy3GLbI1m1znZfreDE+J3
 sgSMp1Hy3o6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,361,1580803200"; 
   d="scan'208";a="244204438"
Received: from yanbingj-mobl1.ccr.corp.intel.com ([10.249.174.232])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2020 19:59:25 -0700
Message-ID: <8132c40d6c146f2b4604362218867eaad6e6ca8c.camel@intel.com>
Subject: Re: [RFC PATCH 1/5] thermal: rename
 thermal_cooling_device_stats_update()
From:   Zhang Rui <rui.zhang@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org
Date:   Thu, 09 Apr 2020 10:59:24 +0800
In-Reply-To: <s5hh7xus402.wl-tiwai@suse.de>
References: <20200408041917.2329-1-rui.zhang@intel.com>
         <s5hh7xus402.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-04-08 at 11:47 +0200, Takashi Iwai wrote:
> On Wed, 08 Apr 2020 06:19:13 +0200,
> Zhang Rui wrote:
> > 
> > Rename thermal_cooling_device_stats_update() to
> > thermal_cdev_stats_update_cur()
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> Thanks for the patch set!  I did a quick test and it seems working
> fine.  Also through a glance, the patches are good, just a few
> trivial
> issues as posted in another mail.
> 
> So, feel free to take my tags for the whole series:
>   Tested-by: Takashi Iwai <tiwai@suse.de>
>   Reviewed-by: Takashi Iwai <tiwai@suse.de>
> 
Thanks for the test and review.

I will refresh the patch set with your comments addressed and also with
the changelog of your patch rephrased.

thanks,
rui


