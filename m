From: Len Brown <lenb@kernel.org>
Subject: intel_idle and turbostat patches for Linux-4.3
Date: Sat, 26 Sep 2015 01:05:11 -0400
Message-ID: <1443243915-6696-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34989 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbbIZFFx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 26 Sep 2015 01:05:53 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi Rafael,

The following patches are available on my "intel_idle"
and "turbostat" branches, as usual, plus here for review.

[PATCH 1/4] intel_idle: Skylake Client Support - updated

	Initial SKL intel_idle support went into 4.3-rc1.
	That patch works, but this patch makes it more optimal,
	under some conditions.

[PATCH 2/4] tools/power turbostat: IVB Xeon: fix --debug regression

	This is a regression fix for a 4.1-rc1 patch
	It was rude for turbostat to start failing on IVB-Xeon boxes.

[PATCH 3/4] tools/power turbostat: KNL workaround for %Busy and

	This works around a newly documented hardware quirk.

[PATCH 4/4] tools/power turbostat: SKL: Adjust for TSC difference

	This works around an accuracy error that initially
	looked insignificant, but on some configurations it will
	be big enough to be noticed and confuse users, so here
	we address it fully.

Thanks,
Len Brown, Intel Open Source Technology Center

