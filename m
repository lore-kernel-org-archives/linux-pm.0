Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C6CC43334
	for <linux-pm@archiver.kernel.org>; Wed, 22 Jun 2022 15:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376300AbiFVP7y (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 22 Jun 2022 11:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359817AbiFVP7m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jun 2022 11:59:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22561427EF;
        Wed, 22 Jun 2022 08:56:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E385D12FC;
        Wed, 22 Jun 2022 08:56:18 -0700 (PDT)
Received: from bogus (unknown [10.57.36.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F00FA3F792;
        Wed, 22 Jun 2022 08:56:15 -0700 (PDT)
Date:   Wed, 22 Jun 2022 16:55:04 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        dietmar.eggemann@arm.com, nm@ti.com, sboyd@kernel.org,
        cristian.marussi@arm.com, matthias.bgg@gmail.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] cpufreq: scmi: Support the power scale in
 micro-Watts in SCMI v3.1
Message-ID: <20220622155504.bcggz7spw4n2ehyj@bogus>
References: <20220622145802.13032-1-lukasz.luba@arm.com>
 <20220622145802.13032-5-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622145802.13032-5-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 22, 2022 at 03:58:02PM +0100, Lukasz Luba wrote:
> The SCMI v3.1 adds support for power values in micro-Watts. They are not
> always in milli-Watts anymore (ignoring the bogo-Watts). Thus, the power
> must be converted conditionally before sending to Energy Model. Add the
> logic which handles the needed checks and conversions.
>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
