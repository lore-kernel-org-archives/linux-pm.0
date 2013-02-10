From: Len Brown <lenb@kernel.org>
Subject: pm_idle cleanup patch series
Date: Sun, 10 Feb 2013 00:58:07 -0500
Message-ID: <1360475903-30007-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169]:54820 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab3BJF6a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 10 Feb 2013 00:58:30 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Use of (pm_idle)() spread from x86 to a number of architectures.
Some used it like x86, but most copied it for no functional reason.

There is no Linux architecture-independent code that mandates
that an architecture supply a pm_idle().
So we delete it from pm.h and we either remove it
or re-name it to be private to each architecture.

It is a safe bet that I fat-fingered something in this series.
Please send me an Ack if you can build/test or I broke
your favorite machine.

In particular, for those with computer museums,
I'd like help testing the APM patch, which is
compile-tested only.

thanks,
Len Brown, Intel Open Source Technology Center


