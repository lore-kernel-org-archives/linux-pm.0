Return-Path: <SRS0=KdAB=73=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3BBC433DF
	for <linux-pm@archiver.kernel.org>; Sun, 14 Jun 2020 02:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB3920789
	for <linux-pm@archiver.kernel.org>; Sun, 14 Jun 2020 02:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgFNCoq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 13 Jun 2020 22:44:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:65316 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgFNCoq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 13 Jun 2020 22:44:46 -0400
IronPort-SDR: lv02LAnizU9/WWWDWtCK+pzTHgNNo3ab9gUdZmN0eYGAVzKNyhRExdqe2BMi3hca93gfDO9zhx
 /Ww7esSobNVg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2020 19:44:45 -0700
IronPort-SDR: hhUf12M7EwiPy0i3rUUaVQrNPQhbBuiU4ngV/zw5TOmSY003nKvn9q0t1goDaggWHeOkm5AxCw
 RD/d5RfgahYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,509,1583222400"; 
   d="scan'208";a="475280183"
Received: from hongmeij-mobl4.ccr.corp.intel.com ([10.255.30.60])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jun 2020 19:44:43 -0700
Message-ID: <779a84cab9e01cbb8cafaea59ead79b26a2573df.camel@intel.com>
Subject: Re: [THERMAL] INT3403 and new 0x91 thermal events in dmesg
From:   Zhang Rui <rui.zhang@intel.com>
To:     Alex Hung <alex.hung@canonical.com>, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date:   Sun, 14 Jun 2020 10:44:42 +0800
In-Reply-To: <ee531821-83f1-2c80-4e2c-b2a359af7583@canonical.com>
References: <ee531821-83f1-2c80-4e2c-b2a359af7583@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2020-06-12 at 15:02 -0600, Alex Hung wrote:
> Hi,
> 
> A user reported int3403 was flooding his dmesg like following
> 
> [ 8.112761] int3403 thermal INT3403:00: Unsupported event [0x91]
> [ 10.121722] int3403 thermal INT3403:00: Unsupported event [0x91]
> [ 12.165233] int3403 thermal INT3403:00: Unsupported event [0x91]
> 
> Buglink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1882823
> 
> In int3403_thermal.c the events are defined up to
> INT3403_THERMAL_EVENT
> (0x90), and thus int3403 complains 0x91 is not supported.
> 
> I did a quick search online and found this is not the only case:
> https://www.spinics.net/lists/ibm-acpi-devel/msg04629.html (though
> the
> 0x91 was unrelated to this problem).
> 
> This is likely a new feature in int3403 but I wasn't able to find any
> specifications or documents. Does anyone know what it is and how this
> can be added to int3403_thermal.c ?
> 
I'm not sure if this is a new feature that we have to support or not,
but before that, we can downgrade the error message just like what we
did in 44c0c23725a1("drivers: thermal: processor_thermal: Downgrade
error message").

thanks,
rui


