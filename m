From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/17] thermal: cpu_cooling: improve interaction with
 cpufreq core
Date: Tue, 11 Apr 2017 11:32:31 +0530
Message-ID: <20170411060231.GA3670@vireshk-i7>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35173 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752868AbdDKGCf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2017 02:02:35 -0400
Received: by mail-pf0-f172.google.com with SMTP id i5so43819812pfc.2
        for <linux-pm@vger.kernel.org>; Mon, 10 Apr 2017 23:02:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1489639999.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>

On 16-03-17, 10:56, Viresh Kumar wrote:
> Hi Guys,
> 
> The cpu_cooling driver is designed to use CPU frequency scaling to avoid
> high thermal states for a platform. But it wasn't glued really well with
> cpufreq core.
> 
> This series tries to improve interactions between cpufreq core and
> cpu_cooling driver and does some fixes/cleanups to the cpu_cooling
> driver.

Thermal guys, Ping !!

-- 
viresh
