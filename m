From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 07/16] ARM: mvebu: Make the CPU idle initialization more
 generic
Date: Thu, 03 Jul 2014 10:54:16 +0200
Message-ID: <53B51A38.6050406@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-8-git-send-email-gregory.clement@free-electrons.com> <20140630160727.628e79c3@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48852 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757278AbaGCIyU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 04:54:20 -0400
In-Reply-To: <20140630160727.628e79c3@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi Thomas,

	struct device_node *np;
>> +	const struct of_device_id *match;
>> +
>> +	np = of_find_matching_node_and_match(NULL, of_cpuidle_table,
>> +					&match);
> 
> I'm not sure I like using of_find_matching_node_and_match() on the
> entire tree to find the root node compatible string. Wouldn't it be
> simpler and shorter to just do:
> 
> 	if (of_machine_is_compatible("marvell,armadaxp"))
> 		ret = armadaxp_cpuidle_init();
> 	else if (of_machine_is_compatible("marvell,armada370"))
> 		ret = armada370_cpuidle_init();
> 	else if (of_machine_is_compaitble("marvell,armada380"))
> 		ret = armada38x_cpuidle_init();
> 
> 	if (ret)
> 		return ret;

Indeed, as I don't use any resource from the device tree here, using
of_find_matching_node_and_match is overkill. And your alternative
will be enough.

> 
> Also, using a boolean to return a success/error status is not the
> kernel way of doing things, you should use an int instead and use
> proper error codes or return 0 on success.

OK


Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
