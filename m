From: Len Brown <lenb@kernel.org>
Subject: [PATCH 0/16] turbostat updates
Date: Sat, 27 Feb 2016 04:00:54 -0500
Message-ID: <1456563670-23282-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35942 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbcB0JBp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 04:01:45 -0500
Received: by mail-yw0-f194.google.com with SMTP id h80so5308154ywc.3
        for <linux-pm@vger.kernel.org>; Sat, 27 Feb 2016 01:01:45 -0800 (PST)
Received: from z87.localdomain (pool-71-184-142-167.bstnma.fios.verizon.net. [71.184.142.167])
        by smtp.gmail.com with ESMTPSA id w82sm13081427ywd.13.2016.02.27.01.01.43
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Feb 2016 01:01:43 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

This patch series makes turbostat useful on Xeon x200 machines,
where it previously displayed erroneous results.

This series also adds some features, as requested by users.

Let me know if you see any troubles with it.

This series is also available directly via git:

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbosat

thanks,
-Len Brown, Intel Open Source Technology Center

