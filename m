Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF2EC7EE23
	for <linux-pm@archiver.kernel.org>; Tue, 23 May 2023 16:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbjEWQ4V (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 May 2023 12:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbjEWQ4R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2023 12:56:17 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F333418F
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 09:56:13 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id b8b31ff5-f98a-11ed-b3cf-005056bd6ce9;
        Tue, 23 May 2023 19:56:12 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 23 May 2023 19:56:11 +0300
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, hdegoede@redhat.com, linus.walleij@linaro.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pm@vger.kernel.org, Shyam-sundar.S-k@amd.com,
        Basavaraj.Natikar@amd.com
Subject: Re: [PATCH v2 4/4] platform/x86/amd: pmc: Use pm_pr_dbg() for
 suspend related messages
Message-ID: <ZGzwKwkWU6aJRQ1S@surfacebook>
References: <20230522200033.2605-1-mario.limonciello@amd.com>
 <20230522200033.2605-4-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522200033.2605-4-mario.limonciello@amd.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Mon, May 22, 2023 at 03:00:33PM -0500, Mario Limonciello kirjoitti:
> Using pm_pr_dbg() allows users to toggle `/sys/power/pm_debug_messages`
> as a single knob to turn on messages that amd-pmc can emit to aid in
> any s2idle debugging.

It has the same two regressions as I pointed out in previous reply.

-- 
With Best Regards,
Andy Shevchenko


