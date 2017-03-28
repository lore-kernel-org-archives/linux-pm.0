From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] schedutil governor causes audio problem in game
Date: Tue, 28 Mar 2017 22:54:27 +0000
Message-ID: <bug-194963-137361-styNCutSpD@https.bugzilla.kernel.org/>
References: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:37834 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752735AbdC1Wyb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Mar 2017 18:54:31 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 63055283F3
        for <linux-pm@vger.kernel.org>; Tue, 28 Mar 2017 22:54:30 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 521BC28458
        for <linux-pm@vger.kernel.org>; Tue, 28 Mar 2017 22:54:28 +0000 (UTC)
In-Reply-To: <bug-194963-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

--- Comment #11 from Rafael J. Wysocki (rjw@rjwysocki.net) ---
Created attachment 255621
  --> https://bugzilla.kernel.org/attachment.cgi?id=255621&action=edit
cpufreq: schedutil: Ramp down frequencies slower

One more patch for the schedutil governor to test.

It should make it ramp up frequency faster, so maybe it will help. :-)

-- 
You are receiving this mail because:
You are the assignee for the bug.
