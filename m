Return-Path: <SRS0=bDVj=BP=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5066C433E0
	for <linux-pm@archiver.kernel.org>; Wed,  5 Aug 2020 20:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD9622B42
	for <linux-pm@archiver.kernel.org>; Wed,  5 Aug 2020 20:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgHEUQU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:16:20 -0400
Received: from foss.arm.com ([217.140.110.172]:32966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbgHEQS5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Aug 2020 12:18:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B93E91424;
        Wed,  5 Aug 2020 09:03:18 -0700 (PDT)
Received: from bogus (unknown [10.37.12.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADCEE3F7D7;
        Wed,  5 Aug 2020 09:03:16 -0700 (PDT)
Date:   Wed, 5 Aug 2020 17:03:12 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, cristian.marussi@arm.com,
        rjw@rjwysocki.net, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
Message-ID: <20200805160312.GC4818@bogus>
References: <20200729151208.27737-1-lukasz.luba@arm.com>
 <a3354ae8-f40f-83f2-d6eb-7f588af75e97@gmail.com>
 <119ce268-18dc-7a4c-b0b2-3a66ff9ff4b0@arm.com>
 <20200805130436.3d2g7z2rsdoesuuk@vireshk-mac-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805130436.3d2g7z2rsdoesuuk@vireshk-mac-ubuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 05, 2020 at 06:34:36PM +0530, Viresh Kumar wrote:
> On 05-08-20, 12:04, Lukasz Luba wrote:
> > I know that Viresh is going to develop patches and improve these
> > cpufreq stats framework. Maybe he also had this 'aggregation' in mind.
> > I will leave it him.
>
> I am only going to look at cpufreq's view of stats independently from
> the firmware.
>

+1, I agree with that. Kernel must avoid any logic to aggregate or
interpret the data in a generic way. The userspace tools can manage that
especially if this tend to be platform specific.

--
Regards,
Sudeep
