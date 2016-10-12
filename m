From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/8] PM / OPP: Multiple regulator support
Date: Wed, 12 Oct 2016 07:41:18 +0530
Message-ID: <20161012021118.GA19385@vireshk-i7>
References: <cover.1475581665.git.viresh.kumar@linaro.org>
 <57FBEA16.2010502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34289 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753067AbcJLCLW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Oct 2016 22:11:22 -0400
Received: by mail-pf0-f173.google.com with SMTP id 190so11282175pfv.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2016 19:11:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <57FBEA16.2010502@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, broonie@kernel.org

On 10-10-16, 14:20, Dave Gerlach wrote:
> Cool, I'm reviewing these patches still but I definitely plan to test them
> out on the TI platforms requiring multi-regulator support. At first glance
> it looks like it does give us the hooks we need. I believe we can use
> cpufreq-dt as is and just provide the regulators before it probes.

Yes you can. That's how I tested it as well.

-- 
viresh
