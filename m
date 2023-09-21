Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84701E7D0A4
	for <linux-pm@archiver.kernel.org>; Thu, 21 Sep 2023 18:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjIUSMd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 21 Sep 2023 14:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjIUSMJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Sep 2023 14:12:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C05E86979E;
        Thu, 21 Sep 2023 10:52:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A229615DB;
        Thu, 21 Sep 2023 04:18:05 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B82123F5A1;
        Thu, 21 Sep 2023 04:17:26 -0700 (PDT)
Date:   Thu, 21 Sep 2023 12:17:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/13] cpufreq: scmi: Add support to parse domain-id
 using #power-domain-cells
Message-ID: <20230921111724.v3c7cl37hhydw44e@bogus>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
 <20230825112633.236607-12-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825112633.236607-12-ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Fri, Aug 25, 2023 at 01:26:31PM +0200, Ulf Hansson wrote:
> The performance domain-id can be described in DT using the power-domains
> property or the clock property. The latter is already supported, so let's
> add support for the power-domains too.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Changes in v3:
> 	- Move to get the power-domain index from power-domain-names.
>

Can you please provide you ack for all the scmi-cpufreq related changes
in this series to take it via arm-soc tree ?

--
Regards,
Sudeep
