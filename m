From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] devfreq: exynos: Don't use OPP structures outside of RCU
 locks
Date: Fri, 02 Dec 2016 17:39:02 +0900
Message-ID: <58413326.6050407@samsung.com>
References: <CGME20161201102605epcas4p118a7bc6f533d61d36f0ed66b8c349852@epcas4p1.samsung.com>
 <9cb02ef0037c8d161f7b57ff3e99c2831661da03.1480587838.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:47556 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbcLBIjF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Dec 2016 03:39:05 -0500
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OHJ00C3DUOULAB0@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Fri, 02 Dec 2016 17:39:03 +0900 (KST)
In-reply-to: <9cb02ef0037c8d161f7b57ff3e99c2831661da03.1480587838.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, nm@ti.com, Vincent Guittot <vincent.guittot@linaro.org>

Hi Viresh,

On 2016년 12월 01일 19:25, Viresh Kumar wrote:
> The OPP structures are abused to the best here, without understanding
> how the OPP core and RCU locks work.
> 
> In short, the OPP pointer saved 'struct exynos_bus' can become invalid
> under your nose, as the OPP core may free it.
> 
> Fix various abuses around OPP structures and calls.
> 
> Compile tested only.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> I would like it to go via the PM tree. Perhaps that's already the
> default tree for this.
> 
>  drivers/devfreq/exynos-bus.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)

Looks good to me and I tested this patch on Exynos4412-odroidu3/Exynos5433-TM2.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
