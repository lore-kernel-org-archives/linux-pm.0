From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 177171] Reduced frequency window for conservative governor
Date: Wed, 12 Oct 2016 06:50:37 +0000
Message-ID: <bug-177171-137361-nOPL91uE3y@https.bugzilla.kernel.org/>
References: <bug-177171-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752132AbcJLGul (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Oct 2016 02:50:41 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 615CB20390
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2016 06:50:39 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id 1E68820389
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2016 06:50:38 +0000 (UTC)
In-Reply-To: <bug-177171-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=177171

--- Comment #7 from Aleksey Rybalkin <aleksey@rybalkin.org> ---
Yes, the patch fixes the issue. The frequencies are selected as expected.

-- 
You are receiving this mail because:
You are the assignee for the bug.
