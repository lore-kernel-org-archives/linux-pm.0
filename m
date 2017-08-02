From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 3/9] cpufreq: Cap the default transition delay value
 to 10 ms
Date: Wed, 2 Aug 2017 08:53:37 +0530
Message-ID: <20170802032337.GA26689@vireshk-i7>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
 <1b93c94cb8b4914314e4f50304c3cb11c53d8b14.1500373914.git.viresh.kumar@linaro.org>
 <1500983686.30745.28.camel@nxp.com>
 <20170726060634.GY352@vireshk-i7>
 <1501174453.7957.30.camel@nxp.com>
 <20170728052843.GT352@vireshk-i7>
 <1501609730.17254.5.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35083 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbdHBDXn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2017 23:23:43 -0400
Received: by mail-pg0-f50.google.com with SMTP id v189so15732967pgd.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Aug 2017 20:23:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1501609730.17254.5.camel@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org

On 01-08-17, 20:48, Leonard Crestez wrote:
> > > I found this by enabling the power:cpu_frequency tracepoint event and
> > > checking for deltas with a script. Enabling CPU_FREQ_STAT show this:
> > > 
> > > time_in_state:
> > > 
> > > 396000 1609
> > So we still stay at the lowest frequency most of the time.
> 
> Yes

Aren't these numbers you shared were taken after this patch is applied? What's
wrong with the numbers then ?

> > Maybe can you compare these values with and without this patch to let
> > us know?
> 
> Without the patch it is always at low freq. Sampling at a lower
> frequency means spikes get ignored.

-- 
viresh
