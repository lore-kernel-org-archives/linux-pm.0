From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] cpufreq: imx6: remove pu regulator dependency for SOCs with no PU regulator
Date: Sat, 19 Jul 2014 02:06:02 +0200
Message-ID: <1700099.R5ebWUKAKG@vostro.rjw.lan>
References: <1403250138-25030-1-git-send-email-b20788@freescale.com> <20140718083116.GD8537@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59836 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755515AbaGRXro (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jul 2014 19:47:44 -0400
In-Reply-To: <20140718083116.GD8537@dragon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Anson Huang <b20788@freescale.com>, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Friday, July 18, 2014 04:31:18 PM Shawn Guo wrote:
> On Fri, Jun 20, 2014 at 03:42:18PM +0800, Anson Huang wrote:
> > PU regulator is not a necessary regulator for cpufreq, not all
> > i.MX6 SoCs have PU regulator, only if SOC has PU regulator, then its
> > voltage must be equal to SOC regulator, so remove the dependency
> > to support i.MX6SX which has no PU regulator.
> > 
> > Signed-off-by: Anson Huang <b20788@freescale.com>
> 
> Rafael,
> 
> Can you please apply this for 3.17?  Thanks.

Queued up for 3.17, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
