From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 16 Oct 2015 16:03:22 +0000
Message-ID: <bug-103351-137361-75v8ZIHx26@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43597 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932833AbbJPQD0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 12:03:26 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 7CD3F20A86
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 16:03:25 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 5C84520A8E
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 16:03:24 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #78 from Dimman <dimmuxx@yahoo.se> ---
(In reply to kernel@benjam.info from comment #77)
> (In reply to Dimman from comment #76)
> > So HLE and RTM remains for me in 0x13. I ripped the microcode myself from a
> > msi bios file. (E16J1IMS.110.zip)
> 
> Awesome! Can you post the SHA-1 sum of the microcode you ripped, so people
> have an easy way to verify that the microcode I'm providing isn't malicious
> (though an unsigned or modified microcode file would do nothing anyways).

Sure, here you go b55c1f4d5858209b5a607377b83994c59c7fb0f3.

-- 
You are receiving this mail because:
You are the assignee for the bug.
