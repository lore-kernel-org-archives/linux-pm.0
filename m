From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/8] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
Date: Wed, 7 Feb 2018 15:50:45 +0530
Message-ID: <20180207102045.GR28462@vireshk-i7>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-5-git-send-email-daniel.lezcano@linaro.org>
 <20180207090448.GP28462@vireshk-i7>
 <4d66ce4f-c8eb-092a-04b5-a705793a1796@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37481 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753476AbeBGKUs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Feb 2018 05:20:48 -0500
Received: by mail-pf0-f196.google.com with SMTP id p1so134249pfh.4
        for <linux-pm@vger.kernel.org>; Wed, 07 Feb 2018 02:20:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4d66ce4f-c8eb-092a-04b5-a705793a1796@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, amit.kachhap@gmail.com, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>

On 07-02-18, 11:15, Daniel Lezcano wrote:
> Do you mean s/CPU_THERMAL/CPU_FREQ_THERMAL/ in include/linux/cpu_cooling.h ?

Yes, but also in the .c file (which you have done in 5/8 anyway).

-- 
viresh
