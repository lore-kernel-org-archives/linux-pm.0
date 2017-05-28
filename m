From: Matthew Giassa <matthew@giassa.net>
Subject: Question: Assessing cause of PM issue on Ubuntu
Date: Sun, 28 May 2017 09:25:23 -0700
Message-ID: <20170528162523.rmpggi76iwigv3bv@darkstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36069 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750791AbdE1QZ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 May 2017 12:25:27 -0400
Received: by mail-qk0-f181.google.com with SMTP id u75so34791803qka.3
        for <linux-pm@vger.kernel.org>; Sun, 28 May 2017 09:25:27 -0700 (PDT)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Good day,

I'm testing out kernel 4.12.0-rc2
(56fff1bb0f31358bf81a3c64a8dcd6da0dc44263) on an Ubuntu 16.04.2 LTS
machine (fresh install), with suspend and hibernation disabled. With
this kernel, if I allow the monitor to go into standby mode, I am not
able to "wake up" the monitor. Mouse and keyboard activity triggers the
LED to change from "standby/orange" to "ready/green" for a few seconds,
but then re-enters standby mode. The only way to regain use of the
machine locally is to drop to a virtual console via CTRL+ALT+F1, login,
"startx".

Is there a preferred VM/testbench to assess if this is an Ubuntu issue
as opposed to a Linux PM issue before filing a bug report. Also, is
there a standard set of logs/dumps that would be helpful for debugging?
I've checked existing docs on basic PM debugging [1], but couldn't find
anything related to this use case.

Cheers!

1. "Debugging hibernation and suspend",
<https://github.com/torvalds/linux/blob/master/Documentation/power/basic-pm-debugging.txt>,
Last accessed 2017-05-28.

-- 

-Matthew
