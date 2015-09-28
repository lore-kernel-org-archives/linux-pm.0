From: Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH] thermal: avoid division by zero in power allocator
Date: Mon, 28 Sep 2015 23:28:33 +0200
Message-ID: <1443475714-19871-1-git-send-email-aarcange@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37431 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855AbbI1V2h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Sep 2015 17:28:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>

Hello,

This is needed for my workstations or they Oops at boot since
v4.3-rc3.

Andrea Arcangeli (1):
  thermal: avoid division by zero in power allocator

 drivers/thermal/power_allocator.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

Thanks,
Andrea
