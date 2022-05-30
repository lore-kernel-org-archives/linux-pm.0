Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1841C433F5
	for <linux-pm@archiver.kernel.org>; Mon, 30 May 2022 15:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbiE3PgO (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 30 May 2022 11:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbiE3PcF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2022 11:32:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80AE1139C9D;
        Mon, 30 May 2022 07:34:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A00B1FB;
        Mon, 30 May 2022 07:34:39 -0700 (PDT)
Received: from bogus (unknown [10.57.9.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 322C73F766;
        Mon, 30 May 2022 07:34:36 -0700 (PDT)
Date:   Mon, 30 May 2022 15:33:49 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: cpuidle: remove generic cpuidle support
Message-ID: <20220530143349.rvbx472q7vfwuqtd@bogus>
References: <20220529181329.2345722-1-michael@walle.cc>
 <20220529181329.2345722-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220529181329.2345722-3-michael@walle.cc>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, May 29, 2022 at 08:13:29PM +0200, Michael Walle wrote:
> The arm64 support of the generic ARM cpuidle driver was removed. This
> let us remove all support code for it.
>

Thanks for doing this, we initially had plans to do this one release after
PSCI idle driver got merged but clearly slipped through the cracks.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
