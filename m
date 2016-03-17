From: Michal Feix <michal@feix.cz>
Subject: intel_idle.max_cstate=1 required on baytrail to prevent crashes
Date: Thu, 17 Mar 2016 08:05:25 +0100
Message-ID: <56EA5735.1060109@feix.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-out3.iol.cz ([194.228.2.91]:43978 "EHLO smtp-out3.iol.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753979AbcCQH01 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Mar 2016 03:26:27 -0400
Received: from port5.iol.cz (port5.iol.cz [192.168.30.95])
	by smtp-out3.iol.cz (Postfix) with ESMTP id B308C38741
	for <linux-pm@vger.kernel.org>; Thu, 17 Mar 2016 08:05:52 +0100 (CET)
Received: from [172.16.0.214] (81-174-51-163.v4.ngi.it [81.174.51.163])
	by smtp.feix.cz (Postfix) with ESMTPSA id E3FC2111004A
	for <linux-pm@vger.kernel.org>; Thu, 17 Mar 2016 08:05:26 +0100 (CET)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello everyone,

for the past few months, I'm fighting random hard lock-ups on my
Baytrail machine with different linux kernels. Freezes are quite
frequent, between few minutes to few hours of uptime. According to other
reporters, this was pinpointed as an intel_idle problem on Baytrail. The
bug report originally started as i915 regression at
https://bugs.freedesktop.org/show_bug.cgi?id=88012 and was moved to
kernel Bugzilla few months ago -
https://bugzilla.kernel.org/show_bug.cgi?id=109051

This bug seems to be a serious showstopper for Baytrail users and was
already confirmed by many, but there is no obvious progress on this bug
report for last few months. Meny reporters have confirmed
intel_idle.max_cstate=1 or intel_idle.max_cstate=2 as a half-working
workaround, which makes the interval between freezes on Baytrail longer.

Could someone here please confirm if this is in or out of anyone's
current focus? I strongly believe this is not a minority issue and maybe
this just slipped through meny other important bug reports.

Thank you,

--
Michael
