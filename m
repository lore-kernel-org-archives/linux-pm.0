From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 120561] powernow_k8 causes kernel panic during block device
 write access
Date: Mon, 20 Jun 2016 03:35:11 +0000
Message-ID: <bug-120561-137361-jdwyZvbSgH@https.bugzilla.kernel.org/>
References: <bug-120561-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41552 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513AbcFTDpJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 19 Jun 2016 23:45:09 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id E8877200ED
	for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2016 03:35:13 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 4BB4E20125
	for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2016 03:35:11 +0000 (UTC)
In-Reply-To: <bug-120561-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=120561

Zhang Rui <rui.zhang@intel.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rui.zhang@intel.com
          Component|Other                       |cpufreq
           Hardware|Intel                       |x86-64
           Assignee|rjw@rjwysocki.net           |linux-pm@vger.kernel.org

-- 
You are receiving this mail because:
You are the assignee for the bug.
