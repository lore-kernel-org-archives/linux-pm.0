From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176411] cpufreq/cpuinfo_cur_freq reports <unknown>
Date: Mon, 03 Apr 2017 23:41:42 +0000
Message-ID: <bug-176411-137361-nK6mhluQ83@https.bugzilla.kernel.org/>
References: <bug-176411-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:54146 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751732AbdDCXlo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2017 19:41:44 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id B6FD228488
        for <linux-pm@vger.kernel.org>; Mon,  3 Apr 2017 23:41:43 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 83591284BC
        for <linux-pm@vger.kernel.org>; Mon,  3 Apr 2017 23:41:42 +0000 (UTC)
In-Reply-To: <bug-176411-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176411

Len Brown (lenb@kernel.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lenb@kernel.org

--- Comment #30 from Len Brown (lenb@kernel.org) ---
Mike Lui : 

  - disabled on-board OC'ing
  - disabled intel c-states
  - enabled turbo-boost

    After this the issues in comment #1 are no longer present.

@ Mike Lui
    Can you verify that there is no problem when you use SETUP DEFAULTs?
    or at least return C-states to their default ENABLED setting)

-- 
You are receiving this mail because:
You are the assignee for the bug.
