From: Len Brown <lenb@kernel.org>
Subject: Two x86 idle cleanups
Date: Sun, 10 Feb 2013 03:10:27 -0500
Message-ID: <1360483829-16349-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f43.google.com ([209.85.212.43]:61139 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240Ab3BJIKl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 Feb 2013 03:10:41 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

The following two patches remove cruft from the x86 native idle code.
These two removals have been marked with a WARN() since Linux 3.0.

Let me know if you see any troubles w/ these patches.

TIP,
These will conflict with another patch in my tree.
So if you approve, please Ack and I can carry in my tree.

thanks,
Len Brown, Intel Open Source Technology Center

