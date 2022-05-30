Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C078DC433EF
	for <linux-pm@archiver.kernel.org>; Mon, 30 May 2022 15:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238408AbiE3P3u (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 30 May 2022 11:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242497AbiE3P3X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2022 11:29:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30A671E049B;
        Mon, 30 May 2022 07:33:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B251D1FB;
        Mon, 30 May 2022 07:32:54 -0700 (PDT)
Received: from bogus (unknown [10.57.9.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDAAC3F766;
        Mon, 30 May 2022 07:32:52 -0700 (PDT)
Date:   Mon, 30 May 2022 15:32:05 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] cpuidle: cpuidle-arm: remove arm64 support
Message-ID: <20220530143205.mdvxojvenb3lcii2@bogus>
References: <20220529181329.2345722-1-michael@walle.cc>
 <20220529181329.2345722-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529181329.2345722-2-michael@walle.cc>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 29, 2022 at 08:13:28PM +0200, Michael Walle wrote:
> Since commit 788961462f34 ("ARM: psci: cpuidle: Enable PSCI CPUidle
> driver") the generic ARM cpuidle driver doesn't probe anymore because
> arm_cpuidle_init() will always return -EOPNOTSUPP. That is, because the
> mentioned commit removes the only .cpu_suspend and .cpu_init_idle
> provider.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
