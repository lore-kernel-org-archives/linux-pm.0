Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610B3C433FE
	for <linux-pm@archiver.kernel.org>; Mon, 21 Nov 2022 12:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKUMXh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 21 Nov 2022 07:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiKUMXg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2022 07:23:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B10EB742EC;
        Mon, 21 Nov 2022 04:23:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E75A61FB;
        Mon, 21 Nov 2022 04:23:41 -0800 (PST)
Received: from e126311.manchester.arm.com (unknown [10.57.69.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83FC53F587;
        Mon, 21 Nov 2022 04:23:33 -0800 (PST)
Date:   Mon, 21 Nov 2022 12:22:44 +0000
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/2] cpuidle: teo: Introduce util-awareness
Message-ID: <Y3ttlCCezC+SvFDH@e126311.manchester.arm.com>
References: <20221102152808.2978590-1-kajetan.puchalski@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102152808.2978590-1-kajetan.puchalski@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Wed, Nov 02, 2022 at 03:28:06PM +0000, Kajetan Puchalski wrote:

[...]

> v3 -> v4:
> - remove the chunk of code skipping metrics updates when the CPU was utilized
> - include new test results and more benchmarks in the cover letter

[...]

It's been some time so I just wanted to bump this, what do you think
about this v4? Doug has already tested it, resuls for his machine are
attached to the v3 thread.

Thanks,
Kajetan
