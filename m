From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH V3 3/9] cpufreq: Cap the default transition delay value
 to 10 ms
Date: Wed, 16 Aug 2017 12:42:45 +0300
Message-ID: <1502876565.23210.15.camel@nxp.com>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
         <1b93c94cb8b4914314e4f50304c3cb11c53d8b14.1500373914.git.viresh.kumar@linaro.org>
         <1500983686.30745.28.camel@nxp.com> <20170726060634.GY352@vireshk-i7>
         <1501174453.7957.30.camel@nxp.com> <20170728052843.GT352@vireshk-i7>
         <20170816063431.GB24299@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn3nam01on0057.outbound.protection.outlook.com ([104.47.33.57]:18560
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751666AbdHPJmx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 16 Aug 2017 05:42:53 -0400
In-Reply-To: <20170816063431.GB24299@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org

On Wed, 2017-08-16 at 12:04 +0530, Viresh Kumar wrote:
> On 28-07-17, 10:58, Viresh Kumar wrote:
> > 
> > At this point I really feel that this is a hardware specific problem
> > and it was working by chance until now. And I am not sure if we
> > shouldn't be stopping this patch from getting merged just because of
> > that.
> > 
> > At least you can teach your distribution to go increase the sampling
> > rate from userspace to make it all work.
> Its been 3 weeks since my last email on this thread and no reply yet
> from any of the IMX maintainers. Can someone please help here ?
> 
> @Shawn: Can you help debugging a bit here, to see what's get screwed
> up due to this commit ? Its just that your platform isn't able to
> change freq at 10 ms rate.
> 
> @Rafael: I am not sure, but should we be stopping this patch because
> some hardware isn't able to change freq at 10ms interval and is just
> faking the transition delay to start with ?
> 
> Maybe we get this merged again and the IMX guys can figure out what's
> wrong on their platform and how to fix it ?

I reported the initial issue but did not have the time to do a more
thorough investigation, this is more complicated than it seems. I said
this before but maybe it got lost:

I don't think the odd behavior I noticed justifies keeping the patch
from merging.

--
Regards,
Leonrd
