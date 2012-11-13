From: Len Brown <lenb@kernel.org>
Subject: [GIT] power tools patches for Linux 3.7-rc5
Date: Tue, 13 Nov 2012 12:43:11 -0500
Message-ID: <50A286AF.2000505@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:49026 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519Ab2KMRnR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Nov 2012 12:43:17 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Linus,

Please pull this pair of power tools patches --
a 3.7 regression fix plus a bug fix.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit bc909421a9c7083fcde795846d22b36a51a7be54:

  Merge tag 'gpio-fixes-v3.7-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio (2012-10-30 15:56:22 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git release

for you to fetch changes up to d91bb17c2a874493603c4d99db305d8caf2d180c:

  tools/power turbostat: graceful fail on garbage input (2012-11-01 00:22:00 -0400)

----------------------------------------------------------------
Len Brown (2):
      tools/power turbostat: Repair Segmentation fault when using -i option
      tools/power turbostat: graceful fail on garbage input

 tools/power/x86/turbostat/turbostat.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)
