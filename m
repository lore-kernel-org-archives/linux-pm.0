From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 177761] [Oops] IP: [<ffffffffa017472d>]
 acpi_cpufreq_target+0x5d/0x240 [acpi_cpufreq]
Date: Mon, 17 Oct 2016 23:36:43 +0000
Message-ID: <bug-177761-137361-UeyRd36K1p@https.bugzilla.kernel.org/>
References: <bug-177761-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934325AbcJQXgs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Oct 2016 19:36:48 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 5E931202EC
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2016 23:36:46 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id 3501220219
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2016 23:36:44 +0000 (UTC)
In-Reply-To: <bug-177761-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=177761

Rafael J. Wysocki <rjw@rjwysocki.net> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rjw@rjwysocki.net
          Component|Power-Processor             |cpufreq
           Assignee|acpi_power-processor@kernel |linux-pm@vger.kernel.org
                   |-bugs.osdl.org              |
            Product|ACPI                        |Power Management

-- 
You are receiving this mail because:
You are the assignee for the bug.
