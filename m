From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 173361] Under heavy load, the CPU speed suddenly and
 irreversibly drops from 3500 to 400 MHz
Date: Thu, 29 Sep 2016 19:29:11 +0000
Message-ID: <bug-173361-137361-EgLIOqrUFx@https.bugzilla.kernel.org/>
References: <bug-173361-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754485AbcI2T3O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Sep 2016 15:29:14 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 6A3742038F
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2016 19:29:12 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id 4F73E2035D
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2016 19:29:11 +0000 (UTC)
In-Reply-To: <bug-173361-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=173361

--- Comment #4 from Larry Finger <Larry.Finger@lwfinger.net> ---
Thanks. I'm running the script with the continuing test of 4.7, which has been
running for a little over 30 hours without triggering the event.

-- 
You are receiving this mail because:
You are the assignee for the bug.
