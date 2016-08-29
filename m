From: Nicolas Porcel <nicolasporcel06@gmail.com>
Subject: Hibernate: Partition table corruption after resume
Date: Tue, 30 Aug 2016 01:59:41 +0200
Message-ID: <20160829235941.qycbzs3jqkpjed2t@nicolas-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32921 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756808AbcH2X7q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Aug 2016 19:59:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so840630wme.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2016 16:59:45 -0700 (PDT)
Received: from localhost (htr06-1-82-227-229-91.fbx.proxad.net. [82.227.229.91])
        by smtp.gmail.com with ESMTPSA id ya1sm36700677wjb.23.2016.08.29.16.59.42
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2016 16:59:42 -0700 (PDT)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi all,

Last time I resumed my computer from hibernate, my partition table was
corrupted. I was running kernel 4.7.0 from Gentoo. Do you think this can
be a kernel bug?

If yes, I am willing to investigate and provide a patch, but I first
wanted to have some opinion before investigating further. I give some
more details about how it happened below.

I hibernated my system using pm-hibernate script a few times without
reboot and was able to resume without problem. But the last time,
the system took a while to resume so I forced shutdown my laptop. I then
discovered that my initramfs was waiting for the swap partition to be
detected (resume hook), but my partition table was gone. I could still
boot as my system is on another drive.

Here is my 500GB hard drive layout:
sda1 8G     swap
sda2 380G   BTRFS
sda3 80G    LVM

I managed to fully recover the sda2 and sda3 partitions using testdisk
and I scrubbed the BTRFS partition and found no error. I also ran the
short and long SMART self-test and found no error, so I believe the
problem might not be hardware but software.

Testdisk didn't manage to recover the swap partition but it reported a
16TB swap partition instead. Unfortunately, I overwrote the partition
table so the part of the corrupted data are lost, but I intentionally,
left the space occupied by the swap partition untouched in case any data
can be extracted from it for investigation.

Thank you for you help,

-- 
Nicolas

