Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEB4C433FE
	for <linux-pm@archiver.kernel.org>; Thu, 10 Dec 2020 16:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB4D23BE5
	for <linux-pm@archiver.kernel.org>; Thu, 10 Dec 2020 16:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgLJQ5E (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 10 Dec 2020 11:57:04 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46566 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391932AbgLJQ4u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2020 11:56:50 -0500
Received: from 89-64-77-250.dynamic.chello.pl (89.64.77.250) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id cdfd7695336cc5bb; Thu, 10 Dec 2020 17:55:57 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Petr Cervinka <pcervinka@suse.com>
Subject: Re: [PATCH 1/2] acpi: cppc: add cpufreq device
Date:   Thu, 10 Dec 2020 17:55:56 +0100
Message-ID: <1916679.syIRshJoYJ@kreacher>
In-Reply-To: <20201210150417.GA24136@suse.de>
References: <20201210142139.20490-1-yousaf.kaukab@suse.com> <CAJZ5v0hWxLrXCS+X15hnLZ2enBsSJ0aEfnxK2kL+n9k4gkg17Q@mail.gmail.com> <20201210150417.GA24136@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thursday, December 10, 2020 4:04:40 PM CET Mian Yousaf Kaukab wrote:
> On Thu, Dec 10, 2020 at 03:32:09PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Dec 10, 2020 at 3:23 PM Mian Yousaf Kaukab
> > <yousaf.kaukab@suse.com> wrote:
> > >
> > > Convert cppc-cpufreq driver to a platform driver (done in a separate patch)
> > > and add cppc-cpufreq device when acpi_cppc_processor_probe() succeeds.
> > 
> > Honestly, I prefer to drop 28f06f770454 (along with its follower)
> > instead of making this change.
> > 
> Even if we revert 28f06f770454 there is still one more small issue that these
> patches fix. Currently, ACPI_PROCESSOR_DEVICE_HID is used to load cppc-cpufreq
> module. In case when CPPC is disabled, some cycles will be wasted in loading
> cppc-cpufreq module. The module will return error from the init call though
> so no memory is wasted.
> 
> After converting to platform-driver, cppc-cpufreq module will only be loaded
> when the platform-device is available.

Even so, that issue is low-impact AFAICS and may be addressed later and I'd
rather not let known breakage go into the mainline.

I'm going to do drop the problematic commit now and please work with Ionela
to produce a clean series of patches in the right order to avoid introducing
issues between them.

If that is done timely enough, it may still be possible to push those patches
for 5.11-rc1.

Thanks!



