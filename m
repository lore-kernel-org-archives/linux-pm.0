From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 30 Sep 2015 05:28:52 +0000
Message-ID: <bug-103351-137361-97sYhLuKqs@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46745 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751550AbbI3F25 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 30 Sep 2015 01:28:57 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 41B8D206E0
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2015 05:28:56 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 9E685206FD
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2015 05:28:54 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #24 from saunders.52@wright.edu ---
Installed the UEFI update to my MSI PX60-2QD, which has a 5750HQ. Tested it by
doing a similar "install to a VirtualBox VM" test (with Fedora 23 Beta,
mentioned above to be exceptionally bad for this) which triggered this before.
(Fedora 23 then broke itself during an upgrade, but that wasn't this issue.)

Changelog for the BIOS update says that it upgraded the microcode to 13, so
hopefully that Microcode will be available for loading at boot time sometime
soon.

-- 
You are receiving this mail because:
You are the assignee for the bug.
