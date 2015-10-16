From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 16 Oct 2015 10:19:44 +0000
Message-ID: <bug-103351-137361-cq4cXs4U8n@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40094 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034AbbJPKTu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 06:19:50 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 7874E20A24
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 10:19:49 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 295C420A63
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 10:19:47 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #72 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
Well, FWIW, the processor flags (pf) reported are _different_.

So now, we need a bit more data from others, to check if processors with
pf=0x20 ends up with RTM disabled, and pf=0x2 ends up with RTM enabled, or if
there is no such connection.

I'd expect pf=0x20 to be the mobile processors (soldered), and pf=0x2 to be the
desktop processors (socketed), BTW.

The "pf" can be read from either the kernel log (microcode: CPU0 sig=... line),
or from "cat /sys/devices/system/cpu/cpu0/microcode/processor_flags".  It
should be analyzed together with the output of "cat /proc/cpuinfo".

-- 
You are receiving this mail because:
You are the assignee for the bug.
