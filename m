From: Ryan <ryanphilips19@googlemail.com>
Subject: how does serial driver suspend work
Date: Mon, 4 Mar 2013 16:48:21 +0530
Message-ID: <CANMsd03ckY9E_rAMPTivCSs5jkB-zarZZG4npA1hsK3aL5FCDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:57558 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756877Ab3CDLSW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Mar 2013 06:18:22 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so8994060oag.32
        for <linux-pm@vger.kernel.org>; Mon, 04 Mar 2013 03:18:22 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello everyone,

Could anyone explain to me how does serial driver suspend work.
if i want to enable debug prints in suspend and resume functions. How
are they displayed on the console.
I could find a variable called "console_suspend_enabled". If this
variable is passed over the bootargs. Why does the kernel go to
suspend
without the serial driver not being suspend. Isnt all the drivers
required to go to suspend for the process to sleep.

Thanks & Regards,
 ryan
