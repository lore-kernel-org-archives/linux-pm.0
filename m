From: Len Brown <lenb@kernel.org>
Subject: [PATCH 0/13] intel_idle patches ready for upstream
Date: Wed,  6 Apr 2016 17:00:46 -0400
Message-ID: <1459976459-2532-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36321 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbcDFVBd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:01:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Bug fixes, plus add a few more table entires for new model #'s.

Some of the BXT table entries will be replaced by values read
from processor configuration registers at boot-time.

Let me know if you see troubles with any of these patches.

They are all available on this git branch:

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git cpuidle

thanks,
-Len Brown, Intel Open Source Technology Center

