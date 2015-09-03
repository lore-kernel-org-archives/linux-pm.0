From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 03 Sep 2015 22:22:59 +0000
Message-ID: <bug-103351-137361-dFy5jfZW0I@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45923 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755593AbbICWXC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Sep 2015 18:23:02 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C889920810
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2015 22:23:00 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id B84CF20699
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2015 22:22:59 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

saunders.52@wright.edu changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |saunders.52@wright.edu

--- Comment #7 from saunders.52@wright.edu ---
Interestingly, while Fedora 22 isn't subject to this issue for some reason by
and large, I CAN invoke it by running an affected kernel in a virtual machine
and it causes the same crash under the same circumstances of the VM being under
load.

-- 
You are receiving this mail because:
You are the assignee for the bug.
