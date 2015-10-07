From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 07 Oct 2015 11:40:24 +0000
Message-ID: <bug-103351-137361-ZtiSpBPp01@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48883 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800AbbJGLke (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 07:40:34 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 7944020788
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2015 11:40:28 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 9A35D206DE
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2015 11:40:27 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #38 from Jonas Platte <linux@jonasplatte.de> ---
Created attachment 189601
  --> https://bugzilla.kernel.org/attachment.cgi?id=189601&action=edit
/proc/cpuinfo when booted with microcode update 0x12

Here you go.

-- 
You are receiving this mail because:
You are the assignee for the bug.
