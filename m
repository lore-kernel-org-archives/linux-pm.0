From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] schedutil governor causes audio problem in game
Date: Wed, 29 Mar 2017 20:28:40 +0000
Message-ID: <bug-194963-137361-XNJbCLZ3Cu@https.bugzilla.kernel.org/>
References: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:44968 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753724AbdC2U2o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 16:28:44 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 0A24C28546
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2017 20:28:43 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 5F97128546
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2017 20:28:41 +0000 (UTC)
In-Reply-To: <bug-194963-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

--- Comment #15 from Rafael J. Wysocki (rjw@rjwysocki.net) ---
Just to be sure that nothing escapes us, can you please test the patch on top
of the linux-next branch *and* with intel_pstate in the passive mode
(intel_pstate=passive) instead of acpi-cpufreq?

-- 
You are receiving this mail because:
You are the assignee for the bug.
