From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 197153] Wrong cores frequencies values in /proc/cpuinfo
Date: Sat, 07 Oct 2017 15:53:45 +0000
Message-ID: <bug-197153-137361-jqtCZna9gX@https.bugzilla.kernel.org/>
References: <bug-197153-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:54032 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751166AbdJGPxq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Oct 2017 11:53:46 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id F2AF128803
        for <linux-pm@vger.kernel.org>; Sat,  7 Oct 2017 15:53:45 +0000 (UTC)
In-Reply-To: <bug-197153-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=197153

Artem S. Tashkinov (t.artem@mailcity.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lenb@kernel.org

--- Comment #4 from Artem S. Tashkinov (t.artem@mailcity.com) ---
(In reply to Doug Smythies from comment #3)
> Back on bug #197009, I couldn't find the related e-mail thread. Now I did:
> https://marc.info/?t=149766883400002&r=1&w=2

Thanks!

> Users who have been consulting /proc/cpuinfo to
> track changing CPU frequency will be dissapointed that
> it no longer wiggles -- perhaps being unaware of the
> limitations of the information they have been consuming.
> 
> Yes, they can change their scripts to look in sysfs
> cpufreq/scaling_cur_frequency.  Here they will find the same
> data of dubious quality here removed from /proc/cpuinfo.
> The value in sysfs will be addressed in a subsequent patch
> to address issues 1-3, above.
> 
> Issue 4 will remain -- users that really care about
> accurate frequency information should not be using either
> proc or sysfs kernel interfaces.
> They should be using using turbostat(8), or a similar
> purpose-built analysis tool.

That sounds like a dozen of Linux utilities need to be rewritten to either
include the turbostat source (how do you even see that? what about updates to
this code?) or ... Len Brown has some other ideas in mind? Does turbostat work
without insmod()'ing the msr module first? Most distros don't autopreload it.

You break the user space interfaces and don't offer any realistic alternatives
at all. I for one refuse to run turbostat in console just to know what
frequencies my CPU cores are running at.

This is not how it should work.

-- 
You are receiving this mail because:
You are the assignee for the bug.
