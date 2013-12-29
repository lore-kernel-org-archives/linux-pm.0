From: Rodolfo =?utf-8?B?R2FyY8OtYSBQZcOxYXM=?= <kix@kix.es>
Subject: s2both
Date: Sun, 29 Dec 2013 20:10:24 +0100
Message-ID: <20131229191023.GA21560@kix.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kix.es ([46.105.17.89]:37068 "EHLO what.com.es"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752091Ab3L2TSn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 29 Dec 2013 14:18:43 -0500
Received: from kix.es (4.Red-217-127-226.staticIP.rima-tde.net [217.127.226.4])
	by what.com.es (Postfix) with ESMTPSA id AE6066A06B6
	for <linux-pm@vger.kernel.org>; Sun, 29 Dec 2013 20:10:20 +0100 (CET)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

I am working in the suspend-utils tools, but s2both is not working fine. s2both is a tool that saves a resume image (to hibernate) but only suspend the machine. Then, if the power fails while the system is suspended, then the resume image is used. But it doesn't work.

Is possible to include the s2both option inside the kernel (echo both > /sys/power/state)? I was reading the kernel code, and I am not sure with the current functions is possible to suspend to ram and restore from disk (S3 -> S4). What should be the new code for s2both?

If s2both should not included in kernel (but as user space tool) is possible suspend to ram but boot the system and resume from disk with the current kernel code? In this case, what kernel calls should I do?

Thanks,
Rodolfo.
-- 
||// //\\// Rodolfo "kix" Garcia
||\\// //\\ http://www.kix.es/
