From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 09 Oct 2015 01:18:24 +0000
Message-ID: <bug-103351-137361-i2or6WKkmU@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33091 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755192AbbJIBS3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 8 Oct 2015 21:18:29 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 3EC1B207E2
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2015 01:18:28 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id DC70E2082C
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2015 01:18:26 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #53 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---

Broadwell-H i7-5700HQ has CPU signature 0x40671...

http://www.intel.com/content/www/us/en/processors/core/desktop-mobile-5th-gen-core-family-spec-update.html

And it looks like that's the CPU signature of the i5/7 5x75C/R as well.

-- 
You are receiving this mail because:
You are the assignee for the bug.
