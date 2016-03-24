From: Len Brown <lenb@kernel.org>
Subject: [PATCH 0/2] 2 cpuidle patches for this merge window
Date: Thu, 24 Mar 2016 01:16:00 -0400
Message-ID: <1458796562-19744-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34174 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074AbcCXFQg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 01:16:36 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

[PATCH 1/2] intel_idle: prevent SKL-H boot failure when C8+C9+C10
... fixes a boot hang, and needs to got to .stable

[PATCH 2/2] intel_idle: Support for Intel Xeon Phi Processor x200
... adds new platform support

Please let me know if you see any trouble with them.

thanks,
Len Brown, Intel Open Source Technology Center

