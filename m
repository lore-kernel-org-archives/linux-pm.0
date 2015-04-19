From: Len Brown <lenb@kernel.org>
Subject: [PATCH 0/1] speeding up cpu_up()
Date: Sat, 18 Apr 2015 20:53:14 -0400
Message-ID: <1429404795-23260-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34797 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbbDSAx2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Apr 2015 20:53:28 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The following patch...

[PATCH 1/1] x86: replace cpu_up hard-coded mdelay with variable

enables reducing cpu_up() time by 10ms on modern systems.

This means that for every processor in the system,
boot-time and resume-time can be reduced by 10ms per-processor.

Once this patch is accepted, I'll send a subsequent patch
to update the default delay, as appropriate.

thanks,
Len Brown, Intel Open Source Technology Center
