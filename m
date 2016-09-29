From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 173361] Under heavy load, the CPU speed suddenly and
 irreversibly drops from 3500 to 400 MHz
Date: Thu, 29 Sep 2016 17:18:02 +0000
Message-ID: <bug-173361-137361-Wm02jDJtFx@https.bugzilla.kernel.org/>
References: <bug-173361-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934253AbcI2RSG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Sep 2016 13:18:06 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id DAF8C20211
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2016 17:18:03 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id C3E4A20398
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2016 17:18:02 +0000 (UTC)
In-Reply-To: <bug-173361-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=173361

--- Comment #2 from Larry Finger <Larry.Finger@lwfinger.net> ---
I have not measured the drop in temperature with change in load, but I know it
happens very quickly, and that the fan speed is very sensitive to the load.
Even when running 4 infinite loops, sending a E-mail with Thunderbird will
decrease the CPU utilization enough that the fan will momentarily slow.

-- 
You are receiving this mail because:
You are the assignee for the bug.
