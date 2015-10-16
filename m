From: Len Brown <lenb@kernel.org>
Subject: [PATCH/RFT 0/2] regression fix: "smpboot: do_boot_cpu failed(-1) to wakeup CPU#1"
Date: Fri, 16 Oct 2015 00:14:27 -0400
Message-ID: <1444968869-21435-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35871 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbbJPEPF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2015 00:15:05 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, shrybman@teksavvy.com, dparsons@brightdsl.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Shane, Donald,
Please test this pair of patches.

If the default kernel still has a problem booting CPU #1 on yoru Core2 system,
"cpu_init_udelay=10000" should get you back to the legacy delays.

thanks,
Len Brown, Intel Open Source Technology Center

