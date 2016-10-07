From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176411] cpufreq/cpuinfo_cur_freq reports <unknown>
Date: Fri, 07 Oct 2016 20:16:37 +0000
Message-ID: <bug-176411-137361-KML1pn74Sm@https.bugzilla.kernel.org/>
References: <bug-176411-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751500AbcJGUQk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 7 Oct 2016 16:16:40 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id EAF51202F0
        for <linux-pm@vger.kernel.org>; Fri,  7 Oct 2016 20:16:38 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id F175E20211
        for <linux-pm@vger.kernel.org>; Fri,  7 Oct 2016 20:16:37 +0000 (UTC)
In-Reply-To: <bug-176411-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176411

--- Comment #8 from Mike Lui <mike.d.lui@gmail.com> ---
# cat /proc/cmdline
initrd=\initramfs-linux.img root=/dev/sda3 rw fbcon=rotate:3

I'm just using the vanilla 4.7 linux kernel from the archlinux [core] repo. For
the 4.8 test, I used the vanilla 4.8 kernel from the archlinux [testing] repo.


Attaching the requested output after this comment

-- 
You are receiving this mail because:
You are the assignee for the bug.
