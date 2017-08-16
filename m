From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 3/9] cpufreq: Cap the default transition delay value
 to 10 ms
Date: Wed, 16 Aug 2017 12:04:31 +0530
Message-ID: <20170816063431.GB24299@vireshk-i7>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
 <1b93c94cb8b4914314e4f50304c3cb11c53d8b14.1500373914.git.viresh.kumar@linaro.org>
 <1500983686.30745.28.camel@nxp.com>
 <20170726060634.GY352@vireshk-i7>
 <1501174453.7957.30.camel@nxp.com>
 <20170728052843.GT352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36210 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbdHPGee (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2017 02:34:34 -0400
Received: by mail-pf0-f170.google.com with SMTP id c28so2431767pfe.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Aug 2017 23:34:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170728052843.GT352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>

On 28-07-17, 10:58, Viresh Kumar wrote:
> At this point I really feel that this is a hardware specific problem
> and it was working by chance until now. And I am not sure if we
> shouldn't be stopping this patch from getting merged just because of
> that.
> 
> At least you can teach your distribution to go increase the sampling
> rate from userspace to make it all work.

Its been 3 weeks since my last email on this thread and no reply yet
from any of the IMX maintainers. Can someone please help here ?

@Shawn: Can you help debugging a bit here, to see what's get screwed
up due to this commit ? Its just that your platform isn't able to
change freq at 10 ms rate.

@Rafael: I am not sure, but should we be stopping this patch because
some hardware isn't able to change freq at 10ms interval and is just
faking the transition delay to start with ?

Maybe we get this merged again and the IMX guys can figure out what's
wrong on their platform and how to fix it ?

-- 
viresh
