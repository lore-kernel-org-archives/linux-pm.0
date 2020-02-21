Return-Path: <SRS0=Ee89=4J=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F45C35646
	for <linux-pm@archiver.kernel.org>; Fri, 21 Feb 2020 17:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CCB222C4
	for <linux-pm@archiver.kernel.org>; Fri, 21 Feb 2020 17:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgBUR3h (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:29:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:34939 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgBUR3g (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Feb 2020 12:29:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2020 09:29:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,469,1574150400"; 
   d="scan'208";a="316112658"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 21 Feb 2020 09:29:36 -0800
Received: from abityuts-desk1.fi.intel.com (abityuts-desk1.fi.intel.com [10.237.68.148])
        by linux.intel.com (Postfix) with ESMTP id 0C6505803FA;
        Fri, 21 Feb 2020 09:29:34 -0800 (PST)
Message-ID: <39fb762880c27da110086741315ca8b111d781cd.camel@gmail.com>
Subject: Not readable 'scaling_governor'
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Linux PM Mailing List <linux-pm@vger.kernel.org>
Cc:     "Rafael J.Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Feb 2020 19:29:33 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

in the latest Linus's kernel this file is not readable:

$ cat /sys/devices/system/cpu/cpu91/cpufreq/scaling_governor 
cat: /sys/devices/system/cpu/cpu91/cpufreq/scaling_governor: Invalid argument

I did not try to bisect, and it must be bug. Known issue?

I checked this commit: ca7e1fd1026c

Thanks,
Artem.

