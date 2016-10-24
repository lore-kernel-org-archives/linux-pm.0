From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 177761] [Oops] IP: [<ffffffffa017472d>]
 acpi_cpufreq_target+0x5d/0x240 [acpi_cpufreq]
Date: Mon, 24 Oct 2016 23:46:17 +0000
Message-ID: <bug-177761-137361-J908OmUey3@https.bugzilla.kernel.org/>
References: <bug-177761-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:32990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757820AbcJXXqV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Oct 2016 19:46:21 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id DCB9720270
        for <linux-pm@vger.kernel.org>; Mon, 24 Oct 2016 23:46:19 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id 0BF9120260
        for <linux-pm@vger.kernel.org>; Mon, 24 Oct 2016 23:46:18 +0000 (UTC)
In-Reply-To: <bug-177761-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=177761

Len Brown <lenb@kernel.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO

--- Comment #3 from Len Brown <lenb@kernel.org> ---
patch above is in 4.9-rc2, please test that release and let us know if this
issue goes away or is still a problem.

-- 
You are receiving this mail because:
You are the assignee for the bug.
