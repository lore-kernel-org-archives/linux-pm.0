From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 23 Oct 2015 12:35:11 +0000
Message-ID: <bug-103351-137361-AHRCliDiZF@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52824 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbbJWMfQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 23 Oct 2015 08:35:16 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 75155209C6
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2015 12:35:15 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 3EAA8209C7
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2015 12:35:14 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #94 from Carlos Alberto Lopez Perez <clopez@igalia.com> ---
I was having crashes with the NVIDIA propietary driver.
After applying a patched glibc that disabled TSX on libpthread
<https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=800574> the crashes are
gone.

However, TSX is still reported as available on the CPU as previous comment

-- 
You are receiving this mail because:
You are the assignee for the bug.
