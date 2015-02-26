From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpuidle: mvebu: Fix the CPU PM notifier usage
Date: Thu, 26 Feb 2015 22:55:10 +0100
Message-ID: <4892716.Bf612zPN6E@vostro.rjw.lan>
References: <1424971248-29076-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64770 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752986AbbBZVbq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Feb 2015 16:31:46 -0500
In-Reply-To: <1424971248-29076-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

On Thursday, February 26, 2015 06:20:48 PM Gregory CLEMENT wrote:
> As stated in kernel/cpu_pm.c, "Platform is responsible for ensuring
> that cpu_pm_enter is not called twice on the same CPU before
> cpu_pm_exit is called.". In the current code in case of failure when
> calling mvebu_v7_cpu_suspend, the function cpu_pm_exit() is never
> called whereas cpu_pm_enter() was called just before.
> 
> This patch moves the cpu_pm_exit() in order to balance the
> cpu_pm_enter() calls.
> 
> Reported-by: Fulvio Benini <fbf@libero.it>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Should that go to "stable" too?  Which "stable" series it should go to if so?

> ---
>  drivers/cpuidle/cpuidle-mvebu-v7.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
> index 38e68618513a..cefa07438ae1 100644
> --- a/drivers/cpuidle/cpuidle-mvebu-v7.c
> +++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
> @@ -37,11 +37,11 @@ static int mvebu_v7_enter_idle(struct cpuidle_device *dev,
>  		deepidle = true;
>  
>  	ret = mvebu_v7_cpu_suspend(deepidle);
> +	cpu_pm_exit();
> +
>  	if (ret)
>  		return ret;
>  
> -	cpu_pm_exit();
> -
>  	return index;
>  }
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
