From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Mon, 28 Sep 2015 14:58:37 +0000
Message-ID: <bug-103351-137361-295KgggJ4T@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35767 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933483AbbI1O6l (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Sep 2015 10:58:41 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 0479A20741
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2015 14:58:40 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id DD8AC20755
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2015 14:58:38 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

Crashbit <crashbit@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |crashbit@gmail.com

--- Comment #15 from Crashbit <crashbit@gmail.com> ---
I have similar problems with i5 5675C. I ran Windows without any problem. I use
Intel Diagnostics Software and CPU is ok.

First, I have random blocks with Ubuntu 14.04 and 15.10 liveusb.
Finally I can install Ubuntu 15.10 server.

System works well without stress. When I install the desktop it appears random
freezes and MCE errors.

mcelog only show Family 6 Model 47 CPU: Only decoding architectural errors

I have been using at restricted drivers Intel microcode firmware on Ubuntu
15.10 daily update, with kernel 4.2.0-11-generic.

My motherboard is Asus H97-Pro Gamer.

I try to dissable Intel StepSpeed, C-States, and Turbo Mode and have random
freezes

-- 
You are receiving this mail because:
You are the assignee for the bug.
