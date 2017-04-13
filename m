From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Hibernating / resuming with ExpressCard
Date: Thu, 13 Apr 2017 13:13:02 +0100
Message-ID: <bf574006-8113-caab-78f5-231afdbb3bdf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34559 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdDMMNG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2017 08:13:06 -0400
Received: by mail-wm0-f49.google.com with SMTP id w204so3494088wmd.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Apr 2017 05:13:05 -0700 (PDT)
Received: from [192.168.1.185] (129.82.54.77.rev.vodafone.pt. [77.54.82.129])
        by smtp.gmail.com with ESMTPSA id 186sm10399253wml.2.2017.04.13.05.13.03
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Apr 2017 05:13:03 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

I have a Lenovo X230 with an ExpressCard/54 slot. I dual boot this
laptop with Windows 10, and I have an external NVIDIA GTX970 connected
to the ExpressCard slot using a EXP GDC external GPU adapter.

Because I only use the NVIDIA card in Windows, I have blacklisted the
nouveau module to prevent it from loading. I also only have the
ExpressCard adapter connected when the computer is docked, otherwise I
keep it disconnected. With the blacklisted nouveau the graphics card is
powered on, but nothing appears in dmesg.

Hibernating and resuming with the ExpressCard adapter connected is not a
problem. However, if I hibernate with it connected and remove the
adapter while the laptop is hibernating, resuming will fail with error
-14 and the following message:

[    3.168680] PM: Starting manual resume from disk
[    3.168754] PM: Hibernation image partition 8:2 present
[    3.168755] PM: Looking for hibernation image.
[    3.168919] PM: Image signature found, resuming
[    3.170330] PM: Preparing processes for restore.
[    3.170333] Freezing user space processes ...
[    3.241365] (elapsed 0.070 seconds) done.
[    3.241510] PM: Loading hibernation image.
[    3.241635] PM: Marking nosave pages: [mem 0x00000000-0x00000fff]
[    3.241637] PM: Marking nosave pages: [mem 0x0009d000-0x000fffff]
[    3.241642] PM: Marking nosave pages: [mem 0x20000000-0x201fffff]
[    3.241658] PM: Marking nosave pages: [mem 0x40004000-0x40004fff]
[    3.241659] PM: Marking nosave pages: [mem 0xada2d000-0xffffffff]
[    3.243319] PM: Basic memory bitmaps created
[    3.270538] PM: Using 3 thread(s) for decompression.
               PM: Loading and decompressing image data (349081 pages)...
[    3.334831] PM: Image loading progress:   0%
[    3.335378] PM: Read 1396324 kbytes in 0.06 seconds (23272.06 MB/s)
[    3.342367] PM: Error -14 resuming
[    3.342434] PM: Failed to load hibernation image, recovering.
[    3.343322] PM: Basic memory bitmaps freed
[    3.343324] Restarting tasks ... done.
[    3.345406] PM: Hibernation image not present or could not be loaded.

The same thing occurs if I hibernate with the adapter disconnected, plug
it in while the computer is hibernated, and then try to resume.

I assume this is because the hibernation process detects a hardware
change and doesn't like it - is there a way around it?

Regards,
Pedro
