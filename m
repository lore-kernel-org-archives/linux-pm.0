From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 01 Oct 2015 17:04:28 +0000
Message-ID: <bug-103351-137361-5WCX6BohAc@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45798 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbbJAREe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 1 Oct 2015 13:04:34 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 5405320709
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2015 17:04:32 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 06FCD2077A
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2015 17:04:30 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #30 from Jonas Platte <linux@jonasplatte.de> ---
Well, apparently that binary blob does contain microcode for other processors.
One of the microcode files on GitHub seems to have been applied successfully on
my i7-5775C and updated the microcode from 0xd to 0x12.

I haven't yet tested it thoroughly, but I have a package building since a few
minutes now that always crashed it very quickly before. Seems to work! :)

-- 
You are receiving this mail because:
You are the assignee for the bug.
