From: Jisheng Zhang <jszhang@marvell.com>
Subject: How to remove warn msg "cache: parent cpui should not be sleeping"
 i=1, 2, 3...
Date: Wed, 21 Dec 2016 19:37:03 +0800
Message-ID: <20161221193703.6eac880c@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:52431 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750745AbcLULl4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Dec 2016 06:41:56 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>

Hi all,

I'm not sure this is a bug, when wake up from s2ram, I could get something
like:

[  313.271464] Enabling non-boot CPUs ...
[  313.271551] CPU1: Booted secondary processor
[  313.271556] Detected VIPT I-cache on CPU1
[  313.301378]  cache: parent cpu1 should not be sleeping
[  313.301504] CPU1 is up
[  313.301582] CPU2: Booted secondary processor
[  313.301585] Detected VIPT I-cache on CPU2
[  313.331485]  cache: parent cpu2 should not be sleeping
[  313.331605] CPU2 is up
[  313.331683] CPU3: Booted secondary processor
[  313.331686] Detected VIPT I-cache on CPU3
[  313.361599]  cache: parent cpu3 should not be sleeping
[  313.361719] CPU3 is up

This is because we call cpu_device_create() when secondary cpu is brought
online, the cpu_cache device's parent device: cpu device isn't already
resumed, all device resume will resume after secondary cores are brought
up.

What's the elegant solution to remove this warning msg?

Thanks in advance,
Jisheng
