From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4] PM / OPP: Pass opp_table to dev_pm_opp_put_regulator()
Date: Thu, 1 Dec 2016 08:59:08 +0530
Message-ID: <20161201032908.GR3288@vireshk-i7>
References: <CGME20161130040034epcas5p4344849b26e8b5c435e658e3a0179cef6@epcas5p4.samsung.com>
 <480ae6e161788d338fb1637aa2615a75588ac3c6.1480478081.git.viresh.kumar@linaro.org>
 <583E6F88.9010805@samsung.com>
 <20161130080543.GJ3288@vireshk-i7>
 <583F80AB.5040408@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34214 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755539AbcLAD3M (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2016 22:29:12 -0500
Received: by mail-pg0-f49.google.com with SMTP id x23so89527518pgx.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2016 19:29:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <583F80AB.5040408@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, "# v4 . 4+" <stable@vger.kernel.org>

On 01-12-16, 10:45, Joonyoung Shim wrote:
> Already i tried and the error was gone but sometimes system resume is
> halt.

That looks to be a different problem which may not be related to
cpufreq at all.

> I'm not sure that it has any effect so i need to more dig.

Right.

-- 
viresh
