From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176411] cpufreq/cpuinfo_cur_freq reports <unknown>
Date: Tue, 11 Oct 2016 23:49:06 +0000
Message-ID: <bug-176411-137361-qASVKFgnfh@https.bugzilla.kernel.org/>
References: <bug-176411-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751146AbcJKXtL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Oct 2016 19:49:11 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id ED77120279
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2016 23:49:09 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id E40FF2034A
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2016 23:49:07 +0000 (UTC)
In-Reply-To: <bug-176411-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176411

--- Comment #19 from Rafael J. Wysocki <rjw@rjwysocki.net> ---
Created attachment 241581
  --> https://bugzilla.kernel.org/attachment.cgi?id=241581&action=edit
WARN if the time argument of the governor hook is 0

Also please apply this patch and see if you see the new warning in dmesg
output.

-- 
You are receiving this mail because:
You are the assignee for the bug.
