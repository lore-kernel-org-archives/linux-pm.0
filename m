From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH -next] CPUFREQ: Loongson1: Fix return value check in
 ls1x_cpufreq_probe()
Date: Wed, 6 Jul 2016 07:14:41 -0700
Message-ID: <20160706141441.GJ2671@ubuntu>
References: <1467807655-31952-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33709 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674AbcGFOOn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jul 2016 10:14:43 -0400
Received: by mail-pa0-f53.google.com with SMTP id b13so77062171pat.0
        for <linux-pm@vger.kernel.org>; Wed, 06 Jul 2016 07:14:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1467807655-31952-1-git-send-email-weiyj_lk@163.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: weiyj_lk@163.com
Cc: Keguang Zhang <keguang.zhang@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-mips@linux-mips.org, linux-pm@vger.kernel.org

On 06-07-16, 12:20, weiyj_lk@163.com wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function clk_get_parent() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.

NULL is a valid clock as per the clk-API and so this patch is wrong.

You need to investigate why you are getting NULL here for your
platform.

-- 
viresh
