From: Len Brown <lenb@kernel.org>
Subject: turbostat patches for 4.3
Date: Thu, 12 Nov 2015 02:42:28 -0500
Message-ID: <1447314152-2145-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:34764 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbbKLHnJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Nov 2015 02:43:09 -0500
Received: by ykfs79 with SMTP id s79so86467391ykf.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2015 23:43:08 -0800 (PST)
Received: from z87.localdomain (pool-173-48-62-196.bstnma.fios.verizon.net. [173.48.62.196])
        by smtp.gmail.com with ESMTPSA id 20sm14629593ywe.49.2015.11.11.23.43.04
        for <linux-pm@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2015 23:43:07 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello Rafael,

Please pick up this small batch of turbostat patches.
As usual, they are available on my turbostat branch.

thanks!
-Len

[PATCH 1/4] tools/power turbostat: simplify Bzy_MHz calculation
[PATCH 2/4] tools/power turbostat: bugfix: print MAX_NON_TURBO_RATIO
[PATCH 3/4] tools/power turbostat: use new name for MSR_PLATFORM_INFO
[PATCH 4/4] x86: remove unused definition of MSR_NHM_PLATFORM_INFO
