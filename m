From: Len Brown <lenb@kernel.org>
Subject: [PATCH 0/2 v4] speed up cpu_up()
Date: Mon, 11 May 2015 17:06:46 -0400
Message-ID: <1431378408-5840-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36340 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932276AbbEKVG4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2015 17:06:56 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

v3, but re-based to tip

(a 1-line change to track new location of the mdelay(10))

thanks,
Len Brown, Intel Open Source Technology Center

