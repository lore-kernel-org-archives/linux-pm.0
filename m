From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
Date: Tue, 17 Dec 2013 11:10:48 +0800
Message-ID: <20131217031045.GF6691@S2101-09.ap.freescale.net>
References: <1387228450-641-1-git-send-email-b20788@freescale.com>
 <1387228450-641-2-git-send-email-b20788@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:3267
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752304Ab3LQDJu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Dec 2013 22:09:50 -0500
Content-Disposition: inline
In-Reply-To: <1387228450-641-2-git-send-email-b20788@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anson Huang <b20788@freescale.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Dec 16, 2013 at 04:14:10PM -0500, Anson Huang wrote:
> @@ -201,9 +238,75 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		goto put_node;
>  	}
>  
> +	prop = of_find_property(np, "fsl,soc-operating-points", NULL);

This is a new property, and it should be documented in binding doc.
Remember to copy devicetree@vger.kernel.org when you send a patch with
binding doc update.

Shawn

