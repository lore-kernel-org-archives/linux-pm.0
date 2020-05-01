Return-Path: <SRS0=hlrK=6P=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59D3C47253
	for <linux-pm@archiver.kernel.org>; Fri,  1 May 2020 17:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BDF524953
	for <linux-pm@archiver.kernel.org>; Fri,  1 May 2020 17:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgEARSn (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 1 May 2020 13:18:43 -0400
Received: from foss.arm.com ([217.140.110.172]:44358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbgEARSm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 1 May 2020 13:18:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D0F130E;
        Fri,  1 May 2020 10:18:42 -0700 (PDT)
Received: from bogus (unknown [10.37.12.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D60D43F305;
        Fri,  1 May 2020 10:18:38 -0700 (PDT)
Date:   Fri, 1 May 2020 18:18:35 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 14/16] vexpress: Move setting master site to
 vexpress-config bus
Message-ID: <20200501171835.GL14018@bogus>
References: <20200429205825.10604-1-robh@kernel.org>
 <20200429205825.10604-15-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200429205825.10604-15-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 29, 2020 at 03:58:23PM -0500, Rob Herring wrote:
> There's only a single caller of vexpress_config_set_master() from
> vexpress-sysreg.c. Let's just make the registers needed available to
> vexpress-config and move all the code there. The registers needed aren't
> used anywhere else either. With this, we can get rid of the private API
> between these 2 drivers.
>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Some of the macro changes below are not so easy to follow/review.
Since nothing is broken,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

for this alone 😁.

--
Regards,
Sudeep
