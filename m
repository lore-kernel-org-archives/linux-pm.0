From: Len Brown <lenb@kernel.org>
Subject: [PATCH 0/2 v3] speed up cpu_up()
Date: Fri,  8 May 2015 13:48:05 -0400
Message-ID: <1431107287-22022-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f47.google.com ([209.85.216.47]:33003 "EHLO
	mail-vn0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbbEHRsS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 13:48:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Thanks for the feedback, here is a simplifed pair of patches.

I also like the x2apic optimization, since it addresses additional delays.
 -- though we may be able to optimize those in the non-x2apic case too.

thanks,
Len Brown, Intel Open Source Technology Center
