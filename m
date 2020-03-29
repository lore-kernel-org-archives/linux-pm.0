Return-Path: <SRS0=SyNq=5O=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A994C43331
	for <linux-pm@archiver.kernel.org>; Sun, 29 Mar 2020 14:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2224E2076E
	for <linux-pm@archiver.kernel.org>; Sun, 29 Mar 2020 14:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgC2OIH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 29 Mar 2020 10:08:07 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:62184 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgC2OIH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 10:08:07 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id f063bb686b1bb6c4; Sun, 29 Mar 2020 16:08:05 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     kbuild test robot <lkp@intel.com>, linux-pm@vger.kernel.org,
        devel@acpica.org, linux-acpi@vger.kernel.org
Subject: Re: [pm:bleeding-edge] BUILD REGRESSION b50a778aa5b714166355ef7f4a1992e4073393fc
Date:   Sun, 29 Mar 2020 16:08:04 +0200
Message-ID: <3863805.FxIobF6Dnx@kreacher>
In-Reply-To: <5e7fb83b.mzs1XRDjQiEqx806%lkp@intel.com>
References: <5e7fb83b.mzs1XRDjQiEqx806%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Saturday, March 28, 2020 9:48:59 PM CEST kbuild test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
> branch HEAD: b50a778aa5b714166355ef7f4a1992e4073393fc  Merge branch 'acpica-next' into bleeding-edge
> 
> Regressions in current branch:
> 
> drivers/acpi/acpica/dswload2.c:476:3: warning: syntax error [syntaxError]
> 
> Error ids grouped by kconfigs:
> 
> recent_errors
> `-- x86_64-allyesconfig
>     `-- drivers-acpi-acpica-dswload2.c:warning:syntax-error-syntaxError

This looks like a script went south.

It should be fixed in my tree now.



