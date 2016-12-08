From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Cpufreq regression in next-20161207
Date: Thu, 8 Dec 2016 11:27:38 +0530
Message-ID: <20161208055738.GB31711@vireshk-i7>
References: <20161208045640.GB4264@atomide.com>
 <20161208050739.GE24152@vireshk-i7>
 <20161208055220.GD4264@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34342 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbcLHF5n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Dec 2016 00:57:43 -0500
Received: by mail-pf0-f169.google.com with SMTP id c4so81811150pfb.1
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2016 21:57:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161208055220.GD4264@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, Dave Gerlach <d-gerlach@ti.com>, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org

On 07-12-16, 21:52, Tony Lindgren wrote:
> Hmm good question. Maybe we don't have the regulators configured for
> pandaboard?

Hmm, and who would be the right person to confirm that? And its not only about
pandaboard but the whole OMAP4 family (which is using cpufreq-dt driver).

-- 
viresh
