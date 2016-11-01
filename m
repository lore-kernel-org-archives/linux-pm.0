From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [Bug] ARM: mxs: STI: console can't wake up from freeze
Date: Tue, 1 Nov 2016 09:23:04 +0000
Message-ID: <20161101092304.GM1041@n2100.armlinux.org.uk>
References: <315017958.66634.5d4fc19c-31cd-4900-8613-af4cadec5da4.open-xchange@email.1und1.de>
 <20161023133134.GI1041@n2100.armlinux.org.uk>
 <1709157673.85170.1cb53b4d-2805-48ea-aef1-dd282306d108.open-xchange@email.1und1.de>
 <20161031161700.GH1041@n2100.armlinux.org.uk>
 <847975190.29034.38a9c7fa-bdf8-4732-ac8b-cf15c21e3ce8.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:43890 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161766AbcKAJX0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Nov 2016 05:23:26 -0400
Content-Disposition: inline
In-Reply-To: <847975190.29034.38a9c7fa-bdf8-4732-ac8b-cf15c21e3ce8.open-xchange@email.1und1.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, joerg.krause@embedded.rocks, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@nxp.com>

On Mon, Oct 31, 2016 at 08:54:33PM +0100, Stefan Wahren wrote:
> [  366.696043] INFO: task ext4lazyinit:70 blocked for more than 120 seconds.
> [  366.703046]       Not tainted 4.9.0-rc1 #7
> [  366.707188] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> message.
> [  366.715161] ext4lazyinit    D c05aa6ac     0    70      2 0x00000000

This looks like a very different problem - I guess one for ext4 people.

> [  366.721713] [<c05aa6ac>] (__schedule) from [<c05aafb8>] (schedule+0x3c/0xbc)
> [  366.728972] [<c05aafb8>] (schedule) from [<c05aee38>]
> (schedule_timeout+0x23c/0x3d8)
> [  366.736917] [<c05aee38>] (schedule_timeout) from [<c05aa398>]
> (io_schedule_timeout+0xb8/0x13c)
> [  366.745721] [<c05aa398>] (io_schedule_timeout) from [<c05ab9d8>]
> (T.1434+0xac/0x12c)
> [  366.753671] [<c05ab9d8>] (T.1434) from [<c02c7668>]
> (submit_bio_wait+0x50/0x68)
> [  366.761078] [<c02c7668>] (submit_bio_wait) from [<c02d9a58>]
> (blkdev_issue_zeroout+0x174/0x1ec)
> [  366.769984] [<c02d9a58>] (blkdev_issue_zeroout) from [<c0196e4c>]
> (ext4_init_inode_table+0x1ac/0x3b0)
> [  366.779410] [<c0196e4c>] (ext4_init_inode_table) from [<c01ba770>]
> (ext4_lazyinit_thread+0x280/0x398)
> [  366.788803] [<c01ba770>] (ext4_lazyinit_thread) from [<c003bce4>]
> (kthread+0xc4/0xe0)
> [  366.796828] [<c003bce4>] (kthread) from [<c000a34c>]
> (ret_from_fork+0x14/0x28)
> [  366.804200]
> [  366.804200] Showing all locks held in the system:
> [  366.810465] 2 locks held by khungtaskd/10:
> [  366.814707]  #0: [  366.816500]  (
> rcu_read_lock[  366.819360] ){......}
> , at: [  366.822236] [<c0093a10>] watchdog+0xb4/0x61c
> [  366.826656]  #1: [  366.828450]  (
> tasklist_lock[  366.831312] ){.+.+..}
> , at: [  366.834320] [<c0051dbc>] debug_show_all_locks+0x28/0x1bc
> [  366.839701] 4 locks held by ext4lazyinit/70:
> [  366.844107]  #0: [  366.845897]  (
> &type->s_umount_key[  366.849280] #22
> ){++++++}[  366.851866] , at:
> [  366.854044] [<c01ba5c4>] ext4_lazyinit_thread+0xd4/0x398
> [  366.859400]  #1: [  366.861178]  (
> sb_writers[  366.863897] #3
> ){.+.+.+}[  366.866412] , at:
> [  366.868475] [<c01ba5dc>] ext4_lazyinit_thread+0xec/0x398
> [  366.873925]  #2: [  366.875716]  (
> jbd2_handle[  366.878405] ){++++..}
> , at: [  366.881292] [<c01f661c>] start_this_handle+0xec/0x404
> [  366.886492]  #3: [  366.888284]  (
> &meta_group_info[i]->alloc_sem[  366.892620] ){++++..}
> , at: [  366.895624] [<c0196d58>] ext4_init_inode_table+0xb8/0x3b0
> [  366.901093] 4 locks held by bash/385:
> [  366.904895]  #0: [  366.906686]  (
> sb_writers[  366.909288] #4
> ){.+.+.+}[  366.911787] , at:
> [  366.913972] [<c011f7d4>] vfs_write+0x194/0x1a4
> [  366.918456]  #1: [  366.920234]  (
> &of->mutex[  366.922824] ){+.+.+.}
> , at: [  366.925940] [<c019029c>] kernfs_fop_write+0xc0/0x1d0
> [  366.930942]  #2: [  366.932714]  (
> s_active[  366.935265] #43
> ){.+.+.+}[  366.937864] , at:
> [  366.939927] [<c01902a4>] kernfs_fop_write+0xc8/0x1d0
> [  366.945029]  #3: [  366.946818]  (
> pm_mutex[  366.949242] ){+.+.+.}
> , at: [  366.952111] [<c005b7e4>] pm_suspend+0x90/0x81c
> [  366.956697]
> [  366.958229] =============================================

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
