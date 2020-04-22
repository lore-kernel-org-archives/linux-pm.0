Return-Path: <SRS0=Cnqh=6G=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3957FC54FCB
	for <linux-pm@archiver.kernel.org>; Wed, 22 Apr 2020 19:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA36215A4
	for <linux-pm@archiver.kernel.org>; Wed, 22 Apr 2020 19:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgDVTFD (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:05:03 -0400
Received: from foss.arm.com ([217.140.110.172]:53928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgDVTFD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 15:05:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF9401FB;
        Wed, 22 Apr 2020 12:05:02 -0700 (PDT)
Received: from bogus (unknown [10.37.12.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74A483F6CF;
        Wed, 22 Apr 2020 12:04:59 -0700 (PDT)
Date:   Wed, 22 Apr 2020 20:04:51 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 01/17] ARM: vexpress: Move vexpress_flags_set() into arch
 code
Message-ID: <20200422190451.GA25585@bogus>
References: <20200419170810.5738-1-robh@kernel.org>
 <20200419170810.5738-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419170810.5738-2-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 12:07:54PM -0500, Rob Herring wrote:
> vexpress_flags_set() is only used by the platform SMP related code and
> has nothing to do with the vexpress-sysreg MFD driver other than both
> access the same h/w block. It's also only needed for 32-bit systems and
> must be built-in for them. Let's move vexpress_flags_set() closer to
> where it is being used. This will allow for vexpress-sysreg to be built
> as a module.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com> 

-- 
Regards,
Sudeep
