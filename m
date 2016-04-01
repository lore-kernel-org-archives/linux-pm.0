From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V1 Resend 2/3] cpufreq: dt: Add generic platform-device
 creation support
Date: Fri, 1 Apr 2016 18:22:14 +0530
Message-ID: <20160401125214.GE2987@vireshk-i7>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
 <12972545.Mi9sHiNJpR@wuerfel>
 <20160330032240.GB8773@vireshk-i7>
 <7250220.227umpmTug@wuerfel>
 <20160401102350.GA5532@vireshk-i7>
 <56FE69E0.1080800@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34325 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758311AbcDAMwS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Apr 2016 08:52:18 -0400
Received: by mail-pf0-f176.google.com with SMTP id x3so93850990pfb.1
        for <linux-pm@vger.kernel.org>; Fri, 01 Apr 2016 05:52:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56FE69E0.1080800@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Arnd Bergmann <arnd@arndb.de>, linaro-kernel@lists.linaro.org, k.kozlowski@samsung.com, kgene.kim@samsung.com, heiko@sntech.de, linux-pm@vger.kernel.org, mmcclint@codeaurora.org, xf@rock-chips.com, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, rob.herring@linaro.org, Sebastian Frias <sebastian_frias@sigmadesigns.com>

On 01-04-16, 14:30, Mason wrote:
> Hmmm... I'm using the older operating-points prop in my platform's DT.
> Why can't we define a new property (e.g. "enable-generic-cpufreq")
> which registers the "cpufreq-dt" pseudo-device?

DT is all about expressing hardware in a file. The same bindings
should be usable across any operating system, not just Linux. And so
we shouldn't have any OS or software-implementation specific
properties here.

> And platforms that manually register "cpufreq-dt" would be
> automatically white-listed, even if they don't have the new
> property, to maintain backward-compat?

Its not about just making it work, otherwise we would have done it
long time back by creating a DT node for cpufreq-dt driver.

> > @Rob: Will that be acceptable to you? We are discussing (again) about how to
> > probe cpufreq-dt driver automatically for platforms :)
> > 
> > The cpus node doesn't have any 'compatible' property today, and I will be
> > required to add that in this case.
> 
> Why does it need a compatible prop?

That compatible property will describe how to parse/describe
operating-points for a CPU. Any driver, which has the ability to parse
those bindings can do things base on such a compatibility string.

I hope you got the idea.

-- 
viresh
