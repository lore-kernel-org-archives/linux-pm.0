From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 08/16] ARM: mvebu: Use a local variable to store the
 resume address
Date: Mon, 30 Jun 2014 17:09:52 +0200
Message-ID: <20140630170952.6d92f96d@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
	<1403875377-940-9-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55789 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751005AbaF3PJ4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jun 2014 11:09:56 -0400
In-Reply-To: <1403875377-940-9-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Dear Gregory CLEMENT,

On Fri, 27 Jun 2014 15:22:49 +0200, Gregory CLEMENT wrote:

> +static void *mvebu_cpu_resume;
> +
>  static struct platform_device mvebu_v7_cpuidle_device = {
>  	.name = "cpuidle-armada-370-xp",
>  };
> @@ -281,7 +283,7 @@ static int mvebu_v7_cpu_pm_notify(struct notifier_block *self,
>  {
>  	if (action == CPU_PM_ENTER) {
>  		unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
> -		mvebu_pmsu_set_cpu_boot_addr(hw_cpu, armada_370_xp_cpu_resume);
> +		mvebu_pmsu_set_cpu_boot_addr(hw_cpu, mvebu_cpu_resume);

Instead of doing this in the CPU_PM_ENTER notifier, do we have a reason
to not do it in the do_armada_370_xp_cpu_suspend() function, and then
do_armada_38x_suspend() function respectively? Those functions are
already SoC-specific, so surely, they already know whether the resume
path should go through armada_370_xp_cpu_resume() or
armada_38x_cpu_resume(), no?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
