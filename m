From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/2] cpufreq: arm_big_little: make function arguments and
 structures const
Date: Thu, 26 Oct 2017 08:33:07 +0530
Message-ID: <20171026030307.GA4240@vireshk-i7>
References: <1508410755-13666-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:48757 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752022AbdJZDDL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Oct 2017 23:03:11 -0400
Received: by mail-pg0-f50.google.com with SMTP id v78so1572467pgb.5
        for <linux-pm@vger.kernel.org>; Wed, 25 Oct 2017 20:03:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1508410755-13666-1-git-send-email-bhumirks@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, sudeep.holla@arm.com, rjw@rjwysocki.net, liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 19-10-17, 12:59, Bhumika Goyal wrote:
> Make some function arguments as const. After this change make the 
> cpufreq_arm_bL_ops structures const.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
