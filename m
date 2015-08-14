From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] thermal: cpu_cooling: fix lockdep problems in
 cpu_cooling
Date: Fri, 14 Aug 2015 11:25:56 +0530
Message-ID: <20150814055556.GZ20238@linux>
References: <16e7d7d811fa2b0f8dcf6cade345a5f2f3e3c36a.1439372926.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:32974 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbbHNF4G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2015 01:56:06 -0400
Received: by pdrh1 with SMTP id h1so27850299pdr.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2015 22:56:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <16e7d7d811fa2b0f8dcf6cade345a5f2f3e3c36a.1439372926.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>, open list <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>

On 12-08-15, 15:22, Viresh Kumar wrote:
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Fixes: 2dcd851fe4b4 ("thermal: cpu_cooling: Update always cpufreq policy with
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> 
> Hi Eduardo/Zhang,
> 
> This is 4.2-rc material, please apply soon.

Hey,

Please apply this one and drop

8ad61f934e9e ("thermal: cpu_cooling: fix lockdep problems in
cpu_cooling")

-- 
viresh
