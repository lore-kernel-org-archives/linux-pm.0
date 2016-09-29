From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 173361] Under heavy load, the CPU speed suddenly and
 irreversibly drops from 3500 to 400 MHz
Date: Thu, 29 Sep 2016 18:28:04 +0000
Message-ID: <bug-173361-137361-RbdcSor3ZC@https.bugzilla.kernel.org/>
References: <bug-173361-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751670AbcI2S2J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Sep 2016 14:28:09 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 293242038F
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2016 18:28:06 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id 29C4C201B9
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2016 18:28:05 +0000 (UTC)
In-Reply-To: <bug-173361-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=173361

--- Comment #3 from Doug Smythies <dsmythies@telus.net> ---
Created attachment 240221
  --> https://bugzilla.kernel.org/attachment.cgi?id=240221&action=edit
Script to continuously monitor package temperature

I guess the point is that one can not come after the event trigger and obtain
anything close to related temperatures. Perhaps the attached script could be
used to monitor package temperature from well before to well after the event.

-- 
You are receiving this mail because:
You are the assignee for the bug.
