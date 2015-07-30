From: Jeremy Eder <jeder@redhat.com>
Subject: turbostat: change to default output
Date: Thu, 30 Jul 2015 14:04:08 -0400
Message-ID: <CABxNGQaAA_sbqp_DfbjFxMFUDwnRVPXqKFOUcxUa18bGSpuicQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:34548 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbG3SEJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 14:04:09 -0400
Received: by ioea135 with SMTP id a135so61724622ioe.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2015 11:04:09 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, lenb@intel.com

Len, commit 1cc21f7b6b747220c29b42cfd1c84b5648d12407
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/tools/power/x86/turbostat/turbostat.c?id=1cc21f7b6b747220c29b42cfd1c84b5648d12407

The commit message mentions "Casual turbostat users generally just
want to know MHz."

Disagree; we don't think there are any casual users of turbostat that
_don't_ care about c-states.

Any chance you can revert this ?  If someone needs a more concise
output, you might offer a --compact flag or so.

Thoughts ?
