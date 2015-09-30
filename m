From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 30 Sep 2015 16:52:27 +0000
Message-ID: <bug-103351-137361-Dm7f70wPhh@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43808 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673AbbI3Qwc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 30 Sep 2015 12:52:32 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 94E1120668
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2015 16:52:31 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id AB4B4206DC
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2015 16:52:29 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #27 from kernel@benjam.info <kernel@benjam.info> ---
(In reply to matthew.dewitt from comment #26)
> Created attachment 189091 [details]
> attachment-9832-0.html
> 
> Can someone post a link to clear instructions on the microcode update with
> 5700HQ, so folks who haven't done this before can get it resolved? Thanks!

1. Check what microcode version you have by running `grep microcode
/proc/cpuinfo`
2. Extract the tarfile.
3. Install iucode-tool.
4. For each .bin file that was in the tarfile, run iucode-tool over it. For
example, `sudo iucode-tool 2494656.bin`. You can pass multiple files at once to
iucode-tool, so you could alternatively just run something like `sudo
iucode-tool *.bin`
5. Check if your version of the microcode has changed with `grep microcode
/proc/cpuinfo`
6. If your version of the microcode changed, then hopefully your issue is
fixed. Make sure to re-run step 4 every time after you reboot, until your
distribution's intel-microcode package is updated, or until you get a UEFI
update.

-- 
You are receiving this mail because:
You are the assignee for the bug.
