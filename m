From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 177171] Reduced frequency window for conservative governor
Date: Mon, 10 Oct 2016 17:40:41 +0000
Message-ID: <bug-177171-137361-mzpM45AqBN@https.bugzilla.kernel.org/>
References: <bug-177171-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752870AbcJJRlK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Oct 2016 13:41:10 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 0FDE820259
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2016 17:40:43 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id 0CCD720254
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2016 17:40:42 +0000 (UTC)
In-Reply-To: <bug-177171-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=177171

--- Comment #2 from Aleksey Rybalkin <aleksey@rybalkin.org> ---
Also,
git revert d352cf47d93e39494b44b792cca8d35a3a0bd9b3
appears to fix the problem on 4.8.1. So it is definitely this commit.

-- 
You are receiving this mail because:
You are the assignee for the bug.
