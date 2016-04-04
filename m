From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 112621] cpupower reports wrong frequencies
Date: Mon, 04 Apr 2016 23:00:24 +0000
Message-ID: <bug-112621-137361-INAVW3NYG5@https.bugzilla.kernel.org/>
References: <bug-112621-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53752 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbcDDXAa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 Apr 2016 19:00:30 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 57422201F5
	for <linux-pm@vger.kernel.org>; Mon,  4 Apr 2016 23:00:28 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 5D907202D1
	for <linux-pm@vger.kernel.org>; Mon,  4 Apr 2016 23:00:25 +0000 (UTC)
In-Reply-To: <bug-112621-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=112621

Chen Yu <yu.c.chen@intel.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO
           Assignee|linux-pm@vger.kernel.org    |yu.c.chen@intel.com

--- Comment #1 from Chen Yu <yu.c.chen@intel.com> ---
please provide
rdmsr 0xce and your acpidump, thanks

-- 
You are receiving this mail because:
You are the assignee for the bug.
