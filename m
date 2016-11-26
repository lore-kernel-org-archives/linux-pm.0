From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176411] cpufreq/cpuinfo_cur_freq reports <unknown>
Date: Sat, 26 Nov 2016 13:34:01 +0000
Message-ID: <bug-176411-137361-agznAS5slN@https.bugzilla.kernel.org/>
References: <bug-176411-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbcKZNeH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 26 Nov 2016 08:34:07 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 5D90120379
        for <linux-pm@vger.kernel.org>; Sat, 26 Nov 2016 13:34:05 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id 06424203A0
        for <linux-pm@vger.kernel.org>; Sat, 26 Nov 2016 13:34:02 +0000 (UTC)
In-Reply-To: <bug-176411-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176411

--- Comment #24 from Dominik Gronkiewicz <gronki@gmail.com> ---
(In reply to Dominik Gronkiewicz from comment #23)
> I can reproduce it on my machine running Fedora 24.
> 
> model name	: Intel(R) Core(TM) i7-5930K CPU @ 3.50GHz
> model		: 63
> 
> Kernel 4.8.8-200.fc24.x86_64
> 
> I also noticed that machine has slowed down significantly.
> 
> If there's any help I can provide to debug this, please let me know. I use
> this machine for computing so CPU time is essential for me to benchmark my
> code.

Sorry for posting two comments in a row. Disabling C-states in MSI BIOS indeed
brings back full functionality and performance of the CPU. Still, if there's
any way I can help in debugging, please let me know.

-- 
You are receiving this mail because:
You are the assignee for the bug.