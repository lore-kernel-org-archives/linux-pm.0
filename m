From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 0/6] PM / devfreq: Modify devfreq/devfreq-event for
 improvement
Date: Thu, 15 Dec 2016 18:56:56 +0900
Message-ID: <8403a6f9-aebd-0b64-4bbb-6f2ea845721f@samsung.com>
References: <CGME20161124050125epcas1p466fc832e77cfe122454b8d40d0f6744e@epcas1p4.samsung.com>
 <1479963668-22845-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:54447 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757561AbcLOJ46 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Dec 2016 04:56:58 -0500
In-reply-to: <1479963668-22845-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Dear all,

Please ignore this patches.
I sent the patches[1][2] again.

[1] https://lkml.org/lkml/2016/12/15/119
[2] https://lkml.org/lkml/2016/12/15/122

-- 
Regards,
Chanwoo Choi

On 2016년 11월 24일 14:01, Chanwoo Choi wrote:
> This patches modify the devfreq and devfreq-event framework for improving
> them. But, these patches don't make an impact to operation of
> devfreq/devfreq-event.
> 
> Chanwoo Choi (6):
>   PM / devfreq: Fix the checkpatch warnings
>   PM / devfreq: Modify the device name as devfreq[X] for sysfs
>   PM / devfreq: event: Simplify the sysfs name of devfreq-event device
>   PM / devfreq: Remove the duplicate sysfs entry for current frequency
>   PM / devfreq: event: exynos-ppmu: Use the regmap interface to handle the registers
>   PM / devfreq: event: exynos-ppmu: Add the completion log of device registration
> 
>  drivers/devfreq/devfreq-event.c     |   2 +-
>  drivers/devfreq/devfreq.c           |  25 ++-
>  drivers/devfreq/event/exynos-ppmu.c | 329 ++++++++++++++++++++++++++----------
>  3 files changed, 251 insertions(+), 105 deletions(-)
> 



