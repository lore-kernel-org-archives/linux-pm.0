From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 177171] Reduced frequency window for conservative governor
Date: Tue, 11 Oct 2016 21:22:27 +0000
Message-ID: <bug-177171-137361-8XdEuZScFp@https.bugzilla.kernel.org/>
References: <bug-177171-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752739AbcJKVWb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Oct 2016 17:22:31 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 6C7A1202EC
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2016 21:22:29 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id 247A0201FE
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2016 21:22:28 +0000 (UTC)
In-Reply-To: <bug-177171-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=177171

--- Comment #5 from Rafael J. Wysocki <rjw@rjwysocki.net> ---
Created attachment 241561
  --> https://bugzilla.kernel.org/attachment.cgi?id=241561&action=edit
cpufreq: conservative: Fix next frequency selection

Does this patch make any difference?

-- 
You are receiving this mail because:
You are the assignee for the bug.
