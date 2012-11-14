From: Len Brown <lenb@kernel.org>
Subject: turbostat tool update for Linux-3.8
Date: Wed, 14 Nov 2012 15:43:17 -0500
Message-ID: <1352925804-6746-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:54671 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab2KNUnc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Nov 2012 15:43:32 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Here are some turbostat patches I have staged.
The 1st two I've requested be pulled into 3.7,
the rest are for 3.8

The final patch allows turbostat to print Watts
as measured by hardware RAPL counters -- something
that people have been asking for.

Please let me know if you see troubles with any of these patches.

thanks,
Len Brown, Intel Open Source Technology Center

