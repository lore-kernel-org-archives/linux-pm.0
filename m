From: yu chen <yu.chen.surf@gmail.com>
Subject: Re: Suspend fails to resume
Date: Tue, 30 Jun 2015 21:55:10 +0800
Message-ID: <CADjb_WRhfajS=teNfp6Afr9DooNB32r18g2=FRN6jTNzM64Ysg@mail.gmail.com>
References: <20150627122600.GH16065@carfax.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35112 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968AbbF3NzM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2015 09:55:12 -0400
Received: by wiga1 with SMTP id a1so99036424wig.0
        for <linux-pm@vger.kernel.org>; Tue, 30 Jun 2015 06:55:10 -0700 (PDT)
In-Reply-To: <20150627122600.GH16065@carfax.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hugo Mills <hugo@carfax.org.uk>
Cc: linux-pm@vger.kernel.org

Hi Hugo,

On Sat, Jun 27, 2015 at 8:26 PM, Hugo Mills <hugo@carfax.org.uk> wrote:
> Jun 27 13:13:42 damon kernel: [ 2188.582469]  0000000000000000 ffffffffa05cc380 ffffffff814817bb 0000000000000000
> Jun 27 13:13:42 damon kernel: [ 2188.582472]  ffffffff81042661 ffff8803eedc2468 ffff8803eedc2400 ffffffffffffffff
> Jun 27 13:13:42 damon kernel: [ 2188.582475]  ffff88042afe0000 ffff88041af5d440 ffffffffa04bbd71 ffff88042afe0720
> Jun 27 13:13:42 damon kernel: [ 2188.582478] Call Trace:
> Jun 27 13:13:42 damon kernel: [ 2188.582488]  [<ffffffff814817bb>] ? dump_stack+0x40/0x50
> Jun 27 13:13:42 damon kernel: [ 2188.582492]  [<ffffffff81042661>] ? warn_slowpath_common+0x81/0xb0
> Jun 27 13:13:42 damon kernel: [ 2188.582506]  [<ffffffffa04bbd71>] ? radeon_ttm_bo_destroy+0xf1/0x100 [radeon]
> Jun 27 13:13:42 damon kernel: [ 2188.582512]  [<ffffffffa044a3ad>] ? ttm_bo_release_list+0x9d/0x180 [ttm]
> Jun 27 13:13:42 damon kernel: [ 2188.582524]  [<ffffffffa04bc2e8>] ? radeon_bo_unref+0x28/0x50 [radeon]
> Jun 27 13:13:42 damon kernel: [ 2188.582538]  [<ffffffffa04d0f8a>] ? radeon_gem_object_free+0x3a/0x40 [radeon]
> Jun 27 13:13:42 damon kernel: [ 2188.582547]  [<ffffffffa03ba7d8>] ? drm_gem_object_handle_unreference_unlocked+0x118/0x120 [drm]
> Jun 27 13:13:42 damon kernel: [ 2188.582553]  [<ffffffffa03ba87a>] ? drm_gem_handle_delete+0x9a/0xe0 [drm]
> Jun 27 13:13:42 damon kernel: [ 2188.582559]  [<ffffffffa03bb712>] ? drm_ioctl+0x172/0x5c0 [drm]
> Jun 27 13:13:42 damon kernel: [ 2188.582564]  [<ffffffff81050c15>] ? __set_current_blocked+0x35/0x50
> Jun 27 13:13:42 damon kernel: [ 2188.582573]  [<ffffffffa049c04a>] ? radeon_drm_ioctl+0x4a/0x80 [radeon]
> Jun 27 13:13:42 damon kernel: [ 2188.582577]  [<ffffffff81199e38>] ? do_vfs_ioctl+0x2e8/0x4f0
> Jun 27 13:13:42 damon kernel: [ 2188.582581]  [<ffffffff81034e8b>] ? __do_page_fault+0x17b/0x3e0
> Jun 27 13:13:42 damon kernel: [ 2188.582583]  [<ffffffff8119a07b>] ? SyS_ioctl+0x3b/0x80
> Jun 27 13:13:42 damon kernel: [ 2188.582587]  [<ffffffff8148699b>] ? system_call_fastpath+0x16/0x6e
> Jun 27 13:13:42 damon kernel: [ 2188.582589] ---[ end trace 79d65ca9618ebe16 ]---
>
>    Can anyone offer any suggestions?
>
Well, I think there might be someting wrong with radeon resumming
code, what if you blacklist it?
>    Thanks,
>    Hugo.
>
> --
> Hugo Mills             | UNIX: British manufacturer of modular shelving units
> hugo@... carfax.org.uk |
> http://carfax.org.uk/  |
> PGP: E2AB1DE4          |



-- 
Regards,
Yu
