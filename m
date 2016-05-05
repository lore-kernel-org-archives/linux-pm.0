From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / OPP: Remove useless check
Date: Thu, 05 May 2016 16:00:29 +0200
Message-ID: <2129933.pyMPGBNMHq@vostro.rjw.lan>
References: <080908c24c189b44442b2fee7be83e760a6dac49.1462367990.git.viresh.kumar@linaro.org> <20160504182127.GR3492@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:43011 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752377AbcEEN5R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 May 2016 09:57:17 -0400
In-Reply-To: <20160504182127.GR3492@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, linux-kernel@vger.kernel.org

On Wednesday, May 04, 2016 11:21:27 AM Stephen Boyd wrote:
> On 05/04, Viresh Kumar wrote:
> > Regulators are optional for devices using OPPs and the OPP core
> > shouldn't be printing any errors for such missing regulators.
> > 
> > It was fine before the commit 0c717d0f9cb4, but that failed to update
> > this part of the code to remove an 'always true' check and an extra
> > unwanted print message.
> > 
> > Fix that now.
> > 
> > Fixes: 0c717d0f9cb4 ("PM / OPP: Initialize regulator pointer to an error value")
> > Reported-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Applied, thanks!

