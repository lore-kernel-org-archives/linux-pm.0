From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: Move struct devfreq_governor to devfreq
 directory
Date: Fri, 07 Apr 2017 15:48:34 +0900
Message-ID: <58E73642.9040104@samsung.com>
References: <1491452375-13815-1-git-send-email-cw00.choi@samsung.com>
        <CGME20170406041937epcas1p1b5cd8e13bf4049e1e4e5ff4d2b1b75b1@epcms1p6>
        <20170407064133epcms1p6daefde5d8ca9e1253c51b0bd3bc23f2d@epcms1p6>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56016 "EHLO
        epoutp02.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753067AbdDGGsh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2017 02:48:37 -0400
In-reply-to: <20170407064133epcms1p6daefde5d8ca9e1253c51b0bd3bc23f2d@epcms1p6>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi,

On 2017년 04월 07일 15:41, MyungJoo Ham wrote:
>> This patch moves the struct devfreq_governor from header file
>> to the devfreq directory because this structure is private data
>> and it have to be only accessed by the devfreq core.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/governor.h | 29 +++++++++++++++++++++++++++++
>>  include/linux/devfreq.h    | 30 +-----------------------------
>>  2 files changed, 30 insertions(+), 29 deletions(-)
>>
> 
> Where have you based on the commit?
> It's not appliable to 4.11-rc5.

When I applied it to 4.11-rc5, there is no any conflict.

I used the 'git am' command. Also, As I knew,
after releasing the 4.11-rc1, there was no patches
related to both drivers/devfreq/governor.h and include/linux/devfreq.h

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
