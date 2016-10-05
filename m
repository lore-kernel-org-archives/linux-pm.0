From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176411] cpufreq/cpuinfo_cur_freq reports <unknown>
Date: Wed, 05 Oct 2016 22:37:45 +0000
Message-ID: <bug-176411-137361-JNFWwyUlDd@https.bugzilla.kernel.org/>
References: <bug-176411-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941987AbcJEWhr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Oct 2016 18:37:47 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 34DFA20220
        for <linux-pm@vger.kernel.org>; Wed,  5 Oct 2016 22:37:46 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id 4000D201CE
        for <linux-pm@vger.kernel.org>; Wed,  5 Oct 2016 22:37:45 +0000 (UTC)
In-Reply-To: <bug-176411-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176411

--- Comment #3 from Mike Lui <mike.d.lui@gmail.com> ---
4.8 has the same results/symptoms.

# cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver

intel_pstate
intel_pstate
intel_pstate
intel_pstate
intel_pstate
intel_pstate
intel_pstate
intel_pstate
intel_pstate
intel_pstate
intel_pstate
intel_pstate

-- 
You are receiving this mail because:
You are the assignee for the bug.
