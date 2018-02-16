From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 8/8] thermal/drivers/cpu_cooling: Add the combo cpu
 cooling device
Date: Fri, 16 Feb 2018 10:11:19 +0100
Message-ID: <f3d05cc2-265f-d0ba-5221-362114abe82d@linaro.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-9-git-send-email-daniel.lezcano@linaro.org>
 <20180202104259.GA28462@vireshk-i7>
 <8dadd854-25ac-68aa-aa9f-33ba76a137a4@linaro.org>
 <20180209094419.GN28462@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38471 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757563AbeBPJLW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Feb 2018 04:11:22 -0500
Received: by mail-wm0-f53.google.com with SMTP id 141so1832636wme.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Feb 2018 01:11:22 -0800 (PST)
In-Reply-To: <20180209094419.GN28462@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, amit.kachhap@gmail.com, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, daniel.thompson@linaro.org

On 09/02/2018 10:44, Viresh Kumar wrote:
> On 02-02-18, 15:30, Daniel Lezcano wrote:
>> Agree the cpufreq driver can be unloaded and this part needs some
>> adjustments.
> 
> Also note that the cpufreq cooling device has two separate set of
> callbacks, one for the power-specific callbacks. You haven't taken
> care of them in the combo thing.

The plan is add them after.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
