From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] cpuidle/mips: remove redundant cpuidle_idle_call()
Date: Mon, 17 Feb 2014 11:09:45 -0500 (EST)
Message-ID: <alpine.LFD.2.11.1402171101060.17677@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:64603 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbaBQQJy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 17 Feb 2014 11:09:54 -0500
Received: from xanadu.home ([66.130.143.177]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0N1500CYVE89B0B0@VL-VM-MR006.ip.videotron.ca> for
 linux-pm@vger.kernel.org; Mon, 17 Feb 2014 11:09:46 -0500 (EST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Burton <paul.burton@imgtec.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-mips@linux-mips.org


The core idle loop now takes care of it.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---

I noticed commit c0b5d598aefda in linux-next adds a call to 
cpuidle_idle_call().  At the same time we're rationalizing the idle 
handling code in order to integrate it with the scheduler proper.  
Please note that a similar patch to the one below will be necessary once 
everything gets merged together.

diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 4b1554b3f5..2d753de5dc 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -253,8 +253,7 @@ static void mips_cpu_idle(void)
 
 void arch_cpu_idle(void)
 {
-	if (cpuidle_idle_call())
-		mips_cpu_idle();
+	mips_cpu_idle();
 }
 
 #ifdef CONFIG_CPU_IDLE
