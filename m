From: Ran Shalit <ranshalit@gmail.com>
Subject: smsc911x suspend/resume
Date: Fri, 6 Mar 2015 11:16:03 +0200
Message-ID: <CAJ2oMhJy3db4WHW8eU_0=bgq+D=vizUy=VqFOP6n8ZORBtE4bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38021 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbbCFJQE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2015 04:16:04 -0500
Received: by widex7 with SMTP id ex7so1270612wid.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2015 01:16:03 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello,

I try to figure out when the resume function is called in smsc911x driver:
http://lxr.free-electrons.com/source/drivers/net/ethernet/smsc/smsc911x.c
According to datasheet
http://ww1.microchip.com/downloads/en/DeviceDoc/9220.pdf
There is the following sequence:
1. host set mode to D1 (sleep, WOL)
2. smsc wakes and through PME interrupt
3. host should set mode to D0 (in order to get to normal operation).

I see that resume is doing stage (3) above, but I don't see how (2) is
done, is it that resume is automatically called whenever there is
interrupt ?

Thank you,
Ran
