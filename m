From: Jiri Kosina <jkosina@suse.cz>
Subject: [GIT PULL] APM
Date: Mon, 7 Jul 2014 20:56:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1407071759200.1655@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37986 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412AbaGGS4V (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 7 Jul 2014 14:56:21 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

Rafael,

please pull

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/apm.git for-next

into linux-pm to obtain simple cleanup for APM driver from Jean Delvare. 
Thanks.

----------------------------------------------------------------
Jean Delvare (1):
      x86, apm: Remove unused variable

 arch/x86/kernel/apm_32.c | 1 -
 1 file changed, 1 deletion(-)

-- 
Jiri Kosina
SUSE Labs
