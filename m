From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 197009] /proc/cpuinfo does not update frequency
Date: Thu, 02 Nov 2017 01:44:04 +0000
Message-ID: <bug-197009-137361-gMiReKkpW1@https.bugzilla.kernel.org/>
References: <bug-197009-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:42714 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933083AbdKBBoG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Nov 2017 21:44:06 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id A650528C80
        for <linux-pm@vger.kernel.org>; Thu,  2 Nov 2017 01:44:05 +0000 (UTC)
In-Reply-To: <bug-197009-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=197009

Rob Thomas (xrobau@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |xrobau@gmail.com

--- Comment #6 from Rob Thomas (xrobau@gmail.com) ---
This appears to be a regression, and Linus has made it reasonably clear that
he's unhappy with regressions - 
http://lkml.iu.edu/hypermail/linux/kernel/1710.3/02474.html is a recent
example.

This breaks a bunch of userspace stuff that is relying on /proc/cpuinfo to
provide an accurate, or even SLIGHTLY accurate, representation of the current
CPU speed.

Can this be readdressed?

-- 
You are receiving this mail because:
You are the assignee for the bug.
