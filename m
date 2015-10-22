From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 22 Oct 2015 11:32:55 +0000
Message-ID: <bug-103351-137361-iblWK3Wtcs@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48868 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757168AbbJVLdE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 22 Oct 2015 07:33:04 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 19A0F20831
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2015 11:33:02 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id BF9F72096D
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2015 11:32:58 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #91 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
Matthew,

You need to load the early initramfs *and* a standard initramfs.  If Lilo can
only handle one, append the standard initramfs to the early initramfs (i.e. the
early initramfs must come first), and tell LILO to load the result.

It doesn't work without an initramfs.  You also need all initramfs support
enabled in the kernel, of course.

-- 
You are receiving this mail because:
You are the assignee for the bug.
