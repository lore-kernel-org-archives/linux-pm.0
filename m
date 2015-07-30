From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 16/20] power/reset: at91-reset: remove useless
 at91_reset_platform_probe()
Date: Thu, 30 Jul 2015 11:40:25 +0200
Message-ID: <20150730114025.3eed9c1d@free-electrons.com>
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com>
	<1438215726-27452-17-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:59245 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751527AbbG3Jk2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 05:40:28 -0400
In-Reply-To: <1438215726-27452-17-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pm@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Dear Alexandre Belloni,

On Thu, 30 Jul 2015 02:22:02 +0200, Alexandre Belloni wrote:

>  static int at91_reset_probe(struct platform_device *pdev)
>  {
>  	int ret;
>  
> -	if (pdev->dev.of_node)
> -		ret = at91_reset_of_probe(pdev);
> -	else
> -		ret = at91_reset_platform_probe(pdev);
>  
> +	ret = at91_reset_of_probe(pdev);

Maybe it no longer makes sense to have separate at91_reset_probe() and
at91_reset_of_probe() functions then.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
