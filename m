From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176411] cpufreq/cpuinfo_cur_freq reports <unknown>
Date: Fri, 07 Oct 2016 20:17:48 +0000
Message-ID: <bug-176411-137361-Lx1iiJgl8F@https.bugzilla.kernel.org/>
References: <bug-176411-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753254AbcJGURv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Oct 2016 16:17:51 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id B3FDA203B8
        for <linux-pm@vger.kernel.org>; Fri,  7 Oct 2016 20:17:49 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id BAC3F20211
        for <linux-pm@vger.kernel.org>; Fri,  7 Oct 2016 20:17:48 +0000 (UTC)
In-Reply-To: <bug-176411-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176411

--- Comment #9 from Mike Lui <mike.d.lui@gmail.com> ---
Created attachment 241141
  --> https://bugzilla.kernel.org/attachment.cgi?id=241141&action=edit
turbostat --debug --msr=0x199

-- 
You are receiving this mail because:
You are the assignee for the bug.
