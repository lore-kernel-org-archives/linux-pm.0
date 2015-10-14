From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 14 Oct 2015 15:23:45 +0000
Message-ID: <bug-103351-137361-hgFdEfrf2s@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51055 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156AbbJNPXu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Oct 2015 11:23:50 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 13E0D20938
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2015 15:23:49 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 1BC802098D
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2015 15:23:48 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

Fredrik Atmer <fredrik+kernel@atmer.se> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |fredrik+kernel@atmer.se

--- Comment #57 from Fredrik Atmer <fredrik+kernel@atmer.se> ---
First, thank you, thank you, thank you =)

I've had my setup i5-5675C on an Asus H97I-Plus motherboard for some time now.
It's not until now that it actually "works". I was afraid something was broken
in my system due to random crashes.

I first tried to install Ubuntu 15.04, but the installer kept crashing. So I
tried 14.04 which worked. Turns out I needed 14.10 for the Intel graphic
drivers. That worked as well. Well, Unity didn't, and I kind of like it.. So
I've been running Metacity since, with the few random crashes. Then I just
realized 14.10 is no more. Then at 3:30 AM I find this thread. I did sleep
first, but the day after I was able to do a dist-upgrade of my 14.10 system to
15.04 using the 0x12 microcode (I used to have 0xd).

This has to be the most haxxor I ever did. Now I'm running Unity without
problems so far in 15.04, Speedstep and Turbo active. I always thought
microcode was something embedded in the processor, not to be accessed from the
outside world.

I'm using the script from the git repository. It works, but the
--persist-debian option fails to make it persistent. I don't know if I'm using
it incorrectly, and I'm happy to provide more information if requested. I also
tried the method with iucode-tool described above, with the same result. The
install.sh script does just that, right?

-- 
You are receiving this mail because:
You are the assignee for the bug.
