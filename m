From: Ryan <ryanphilips19@googlemail.com>
Subject: periodic wakeup
Date: Wed, 23 Sep 2015 04:15:30 +0530
Message-ID: <CANMsd01MpXbfxm5Lnba8eTJJXs8ac23ffCWC-4UB9jbaF9Jzjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36514 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933595AbbIVWpa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 22 Sep 2015 18:45:30 -0400
Received: by oibi136 with SMTP id i136so14445772oib.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2015 15:45:30 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

I want to measure the standby time of a device. The device goes to
suspend. How can i make the device wake up periodically (every 15 mins
or so) so that i can log the serial console prints to find out how
much time the battery lasts.

Thanks,
ryan
