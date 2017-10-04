From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH ] cpufreq: ti-cpufreq: kfree opp_data when failure
Date: Wed, 4 Oct 2017 11:06:42 +0530
Message-ID: <20171004053642.GA8478@vireshk-i7>
References: <1506496097-30852-1-git-send-email-zumeng.chen@windriver.com>
 <20170927174026.GB12211@ubuntu>
 <7b7315f0-c2e4-a09e-8769-2d15a167fa73@windriver.com>
 <20170928041933.GG12211@ubuntu>
 <7a2171a3-d594-7fd7-2ccf-75ef7110dd98@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:51183 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdJDFgq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2017 01:36:46 -0400
Received: by mail-pf0-f178.google.com with SMTP id m63so5743319pfk.7
        for <linux-pm@vger.kernel.org>; Tue, 03 Oct 2017 22:36:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7a2171a3-d594-7fd7-2ccf-75ef7110dd98@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zumeng Chen <zumeng.chen@windriver.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, rjw@rjwysocki.net, d-gerlach@ti.com, tony@atomide.com

On 28-09-17, 13:00, Zumeng Chen wrote:
> Yes, you are right, it seems of_node_put(np) that you mentioned were
> ignored by both paths. If you don't mind I can deliver a separate patch
> to fix this based on some testing later.

Yeah, that's exactly how I want it.

-- 
viresh
