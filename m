From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 177761] [Oops] IP: [<ffffffffa017472d>]
 acpi_cpufreq_target+0x5d/0x240 [acpi_cpufreq]
Date: Wed, 26 Oct 2016 03:16:54 +0000
Message-ID: <bug-177761-137361-J9DxdDj0SL@https.bugzilla.kernel.org/>
References: <bug-177761-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751485AbcJZDQ6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Oct 2016 23:16:58 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 3080C20380
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2016 03:16:56 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id 4AC9D20377
        for <linux-pm@vger.kernel.org>; Wed, 26 Oct 2016 03:16:55 +0000 (UTC)
In-Reply-To: <bug-177761-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=177761

JianhongYin <yin-jianhong@163.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |VERIFIED
         Resolution|---                         |CODE_FIX

--- Comment #5 from JianhongYin <yin-jianhong@163.com> ---
(In reply to Len Brown from comment #3)
> patch above is in 4.9-rc2, please test that release and let us know if this
> issue goes away or is still a problem.

yes the issue gone on 4.9-rc2.

-- 
You are receiving this mail because:
You are the assignee for the bug.
