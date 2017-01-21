From: Jeremy Nouhaud <jeremy9856@gmail.com>
Subject: Bug 178641 - Freeze on the third time on resume from suspend to RAM
Date: Sat, 21 Jan 2017 07:09:10 +0100
Message-ID: <1484978950.9620.2.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33999 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbdAUGJM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Jan 2017 01:09:12 -0500
Received: by mail-wm0-f66.google.com with SMTP id c85so11524998wmi.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Jan 2017 22:09:11 -0800 (PST)
Received: from Desktop (158.77.126.78.rev.sfr.net. [78.126.77.158])
        by smtp.googlemail.com with ESMTPSA id h3sm2875245wrb.31.2017.01.20.22.09.10
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jan 2017 22:09:10 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello,

I opened an issue (Bug 178641) on bugzilla.kernel.org because I have my
desktop for something like 5 years and suspend to RAM never worked. I
never looked to make it work until now. I tried everything I found on
the web with no luck. The 2 first time the suspend / resume work
perfectly but the third time the PC freeze. The PC can freeze while
going to suspend that it seem to never reach (still on), or, more
frequently, on resume, ending up with a black screen or a frozen
desktop. Very often the keyboard doesn't respond (caps led).

I tried a lot of things as you can see in the bug report and I will be
happy to provide every info you need to help me make suspend to ram
working.

Thanks !
