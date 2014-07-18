From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH V2] cpufreq: imx6: remove pu regulator dependency for
 SOCs with no PU regulator
Date: Fri, 18 Jul 2014 16:31:18 +0800
Message-ID: <20140718083116.GD8537@dragon>
References: <1403250138-25030-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1lp0139.outbound.protection.outlook.com ([207.46.163.139]:8970
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760324AbaGRIb3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Jul 2014 04:31:29 -0400
Content-Disposition: inline
In-Reply-To: <1403250138-25030-1-git-send-email-b20788@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Anson Huang <b20788@freescale.com>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Fri, Jun 20, 2014 at 03:42:18PM +0800, Anson Huang wrote:
> PU regulator is not a necessary regulator for cpufreq, not all
> i.MX6 SoCs have PU regulator, only if SOC has PU regulator, then its
> voltage must be equal to SOC regulator, so remove the dependency
> to support i.MX6SX which has no PU regulator.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Rafael,

Can you please apply this for 3.17?  Thanks.

Shawn
