From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [1/2] cpufreq: dt-platdev: Automatically create cpufreq device
 with OPP v2
Date: Tue, 19 Sep 2017 11:46:35 -0700
Message-ID: <20170919184635.GA30848@ubuntu>
References: <20170821131332.GA14662@verge.net.au>
 <20170821131735.GB14662@verge.net.au>
 <20170829101146.GF3101@ubuntu>
 <9f37e244-7c6d-d556-ee7c-a5f3c9d5f756@ti.com>
 <7c607393-2a3d-1e5e-7b54-3745cee416e3@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:56429 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbdISSqh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Sep 2017 14:46:37 -0400
Received: by mail-pf0-f179.google.com with SMTP id g65so254226pfe.13
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2017 11:46:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7c607393-2a3d-1e5e-7b54-3745cee416e3@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, Simon Horman <horms@verge.net.au>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, geert@linux-m68k.org, maxime.ripard@free-electrons.com, wens@csie.org, xuwei5@hisilicon.com, kgene@kernel.org, krzk@kernel.org, yamada.masahiro@socionext.com, jun.nie@linaro.org, baoyou.xie@linaro.org, linux-kernel@vger.kernel.org

On 11-09-17, 09:18, Dave Gerlach wrote:
> Yes, ti-cpufreq registers the cpufreq-dt platdev in order to ensure the
> ti-cpufreq driver probes first and provides the necessary opp-supported-hw for
> cpufreq-dt. This applies to am335x, am437x, dra7xx, and am57xx. I suppose these
> platforms will need to be added to the 'blacklist' to prevent the cpufreq-dt
> platdev from being created automatically, unless there is a better way to handle
> this dependency...

Right. Patches are already on the list to fix all platforms that had such
issues.

-- 
viresh
