From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 04 Sep 2015 16:06:08 +0000
Message-ID: <bug-103351-137361-0YEIB5xirJ@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38527 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760099AbbIDQGK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Sep 2015 12:06:10 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id A18B72089D
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2015 16:06:09 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id C9B36207D5
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2015 16:06:08 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #9 from ed <omfdzg@gmail.com> ---
my mistake,till now tested without "processor.max_cstate=0
intel_idle.max_cstate=0 idle=poll" system was unstable on all kernels, now
trying with these boot parameters and system as for now behave stable on 4.2rc8
under heavy load (BOINC)

-- 
You are receiving this mail because:
You are the assignee for the bug.
