Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F67EC38A2D
	for <linux-pm@archiver.kernel.org>; Tue, 25 Oct 2022 11:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbiJYLnj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 25 Oct 2022 07:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiJYLni (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Oct 2022 07:43:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CBE9172B62;
        Tue, 25 Oct 2022 04:43:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19517D6E;
        Tue, 25 Oct 2022 04:43:43 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7B213F7B4;
        Tue, 25 Oct 2022 04:43:35 -0700 (PDT)
Date:   Tue, 25 Oct 2022 12:43:33 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpuidle: dt: Clarify a comment and simplify code in
 dt_init_idle_driver()
Message-ID: <20221025114333.liwaw767uijwlvrh@bogus>
References: <20221021151013.148457-1-ulf.hansson@linaro.org>
 <20221021151013.148457-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021151013.148457-2-ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 21, 2022 at 05:10:13PM +0200, Ulf Hansson wrote:
> The drv->state_count is assigned the total number of available states, so
> let's make that clear.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
