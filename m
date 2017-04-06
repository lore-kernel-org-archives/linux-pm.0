From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176411] cpufreq/cpuinfo_cur_freq reports <unknown>, MSI X99A
 SLI PLUS i7-5820K,  MSI i7-5930K, MSI X99A Raider i7-5820K
Date: Thu, 06 Apr 2017 16:37:48 +0000
Message-ID: <bug-176411-137361-T5mmY1BALw@https.bugzilla.kernel.org/>
References: <bug-176411-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:33544 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933208AbdDFQhu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Apr 2017 12:37:50 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 58635285B8
        for <linux-pm@vger.kernel.org>; Thu,  6 Apr 2017 16:37:49 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 8F636285B1
        for <linux-pm@vger.kernel.org>; Thu,  6 Apr 2017 16:37:48 +0000 (UTC)
In-Reply-To: <bug-176411-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176411

--- Comment #33 from ish@unx.ca ---
It appears that this has resolved itself for me. I've recently updated to
kernel:

Linux desktop 4.10.8-200.fc25.x86_64 #1 SMP Fri Mar 31 13:20:22 UTC 2017 x86_64
x86_64 x86_64 GNU/Linux

with Fedora 25.

I did a few reboots without power cycle with c-states disabled, which is how I
last left my bios configured.  Running htop showed CPU percentages after each
boot, i7z showed cores hitting max mhz.

I then reset my bios to factory default, which enables c-state. And did a few
non-power cycle reboots, again seeing expected behaviour with the cores.  I did
not have to power cycle this time to get full speed.

I'll keep monitoring it, but is it possible a kernel update could have fixed
it?

===> /sys/class/dmi/id/

./product_serial =====> Default string
./bios_vendor =====> American Megatrends Inc.
./product_version =====> 5.0
./chassis_asset_tag =====> Default string
./chassis_serial =====> Default string
./board_vendor =====> MSI
./board_asset_tag =====> To be filled by O.E.M.
./board_version =====> 5.0
./power/runtime_suspended_time =====> 0
./power/autosuspend_delay_ms =====>
./power/runtime_active_time =====> 0
./power/control =====> auto
./power/runtime_status =====> unsupported
./chassis_vendor =====> MSI
./modalias =====>
dmi:bvnAmericanMegatrendsInc.:bvrP.50:bd07/19/2016:svnMSI:pnMS-7885:pvr5.0:rvnMSI:rnX99ARAIDER(MS-7885):rvr5.0:cvnMSI:ct3:cvr5.0:
./product_uuid =====> AAAAAAAA-AAAA-AAAA-AAAA-D8CB8AEDA146
./bios_version =====> P.50
./sys_vendor =====> MSI
./board_serial =====> To be filled by O.E.M.
./chassis_version =====> 5.0
./chassis_type =====> 3
./uevent =====>
MODALIAS=dmi:bvnAmericanMegatrendsInc.:bvrP.50:bd07/19/2016:svnMSI:pnMS-7885:pvr5.0:rvnMSI:rnX99ARAIDER(MS-7885):rvr5.0:cvnMSI:ct3:cvr5.0:
./product_name =====> MS-7885
./bios_date =====> 07/19/2016
./board_name =====> X99A RAIDER (MS-7885)

-- 
You are receiving this mail because:
You are the assignee for the bug.
