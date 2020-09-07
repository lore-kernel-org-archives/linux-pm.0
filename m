Return-Path: <SRS0=fmUR=CQ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DE7C433E2
	for <linux-pm@archiver.kernel.org>; Mon,  7 Sep 2020 22:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA9D2168B
	for <linux-pm@archiver.kernel.org>; Mon,  7 Sep 2020 22:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgIGW6G (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 7 Sep 2020 18:58:06 -0400
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:56178 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727119AbgIGW6F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2020 18:58:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 9C6AD837F24D;
        Mon,  7 Sep 2020 22:58:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wool49_5e16e12270cf
X-Filterd-Recvd-Size: 1397
Received: from XPS-9350 (cpe-72-134-242-36.natsow.res.rr.com [72.134.242.36])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon,  7 Sep 2020 22:58:01 +0000 (UTC)
Message-ID: <1f22437045f1782f472291a747664fd3bad9d421.camel@perches.com>
Subject: Re: [PATCH 1/4] drivers core: Use sysfs_emit and sysfs_emit_at for
 show(device *...) functions
From:   Joe Perches <joe@perches.com>
To:     kernel test robot <lkp@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date:   Mon, 07 Sep 2020 15:58:00 -0700
In-Reply-To: <202009080519.SXudMmrU%lkp@intel.com>
References: <1fdeef21167fcf96c94255349401d004a18b7243.1599501047.git.joe@perches.com>
         <202009080519.SXudMmrU%lkp@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2020-09-08 at 05:24 +0800, kernel test robot wrote:
> Hi Joe,

Hi robot.

> I love your patch! Yet something to improve:

Nothing really to improve as these are dependent
on a previous patch that this robot did not apply.


