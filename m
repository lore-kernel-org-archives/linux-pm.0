From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 3/9] cpufreq: Cap the default transition delay value
 to 10 ms
Date: Thu, 17 Aug 2017 09:08:02 +0530
Message-ID: <20170817033802.GE24299@vireshk-i7>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
 <1b93c94cb8b4914314e4f50304c3cb11c53d8b14.1500373914.git.viresh.kumar@linaro.org>
 <1500983686.30745.28.camel@nxp.com>
 <20170726060634.GY352@vireshk-i7>
 <1501174453.7957.30.camel@nxp.com>
 <20170728052843.GT352@vireshk-i7>
 <20170816063431.GB24299@vireshk-i7>
 <1502876565.23210.15.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:37105 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbdHQDiG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2017 23:38:06 -0400
Received: by mail-pg0-f42.google.com with SMTP id y129so33811399pgy.4
        for <linux-pm@vger.kernel.org>; Wed, 16 Aug 2017 20:38:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1502876565.23210.15.camel@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org

On 16-08-17, 12:42, Leonard Crestez wrote:
> I reported the initial issue but did not have the time to do a more
> thorough investigation, this is more complicated than it seems. I said
> this before but maybe it got lost:
> 
> I don't think the odd behavior I noticed justifies keeping the patch
> from merging.

Thanks for that.

I will resend this patch now.

-- 
viresh
