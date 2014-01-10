From: Jiri Kosina <jkosina@suse.cz>
Subject: [GIT] APM
Date: Fri, 10 Jan 2014 11:50:08 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1401101148220.9087@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42653 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756032AbaAJKuL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Jan 2014 05:50:11 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Rafael,

please consider pulling

  git://git.kernel.org/pub/scm/linux/kernel/git/jikos/apm.git for-next

into linux-pm.git, to receive:


- addition of hibernation events to apm-emulation, from Bin Shi


Thanks.

Bin Shi (1):
      apm-emulation: add hibernation APM events to support suspend2disk

 drivers/char/apm-emulation.c  |   11 +++++++++--
 include/uapi/linux/apm_bios.h |    2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
Jiri Kosina
SUSE Labs
