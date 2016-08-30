From: Yu Chen <yu.chen.surf@gmail.com>
Subject: Re: Hibernate: Partition table corruption after resume
Date: Tue, 30 Aug 2016 09:44:07 +0800
Message-ID: <CADjb_WQ1ya51v7xMhqYVDBq7UqBefbvJkt+KVT5vQ_7xzUdGWA@mail.gmail.com>
References: <20160829235941.qycbzs3jqkpjed2t@nicolas-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34540 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753429AbcH3BoK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Aug 2016 21:44:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so1041194wma.1
        for <linux-pm@vger.kernel.org>; Mon, 29 Aug 2016 18:44:09 -0700 (PDT)
In-Reply-To: <20160829235941.qycbzs3jqkpjed2t@nicolas-laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Porcel <nicolasporcel06@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>

On Tue, Aug 30, 2016 at 7:59 AM, Nicolas Porcel
<nicolasporcel06@gmail.com> wrote:
> Hi all,
>
> Last time I resumed my computer from hibernate, my partition table was
> corrupted. I was running kernel 4.7.0 from Gentoo. Do you think this can
> be a kernel bug?
>
> If yes, I am willing to investigate and provide a patch, but I first
> wanted to have some opinion before investigating further. I give some
> more details about how it happened below.
>
> I hibernated my system using pm-hibernate script a few times without
> reboot and was able to resume without problem. But the last time,
> the system took a while to resume so I forced shutdown my laptop. I then
> discovered that my initramfs was waiting for the swap partition to be
> detected (resume hook), but my partition table was gone. I could still
> boot as my system is on another drive.
>
> Here is my 500GB hard drive layout:
> sda1 8G     swap
> sda2 380G   BTRFS
> sda3 80G    LVM
>
> I managed to fully recover the sda2 and sda3 partitions using testdisk
> and I scrubbed the BTRFS partition and found no error. I also ran the
> short and long SMART self-test and found no error, so I believe the
> problem might not be hardware but software.
>
> Testdisk didn't manage to recover the swap partition but it reported a
> 16TB swap partition instead. Unfortunately, I overwrote the partition
> table so the part of the corrupted data are lost, but I intentionally,
> left the space occupied by the swap partition untouched in case any data
> can be extracted from it for investigation.
>
I've no idea why this happened, as hibernation should not touch partition table
AFAIK,  is there any lvm daemon thread running when hibernation
is saving its pages? I'd try to create a swap file, and disable the
original swap
partion, and use swap file as the new swap partition
to see if it can be reproduced by echo test_resume > /sys/power/disk,
echo disk > /sys/power/state.
Let's see if other people has more suggestions.
