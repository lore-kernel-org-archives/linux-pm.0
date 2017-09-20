From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH V2] PM / OPP: Call notifier without holding
 opp_table->lock
Date: Thu, 21 Sep 2017 08:58:37 +0900
Message-ID: <59C300AD.6000309@samsung.com>
References: <59C2414E.6020803@samsung.com>
        <CGME20170920202534epcas3p4c5f11e910684af4974e114e3c057901d@epcas3p4.samsung.com>
        <5b70f7bdf12975f869a83f77e36bf3a40e0fa4b9.1505939072.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:63826 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbdITX6l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2017 19:58:41 -0400
In-reply-to: <5b70f7bdf12975f869a83f77e36bf3a40e0fa4b9.1505939072.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, myungjoo.ham@samsung.com, inki.dae@samsung.com, linux-kernel@vger.kernel.org

Hi Viresh,

On 2017년 09월 21일 05:25, Viresh Kumar wrote:
> The notifier callbacks may want to call some OPP helper routines which
> may try to take the same opp_table->lock again and cause a deadlock. One
> such usecase was reported by Chanwoo Choi, where calling
> dev_pm_opp_disable() leads us to the devfreq's OPP notifier handler,
> which further calls dev_pm_opp_find_freq_floor() and it deadlocks.
> 
> We don't really need the opp_table->lock to be held across the notifier
> call though, all we want to make sure is that the 'opp' doesn't get
> freed while being used from within the notifier chain. We can do it with
> help of dev_pm_opp_get/put() as well. Let's do it.
> 
> Reported-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V1->V2:
> - s/Lets/Let's/ in commit log and added Stephen's tag.
> 

Thanks for your fixup. Looks good to me.
IMHO, this patch should be posted to stable@vger.kernel.org.

Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip] 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
