From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Sat, 09 Jan 2016 23:40:17 +0000
Message-ID: <bug-103351-137361-qL96Hr1GZW@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54050 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756279AbcAIXkW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 9 Jan 2016 18:40:22 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 2B664202E9
	for <linux-pm@vger.kernel.org>; Sat,  9 Jan 2016 23:40:21 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 5E24B20340
	for <linux-pm@vger.kernel.org>; Sat,  9 Jan 2016 23:40:20 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

Bluhd <javijose.8@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |javijose.8@gmail.com

--- Comment #106 from Bluhd <javijose.8@gmail.com> ---
Confirmed working for i7-5700HQ.
Thank you all so much!

-- 
You are receiving this mail because:
You are the assignee for the bug.
