From: Len Brown <lenb@kernel.org>
Subject: [GIT PULL] cpuidle patches for merge
Date: Thu, 24 Mar 2016 01:23:04 -0400
Message-ID: <CAJvTdKkCFLxRhSgyZRriq=kP8enWnXS7FH6HORw-cc5tK_yJqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36759 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbcCXFXH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 01:23:07 -0400
Received: by mail-lf0-f48.google.com with SMTP id d82so26442250lfe.3
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2016 22:23:05 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rafael@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>

Hi Rafael,

Please pull these two cpuidle patches

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc:

  Linux 4.4 (2016-01-10 15:01:32 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git cpuidle

for you to fetch changes up to 281baf7a702693deaa45c98ef0c5161006b48257:

  intel_idle: Support for Intel Xeon Phi Processor x200 Product Family
(2016-03-23 16:19:38 -0400)

----------------------------------------------------------------
Dasaratharaman Chandramouli (1):
      intel_idle: Support for Intel Xeon Phi Processor x200 Product Family

Len Brown (1):
      intel_idle: prevent SKL-H boot failure when C8+C9+C10 enabled

 drivers/idle/intel_idle.c | 133 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 111 insertions(+), 22 deletions(-)
