From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 197153] Wrong cores frequencies values in /proc/cpuinfo
Date: Sun, 08 Oct 2017 03:37:21 +0000
Message-ID: <bug-197153-137361-FXeAl0Phlo@https.bugzilla.kernel.org/>
References: <bug-197153-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:35330 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753187AbdJHDhV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Oct 2017 23:37:21 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 763112872E
        for <linux-pm@vger.kernel.org>; Sun,  8 Oct 2017 03:37:21 +0000 (UTC)
In-Reply-To: <bug-197153-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=197153

--- Comment #7 from Doug Smythies (dsmythies@telus.net) ---
@Artem: Please be considerate that, since this bug is unassigned, emails are
going to the entire linux-pm e-mail list.

> The /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq interface is also
> broken in 4.13.

It is not broken, and the numbers you are getting are most probably correct.
If you are running a desktop computer with a GUI, then this statement:

"my laptop is more or less completely idle"

simply is not true. You would have to disable the GUI and a bunch of other
services to get a more idle system (which would still not be completely idle).

If I use my test Ubuntu 16.04.3 server (no GUI) and disable several services,
i.e.:

$ cat set_cpu_turn_off_services
#! /bin/bash
# Turn off some services to try to get "idle" to be more "idle"
sudo systemctl stop mysql.service
sudo systemctl stop apache2.service
sudo systemctl stop nmbd.service
sudo systemctl stop smbd.service
sudo systemctl stop cron.service
sudo systemctl stop winbind.service
sudo systemctl stop apt-daily.timer

then for your command I usually get 1.61 GHz, which is the minimum for my
processor.

In order to not influence the system I was testing, I ran your command at a
very slow rate of once every 2 seconds for 6112 samples. 5970 (97.68%) of them
reported the minimum frequency for my 8 CPU processor.

-- 
You are receiving this mail because:
You are the assignee for the bug.
