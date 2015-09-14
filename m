From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Mon, 14 Sep 2015 00:32:37 +0000
Message-ID: <bug-103351-137361-VWvQZKEy5Q@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47384 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143AbbINAcl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 13 Sep 2015 20:32:41 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 8A02320663
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2015 00:32:40 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 0320A20653
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2015 00:32:39 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

Jonas Platte <linux@jonasplatte.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |linux@jonasplatte.de

--- Comment #11 from Jonas Platte <linux@jonasplatte.de> ---
Can reproduce with i7-5775C as well. Adding cpufreq.governor=performance to the
kernel command line makes the system more stable, but doesn't completely make
the problem go away.

I was also able to freeze Fedora 22, not with VM, but with chrooting into my
arch system and running the configure script for glade (which is one of the
things that reliably freezes my arch install) from there. Running the same
script with the Fedora autotools and whatever is called by them doesn't freeze
the system.

FWIW, me and a few other people affected by this were discussing this are also
discussing thing on the arch linux forums
(https://bbs.archlinux.org/viewtopic.php?id=201194), and the best guess so far
has been that this is caused by some exotic CPU instruction used by a core
library like glibc, which is disabled in the Fedora build of that library.

-- 
You are receiving this mail because:
You are the assignee for the bug.
