From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] schedutil governor causes audio problem in game
Date: Fri, 24 Mar 2017 15:17:28 +0000
Message-ID: <bug-194963-137361-7RjhcEm97Y@https.bugzilla.kernel.org/>
References: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:45824 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934613AbdCXPRl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2017 11:17:41 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id F2FBC26E56
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2017 15:17:29 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C2A4126E56
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2017 15:17:29 +0000 (UTC)
In-Reply-To: <bug-194963-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

Rafael J. Wysocki (rjw@rjwysocki.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|ASSIGNED                    |NEEDINFO

--- Comment #9 from Rafael J. Wysocki (rjw@rjwysocki.net) ---
I would use intel_pstate "powersave" (with the patch you have tested applied).

One more question, though.

I guess that you used "schedutil" with acpi-cpufreq as a scaling_driver?

If that's correct, can you please also try to run intel_pstate in the passive
mode (that is, pass "intel_pstate=passive" to the kernel command line) and use
"schedutil" with that (scaling_driver will show "intel_cpufreq" in that
configuration)?

With acpi-cpufreq "schedutil" may under-provision things due to the way in
which turbo P-states are represented in the ACPI tables.

-- 
You are receiving this mail because:
You are the assignee for the bug.
