From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Question about runtime pm status issue
Date: Mon, 29 Oct 2012 21:46:04 +0800
Message-ID: <508E889C.6070009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36823 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758795Ab2J2Nrg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Oct 2012 09:47:36 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3439776pad.19
        for <linux-pm@vger.kernel.org>; Mon, 29 Oct 2012 06:47:36 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@vger.kernel.org>

hi Rafael, Alan:
	I recently meet a problem that I enable a usb disk's runtime auto autosuspend,
set power/autosuspend_delay_ms to be 100 and make its usage_count to be 0. But after
a long time, the disk's runtime status always is active. From my view, the
disk's status
should be "suspend" after the usage_count being 0 and delay timeout. If my
opinion was
wrong, please corrent me. Thanks.
-- 
Best regards
Tianyu Lan
