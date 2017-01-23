From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 0/4] PM / devfreq: Update the devfreq and devfreq-event
 device
Date: Mon, 23 Jan 2017 09:29:36 +0900
Message-ID: <58854E70.7040600@samsung.com>
References: <CGME20170116122609epcas5p34b6109202b5bc05f13325318d0f2dbe3@epcas5p3.samsung.com>
 <1484569567-29810-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:38506 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdAWA7l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2017 19:59:41 -0500
In-reply-to: <1484569567-29810-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: linux-pm@vger.kernel.org, kyungmin.park@samsung.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org

Ping. Hi Myungjoo,

Could you apply these patches if there is no any comment?


On 2017년 01월 16일 21:26, Chanwoo Choi wrote:
> This patches update the devfreq and devfreq-event device. I add the summary
> of each patch as following.
> - Patch1 fixes the wrong description of governor_userspace.c.
> - Patch2 show the information of registered PPMU devices.
> - Patch3/4 modify the name of sysfs entry for devfreq/devfreq-event device
> 
> Changes from v2:
> (https://lkml.org/lkml/2016/12/28/102)
> - On v2 patchset, patch1/2/3/5 were merged on devfreq git repo.
> - Remain the warning message for exynos-ppmu.c when failed to get the clock of ppmu
> - Rebase these patches on devfreq git repo[1].
> 
> Changes from v1:
> - Rebase these patches on v4.10-rc1.
> - Include the separate patch[2] in these patches.
> 
> [1] https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/ (branch: for-4.10-rc)
> [2] https://lkml.org/lkml/2016/12/16/7
> - [PATCH] PM / devfreq: Fix the wrong description for userspace governor
> 
> Chanwoo Choi (4):
>   PM / devfreq: Fix the wrong description for userspace governor
>   PM / devfreq: exynos-ppmu: Show the registred device for ppmu device
>   PM / devfreq: Simplify the sysfs name of devfreq-event device
>   PM / devfreq: Modify the device name as devfreq[X] for sysfs
> 
>  drivers/devfreq/devfreq-event.c      | 2 +-
>  drivers/devfreq/devfreq.c            | 4 +++-
>  drivers/devfreq/event/exynos-ppmu.c  | 3 +++
>  drivers/devfreq/governor_userspace.c | 3 +--
>  4 files changed, 8 insertions(+), 4 deletions(-)
> 


-- 
Best Regards,
Chanwoo Choi
S/W R&D Center
Samsung Electronics
