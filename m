From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH V2] cpufreq: imx6: remove pu regulator dependency for
 SOCs with no PU regulator
Date: Sat, 21 Jun 2014 20:28:40 +0800
Message-ID: <20140621122839.GF18165@dragon>
References: <1403250138-25030-1-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1blp0185.outbound.protection.outlook.com ([207.46.163.185]:4182
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751452AbaFUMnu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 21 Jun 2014 08:43:50 -0400
Content-Disposition: inline
In-Reply-To: <1403250138-25030-1-git-send-email-b20788@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Fri, Jun 20, 2014 at 03:42:18PM +0800, Anson Huang wrote:
> PU regulator is not a necessary regulator for cpufreq, not all
> i.MX6 SoCs have PU regulator, only if SOC has PU regulator, then its
> voltage must be equal to SOC regulator, so remove the dependency
> to support i.MX6SX which has no PU regulator.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Acked-by: Shawn Guo <shawn.guo@freescale.com>
