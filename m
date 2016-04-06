From: Len Brown <lenb@kernel.org>
Subject: [PATCH 0/7] turbostat updates available for upstream
Date: Wed,  6 Apr 2016 17:15:53 -0400
Message-ID: <1459977360-2841-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36532 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbcDFVQk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:16:40 -0400
Received: by mail-yw0-f196.google.com with SMTP id p65so8580689ywb.3
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 14:16:39 -0700 (PDT)
Received: from z87.localdomain (pool-71-184-142-167.bstnma.fios.verizon.net. [71.184.142.167])
        by smtp.gmail.com with ESMTPSA id d140sm2883320ywb.48.2016.04.06.14.16.38
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Apr 2016 14:16:38 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Couple of bug fixes, and add some model#'s to work properly
on some newer platforms.

These patches:

[PATCH 1/7] tools/power turbostat: SGX state should print only if
[PATCH 2/7] tools/power turbostat: print IRTL MSRs
[PATCH 3/7] tools/power turbostat: initial BXT support
[PATCH 4/7] tools/power turbostat: decode BXT TSC frequency via CPUID
[PATCH 5/7] tools/power turbostat: initial SKX support
[PATCH 6/7] tools/power turbostat: initial KBL support
[PATCH 7/7] tools/power turbostat: work around RC6 counter wrap

are available on this git branch:

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat

Please let me know if you see troubles with any of them.

thanks,
Len Brown, Intel Open Source Technology Center

