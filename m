From: Nicolas Porcel <nicolasporcel06@gmail.com>
Subject: Re: Hibernate: Partition table corruption after resume
Date: Wed, 31 Aug 2016 02:10:12 +0200
Message-ID: <20160831001012.62acvt5szqy6v3jh@nicolas-laptop>
References: <20160829235941.qycbzs3jqkpjed2t@nicolas-laptop>
 <CADjb_WQ1ya51v7xMhqYVDBq7UqBefbvJkt+KVT5vQ_7xzUdGWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33388 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbcHaAKP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2016 20:10:15 -0400
Received: by mail-wm0-f43.google.com with SMTP id d196so25804855wmd.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Aug 2016 17:10:15 -0700 (PDT)
Received: from localhost (htr06-1-82-227-229-91.fbx.proxad.net. [82.227.229.91])
        by smtp.gmail.com with ESMTPSA id r16sm20900119wme.16.2016.08.30.17.10.12
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Aug 2016 17:10:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADjb_WQ1ya51v7xMhqYVDBq7UqBefbvJkt+KVT5vQ_7xzUdGWA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>

On Tue, Aug 30, 2016 at 09:44:07AM +0800, Yu Chen wrote:
> I've no idea why this happened, as hibernation should not touch partition table
> AFAIK,  is there any lvm daemon thread running when hibernation
> is saving its pages? I'd try to create a swap file, and disable the
> original swap
> partion, and use swap file as the new swap partition
> to see if it can be reproduced by echo test_resume > /sys/power/disk,
> echo disk > /sys/power/state.
> Let's see if other people has more suggestions.

Thank you for your suggestions.

Yes, a LVM daemon was running. Do you think LVM can be responsible for
the corruption? It is only running on a small partition of my drive, but
I use it for KVM virtual machines, so it might also be possible that one
of them was running when I hibernated.

I can't create any swap file as all my filesystems are BTRFS but I
created a LVM swap volume instead. I then tried to echo test_resume
but this option is not available in my kernel:

# cat /sys/power/disk
[platform] shutdown reboot suspend 

I found in this documentation page that I can try reboot, shutdown and
then platform: Documentation/power/drivers-testing.txt. I tested all 3
without reboot in between. I saved the dmesg output in case anyone is
interested, but I didn't find anything abnormal.
