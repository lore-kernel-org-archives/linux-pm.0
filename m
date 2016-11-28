From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176411] cpufreq/cpuinfo_cur_freq reports <unknown>
Date: Mon, 28 Nov 2016 17:06:25 +0000
Message-ID: <bug-176411-137361-QO1ZuhZH5z@https.bugzilla.kernel.org/>
References: <bug-176411-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932495AbcK1RG3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Nov 2016 12:06:29 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 5E9002020F
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2016 17:06:27 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id C16C3201B9
        for <linux-pm@vger.kernel.org>; Mon, 28 Nov 2016 17:06:25 +0000 (UTC)
In-Reply-To: <bug-176411-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176411

--- Comment #25 from Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> ---
Please apply patch "WARN if the time argument of the governor hook is 0"
attached in this bugzilla.
During boot add this to kernel command line:
"dyndbg="file intel_pstate.c +p"

and send dmesg log.

-- 
You are receiving this mail because:
You are the assignee for the bug.
