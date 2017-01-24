From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4 2/4] PM / devfreq: exynos-ppmu: Show the registred
 device for ppmu device
Date: Tue, 24 Jan 2017 17:15:16 +0900
Message-ID: <58870D14.3010403@samsung.com>
References: <1485142299-9986-1-git-send-email-cw00.choi@samsung.com>
 <CGME20170123033151epcas5p341aa786474af221e390eed87ea48381e@epcas5p3.samsung.com>
 <20170124034245epcms1p81308f665bd3446628302667d14bb3d36@epcms1p8>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:36905 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbdAXKZZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2017 05:25:25 -0500
In-reply-to: <20170124034245epcms1p81308f665bd3446628302667d14bb3d36@epcms1p8>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2017년 01월 24일 12:42, MyungJoo Ham wrote:
>> This patch just adds the simple log to show the PPMU device's registration
>> during the kernel booting.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/event/exynos-ppmu.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
> 
> Applied in for-next

I'd like you to review the patch3 and patch4.
On v4, The patch4 is modified according to your comment.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
