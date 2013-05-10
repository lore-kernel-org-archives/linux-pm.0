From: Len Brown <lenb@kernel.org>
Subject: [GIT PULL] idle patches for Linux-3.10 merge
Date: Fri, 10 May 2013 16:41:24 -0400
Message-ID: <518D5B74.6050500@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:49300 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276Ab3EJUl1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2013 16:41:27 -0400
Received: by mail-vc0-f176.google.com with SMTP id ib11so3987578vcb.21
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2013 13:41:26 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>

Hi Linus,

Please pull these patches to add support for new Haswell-ULT CPU idle power states.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 149c2319c6316d979de90ce2c8665e9c02d5927b:

  tools/power turbostat: additional Haswell CPU-id (2013-03-15 11:05:26 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git release

for you to fetch changes up to 86239ceb33b0d8480b0f0ca0eec08e7f7a807374:

  intel_idle: initial C8, C9, C10 support (2013-04-17 19:23:32 -0400)

----------------------------------------------------------------
Kristen Carlson Accardi (1):
      tools/power turbostat: display C8, C9, C10 residency

Len Brown (1):
      intel_idle: initial C8, C9, C10 support

 arch/x86/include/uapi/asm/msr-index.h |  3 ++
 drivers/idle/intel_idle.c             | 21 ++++++++++++++
 include/linux/cpuidle.h               |  2 +-
 tools/power/x86/turbostat/turbostat.c | 54 ++++++++++++++++++++++++++++++++++-
 4 files changed, 78 insertions(+), 2 deletions(-)
