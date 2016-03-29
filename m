From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V1 Resend 2/3] cpufreq: dt: Add generic platform-device
 creation support
Date: Tue, 29 Mar 2016 22:12:09 +0530
Message-ID: <20160329164209.GF14322@vireshk-i7>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
 <2f2947872d41ecccc393d6ae95eafc72f205e03c.1459233524.git.viresh.kumar@linaro.org>
 <5412084.gVvuDFzkvo@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:32985 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757233AbcC2QmN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 12:42:13 -0400
Received: by mail-pa0-f51.google.com with SMTP id zm5so17947616pac.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Mar 2016 09:42:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5412084.gVvuDFzkvo@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, k.kozlowski@samsung.com, kgene.kim@samsung.com, heiko@sntech.de, xf@rock-chips.com, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, mmcclint@codeaurora.org

On 29-03-16, 17:14, Arnd Bergmann wrote:
> 	if (of_device_match(of_root, compat))

You meant of_match_node() here, right?

> 		platform_device_register_simple(NULL, "cpufreq-dt", 0, NULL, 0);

-- 
viresh
