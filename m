From: vkalia@codeaurora.org
Subject: Usage of notifier callback in devfreq
Date: Fri, 13 Feb 2015 20:41:05 -0000
Message-ID: <afeecb7da6f34951d9ca16fcd72aeb39.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34191 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752618AbbBMUlH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Feb 2015 15:41:07 -0500
Received: from www.codeaurora.org (unknown [198.145.29.65])
	by smtp.codeaurora.org (Postfix) with ESMTP id A15A013FFE2
	for <linux-pm@vger.kernel.org>; Fri, 13 Feb 2015 20:41:05 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi

We want to implement DCVS for video device. Video device interrupts the
driver when the frequency needs to be updated. Since conventional
governors work on polling mechanism we would like to know how we can
implement a governor with event based mechanism. We would like to use the
notifier callback in devfreq for this to wake up the governor at certain
points so it can query the new stats from video driver. Is this the right
approach? If not can you please suggest an alternative. Any examples will
be of great help.

Notifier callback we plan to use is @
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/devfreq/devfreq.c?id=refs/tags/v3.19#n480

Thanks
Vinay

