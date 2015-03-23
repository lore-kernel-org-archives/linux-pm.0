From: =?utf-8?Q?Peter_M=C3=BCnster?= <pmlists@free.fr>
Subject: prevent disk from spinning up at system resume
Date: Mon, 23 Mar 2015 12:02:30 +0100
Message-ID: <87iodsht89.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58769 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106AbbCWMKJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 23 Mar 2015 08:10:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gll-linux-pm2@m.gmane.org>)
	id 1Ya1BE-0000ts-MO
	for linux-pm@vger.kernel.org; Mon, 23 Mar 2015 13:10:04 +0100
Received: from arennes-651-1-273-185.w2-2.abo.wanadoo.fr ([2.2.240.185])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2015 13:10:04 +0100
Received: from pmlists by arennes-651-1-273-185.w2-2.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2015 13:10:04 +0100
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

My SATA disk (sdb) spins up at every system resume. How could I avoid
that please?

Some details:

- sdb not mounted
- echo 0 >/sys/block/sdb/device/scsi_disk/2:0:0:0/manage_start_stop
- hdparm -C /dev/sdb :   "drive state is:  standby"
- s2ram
- after wake up:         "drive state is:  active/idle"
- kernel message at wakeup: "sd 2:0:0:0: [sdb] Synchronizing SCSI cache"
- when doing "echo scsi remove-single-device 2 0 0 0 >/proc/scsi/scsi"
  before s2ram, sdb keeps sleeping after resume

I need the disk only about once per week. I use s2ram several times per
day, and I prefer that sdb keeps sleeping.

TIA for any hints,
-- 
           Peter

