From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 01 Oct 2015 23:36:58 +0000
Message-ID: <bug-103351-137361-jIK3cJ61AX@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39104 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750781AbbJAXhD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 1 Oct 2015 19:37:03 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 2053A20810
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2015 23:37:02 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id C9B3B207EE
	for <linux-pm@vger.kernel.org>; Thu,  1 Oct 2015 23:37:00 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #36 from kernel@benjam.info <kernel@benjam.info> ---
I added experimental persistence support on Debian-based systems (using
initramfs-tools) to the install script:
https://github.com/bgw/bdw-ucode-update-tool#install-instructions

I welcome pull requests for other distributions.

-- 
You are receiving this mail because:
You are the assignee for the bug.
